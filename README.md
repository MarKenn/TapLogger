# TapLogger

## JUST ONE MORE TAP...

This is a simple event logger app to showcase some basic skills in native iOS development. 

## Description

The core functionality of the app is to detect button presses on th Tap tab, log them in a database, and display the logs on the Logs tab.

I initially thought of using CoreData for the database/storage solution, but since the data is only composed of a name and a timestamp property, I opted to using a simple json file instead. Thought it also fit the app more since it is a logging app.

## Additional Features

### Session console

 - Added a "Session console" which shows events from your current session
 - Gets cleared and reset when app is closed. Does not fetch logs from the saved file
   
|  |  | 
| --- | --- |
| ![Simulator Screenshot - iPhone 16 - 2025-02-01 at 22 29 42](https://github.com/user-attachments/assets/ec61d872-b8ce-4783-9688-ba88c7dc239b) | ![Simulator Screenshot - iPhone 16 - 2025-02-01 at 22 29 52](https://github.com/user-attachments/assets/a3e42e5f-ec36-4af0-9e93-30178cb693e8) |

### Download logs

 - Added a download button on the logs tab.
 - Creates a copy of the JSON log file which can then be moved to the device's file storage.

|  |  | 
| --- | --- |
| <img src="https://github.com/user-attachments/assets/d0a0260f-5971-408a-8dcf-2a54f65a0f1a" width="478.5"> | <video src="https://github.com/user-attachments/assets/522b3659-6bab-4fb6-ac41-77bf2086a0f8" width="200"> |


