public with sharing class RetailerAnomalyHandler {
    public RetailerAnomalyHandler() {

    }
    
}
/*
global class RetailerAnomalyHandler implements TxnSecurity.EventAction {

    global void execute(TxnSecurity.Event e, TxnSecurity.Context ctx) {

        // Cast event to LoginEvent
        LoginEvent login = (LoginEvent)e.getEvent();

        // Fetch the user who triggered the high-risk login
        User u = [
            SELECT Id, Email, Profile.Name
            FROM User
            WHERE Id = :login.UserId LIMIT 1
        ];

        // Send email only to this user
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{u.Email});
        mail.setSubject('Security Alert: Suspicious Login Detected');
        mail.setPlainTextBody(
            'A suspicious login attempt was detected on your account.' +
            '\n\nTime: ' + login.LoginTime +
            '\nIP: ' + login.SourceIp +
            '\nCity: ' + login.City +
            '\nCountry: ' + login.Country +
            '\n\nIf this was not you, please reset your password.'
        );

        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}


*/