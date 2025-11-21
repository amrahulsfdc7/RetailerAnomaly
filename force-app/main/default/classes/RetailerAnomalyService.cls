public class RetailerAnomalyService {
    public static void handleLoginEvent(TxnSecurity.Event e, TxnSecurity.Context ctx) {
        LoginEvent login = (LoginEvent)e.getEvent();
        User u = [SELECT Id, Email, Profile.Name FROM User WHERE Id = :login.UserId LIMIT 1];
        if (!u.Profile.Name.toLowerCase().contains('retailer')) return;
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{u.Email});
        mail.setSubject('Security Alert: Suspicious Login Detected');
        mail.setPlainTextBody(
            'Dear Retailer,\n\n' +
            'We detected a suspicious login attempt on your account.\n\n' +
            'Time: ' + String.valueOf(login.LoginTime) + '\n' +
            'IP: ' + login.SourceIp + '\n' +
            'City: ' + login.City + '\n' +
            'Country: ' + login.Country + '\n\n' +
            'If this was not you, please reset your password.'
        );
        Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
    }
}