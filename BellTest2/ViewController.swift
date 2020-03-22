//
//  ViewController.swift
//  BellTest2
//
//  Created by G Bear on 2020-03-20.
//  Copyright © 2020 Rooh Bear Corporation. All rights reserved.
//

import UIKit

// my little extension to String that converts a string to a Date object
extension String
{
    func stringToDate() -> Date!
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.date(from:self)
    }
}

class ViewController: UIViewController
{
    @IBOutlet var switchUseCodable:UISwitch!
    @IBOutlet var buttonTest:UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
    
        // I have a little more attention to detail :-)
        buttonTest.layer.cornerRadius = 30
        buttonTest.layer.borderWidth = 5
        buttonTest.layer.borderColor = UIColor.black.cgColor
    }
    
    @IBAction func buttonClicked(sender:UIButton)
    {
        if let theSwitch = self.switchUseCodable {
            if theSwitch.isOn {
                self.doCodableTechnique()
            }else{
                self.doSimplerTechnique()
            }
        }
    }

    // this does the job in as few lines as I could do
    func doSimplerTechnique()
    {
        if let url = URL.init(string:"https://capi.stage.9c9media.com/destinations/tsn_ios/platforms/iPad/contents/69585") {
             do {
                 // This single line downloads the feed and stores it into data.
                 // This is the quick-and-dirty way. The better way is to use NSURLRequest and make a task to get the data
                 // because it runs the background, can be modified to do POST or GET, can put stuff in the headers for
                 // security, etc.
                 let theData = try Data.init(contentsOf:url)
                     
                 do {
                    let dataDecoded = try JSONSerialization.jsonObject(with:theData, options:.mutableLeaves)
                    if let dictData = dataDecoded as? NSDictionary {
                        if let dateWanted = dictData["LastModifiedDateTime"] as? String {
                            self.displayAlert(dateWanted)
                        }
                    }
                }
            }catch{
            }
        }
    }

    // this does the job using Codable, and uses my extension of String
    // that converts the date to a Date object
    func doCodableTechnique()
    {
        if let url = URL.init(string:"https://capi.stage.9c9media.com/destinations/tsn_ios/platforms/iPad/contents/69585") {
            do {
                // This single line downloads the feed and stores it into data.
                // This is the quick-and-dirty way. The better way is to use NSURLRequest and make a task to get the data
                // because it runs the background, can be modified to do POST or GET, can put stuff in the headers for
                // security, etc.
                let theData = try Data.init(contentsOf:url)
                    
                do {
                    // This single line of code uses the Codable feature of Swift to parse theData into parsedData.
                    let parsedData = try JSONDecoder().decode(Json4Swift_Base.self, from:theData)
                    print("Yay! Loaded OK")

                    // if we get here, parsedData contains the entire feed
                    if let strLastModifiedDateTime = parsedData.lastModifiedDateTime {
                        if let date = strLastModifiedDateTime.stringToDate() {
                            let messageToDisplay = "The date in the JSON is \(date)"
                            self.displayAlert(messageToDisplay)
                        }
                    }
                }catch let error {
                    self.displayAlert("Boo! Parsing failed because \(error)")
                }
            }catch{
                self.displayAlert("Error calling web server")
            }
        }
    }

    // The "_" makes it so the the caller doesn't have to specify the parameter name.
    // I usually do this when the function name is blatantly obvious as to what it does, and only takes one parameter.
    func displayAlert(_ messageToDisplay:String)
    {
        // All UI stuff is supposed to be done on the main thread.
        // Because we can't trust who calls this method, use DispatchQueue.main.async() to ensure that it does.
        DispatchQueue.main.async {
            let uac = UIAlertController.init(title:"Bell Test2", message:messageToDisplay, preferredStyle: .alert)
            let actionOK = UIAlertAction.init(title:"Ok", style:.default, handler:nil)
            uac.addAction(actionOK)

            self.present(uac, animated:true, completion:nil)
        }
    }
}

