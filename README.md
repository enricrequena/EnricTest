# EnricTest
iOS App to show a list of public images from Flickr Feed. For each image you can:

* Save the image to the system photo library
* Open the image in Safari
* Share the image

This application has been developed using VIPER architecture.

As it stands at the moment, we have 2 modules, ImageList and Share. Each module has been split into multiple layers to separate responsabilities and keep layers decoupled from each other.

A VIPER architecture has the following structure:

- View: Reponsible to present the User Interface. ImageList module has a ImageListView protocol which is implemented by ImageListViewController. This protocol defines all the relevant methods needed for a View to do its job.
- Interactor: Responsible to execute any interactions. ImageList module has a ImageListInteractor protocol which allow us to fetch a list of images, load an image from a URL, cancel an image load and save an image to the system’s library.
- Presenter: Responsible to prepare any data to be consumed by the View. Any interaction on the view is then comunicated to the presenter through an ImageListPresenter protocol so the presenter can act accordingly. Presenters normally use a ViewModel to send data back to the view. Our app has different types of view models to wrap different user actions. Presenters also communicate to wireframes when they need to navigate to another module (e.g.: tapping on Share Image).
- Entity: Entity are the objects that represent our model, in our app the model is the DataFeed class.
- Router: A router or Wireframe is responsible to build and present the module and also navigate to other modules.

As you will notice, the ImageListInteractor uses Operation objects and an OperationQueue. That is design this way so in the future, we could exend this using Operation dependencies to perform multiple tasks such as editing the image once it has been downloaded. If we had such a requirement, we would send the image back to the UI as soon as it is downloaded so the user can see it, and in the background, we will process the image (apply any filters or effects which can be time consuming) and once ready, we will update the UI with the final image.

A couple of CocoaPods libraries have been used in this project. I've chosen to implement most of the things natively to reduce dependencies to third party libraries as often those could cause issues, specially in new releases of iOS, but at the same time I wanted to show a couple of CocoaPod integration examples. ReachabilitySwift and Toast-Swift felt like two good candidates.

I wanted to design the app following SOLID principles to keep its components decoupled so it can be extended and mantained easily moving forward. Another important benefit of using SOLID principles is that writing tests becomes much easier as components have "ideally" a single responsibility so its tests are small and clean.

We have a combination of UnitTests and IntegrationTests (99 in total). Test coverage is not 100% and unfortunately I could not implement UITests due time constraints. In our production app though, UITests will be in place to test all the user journeys and actions performed by the app. On the positive side, our integration test will tell us when Flickr feed is down or failed to download data. This test coverage though should give us enough confidence to know that the app will perform as expected.

Notice that we have a view to handle network errors such as no internet connection, and a retry button is in place when something goes wrong. Also a Loading view has been added to give a better user experience.

Finally, the app has been designed as a Universal App and supports any screen orientation. You will notice though that the UI/UX is not perfect, but as any good Universal image app would do, images on the iPad are bigger than images on the iPhone.

Enjoy!


