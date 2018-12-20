
# News Demo

## Language, Editor and Platform versions used in this project:
* **Language:** Swift 4.2
* **Platform:** iOS 12.1
* **Editor**: Xcode 10.1

## Sample Project Details
**Goal:**

1. Create an app that connects to JSON API, parses and display the data. (List of News is a Scrolling List/UITableView/UICollectionView).
* Use “HeadLine” for News headline.
* Use “Image ->Thumb” value for thumbnail image.
* If “DateLine” value is less than 1 hour, use “ByLine” – “DateLine” value.

2. Add Offline functionality (Image caching, news caching in DB/Local). If network is
not available, images & news should be loaded from persistence.

3. For iOS – use of Autoloayout is suggested.

* iOS version > 9.0.


### API Details
http://timesofindia.indiatimes.com/feeds/newsdefaultfeeds.cms?feedtype=sjson

### Look and feel for individual cell or view:
* When image is available & “DateLine” key value (i.e is time) is less than one hour.
* When image is available & “DateLine” key value (i.e is time) is greater than one hour.
* When image is not available.

### Screencast
[![Screencast video News Demo](https://img.youtube.com/vi/ZwLk_HqR1y0/0.jpg)](https://youtu.be/ZwLk_HqR1y0)

### Screenshot Images

<img src="https://user-images.githubusercontent.com/12752821/50308797-5f447800-04c2-11e9-9cf0-1828227e04a1.png" alt="Simulator Screen Shot - iPhone XR - 2018-12-21 at 01.46.17" width="400"> 

<img src="https://user-images.githubusercontent.com/12752821/50309187-e9d9a700-04c3-11e9-86c8-df870114fe60.png" alt="Simulator Screen Shot - iPhone XR - 2018-12-21 at 01.57.27" width="400"> 

<img src="https://user-images.githubusercontent.com/12752821/50309943-8e5ce880-04c6-11e9-9359-49df2187602f.png" alt="Simulator Screen Shot - iPhone XR - 2018-12-21 at 02.16.37" width="400"> 





