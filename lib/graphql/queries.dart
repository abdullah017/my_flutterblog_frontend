/// The `GET_POSTS` constant in Dart is storing a GraphQL query string. This particular query is named
/// `GetPosts` and it retrieves a list of posts ordered by the `created_at` field in descending order.
/// The query fetches the `id`, `title`, `content`, `cover_image`, `is_published`, `created_at`, and
/// `updated_at` fields for each post.
const String GET_POSTS = r'''
  query GetPosts {
    posts(order_by: { created_at: desc }) {
      id
      title
      content
      cover_image
      is_published
      created_at
      updated_at
    }
  }
''';
/// The `GET_POST_BY_ID` constant in Dart is storing a GraphQL query string. This query is named
/// `GetPostById` and it is used to retrieve a specific post by its `id`. The query fetches the `id`,
/// `title`, `content`, `cover_image`, `is_published`, `created_at`, and `updated_at` fields for the
/// post with the specified `id`. The query takes a parameter `` of type `Int!` which is required to
/// fetch the post with that specific id.

const String GET_POST_BY_ID = r'''
  query GetPostById($id: Int!) {
    posts_by_pk(id: $id) {
      id
      title
      content
      cover_image
      is_published
      created_at
      updated_at
    }
  }
''';
