#!/usr/bin/osascript

/**
 * Take all messages systems offline.
 *
 * Supports:
 * Adium ("Adium") - Take offline
 * Apple Messages ("Messages")- Take offline
 * Slack ("Slack") - Quit
 */
 
if(isApplicationRunning("Messages")) {
  offlineMessages();
}
if(isApplicationRunning("Slack")) {
  // No AppleScript to "logout" of Slack, so just quit.
  Application('Slack').quit();
}
if(isApplicationRunning("Adium")) {
  Application('Adium').goOffline();
}

function offlineMessages() {
  var messagesApp = Application('Messages'),
      i;
	  

  messagesApp.quit();
  /*  
  for (i = 0; i < messagesApp.services.length; i++) {
    if(messagesApp.services[i].name() !== "SMS" && messagesApp.services[i].status() !== "offline") {
  	  // console.log(messagesApp.services[i].name() + " - " + messagesApp.services[i].status());
	  messagesApp.services[i].logOut();
	}
  }
  */  
}

/**
 * Check if an application process is running.  The name to use is the application
 * name as registered by system events.
 *
 * @param {string} applicatioName the name of the application register to system events.
 * @return {boolean} true/false if it is or isn't running.
 */
function isApplicationRunning(applicatioName) {
  var systemEventsApp = Application('System Events'),
      applicationProcess = systemEventsApp.applicationProcesses.byName(applicatioName),
	  isProcessRunning = false;

  try {	
	applicationProcess.name();
    isProcessRunning = true;
  } catch (err) {
    isProcessRunning = false;
  }
  return isProcessRunning;
}
