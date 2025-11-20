global class RetailerAbnormalLoginPolicy extends TxnSecurity.EventHandler {

    private static final Set<String> RETAILER_PROFILES = new Set<String>{
        'Retailer Profile',
        'Retail_Sales_Profile'
    };

    global override void handleEvent(TxnSecurity.Event event, TxnSecurity.Context context) {

        if(!(event instanceof TxnSecurity.LoginEvent)) {
            return;
        }

        TxnSecurity.LoginEvent loginEvent = (TxnSecurity.LoginEvent) event;

        User u = [
            SELECT Id, Email, Profile.Name, LastLoginDate
            FROM User
            WHERE Id = :loginEvent.userId
            LIMIT 1
        ];

        if(!RETAILER_PROFILES.contains(u.Profile.Name)) {
            return;
        }

        Boolean isNewIp          = loginEvent.isNewIp;
        Boolean isNewBrowser     = loginEvent.isNewBrowser;
        Boolean isHighRisk       = (loginEvent.riskLevel == 'High');
        String  loginCountry     = loginEvent.loginGeoCountry;
        Integer loginHour        = loginEvent.loginHour;

        Boolean isGeoAbnormal = (loginCountry != null && loginCountry != 'IN');
        Boolean isNightLogin = (loginHour <= 6 || loginHour >= 23);

        Boolean isAbnormal =
               isNewIp
            || isNewBrowser
            || isHighRisk
            || isGeoAbnormal
            || isNightLogin;

        if(!isAbnormal){
            return;
        }

        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        email.setToAddresses(new String[]{ u.Email });
        email.setSubject('Security Alert: Suspicious Login Detected');
        email.setPlainTextBody(
            'Dear Retailer,' + '\n\n' +
            'A suspicious login was detected on your account.' + '\n' +
            'Login Details:' + '\n' +
            ' - New IP: ' + isNewIp + '\n' +
            ' - New Browser: ' + isNewBrowser + '\n' +
            ' - Country: ' + loginCountry + '\n' +
            ' - Time: ' + loginHour + ':00' + '\n' +
            ' - Risk Level: ' + loginEvent.riskLevel + '\n\n' +
            'If this was not you, please reset your password immediately.'
        );

        try {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[]{ email });
        } catch(Exception ex) {
            System.debug('Email sending failed: ' + ex.getMessage());
        }

    }
}