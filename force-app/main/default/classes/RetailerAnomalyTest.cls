@IsTest
private class RetailerAnomalyTest {
    // @IsTest
    // static void testRetailerThreatEmail() {
    //     Profile p = [SELECT Id FROM Profile WHERE Name LIKE '%Retailer%' LIMIT 1];
    //     User u = new User(
    //         FirstName='Test', LastName='Retail',
    //         Email='testretailer@example.com',
    //         Username='testretailer_' + System.currentTimeMillis() + '@example.com',
    //         Alias='tret',
    //         TimeZoneSidKey='Asia/Kolkata',
    //         LocaleSidKey='en_US',
    //         EmailEncodingKey='UTF-8',
    //         LanguageLocaleKey='en_US',
    //         ProfileId=p.Id
    //     );
    //     insert u;
    //     LoginEvent login = (LoginEvent)JSON.deserialize(
    //         '{"UserId":"' + u.Id + '","SourceIp":"11.22.33.44","City":"Hyderabad","Country":"IN"}',
    //         LoginEvent.class
    //     );
    //     TxnSecurity.Event evt = new TxnSecurity.Event(login);
    //     Test.startTest();
    //     RetailerAnomalyService.handleLoginEvent(evt, null);
    //     Test.stopTest();
    //     System.assertEquals(1, Limits.getEmailInvocations());
    // }
}