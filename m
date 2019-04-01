Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EB9C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CDEC20870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 02:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731571AbfDACJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:09:29 -0400
Received: from asrmicro.com ([210.13.118.86]:33668 "EHLO
        barracuda.asrmicro.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726985AbfDACJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 22:09:29 -0400
X-ASG-Debug-ID: 1554084565-12329d17f794e70001-xx1T2L
Received: from mail2012.asrmicro.com (mail2012.asrmicro.com [10.1.24.123]) by barracuda.asrmicro.com with ESMTP id 34GpxCfH6dTdF3Yg; Mon, 01 Apr 2019 10:09:25 +0800 (CST)
X-Barracuda-Envelope-From: qiaozhou@asrmicro.com
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Mon, 1 Apr
 2019 10:09:25 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Mon, 1 Apr 2019 10:09:25 +0800
From:   =?gb2312?B?WmhvdSBRaWFvKNbcx8gp?= <qiaozhou@asrmicro.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: asr: clock driver support for ASR AquilaC Soc
Thread-Topic: [PATCH] clk: asr: clock driver support for ASR AquilaC Soc
X-ASG-Orig-Subj: Re: [PATCH] clk: asr: clock driver support for ASR AquilaC Soc
Thread-Index: AQHU4YHopz31FtWFAkiYszGyOOeFvQ==
Date:   Mon, 1 Apr 2019 02:09:24 +0000
Message-ID: <a652d858bd3d4c0a9670e03182d5fd8e@mail2012.asrmicro.com>
References: <1553350115-2614-1-git-send-email-qiaozhou@asrmicro.com>
 <155389787963.20095.9145169286940814698@swboyd.mtv.corp.google.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.6.250]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Barracuda-Connect: mail2012.asrmicro.com[10.1.24.123]
