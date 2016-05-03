#Inspiration
Our project is inspired by the incredible power of new machine learning techniques. We were especially intrigued by a particular set of images that were recreated in the styles of other images through the use of convolutional neural networks.

#What it does
The application allows for users to upload two images from their phones, or from the web. These images are sent to a server, where a convolutional neural network is used to attempt to recreate the first photo in the style of the second photo. The resulting photo is displayed to the user, and is saved in a gallery.

#How we built it
We quickly found out that running the neural network would require an immense amount of graphics processing power. For this reason, we used certain AWS servers that gave us access to more powerful hardware. We then installed torch and loadcaffe, and configured the parameters of the neural network. Afterwards, we created a simple API with node.js, which allowed for photos to be uploaded from other devices, as well as to send generated photos back to the devices. After setting up the server, we spent time building an iPhone application that would allow for users to choose photos from their phone, or from the web, and send them to our server for processing.

#Challenges we ran into
The largest challenge that we had was figuring out how to generate images at a decent pace, since it took nearly 2 hours to develop each photo on our laptops. By migrating to AWS servers that had better GPUs, we were able to bring the time to about 5 minutes, which was a lot better than before. The other challenge that we ran into was figuring out how to send images between an iPhone and our server.

#Accomplishments that we're proud of
We are proud that we were able to overcome many obstacles and create code in languages and programs that we had never used before. This was a great learning experience, and the generated images came out looking amazing!


