import CryptoJS from '@ohos/crypto-js'

//将obj中所有参数，除去sign本身以及值为空的参数，按参数名字母升顺排序,使用 || 做为拼接符
function arrSort(obj) {
  if (obj == undefined || obj == null || !Object.keys(obj).length) {
    return "";
  }
  var arr = [];
  if (obj.hasOwnProperty("sign")) {
    delete obj.sign;
  }

  for (var i in obj) {
    if (obj[i] instanceof Object && Object.keys(obj[i]).length) {
      obj[i] = JSON.stringify(objKeySort(obj[i]));
    }
    if (obj[i] != undefined && obj[i] != null && obj[i] !== "") {

      if (obj[i] instanceof Object) {
        if (Object.keys(obj[i]).length) {
          var o = i + "=" + obj[i];
          arr.push(o);
        }
      } else {
        var s = i + "=" + obj[i];
        arr.push(s);
      }
    }
  }
  arr.sort();
  var str = arr.join("||");
  return str;
}

function objKeySort(obj) {
  //排序的函数
  //先用Object内置类的keys方法获取要排序对象的属性名，再利用Array原型上的sort方法对获取的属性名进行排序，newkey是一个数组
  var newkey = Object.keys(obj).sort();
  var newObj = {}; //创建一个新的对象，用于存放排好序的键值对
  if (obj instanceof Array) {
    newObj = [];
  }
  for (var i = 0; i < newkey.length; i++) {
    //遍历newkey数组
    // newObj[newkey[i]] = obj[newkey[i]];
    if (
      obj[newkey[i]] instanceof Object &&
      Object.keys(obj[newkey[i]]).length
    ) {
      newObj[newkey[i]] = objKeySort(obj[newkey[i]]);
    }
    if (!(obj[newkey[i]] instanceof Object)) {
      newObj[newkey[i]] = obj[newkey[i]]; //向新创建的对象中按照排好的顺序依次增加键值对
    }
  }
  return newObj; //返回排好序的新对象
}

export function uuid() {
  var s = [];
  var hexDigits = "0123456789abcdef";
  for (var i = 0; i < 36; i++) {
    s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
  }
  s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
  s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
  s[8] = s[13] = s[18] = s[23] = "-";

  var uuid = s.join("");
  return uuid;
}

//生成 sign 签名
export function generateSign(jsonObj, clientSecret) {
  var headerStr = arrSort(jsonObj.system);
  var paramsStr = arrSort(jsonObj.params);
  var sign = "";
  if (paramsStr) {
    sign = headerStr + "||" + paramsStr + "||" + clientSecret;
  } else {
    sign = headerStr + "||" + clientSecret;
  }
  return sign;
}

export function generateMD5Sign(jsonObj, clientSecret) {
  var headerStr = arrSort(jsonObj.system);
  var paramsStr = arrSort(jsonObj.params);
  var sign = "";
  if (paramsStr) {
    sign = headerStr + "||" + paramsStr + "||" + clientSecret;
  } else {
    sign = headerStr + "||" + clientSecret;
  }
  return CryptoJS.MD5(sign).toString()
}