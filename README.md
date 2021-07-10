# An Agile Squad

An Agile Squad is a rudimentary clone of MS Teams built in sprints using SCRUM, an Agile methodology of software development. This is a <b>cross-platform mobile application</b> which enables users connect with each other instantly via text messages and video calls. 
<br>
An Agile Squad was developed as part of the Microsoft Engage 2021 Program organised by AceHacker and Microsoft. <br>

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

<ol>
  <h3><li> Video-Calling </h3>
  The video calling feature can be accessed from the videocam icon inside the chat screen. This functionality allows <b>a minimum of 2</b> and <b>a maximum of 5 users</b> to be present in the same call at a time. <a href="https://www.agora.io/en/">Agora</a> provides the <b>Agora RTC (Real-time Communication) SDK/Engine</b> for enabling real-time audio and video communications. The video channel is initialised and rendered in a split screen view depending on the number of participants with the help of Agora Event Handlers and helper functions. The users can also <b>mute and unmute</b> themselves and <b>switch b/w their front and back cameras</b>.<br><br>
  <b>Optimisations:</b> A <b>pickup screen</b> containing the <b>user's profile picture, pick call and end call buttons</b> has been wrapped over the home screen and is triggered on the receiver's screen as soon as a video call is initiated by the caller.<br>
  
  Click <a href="https://github.com/sonalika2001/An-Agile-Squad/tree/Video-Call" >here</a> to view the video-calling feature branch.
  
  
  <b>Important Note:</b><i> The temporary token provided by Agora is a must for the functionalities to work properly. These expire every 24 hours and will hence be the only thing being updated alongside the newly generated apks after the submission deadline.</i>
 </li>
  
  <h3><li> Chat </h3>
  </li>
  
  <h3><li> Call Logs </h3>
  </li>
  
  <h3><li>Search </h3>
  </li>
  
  <h3><li> Authentication </h3>
 </li>
  
  <h3><li> Online Presence Indicator </h3>
  </li>
  
  <h3><li> User Interface </h3>
  </li>
  
  
  </ol>
  
## Repository Structure
The [master](https://github.com/sonalika2001/An-Agile-Squad/tree/master) branch contains the complete implementations. The rest are feature branches and can be viewed [here](https://github.com/sonalika2001/An-Agile-Squad/branches/active).
    
## Installation & Requirements
In order to clone this repository and run it on your device, the above mentioned versions of Flutter and Dart must be downloaded. For further installation instructions, refer the [Flutter installation guide](https://flutter.dev/docs/get-started/install).

## High Level Folder Structure

## Low Level Folder/File Structure

## Mobile Architecture and State Management

## Upcoming Features & Future Improvements

  

  