X-Barracuda-Start-Time: 1554084565
X-Barracuda-URL: https://10.1.24.120:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at asrmicro.com
X-Barracuda-Scan-Msg-Size: 2751
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.69254
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS8zLzMwIMnPzuc2OjE4LCBTdGVwaGVuIEJveWQgd3JvdGU6Cj4gUXVvdGluZyBxaWFv
emhvdSAoMjAxOS0wMy0yMyAwNzowODozNSkKPj4gRnJvbTogUWlhbyBaaG91IDxxaWFvemhvdUBh
c3JtaWNyby5jb20+Cj4+Cj4+IGFkZCBjbG9jayBkcml2ZXIgc3VwcG9ydCBmb3IgQVNSIEFxdWls
YUMgU29DLgo+Pgo+PiBXZSBhZGQgY2xrLWdhdGUsIGNsay1taXgsIGFuZCBjbGstcGxsIGRyaXZl
cnM6Cj4+IDEuIGNsay1nYXRlIGRyaXZlciBpcyBmb3IgcmVnaXNlcnMgd2hpY2ggaGF2ZSBkaWZm
ZXJlbnQgZW5hYmxlL2Rpc2FibGUgYml0cwo+PiB0byBjb250cm9sIGdhdGluZy4KPj4gMi4gY2xr
LW1peCBkcml2ZXIgaXMgZm9yIHJlZ2lzdGVycyB3aGljaCByZXF1ZXN0IHRvIHNldCBkaXYgYW5k
IG11eAo+PiBiaXRzIGF0IHRoZSBzYW1lIHRpbWUuCj4+IDMuIGNsay1wbGwgZHJpdmVyIGlzIGZv
ciBwbGwgY29uZmlndXJhdGlvbi4KPj4KPj4gU2lnbmVkLW9mZi1ieTogcWlhb3pob3UgPHFpYW96
aG91QGFzcm1pY3JvLmNvbT4KPiBQbGVhc2UgbWFrZSB0aGlzIG1hdGNoIHlvdXIgIkZyb20iIGxp
bmUgYWJvdmUuCkknbGwgY2hhbmdlIGl0Lgo+Cj4+ICsKPj4gK3N0YXRpYyB2b2lkIF9faW5pdCBh
cXVpbGFjX2Nsa19pbml0KHN0cnVjdCBkZXZpY2Vfbm9kZSAqbnApCj4+ICt7Cj4+ICsgICAgICAg
aW50IHJldDsKPj4gKyAgICAgICBzdHJ1Y3QgYXNyX2Nsa19kYXRhICpjbG9ja19kYXRhOwo+PiAr
Cj4+ICsgICAgICAgY2xvY2tfZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKCpjbG9ja19kYXRhKSwgR0ZQ
X0tFUk5FTCk7Cj4+ICsgICAgICAgaWYgKCFjbG9ja19kYXRhKQo+PiArICAgICAgICAgICAgICAg
cmV0dXJuOwo+PiArCj4+ICsgICAgICAgcmV0ID0gYXF1aWxhY19jbGtfb2ZfaW9tYXAobnAsIGNs
b2NrX2RhdGEpOwo+PiArICAgICAgIGlmIChyZXQgPCAwKQo+PiArICAgICAgICAgICAgICAgZ290
byBvdXQ7Cj4+ICsKPj4gKyAgICAgICByZXQgPSBhc3JfY2xrX2luaXQobnAsICZjbG9ja19kYXRh
LT51bml0LCBBU1JfTlJfQ0xLUyk7Cj4+ICsgICAgICAgaWYgKHJldCA8IDApCj4+ICsgICAgICAg
ICAgICAgICBnb3RvIG91dDsKPj4gKwo+PiArICAgICAgIGFxdWlsYWNfZ2VuZXJhbF9jbGtfaW5p
dChjbG9ja19kYXRhKTsKPj4gKwo+PiArICAgICAgIGFxdWlsYWNfcGxsX2luaXQoY2xvY2tfZGF0
YSk7Cj4+ICsKPj4gKyAgICAgICBhcXVpbGFjX21peF9jbGtfaW5pdChjbG9ja19kYXRhKTsKPj4g
Kwo+PiArICAgICAgIGFxdWlsYWNfcGVyaXBoX2Nsa19pbml0KGNsb2NrX2RhdGEpOwo+PiArCj4+
ICsgICAgICAgYXNyX2Nsa3NfZW5hYmxlKChjb25zdCBjaGFyICoqKWtlZXBfb25fY2xvY2tzX3Ri
bCwgQVJSQVlfU0laRShrZWVwX29uX2Nsb2Nrc190YmwpKTsKPj4gKwo+PiArICAgICAgIHJldHVy
bjsKPj4gK291dDoKPj4gKyAgICAgICBrZnJlZShjbG9ja19kYXRhKTsKPj4gK30KPj4gK0NMS19P
Rl9ERUNMQVJFKGFxdWlsYWNfY2xrLCAiYXNyLDg3NTFjLWNsb2NrIiwgYXF1aWxhY19jbGtfaW5p
dCk7Cj4gQW55IHJlYXNvbiB0aGlzIGNhbid0IGJlIGEgcGxhdGZvcm0gZHJpdmVyPwpJdCBjb3Vs
ZCBiZSBhIHBsYXRmb3JtIGRyaXZlci4gV2Ugd3JvdGUgdGhlIGNvZGUgYnkgdGFraW5nIGEgcmVm
ZXJlbmNlCm9mIEhpc2ljb24vU2Ftc3VuZyBjbG9jayBkcml2ZXJzLCBhbmQgd3JvdGUgaXQgbGlr
ZSB0aGlzLiBJIGNhbiBjaGFuZ2UKaXQgdG8gYSBwbGF0Zm9ybSBkcml2ZXIsIGp1c3QgdGhhdCBJ
IGRvbid0IGtub3cgdGhlIGJlbmVmaXRzIHRoYXQgaXQncyBhCnBsYXRmb3JtIGRyaXZlciB0aG91
Z2guIElzIHRoZXJlIGFueSBndWlkZT8gVGhhbmtzLgo+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2Nsay9hc3IvY2xrLWdhdGUuYyBiL2RyaXZlcnMvY2xrL2Fzci9jbGstZ2F0ZS5jCj4+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0Cj4+IGluZGV4IDAwMDAwMDAuLjRiYTU1ODcKPj4gLS0tIC9kZXYvbnVs
bAo+PiArKysgYi9kcml2ZXJzL2Nsay9hc3IvY2xrLWdhdGUuYwo+PiBAQCAtMCwwICsxLDE1MSBA
QAo+PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAKPj4gKy8qCj4+ICsgKiBh
c3IgZ2F0ZSBjbG9jayBvcGVyYXRpb24gc291cmNlIGZpbGUKPj4gKyAqCj4+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMTkgQVNSIE1pY3JvZWxlY3Ryb25pY3MoU2hhbmdoYWkpIENvLiwgTHRkLgo+PiAr
ICogR2FuZyBXdSA8Z2FuZ3d1QGFzcm1pY3JvLmNvbT4KPj4gKyAqIFFpYW8gWmhvdSA8cWlhb3po
b3VAYXNybWljcm8uY29tPgo+PiArICoKPj4gKyAqIFRoaXMgZmlsZSBpcyBsaWNlbnNlZCB1bmRl
ciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYwo+PiArICogTGljZW5zZSB2ZXJz
aW9uIDIuIFRoaXMgcHJvZ3JhbSBpcyBsaWNlbnNlZCAiYXMgaXMiIHdpdGhvdXQgYW55Cj4+ICsg
KiB3YXJyYW50eSBvZiBhbnkga2luZCwgd2hldGhlciBleHByZXNzIG9yIGltcGxpZWQuCj4gUGxl
YXNlIG9ubHkgaGF2ZSB0aGUgU1BEWCB0YWcgYW5kIG5vdCB0aGlzIGFib3ZlIHBhcmFncmFwaC4K
SSdsbCBmaXggaXQuCj4KPj4gKyAqLwo+PiArCj4gSSdtIG5vdCBnb2luZyB0byByZXZpZXcgYW55
bW9yZSBhcyBJJ2xsIHdhaXQgZm9yIGEgcmVzZW5kIGZvciBEYW4ncwo+IGNvbW1lbnRzLgpUaGFu
a3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3aW5nLiBJJ2xsIHJlZmluZSBhbmQgcmVzZW5kIHRoZSBw
YXRjaCBzZXQuCj4KPgoK
