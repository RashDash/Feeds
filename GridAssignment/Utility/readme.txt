
1. Please take a look at attached JSON file
2. This contains details about 3 type of medias (image, Audio and video)

You need to make a single view iPhone application which will have UICollectionView and each cell of this UICollectionView will represent 1 record from this JSON

So ideally your application will:

1. Consume this JSON (feel free to drop it in your project as-is)
2. Read the JSON programmatically and save data in local Model. 
3. Please note that the field "type" in JSON denotes the media type (0: image, 1: audio, 2: video)
4. Download the media(s) (image, audio, video). Basically when the cell will request it.
4. Show the media in respective cell. So you will have 3 type of cells (image, audio, video)
5. Originally all audio and video should be in pause state, Once we tap on the cell the media should start playing. Tapping on the cell again should pause the media.


The final submission:

1. Zip file of your project
2. Project should be compilable in latest XCode
3. Project should have 0 errors 0 warnings
4. Project SHOULD NOT have any 3rd party library or PODS or CocoaPods (such as alamofire, etc etc)
5. Project should be written in Swift language

Things that we are looking for

1. Fluid UI- when user launches the application and you show the collection view; at this time some of the media may not be downloaded. AT this time, we should still be able to play with the UI. Show Spin Controls in cells where the media is not yet available

2. Your approach of designing the application in either MVC or MVVM pattern

3. How do you ensure that a particular media (image/video/audio) is downloaded ONLY once and is cached and then the cache version is used when any cell requires the media next time.

4. How will the app scale in various iPhones (iPhone 12 Pro, iPhone 12, iPhone SE etc)

5. Your knowledge of multi-threaded application which will use background and main UI threads appropriately.

6. Feel free to design your own cells. At the minimum, show the "title" field in each cell.