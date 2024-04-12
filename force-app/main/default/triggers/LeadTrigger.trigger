/**
 * @info    : LeadTrigger uses TriggerHandler class framework. Please refer this class for logic handling.
 */
trigger LeadTrigger on Lead (after insert, after update) {
    new LeadTriggerHandler().run();
}