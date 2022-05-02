abstract class RouteBoard{
  static const home = '/';
  static const board = '/board/:boardName';
  static const post = '$board/:id';
  static const postCreate = '/post-create/:boardName';
  static const postUpdate = '/post-update/:boardName';
  static const notFound = '/not-found';
  static const notAvailable = '/not-available';
}