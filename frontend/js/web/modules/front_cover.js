import axios from 'axios';
import { h, app } from 'hyperapp';
import { Route, location, Redirect } from "@hyperapp/router";

const perPage = 3;

// components
import Detail from './components/post_detail';
import FrontCoverContents from './components/front_cover_contents';
import FrontCoverPagination from './components/front_cover_pagination';
import ErrorPage from './components/error_page';

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
  isLastPage: false,
  backendApiError: false,
  queryParameter: ''
};

// actions
const actions = {
  location: location.actions,

  // call backend API
  getPosts: () => (state, actions) => {
    axios.get('/authentication').then(res => {
      axios.get(`/posts?page=${state.currentPage}&perPage=${perPage}`, { headers: { 'Backend-Api-Token': res.data.api_token } }).then(_res => {
        actions.setPosts(_res.data);
        _res.data.length < perPage ? actions.chageLastPage(true) : actions.chageLastPage(false);
      }).catch(_e => { actions.errorBackendApi(); })
    }).catch(e => { actions.errorBackendApi(); });
  },
  getPost: (post_id) => (state, actions) => {
    axios.get('/authentication').then(res => {
      axios.get(`/posts/${post_id}`, { headers: { 'Backend-Api-Token': res.data.api_token } }).then(res => {
        actions.setPost(res.data);
      }).catch(_e => { actions.errorBackendApi(); })
    }).catch(e => { actions.errorBackendApi(); });
  },

  // set state
  setPosts:        posts => state => ({ posts: posts }),
  setPost:         post => state => ({ post: post }),
  chageLastPage:   bool => state => ({ isLastPage: bool }),
  errorBackendApi: () => state => ({ backendApiError: true }),
  upPage: () => state => {
    const _currentPage    = state.currentPage + 1;
    const _queryParameter = `?page=${_currentPage}`;
    _method.actions.setQueryParameter(_queryParameter);

    return {
      currentPage: _currentPage,
      queryParameter: _queryParameter
    };
  },
  downPage: () => state => {
    const _currentPage    = state.currentPage - 1;
    const _queryParameter = `?page=${_currentPage}`;
    _method.actions.setQueryParameter(_queryParameter);

    return {
      currentPage: _currentPage,
      queryParameter: _queryParameter
    };
  }
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
  } else if(state.backendApiError) {
    return(<ErrorPage/>);
  } else {
    actions.getPosts();
    return null;
  }
};

// contain methods to use generally
const _method = {
  actions: {
    setQueryParameter: (queryParameter) => {
      history.replaceState('', '', queryParameter);
    }
  }
}

const main = app(state, actions, view, document.body);

const unsubscribe = location.subscribe(main.location);