// ✳️✳️✳️ The class below here is NOT USED ✳️✳️✳️
// I'm just leaving it there to show my attempt to use Codable to parse the JSON.
// I got 5 of the variables parsed, though!
// I ran into trouble with the 'Owner' because to use Codable, the elements have to be compliant with Codable and Decodable
// but Any, AnyObject, and NSObject by themselves are not. I tried String but that didn't work either. I was spending too
// much time on this, so I tried Postman to see if it would generate the code I needed. It didn't. I did a search for
// "swift generate codable from json" and found https://www.json4swift.com which ALMOST worked. It generated some code
// but still needed some work to work with Swift 5.

//As of March 20, 2020, here are the contents of
//https://capi.stage.9c9media.com/destinations/tsn_ios/platforms/iPad/contents/69585 :
//{"Id":69585,"Name":"TSN2","Desc":"Watch TSN2 Live","ShortDesc":"Watch TSN2 Live","Type":"stream","Owner":{},"Episode":null,"AgvotCode":"E","AgvotDisclaimer":null,"QfrCode":"G","AiringOrder":null,"BroadcastDate":null,"BroadcastTime":null,"BroadcastDateTime":null,"LastModifiedDateTime":"2020-02-10T15:49:05Z","GameId":null,"Album":null,"Genres":[],"Keywords":[],"Tags":[],"Images":[{"Type":"thumbnail","Url":"https://images2.9c9media.com/image_asset/2015_6_16_74e12190-f6ac-0132-a8b0-10604ba4c9b1_png_2000x1125.jpg","Width":2000,"Height":1125},{"Type":"background","Url":"https://images2.9c9media.com/image_asset/2018_4_17_e433bec7-e30d-4a33-b250-3cf596ddb205_jpg_3840x2160.jpg","Width":3840,"Height":2160},{"Type":"message","Url":"https://images2.9c9media.com/image_asset/2014_9_24_25933d90-2639-0132-f395-34b52f6f1279_jpg_2000x1125.jpg","Width":2000,"Height":1125}],"Authentication":{"Required":true,"Resources":[{"ResourceCode":"TSN2"}]},"NextAuthentication":null,"RatingWarnings":[],"People":[],"Funding":null,"MusicLabels":[],"BroadcastNetworks":[]}

//Below are the keys found in the JSON which I assume is all the info for one "media object"
//
//Id
//Name
//Desc
//ShortDesc
//Type
//Owner
//Episode
//AgvotCode
//AgvotDisclaimer
//QfrCode
//AiringOrder
//BroadcastDate
//BroadcastTime
//BroadcastDateTime
//LastModifiedDateTime
//GameId
//Album
//Genres
//Keywords
//Tags
//Images
//Authentication
//NextAuthentication
//RatingWarnings
//People
//Funding
//MusicLabels
//BroadcastNetworks

//Below are the keys with their object types. If the object can be NULL, then it is considered
//optional therefore you will see a "!" suffix (you see "String!" instead of "String"). I'm not
//sure if some of these values are strings, ints, doubles, or whatever so I'm using "Any" for now.
//If you see "[Any]", that's an array of unknown objects.
//If you see "Any!" that's an unknown optional object.
//Images contains a rather large number of different values but for simplicity, we'll just use Any for now.
//
//Id:Int
//Name:String
//Desc:String
//ShortDesc:String
//Type:String
//Owner:String!
//Episode:Any!
//AgvotCode:String
//AgvotDisclaimer:Any!
//QfrCode:String
//AiringOrder:Any
//BroadcastDate:Any
//BroadcastTime:Any
//BroadcastDateTime:Any
//LastModifiedDateTime:Date
//GameId:Any!
//Album:Any!
//Genres:[Any]
//Keywords:[Any]
//Tags:[Any]
//Images":[Any]
//Authentication":Any
//NextAuthentication":Any!
//RatingWarnings":[Any]
//People":[Any]
//Funding":Any!
//MusicLabels":[Any]
//BroadcastNetworks":[Any]

