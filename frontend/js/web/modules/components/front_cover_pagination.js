import { h } from 'hyperapp';

const getPrev = (props) => {
  props.downPage();
  props.getPosts();
}

const getNext = (props) => {
  props.upPage();
  props.getPosts();
}

const prevComponent = (props) => {
  if(props.currentPage === 1) {
    return null;
  } else {
    return <div class='prev common' onclick={() => getPrev(props)}><span>前へ</span></div>;
  }
}

const nextComponent = (props) => {
  if(props.isLastPage) {
    return null;
  } else {
    return <div class='next common' style={{ textAlign: props.currentPage === 1 ? '' : 'right' }} onclick={() => getNext(props)}><span>次へ</span></div>;
  }
}

export default (props) => {
  return(
    <div class='pagination'>
      {prevComponent(props)}
      {nextComponent(props)}
    </div>
  );
};
