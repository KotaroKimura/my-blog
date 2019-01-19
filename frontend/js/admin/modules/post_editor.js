import Vue from 'vue'
import MarkdownEditor from './components/markdown_editor.vue'

document.addEventListener('DOMContentLoaded', () => {
  const markdownEditorDOM = document.getElementById('markdown-editor')

  if(markdownEditorDOM) {
    const markdownEditor = new Vue({
      el: markdownEditorDOM,
      render: h => h(MarkdownEditor),
    })
  }
})