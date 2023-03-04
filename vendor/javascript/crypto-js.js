import r from"./core.js";import o from"./x64-core.js";import a from"./lib-typedarrays.js";import m from"./enc-utf16.js";import t from"./enc-base64.js";import i from"./md5.js";import s from"./sha1.js";import f from"./sha256.js";import p from"./sha224.js";import e from"./sha512.js";import n from"./sha384.js";import v from"./sha3.js";import j from"./ripemd160.js";import c from"./hmac.js";import d from"./pbkdf2.js";import h from"./evpkdf.js";import u from"./cipher-core.js";import l from"./mode-cfb.js";import b from"./mode-ctr.js";import g from"./mode-ctr-gladman.js";import _ from"./mode-ofb.js";import y from"./mode-ecb.js";import A from"./pad-ansix923.js";import x from"./pad-iso10126.js";import B from"./pad-iso97971.js";import C from"./pad-zeropadding.js";import k from"./pad-nopadding.js";import w from"./format-hex.js";import L from"./aes.js";import M from"./tripledes.js";import T from"./rc4.js";import z from"./rabbit.js";import O from"./rabbit-legacy.js";import"crypto";var W="undefined"!==typeof globalThis?globalThis:"undefined"!==typeof self?self:global;var q={};(function(o,a){q=q=a(r)})(0,(function(r){(function(){var o=r;var a=o.lib;var m=a.WordArray;var t=o.enc;t.Base64url={
/**
       * Converts a word array to a Base64url string.
       *
       * @param {WordArray} wordArray The word array.
       *
       * @param {boolean} urlSafe Whether to use url safe
       *
       * @return {string} The Base64url string.
       *
       * @static
       *
       * @example
       *
       *     var base64String = CryptoJS.enc.Base64url.stringify(wordArray);
       */
stringify:function(r,o=true){var a=r.words;var m=r.sigBytes;var t=o?(this||W)._safe_map:(this||W)._map;r.clamp();var i=[];for(var s=0;s<m;s+=3){var f=a[s>>>2]>>>24-s%4*8&255;var p=a[s+1>>>2]>>>24-(s+1)%4*8&255;var e=a[s+2>>>2]>>>24-(s+2)%4*8&255;var n=f<<16|p<<8|e;for(var v=0;v<4&&s+.75*v<m;v++)i.push(t.charAt(n>>>6*(3-v)&63))}var j=t.charAt(64);if(j)while(i.length%4)i.push(j);return i.join("")},
/**
       * Converts a Base64url string to a word array.
       *
       * @param {string} base64Str The Base64url string.
       *
       * @param {boolean} urlSafe Whether to use url safe
       *
       * @return {WordArray} The word array.
       *
       * @static
       *
       * @example
       *
       *     var wordArray = CryptoJS.enc.Base64url.parse(base64String);
       */
parse:function(r,o=true){var a=r.length;var m=o?(this||W)._safe_map:(this||W)._map;var t=(this||W)._reverseMap;if(!t){t=(this||W)._reverseMap=[];for(var i=0;i<m.length;i++)t[m.charCodeAt(i)]=i}var s=m.charAt(64);if(s){var f=r.indexOf(s);-1!==f&&(a=f)}return parseLoop(r,a,t)},_map:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",_safe_map:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"};function parseLoop(r,o,a){var t=[];var i=0;for(var s=0;s<o;s++)if(s%4){var f=a[r.charCodeAt(s-1)]<<s%4*2;var p=a[r.charCodeAt(s)]>>>6-s%4*2;var e=f|p;t[i>>>2]|=e<<24-i%4*8;i++}return m.create(t,i)}})();return r.enc.Base64url}));var D=q;var E={};(function(W,q,F){E=E=q(r,o,a,m,t,D,i,s,f,p,e,n,v,j,c,d,h,u,l,b,g,_,y,A,x,B,C,k,w,L,M,T,z,O)})(0,(function(r){return r}));var F=E;export default F;