// Below are the keys with examples of their values from the test JSON:
//"Id":69585,
//"Name":"TSN2",
//"Desc":"Watch TSN2 Live",
//"ShortDesc":"Watch TSN2 Live",
//"Type":"stream",
//"Owner":{},
//"Episode":null,
//"AgvotCode":"E",
//"AgvotDisclaimer":null,
//"QfrCode":"G",
//"AiringOrder":null,
//"BroadcastDate":null,
//"BroadcastTime":null,
//"BroadcastDateTime":null,
//"LastModifiedDateTime":"2020-02-10T15:49:05Z",
//"GameId":null,
//"Album":null,
//"Genres":[],
//"Keywords":[],
//"Tags":[],
//"Images":[{"Type":"thumbnail","Url":"https://images2.9c9media.com/image_asset/2015_6_16_74e12190-f6ac-0132-a8b0-10604ba4c9b1_png_2000x1125.jpg","Width":2000,"Height":1125},{"Type":"background","Url":"https://images2.9c9media.com/image_asset/2018_4_17_e433bec7-e30d-4a33-b250-3cf596ddb205_jpg_3840x2160.jpg","Width":3840,"Height":2160},{"Type":"message","Url":"https://images2.9c9media.com/image_asset/2014_9_24_25933d90-2639-0132-f395-34b52f6f1279_jpg_2000x1125.jpg","Width":2000,"Height":1125}],
//"Authentication":{"Required":true,"Resources":[{"ResourceCode":"TSN2"}]},
//"NextAuthentication":null,
//"RatingWarnings":[],
//"People":[],
//"Funding":null,
//"MusicLabels":[],
//"BroadcastNetworks":[]

public class MediaObject : NSObject, Codable
{
    public var Id:Int32
    public var Name:String
    public var Desc:String
    public var ShortDesc:String
    public var type:String              // can't have a variable called "Type" in Swift, so I'm calling it "type"
//    public var Owner:AnyObject
//    public var Episode:Any!
//    public var AgvotCode:String
//    public var AgvotDisclaimer:Any!
//    public var QfrCode:String
//    public var AiringOrder:Any
//    public var BroadcastDate:Any
//    public var BroadcastTime:Any
//    public var BroadcastDateTime:Any
//    public var LastModifiedDateTime:Date
//    public var GameId:Any!
//    public var Album:Any!
//    public var Genres:[Any]
//    public var Keywords:[Any]
//    public var Tags:[Any]
//    public var Images:[Any]
//    public var Authentication:Any
//    public var NextAuthentication:Any!
//    public var RatingWarnings:[Any]
//    public var People:[Any]
//    public var Funding:Any!
//    public var MusicLabels:[Any]
//    public var BroadcastNetworks:[Any]

    override init()
    {
        self.Id = 0
        self.Name = ""
        self.Desc = ""
        self.ShortDesc = ""
        self.type = ""
//        self.Owner = AnyBellObject.init(id: "X")
//        self.Episode = nil
        
    }
    
    public init(_id:Int32, _name:String, _desc:String, _shortDesc:String, _type:String)
    {
        self.Id = _id
        self.Name = _name
        self.Desc = _desc
        self.ShortDesc = _shortDesc
        self.type = _type
//        self.Owner = _owner
    }
        
    public enum CodingKeys: String, CodingKey
    {
        case Id
        case Name
        case Desc
        case ShortDesc
        case type
//        case Owner
//        case Episode
//        case AgvotCode
//        case AgvotDisclaimer
//        case QfrCode
//        case AiringOrder
//        case BroadcastDate
//        case BroadcastTime
//        case BroadcastDateTime
//        case LastModifiedDateTime
//        case GameId
//        case Album
//        case Genres
//        case Keywords
//        case Tags
//        case Images
//        case Authentication
//        case NextAuthentication
//        case RatingWarnings
//        case People
//        case Funding
//        case MusicLabels
//        case BroadcastNetworks
    }
}
