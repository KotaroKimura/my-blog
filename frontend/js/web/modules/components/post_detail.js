import { h } from 'hyperapp';
import markdownIt from 'markdown-it';
import taskLists from 'markdown-it-task-lists';
import mark from 'markdown-it-mark';
import ins from 'markdown-it-ins';
import foornote from 'markdown-it-footnote';
import abbr from 'markdown-it-abbr';
import emoji from 'markdown-it-emoji';
import sup from 'markdown-it-sup';
import sub from 'markdown-it-sub';
import container from 'markdown-it-container';
import hljs from 'highlight.js';
import {convertDateFormat} from '../../../utilities/_time';
import ErrorPage from './error_page';

export default (state, actions, postId) => {
  const md = new markdownIt({
    highlight: function (str, lang) {
      if (lang && hljs.getLanguage(lang)) {
        try {
          return hljs.highlight(lang, str).value;
        } catch (__) {}
      }

      return '';
    }
  }).use(taskLists)
    .use(mark)
    .use(ins)
    .use(foornote)
    .use(abbr)
    .use(emoji)
    .use(sup)
    .use(sub)
    .use(container)
    .use(container, 'hljs-left')
    .use(container, 'hljs-center')
    .use(container, 'hljs-right');

  if(Object.keys(state.post).length !== 0) {
    return(
      <div class='detail'>
        <h4 class='site-title'>PostList.</h4>
        <article class='post'>
          <p class='post-created-at'>{convertDateFormat(state.post.created_at)}</p>
          <h2 class='post-title'>{state.post.title}</h2>
          <div class='markdown-body' innerHTML={md.render(state.post.body)}></div>
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
