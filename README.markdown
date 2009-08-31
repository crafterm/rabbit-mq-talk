# RabbitMQ Demo Applications.

The following project includes a Rails and RubyCocoa demo application shown as part of a presentation about Messaging/RabbitMQ at 
the Melbourne Ruby group. 

### 01 rails

  This example is a small Rails application that allows photos to be uploaded to a site. Upon uploads, the photo ID is added 
  to a RabbitMQ queue, and a preview/greyscale/watermarked/edge version of the photo is created in the background. Run server.rb
  and upload a file using the Rails app under http://localhost:3000/photos/new, or use the bulk poster multiple.rb

### 02 fanout

  This example is a RubyCocoa client that simulates Surf report information, choose a beach and set the size of the swell. Start
  server.rb to see a list of surf swell sizes as the desktop client reports them. A further queue consumer can be started using
  the News Feed project, which is a video of surfer quotes. As the dekstop client reports swell sizes, both the video and text
  feed report the information.

[http://redartisan.com/2009/8/31/rabbitmq]
