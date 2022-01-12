trigger workItemNameValidation on Work_Item__c (before insert) {
    for (Work_Item__c wi : Trigger.New) {
        ID proID = [SELECT Project__c FROM Sprint__c WHERE ID = :wi.Sprint__c].Project__c;
        Sprint__c[] sprints = [SELECT ID, (SELECT NAME FROM Work_Item__r WHERE NAME = :wi.Name ) FROM Sprint__c WHERE Project__c = :proID];  
        Work_Item__c[] wis = sprints[0].Work_Item__r;
        if(wis.size()>0){
            wi.Name.addError('Name exists');
        }
    }

}