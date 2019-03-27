Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40104C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 119FE2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 07:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfC0HPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 03:15:49 -0400
Received: from asrmicro.com ([210.13.118.86]:20484 "EHLO
        barracuda.asrmicro.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbfC0HPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 03:15:49 -0400
X-ASG-Debug-ID: 1553670943-12329d17f8006a0001-xx1T2L
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123]) by barracuda.asrmicro.com with ESMTP id okml9KCLPzqChKwu; Wed, 27 Mar 2019 15:15:43 +0800 (CST)
X-Barracuda-Envelope-From: qiaozhou@asrmicro.com
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 27 Mar
 2019 15:15:42 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Wed, 27 Mar 2019 15:15:42 +0800
From:   =?gb2312?B?WmhvdSBRaWFvKNbcx8gp?= <qiaozhou@asrmicro.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: add support for ASR AquilaC SoC
Thread-Topic: [PATCH] arm64: add support for ASR AquilaC SoC
X-ASG-Orig-Subj: Re: [PATCH] arm64: add support for ASR AquilaC SoC
Thread-Index: AQHU4dyn2sGIvBR3R0qU+RLDVsHGCA==
Date:   Wed, 27 Mar 2019 07:15:42 +0000
Message-ID: <392f0d859fd446b5a8e637c2b858089f@mail2012.asrmicro.com>
References: <1553389083-13237-1-git-send-email-qiaozhou@asrmicro.com>
 <20190326081251.GE32613@kadam>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.6.250]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: mail2012.asrmicro.com[10.1.24.123]
X-Barracuda-Start-Time: 1553670943
X-Barracuda-URL: https://10.1.24.120:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at asrmicro.com
X-Barracuda-Scan-Msg-Size: 1658
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.69048
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8zLzI2IM/Czuc0OjEzLCBEYW4gQ2FycGVudGVyIHdyb3RlOgo+IEknbSBub3QgdGhl
IHJpZ2h0IHBlcnNvbiB0byBzZW5kIHRoaXMgdG8uLi4KPgo+ICQgLi9zY3JpcHRzL2dldF9tYWlu
dGFpbmVyLnBsIC1mIGFyY2gvYXJtNjQvS2NvbmZpZy5wbGF0Zm9ybXMKPiBDYXRhbGluIE1hcmlu
YXMgPGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tPiAobWFpbnRhaW5lcjpBUk02NCBQT1JUIChBQVJD
SDY0IEFSQ0hJVEVDVFVSRSkpCj4gV2lsbCBEZWFjb24gPHdpbGwuZGVhY29uQGFybS5jb20+ICht
YWludGFpbmVyOkFSTTY0IFBPUlQgKEFBUkNINjQgQVJDSElURUNUVVJFKSkKPiBsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcgKG1vZGVyYXRlZCBsaXN0OkFSTTY0IFBPUlQgKEFB
UkNINjQgQVJDSElURUNUVVJFKSkKPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIChvcGVu
IGxpc3QpCkknbGwgc2VuZCBpdCB0byBDYXRhbGluIGFuZCBXaWxsLiAgVGhhbmtzIGEgbG90IGZv
ciB5b3VyIHJldmlld2luZy4KPgo+Cj4gT24gU3VuLCBNYXIgMjQsIDIwMTkgYXQgMDg6NTg6MDNB
TSArMDgwMCwgcWlhb3pob3Ugd3JvdGU6Cj4+IEZyb206IFFpYW8gWmhvdSA8cWlhb3pob3VAYXNy
bWljcm8uY29tPgo+Pgo+PiBBZGQgQVJDSF9BU1IKPiBZb3UnbGwgbmVlZCB0byBleHBhbmQgdGhp
cy4KWWVzLCBJJ2xsIGFkZCBtb3JlIGRlc2NyaXB0aW9uLgo+Cj4+IFNpZ25lZC1vZmYtYnk6IHFp
YW96aG91IDxxaWFvemhvdUBhc3JtaWNyby5jb20+Cj4gICAgICAgICAgICAgICAgICBeXl5eXl5e
Xgo+IFVzZSBRaWFvIFpob3Ugc28gaXQgbWF0Y2hlcyB0aGUgRnJvbSBoZWFkZXIuCk9LLgo+Cj4K
Pj4gLS0tCj4+ICBhcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zIHwgNiArKysrKysKPj4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvS2NvbmZpZy5wbGF0Zm9ybXMgYi9hcmNoL2FybTY0L0tjb25maWcucGxhdGZvcm1zCj4+IGlu
ZGV4IDcwNDk4YTAuLmRhOGQ0M2EgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvYXJtNjQvS2NvbmZpZy5w
bGF0Zm9ybXMKPj4gKysrIGIvYXJjaC9hcm02NC9LY29uZmlnLnBsYXRmb3Jtcwo+PiBAQCAtMjc4
LDQgKzI3OCwxMCBAQCBjb25maWcgQVJDSF9aWU5RTVAKPj4gIAloZWxwCj4+ICAJICBUaGlzIGVu
YWJsZXMgc3VwcG9ydCBmb3IgWGlsaW54IFp5bnFNUCBGYW1pbHkKPj4gIAo+PiArY29uZmlnIEFS
Q0hfQVNSCj4+ICsJYm9vbCAiQVNSIE1pY3JvZWxlY3Ryb25pY3MgY2hpcCBGYW1pbHkiCj4+ICsJ
c2VsZWN0IFBJTkNUUkwKPj4gKwloZWxwCj4+ICsJICBUaGlzIGVuYWJsZXMgc3VwcG9ydCBmb3Ig
QVNSIE1pY3JvZWxlY3Ryb25pY3MgY2hpcCBGYW1pbHksIGluY2x1ZGluZzoKPj4gKwkgIC0gQVNS
IDg3NTFDIFNvQwo+PiAgZW5kbWVudQo+IFdhcyB0aGlzIHN1cHBvc2VkIHRvIGJlIHBhcnQgb2Yg
dGhlIHBhdGNoIHlvdSBzZW50IGVhcmxpZXI/ICBZb3Ugd2lsbAo+IG5lZWQgdG8gcmVzZW5kIHRo
YXQgb25lIGFzIGEgdjIgcGF0Y2guClllcy4gIEknbGwgcmVmaW5lIHRoZSBwYXRjaGVzIGFuZCBy
ZXNlbmQgVjIgcGF0Y2ggc2V0LiBUaGFua3MuCj4KPiByZWdhcmRzLAo+IGRhbiBjYXJwZW50ZXIK
Pgo+Cgo=
