public Inherited sharing class workItemsStoryPointsController {
    
    public Work_Item__c wi{get; set;}
    public List<Work_Item__c> workItems{get; set;}
    public String status {get; set;}
    
    public workItemsStoryPointsController(ApexPages.StandardController controller){
        controller.addFields(new List<String>{'Story_Points__c', 'Sprint__r.Project__c'});
        this.wi = (Work_Item__c)controller.getRecord();
        getWorkItems('');
    }
    
    public List<Work_Item__c> getWorkItems(String stat){
        if(stat != ''){
            workItems = [SELECT Name, Story_Points__c, Status__c, Sprint__c FROM Work_Item__c WHERE Status__c = :status AND Story_Points__c = :wi.Story_Points__c AND Sprint__r.Project__c =:wi.Sprint__r.Project__c];
        } else {
            workItems = [SELECT Name, Story_Points__c, Status__c, Sprint__c FROM Work_Item__c WHERE Story_Points__c = :wi.Story_Points__c AND Sprint__r.Project__c =:wi.Sprint__r.Project__c ];
        }
        return workItems;
    }
    
    public void search(){
        getWorkItems(status);
    }

    public List<SelectOption> getdynamiclist() {
        List<SelectOption> pickListValuesList= new List<SelectOption>();
        Schema.DescribeFieldResult fieldResult = Work_Item__c.Status__c.getDescribe();
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry pickListVal : ple){
            pickListValuesList.add(new SelectOption(pickListVal.getLabel(),pickListVal.getLabel()));
        }     
        return pickListValuesList;
    }
}