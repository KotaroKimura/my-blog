import axios from 'axios';
import { h, app } from 'hyperapp';
import { Route, location, Redirect } from "@hyperapp/router"

const perPage = 3;

// components
import Detail from './components/post_detail';
import FrontCoverContents from './components/front_cover_contents';
import FrontCoverPagination from './components/front_cover_pagination';

const Index = (state, actions) => {
  return(
    <div class='index'>
      <h1 class='site-title'>PostList.</h1>
      <FrontCoverContents posts={state.posts} setPost={actions.setPost} />
      <FrontCoverPagination
        getPosts={actions.getPosts}
        upPage={actions.upPage}
        downPage={actions.downPage}
        currentPage={state.currentPage}
        isLastPage={state.isLastPage}
      />
    </div>
  );
}

// state
const state = {
  location: location.state,

  posts: [],
  post: {},
  currentPage: 1,
  isLastPage: false
};

// actions
const actions = {
  location: location.actions,

  // call backend API
  getPosts: () => (state, actions) => {
    axios.get(`/posts?page=${state.currentPage}&perPage=${perPage}`).then(res => {
      actions.setPosts(res.data);
      res.data.length < perPage ? actions.chageLastPage(true) : actions.chageLastPage(false);
    });
  },
  getPost: (post_id) => (state, actions) => {
    axios.get(`/posts/${post_id}`).then(res => {
      actions.setPost(res.data);
    });
  },

  // set state
  setPosts:      posts => state => ({ posts: posts }),
  setPost:       post => state => ({ post: post }),
  upPage:        () => state => ({ currentPage: state.currentPage + 1 }),
  downPage:      () => state => ({ currentPage: state.currentPage - 1 }),
  chageLastPage: bool => state => ({ isLastPage: bool }),
};

// view
const view = (state, actions) => {
  const isDetail = state.location.pathname.match(/posts\/(\d+)/);

  if(isDetail || state.posts.length > 0) {
    return(
      <main id='container'>
        <Route path='/' render={() => Index(state, actions)} />
        <Route path='/posts' render={() => <Redirect to="/" />} />
        <Route path='/posts/:id' render={() => Detail(state, actions, isDetail[1])} />
      </main>
    );
  } else {
    actions.getPosts();
    return null;
  }
};

const main = app(state, actions, view, document.body);

const unsubscribe = location.subscribe(main.location);
