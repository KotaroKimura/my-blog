import axios from 'axios'
import {csrfToken} from '../../utilities/_csrf_token'

document.addEventListener('DOMContentLoaded', () => {
  const createButtonDOM = document.getElementById('post-create')

  if(createButtonDOM) {
    createButtonDOM.addEventListener('click', () => {
      axios.post(`/admin/posts?_csrf_token=${csrfToken()}`).then(res => {
        window.location.href = window.location.origin + res.data
      }).catch(e => {
        alert(e.response.data)
      })
    }, false);
  }
})