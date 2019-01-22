const getNowYMD = () => {
  const dt     = new Date();
  const y      = dt.getFullYear();
  const m      = ("00" + (dt.getMonth()+1)).slice(-2);
  const d      = ("00" + dt.getDate()).slice(-2);
  const result = y + '-' + m + '-' + d;

  return result;
}

module.exports = {
  getNowYMD
}