import { h } from 'hyperapp';
import { Link } from '@hyperapp/router';
import removeMd from 'remove-markdown';
import {convertDateFormat} from '../../../utilities/_time'

const MAX_BODY_LENGTH = 100;

const bodyDisplayFrame = (body) => {
  if(body.length > MAX_BODY_LENGTH) {
    return body.substr(0, MAX_BODY_LENGTH - 1) + ' ...';
  } else {
    return body;
  }
};

const readMore = (post, setPost) => {
  if(post.body.length <= MAX_BODY_LENGTH) {
    return null;
  } else {
    return <Link to={`/posts/${post.id}`} class='read-more' onclick={() => setPost(post)}>続きを読む</Link>;
  }
};

const PostComponent = (props) => {
  const post = props.post;

  return(
    <article class='post'>
      <h3 class='post-title'>{post.title}</h3>
      <p class='post-created-at'>{convertDateFormat(post.created_at)}</p>
      <p class='post-body'>{removeMd(bodyDisplayFrame(post.body))}</p>
      {readMore(post, props.setPost)}
    </article>
  );
};

export default ({ posts, setPost }) => {
  return(
    posts.map((post) =>
      <PostComponent post={post} setPost={setPost} />
    )
  );
};
