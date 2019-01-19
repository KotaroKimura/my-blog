const convertDateFormat = (timestamp) => {
  const parsedTimestamp = Date.parse(timestamp);
  const date = new Date(parsedTimestamp);
  return date.toISOString().match(/(\d{4}-\d{2}-\d{2})/)[0];
}

module.exports = {
  convertDateFormat
}