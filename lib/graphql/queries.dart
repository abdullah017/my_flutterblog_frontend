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
