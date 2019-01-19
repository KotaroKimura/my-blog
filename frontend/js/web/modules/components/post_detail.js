import { h } from 'hyperapp';
import markdownIt from 'markdown-it';
import {convertDateFormat} from '../../../utilities/_time'
import ErrorPage from './error_page';

export default (state, actions, postId) => {
  const md = new markdownIt();

  if(Object.keys(state.post).length !== 0) {
    return(
      <div class='detail'>
        <h4 class='site-title'>PostList.</h4>
        <article class='post'>
          <p class='post-created-at'>{convertDateFormat(state.post.created_at)}</p>
          <h2 class='post-title'>{state.post.title}</h2>
          <div class='contant' innerHTML={md.render(state.post.body)}></div>
        </article>
      </div>
    );
  } else if(state.backendApiError) {
    return(<ErrorPage/>);
  } else {
    actions.getPost(postId);
    return null;
  }
};
