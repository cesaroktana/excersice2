trigger createBacklogSprint on Project__c (after insert) {

    List<Sprint__c> sprints = new List<Sprint__c>();
    for (Project__c pr : Trigger.New) {
        sprints.add(new Sprint__c(
            Name = 'Backlog',
            Start_Date__c = System.today(),
            End_Date__c = System.today(),
            Project__c= pr.ID
        ));    
    }
    insert sprints;
}