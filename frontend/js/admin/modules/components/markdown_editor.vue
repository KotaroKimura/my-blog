<template>
  <div id='post-edit-container'>
    <div class='title-and-message-box-container'>
      <input class='title' type='text' v-model="attributes.title" placeholder="タイトルを入力してください.">
      <div class='message-box' v-if="message.text" v-bind:class="message.color">{{message.text}}</div>
    </div>
    <mavon-editor ref="md" v-model="attributes.body" language='en' :toolbars="toolbars" :boxShadow="false" placeholder='本文を入力してください.' @imgAdd="$imgAdd" @imgDel="$imgDel"></mavon-editor>
    <button class='post-bottun' type='submit' v-on:click="update()">保存する</button>
  </div>
</template>

<script>
  import axios from 'axios'
  import { mavonEditor } from 'mavon-editor'
  import { forEach } from 'lodash/lodash'
  import { csrfToken } from '../../../utilities/_csrf_token'

  export default {
    name: 'editor',
    components: {
      mavonEditor
    },
    data() {
      return {
        message: {
          text: '',
          color: ''
        },
        attributes: {
          title: '',
          body: '',
        },
        toolbars: {
          bold: true,
          italic: true,
          header: true,
          underline: true,
          strikethrough: true,
          mark: true,
          superscript: true,
          subscript: true,
          quote: true,
          ol: true,
          ul: true,
          link: true,
          imagelink: true,
          code: true,
          table: true,
          help: true,
          /* 1.3.5 */
          undo: true,
          redo: true,
          trash: true,
          /* 2.1.8 */
          alignleft: true,
          aligncenter: true,
          alignright: true,
          /* 2.2.1 */
          preview: true
        }
      }
    },
    created() {
      this.load()
    },
    computed: {
      postId() {
        return window.location.pathname.match(/posts\/(\d+)\/edit/)[1]
      },
      _md() {
        return this.$refs.md
      }
    },
    methods: {
      generateMessageBox(text, color='green') {
        this.message.text  = text
        this.message.color = color
      },
      clearMessageBox() {
        setTimeout(()=> { this.message.text = ''; this.message.color = ''; }, 3000)
        return null
      },
      load() {
        axios.get(`/admin/posts/${this.postId}/edit`).then(res => {
          const _this           = this
          this.attributes.body  = res.data.body
          this.attributes.title = res.data.title

          forEach(res.data.images, function(image, index) {
            const _function = {
              toFile(fileName, fileType) {
                const bin    = atob('')
                const buffer = new Uint8Array(bin.length)
                return new File([buffer.buffer], fileName, { type: fileType })
              }
            }

            const imageUrlFullPath                            = window.location.origin + image[1]
            const filedImage                                  = _function.toFile(image[0], image[2])
            filedImage.miniurl                                = imageUrlFullPath
            _this._md.$refs.toolbar_left.img_file[index][1]   = imageUrlFullPath
            _this._md.$refs.toolbar_left.img_file[index+1]    = []
            _this._md.$refs.toolbar_left.img_file[index+1][0] = filedImage
            _this._md.$refs.toolbar_left.img_file[index+1][1] = index
            _this._md.$refs.toolbar_left.num                  = index+1
          })
        }).catch(e => {
          console.log(e)
          this.generateMessageBox('Could Not Load Data. Please Reload Again.', 'red')
        })
      },
      update() {
        axios.patch(`/admin/posts/${this.postId}?_csrf_token=${csrfToken()}`, this.attributes).then(res => {
          this.generateMessageBox(res.data)
          this.clearMessageBox()
        }).catch(e => {
          this.generateMessageBox(e.response.data, 'red')
        })
      },
      $imgAdd(pos, $file) {
        const formdata = new FormData()
        formdata.append('image', $file)
        formdata.append('post_id', this.postId)
        formdata.append('_csrf_token', csrfToken())

        axios({
          url: '/admin/images',
          method: 'post',
          data: formdata,
          headers: { 'Content-Type': 'multipart/form-data' },
        }).then(res => {
          this._md.$img2Url(pos, window.location.origin + res.data.image_url)
          this.generateMessageBox('Image was Uploaded.')
          this.clearMessageBox()
        }).catch(e => {
          this.generateMessageBox(e.response.data, 'red')
        })
      },
      $imgDel(pos) {
        const formdata = new FormData()
        formdata.append('miniurl',     pos[0].miniurl)
        formdata.append('_csrf_token', csrfToken())

        axios({
          url: `/admin/images/${pos[0].name}`,
          method: 'delete',
          data: formdata
        }).then(res => {
          this.generateMessageBox(res.data)
          this.clearMessageBox()
        }).catch(e => {
          this.generateMessageBox(e.response.data, 'red')
        })
      },
    }
  }
</script>

<style lang="scss" scoped>
  #post-edit-container {
    width: 100%;
    .title-and-message-box-container {
      display: flex;
      .title {
        width: 40%;
        height: 2rem;
        margin: 1rem 0;
        font-size: 1rem;
        padding: 0 1%;
      }
      .message-box {
        width: 59%;
        text-align: right;
        margin: 2% 0 0 0;
        &.green {
          color: #4FB99F;
        }
        &.red {
          color: #ED553B;
        }
      }
    }
    .markdown-body {
      max-height: 475px;
      min-height: 475px;
    }
    .post-bottun {
      width: 8%;
      padding: 1% 0;
      margin: 2% 0 0 0;
      cursor: pointer;
      border-radius: 3px;
      font-size: 0.7em;
      &:focus {
        outline: none;
      }
    }
  }
</style>