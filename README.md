# EnricTest
iOS App to show a list of public images from Flickr Feed.

This application has been developed using VIPER architecture.

At the is very simple and it only has one module called ImageList. The module has been split into multiple layers to separate responsabilities and keep each layer decoupled from each other.

A VIPER architecture is splitted into the following parts:

- View: Reponsible to present the User Interface. ImageList module has a ImageListView protocol which is implemented by ImageListViewController. This protocol defines all the relevant methods needed for a View to do its job.
- Interactor: Responsible to execute any interactions. ImageList module has a ImageListInteractor protocol which allow us to fetch a list of images, load an image from a URL, and cancel an image load.
- Presenter: Responsible to prepare any data to be consumed by the View. Any interaction on the view is then comunicated to the presenter through an ImageListPresenter protocol so the presenter can act accordingly. Presenters normally use a ViewModel to send data back to the view.
- Entity: Entity are the objects that represent our model. In our case that would be the DataFeed class responsability.
- Router: A router or Wireframe is responsible to build and present the module and also navigate to other modules in the app.

As you will notice, the ImageListInteractor uses Operation objects and an OperationQueue. That is design this way so in the future, we could exend this using Operation dependencies to perform multiple tasks such as caching the image once has been downloaded. The way it would work is as it is, but as well as sending back the image to be displayed in the UI, we would then pass it to another Operation (which would depend on ImageDownloadOperation) which would then cache it.

Only onle CocoaPods library has been used in this project. I've choosen to implement most of the thing natively to reduce dependencies to third party libraries as often those could cause issue, specially in new releases of iOS but at the same time I wanted to show a CocoaPod integration example. ReachabilitySwift felt like the right candidate.

I wanted to design the app following SOLID principles to keep its components decoupled so it can be extended and mantained easily moving forward. Another important benefit of using SOLID principles is that writing tests becomes much easier as components have "ideally" a single responsability so its tests are small and clean.

We have a combination of UnitTests and IntegrationTests (63 in total). Test coverage is about 80%, in our final version we will make sure that all components are fully tested but for this demo due to time constraints I could not get 100% test coverage. Our integration test will tell us when Flickr feed is dow or failes to downlowd data. This test coverage gives me enough confidence that the app will perform as expected.

Notice that we have a view to handle network errors such as no internet connection, and a retry button so the app does not crash or hangs when something goes wrong. Also a Loading view has been added to give a better user experience.

Finally, the app has been designed only for iPhone portrait but supporting iPad and other screen orientations will be easily done.

Enjoy!



