const csrfToken = () => {
  return document.getElementsByName('csrf-token')[0].content;
}

module.exports = {
  csrfToken
}