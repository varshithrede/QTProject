@isTest
public class TestFactory {
    
    public static User createUser(String profileName){
        Blob b = Crypto.GenerateAESKey(128);
        String h = EncodingUtil.ConvertTohex(b);
        String uid = h.SubString(0,8);
        
        User u =  new User(Alias = uid, Email= uid + '@testdomain.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = getProfileIdByName(profileName),
            TimeZoneSidKey='America/New_York', UserName= uid + '@testdomain.com'); 
        insert u;
        return u; 
    }

    public static Id getProfileIdByName(String profileName){
        Map<String, Id> profilesMap = new Map<String, Id>(); 
        for(Profile profile : [SELECT Id, Name FROM Profile]){
            profilesMap.put(profile.Name, profile.Id);
        }
        return profilesMap.get(profileName);
    }
}