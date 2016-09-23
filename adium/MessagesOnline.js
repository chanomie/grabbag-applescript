#!/usr/bin/osascript

var messagesApp = Application('Messages');
messagesApp.launch();
/*
for (i = 0; i < messagesApp.services.length; i++) {
  messagesApp.services[i].logIn();
}
*/	  

var slackApp = Application('Slack');
slackApp.launch();