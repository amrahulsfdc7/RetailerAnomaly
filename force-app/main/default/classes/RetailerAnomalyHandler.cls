global class RetailerAnomalyHandler implements TxnSecurity.EventAction {
    global void execute(TxnSecurity.Event e, TxnSecurity.Context ctx) {
        RetailerAnomalyService.handleLoginEvent(e, ctx);
    }
}