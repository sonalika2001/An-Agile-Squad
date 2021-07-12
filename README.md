# An Agile Squad

An Agile Squad is a rudimentary clone of MS Teams built in sprints using SCRUM, an Agile methodology of software development. This is a <b>cross-platform mobile application</b> which enables users connect with each other instantly via text messages and video calls. 
<br>
An Agile Squad was developed as part of the Microsoft Engage 2021 Program organised by Ace Hacker and Microsoft. <br>

## Download and Usage

<ul>  
  <li>The apks for various architectures can be accessed <a class=download_link
               href="https://sonalika2001.github.io/An-Agile-Squad-Website/"
                                                            download>here.</a> </li> 
  <li>The minimum Android API level required to run the app is <b>16</b>.</li>
  <li>The minimum iOS version required to run the app is <b>8.0</b></li>
  <li>Device permissions are required to run the app on both Android and iOS.</li>
</ul>
  
<b>Note:</b><i> Although the codebase is supported by iOS as well as android, due to privacy issues, iOS doesn't permit apps that are not approved by the app store to be run on iPhones. This app couldn't be tested on an iOS emulator either due to the non availability of a mac.</i>
  
## Technologies & Dependencies Used

<ul>
  <li>Flutter: Version 1.0.0+1 </li>
  <li>Dart: Verion 2.9.1 </li>
  <li>Firebase</li>
  <li>Agora SDK</li>
  <li>Sqflite</li>
  <li>Hive</li>
  
  <i>For a complete list of dependencies, refer [pubspec.yaml](https://github.com/sonalika2001/An-Agile-Squad/blob/master/pubspec.yaml)</i>
   
</ul>

## Features 
<b> Note: </b> All the <b>required permissions</b> are asked for before using the native components. <br>
<ol>
  <h3><li> Video-Calling </h3>
  <ul>
    <li>The video calling feature can be accessed from the videocam icon inside the chat screen. </li>
    <li>This functionality allows <b>a minimum of 2</b> and <b>a maximum of 5 users</b> to engage in a video conversation at the same time. </li>
    <li> <a href="https://www.agora.io/en/">Agora</a> provides the <b>Agora RTC (Real-time Communication) SDK/Engine</b> for enabling real-time audio and video communications.</li><li> The video channel is initialised and rendered in a split screen view depending on the number of participants with the help of Agora Event Handlers and helper functions. <li>The users can also <b>mute and unmute</b> themselves and <b>switch b/w their front and back cameras</b>.</li>
  <li> A <b>pickup screen</b> containing the <b>user's profile picture, pick call and end call buttons</b> has been wrapped over the home screen and is triggered on the receiver's screen as soon as a video call is initiated by the caller.</li>
    <br>
   <b>Important Note:</b><i> The temporary token provided by Agora is a must for the functionalities to work properly. These expire every 24 hours and will hence be the only thing being updated alongside the newly generated apks after the submission deadline.</i>
 <br><br>
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/video-calling/pickup.jpeg" width=150 height=300 >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/video-calling/two_participants.jpeg" width=150 height=300 > 
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/video-calling/three_participants.jpeg" width=150 height=300 >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/video-calling/four_participants.jpeg" width=150 height=300 >
  </ul><br>
  
  </li>
 
  
  <h3><li> Chat </h3>
  <ul>
  <li>This is a <b>real-time chat</b> feature between that lets users view and send messages. This can be accessed from the chat tab. </li>
  <li>Users can conduct a video conversation anytime while messaging and can also continue the conversation once the video call has ended. </li>
  <li>This feature also <b>handles the edge cases</b>, for example, the send button is not triggered until some text has been entered. Blank spaces <b> donot </b> count as text! The <b>textfield is cleared</b> as soon as a message has been sent.</li>
  <li> Whenever a message is received, the chat screen <b>automatically scrolls to the bottom</b> in order to let the receiver view the message instantly.</li>
  <li> An<b> emoji keyboard</b> has been incorporated as the suffix icon of the textfield. This lets users easily access their favourite emoticons and express themselves as much as they wish.</li>
  <li> Users can not only send text messages, but also engage in conversations involving <b>image files</b>. The '+' button to the left of the text field can be used to select the pictures that they wish to <b>send from their gallery</b>, while the camera icon to the right <b>routes the user to their camera</b> so that they can send instant images.</li>
  <li> In addition to this, the images being sent and received as part of a conversation are <b>cached</b>. They are also <b>compressed</b> before being sent. These work as great optimizations and enable the messages to load instantly whenever the user reopens the chat screen. </li>
  <li> <b>Chat tiles are added</b> to the chat screen whenever a conversation is initiated with a certain user. These chat tiles display the username, profile picture of the user and the <b>latest message</b> that was sent in the conversation.
  </li>
  <li> <a href="https://firebase.google.com/docs/firestore/">Firebase Cloud Firestore</a> has been used to store messages to the cloud.</li>
<br>
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/chat/chat_list.jpeg" width=150 height=300  >
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/chat/chat_screen.jpeg" width=150 height=300 >
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/chat/typing.jpeg" width=150 height=300 >
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/chat/media.jpeg" width=150 height=300 >
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/chat/pictures.jpeg" width=150 height=300 >
  </ul> <br>
  
  </li>
  
  <h3><li> Call Logs </h3> 
  <ul>
  <li> Call logs maintain a history of video calls that have been made by a particular user. These can be found in the call logs tab.</li>
  <li> A call is logged into the database whenever a call has been <b>made(dialled), missed or received</b>. Each of these are denoted by different colors.</li>
  <li> Every log has the <b>name & profile picture (of the user at the other end) and the date</b> when the call was made.</li> 
  <li> <b>Each log can be deleted</b> whenever the user wishes to. Long pressing on the log tile triggers a pop up asking the user whether they wish to delete the log(yes) or not(no).</li>
  <li><a href="https://pub.dev/packages/sqflite"> Sqflite</a>, an SQL database and <a href="https://pub.dev/packages/hive">Hive</a>, a NoSQL database, both have been incorporated into the app due to their at par performance. One can switch between the two by using a bool. By default, Hive is being used to locally store the logs.</li>
  <li>The database of a user is closed as soon as the user logs out. This ensures that the logs of that user aren't reflected in the account of any other user logging in from the same device.</li><br>
 <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/log/log.jpeg" width=150 height=300  >
 <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/log/deletelog.jpeg" width=150 height=300  >
   </ul> <br>
  </li>
  
  <h3><li>Search </h3>
  <ul>
  <li> The search functionality lets the users search for other users from among those who have logged into the app at any point of time, which in some sense means that they have signed up for An Agile Squad.</li>
  <li> The search functionality can be accessed from the search icon on the app bar as well as the floating icon button on the chat list screen.</li>
  <li> This functionality parses the email id and provides instant results. On selecting any search result, the user is routed to the existing(if present)/empty chat screen with the resultant user.</li><br>
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/search/search.jpeg" height=300 width=150>
  </ul><br>
  </li>
  
  
  <h3><li> Authentication </h3>
  <ul>
  <li> User authentication is the first functionality that a user encounters on the <b>login screen</b>.</li>
  <li> At present, the user has the option to <b>login with their google account</b>.</li>
  <li> A majority of features of this app are dependent on user authentication, since the user information is used for various functionalities and UI elements.</li>
  <li> The user's initials are parsed and displayed at the centre of the app bar as a <b>user circle</b>, similar to that in Microsoft Teams. Clicking on this leads to the <b>user details screen</b> which can be dismissed by swiping down. </li>
  <li> The users can also <b>log out </b> from the log out button on the user details screen. </li>
  <li> <a href="https://firebase.google.com/docs/auth/">Firebase Authentication</a> has been used to implement this feature. </li><br>
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/auth/sign_in.jpeg" width=150 height=300  >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/auth/sign_out.jpeg" width=150 height=300  >
  </ul><br>
 </li>
  
  <h3><li> Presence Indicator </h3>
  <ul>
  <li> The tiny circle that we see stacked at the <b>bottom right of a user's profile picture</b> is called a Presence Indicator. </li>
  <li> The color of the indicator conveys whether a user is <b>online(green), offline(red), or idle (orange)</b>. </li>
  <li> This functionality was built by <b>fetching a stream of user document snapshots</b> from firebase to get the status in real time and the records were updated whenever the status changes. </li> 
 </ul><br>
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/dot%20indicator/idle.jpeg" width=300 height=100  >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/dot%20indicator/offline.jpeg" width=300 height=100  >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/dot%20indicator/online.jpeg" width=300 height=100  >
 
  <br>
  </li>
  
  <h3><li> User Interface/Experience </h3>
  <ul>
  <li> The UI/UX of An Agile Squad is heavily inspired by Microsoft Teams as well as Skype.</li>
  <li> The <b>color scheme</b> is the same as that of Teams and the positioning of various widgets is similar to that of Skype.</li>
  <li> Flutter's <b>material design components</b> have been used to build the User Interface. </li>
  <li> Most functionalities can be done with minimal taps. For instance, the app is designed such that the users can swipe between the various tabs instead of tapping the tab button. </li>
  <li> The usage of <b>icons and symbols</b> make the usage of the app very self-explanatory and seamless to navigate through. </li>
  <li> The <b>information boxes</b> that appear on the various screens the first time a user uses An Agile Squad also help users understand the app. The <b>circular progress indicators</b> are a necessity to let the user know that their data is being retrieved at the moment and will soon be displayed. </li>
  <li> The logo of the app represents its goal. </li>
  <li> Lastly, the app's name originates from the project management philosophy that was used to build the app, namely <b>Agile</b> and from the fact that it represents a clone of MS 'Teams' (synonymous to Squad).</li>
<br>
 <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/UI/quietbox_call.jpeg" width=150 height=300  >
  <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/UI/quietbox_log.jpeg" width=150 height=300  >
  </ul>
  <br>
  </li>
  
  
  </ol>
  
## Repository Structure
<ul>
  <li>The <a href="https://github.com/sonalika2001/An-Agile-Squad/tree/master">master</a> branch contains the complete implementations. The rest are feature branches and can be viewed <a href="https://github.com/sonalika2001/An-Agile-Squad/branches/active">here</a>.</li>
  <li> The <b> android and iOS</b> folders contain the complete android and iOS projects respectively with their compiled codes.</li>
  <li> The <b> lib </b> fodler contains 99% of the code written by the developer which consists of dart files.</li>
  <li> The <b> assets and fonts </b> folders contain the images and fonts used in the app respectively.</li>
  <li> The <b> test</b> folder allows the developer to write automated tests, i.e. it contains code to run the app and test for various parameters.</li>
  <li> Flutter saves internal data and dependencies in the <b> .metadata</b> file.</li>
  <li> The <b> pubspec.yaml</b> file helps configure dependencies and 3rd party packages. The <b> pubspec.lock</b> file is generated based on pubspec.yaml and it holds certain extra information which can be specific to the developer's environment.</li>
  <li> The <b> build </b> folder(hidden, hence not pushed to repository) holds the output of the flutter application, such as the various APKs generated. It is handled by the Flutter SDK </li>
  </ul>
    
## Installation & Requirements
In order to clone this repository and run it on your device, the above mentioned versions of Flutter and Dart must be downloaded. For further installation instructions, refer the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

## High Level Folder Structure
This is the structure specific to the <b> lib </b> folder, since this is where all the code is written. The other folders are non-modifiable.<br>
<i>The folders are denoted by rounded rectangles and follow color scheme according to level of nesting.</i><br><br>
<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/High%20Level%20Structure.png" alt="high level folder structure" ><br>


## Low Level Folder/File Structure
This is the structure specific to the <b> lib </b> folder, since this is where all the code is written. The other folders are non-modifiable.<br>
<i>The folders are denoted by rounded rectangles, files are denoted by rectangles and they follow color scheme according to their level of nesting(for folders) and type of document(files).</i><br><br>

<img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/Low%20level%20diagram.png" alt="low level structure"><br>



## Mobile Architecture and State Management
<ul>
  <li> Flutter applications use the <b> MVC (Model, View, Controller) Design pattern </b>, which is a popular mobile architecture. </li>
  <li> Local state exists towards the lower end of the widget tree which global state is used across the app. In order to be able to use certain local states higher up in the widget tree efficiently, such that it is accessible by every state that requires it, we need to <b> lift state up </b>. This is the most vital part of <b> State Management. </b></li>
  <li> <a href="https://pub.dev/packages/provider">Provider</a>, which is a state management package that works well with flutter applications has been used in An Agile Squad. This paackage decreases the complexity of the code significantly. </li>
  <li> Provider moves states up to the top. Widgets then subscribe to the state, i.e they listen to any changes in that state and change their own state accordingly. </li>
  <li>Provider package, at the core, is a wrapper around <a href="https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html">Inherited Widget</a>. Inherited widgets allow passing data down the widget tree without having to rebuild the intervening parts. </li>
  </ul><br>
 <i> A high level state tree of An Agile Squad has been shown below. The states which have been lifted up by Provider are denoted by a parallelogram while all other states are represented by ellipses.</i><br><br>
 <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/state%20diagram.png" alt="state tree"><br>
  

## Future Improvements and Upcoming Features
<ul>
  <li> Adding more authentication methods would make login flexible and comfortable for users.</li>
  <li> Options such such deleting and archiving chats can make the chat list more dynamic. </li>
  <li> At present, the floating action button routes users to the main search screen. Another search functionality specific to the chat list could be added instead.</li>and
  <li>Audio calls, voice messages and other media options can be integrated. Clear options for organising meetings/group calls can be added. At present, <b> if a third person video calls a person who is already a part of another video call, this third person is added to the same video call</b>, hence increasing the number of participants, which might not be favourable in many cases. Video call related functionalities such as screenshare, turning video off etc. can be incorparated as well.</li>
  <li> Pictures sent in the chat could be viewed in full screen on clicking.</li>
  <li> "user is typing..." can be displayed when the person on the other side of the chat is typing.</li>
  <li> pickup screen can be scaled such that it appears at any screen in the user's device when a call is being received. The disposal functionality of the pickup screen can be improved. </li>
  <li> Users can be provided with the option to switch between multiple themes. </li>
  <li> Call notifications, push notifications etc. can be implemented so that user is interacting An Agile Squad even when not using it.</li>
  <li> Device Contacts can be accessed and used to make calls and invite more people to use An Agile Squad. </li>
  <li> The ability to create group chats/teams can be incorporated to make it closer to MS Teams.</li>
    
    <br>
    <img src="https://github.com/sonalika2001/An-Agile-Squad/blob/master/screenshots%20and%20diagrams/coming_soon.jpeg" width=150 height=300  >
    </ul>
    
## 
Developed and Documented by Sonalika Sahoo
  

  

  
