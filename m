Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6A1C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949C220856
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:59:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH1B7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:59:48 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726127AbfH1B7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:59:48 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id C5486602C5D1A1E04F6C;
        Wed, 28 Aug 2019 09:59:45 +0800 (CST)
Received: from DGGEMI423-HUB.china.huawei.com (10.1.199.152) by
 dggemi404-hub.china.huawei.com (10.3.17.142) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 09:59:45 +0800
Received: from DGGEMI524-MBX.china.huawei.com ([169.254.7.30]) by
 dggemi423-hub.china.huawei.com ([10.1.199.152]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 09:59:38 +0800
From:   chengzhihao <chengzhihao1@huawei.com>
To:     Richard Weinberger <richard.weinberger@gmail.com>
CC:     Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggUkZDIHYyXSB1Ymk6IHViaV93bF9nZXRfcGViOiBJ?=
 =?utf-8?B?bmNyZWFzZSB0aGUgbnVtYmVyIG9mIGF0dGVtcHRzIHdoaWxlIGdldHRpbmcg?=
 =?utf-8?Q?PEB?=
Thread-Topic: [PATCH RFC v2] ubi: ubi_wl_get_peb: Increase the number of
 attempts while getting PEB
Thread-Index: AQHVT2EsTJNmHoCNk0y5Wp2VB7/tCKb5GeuAgBbPnRA=
Date:   Wed, 28 Aug 2019 01:59:37 +0000
Message-ID: <0B80F9D4116B2F4484E7279D5A66984F7D875E@dggemi524-mbx.china.huawei.com>
References: <1565431061-145460-1-git-send-email-chengzhihao1@huawei.com>
 <CAFLxGvzOMfqJJ+ZKTUavxEx+0_OJO_VcrNu1nn2rrvcypAxAAA@mail.gmail.com>
In-Reply-To: <CAFLxGvzOMfqJJ+ZKTUavxEx+0_OJO_VcrNu1nn2rrvcypAxAAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.177.224.82]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBwYXRjaCBtaXNzZWQgdGhlIGZpeGVzIHB1bGwgcmVxdWVzdCg1LjMtcmM2KSwgd2lsbCBp
dCBiZSBpbiB2NS4zLXJjNz8NCg0KLS0tLS3pgq7ku7bljp/ku7YtLS0tLQ0K5Y+R5Lu25Lq6OiBS
aWNoYXJkIFdlaW5iZXJnZXIgW21haWx0bzpyaWNoYXJkLndlaW5iZXJnZXJAZ21haWwuY29tXSAN
CuWPkemAgeaXtumXtDogMjAxOeW5tDjmnIgxNOaXpSA1OjM4DQrmlLbku7bkuro6IGNoZW5nemhp
aGFvIDxjaGVuZ3poaWhhbzFAaHVhd2VpLmNvbT4NCuaKhOmAgTogUmljaGFyZCBXZWluYmVyZ2Vy
IDxyaWNoYXJkQG5vZC5hdD47IHpoYW5neWkgKEYpIDx5aS56aGFuZ0BodWF3ZWkuY29tPjsgbGlu
dXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc+DQrkuLvpopg6IFJlOiBbUEFUQ0ggUkZDIHYyXSB1Ymk6IHViaV93bF9nZXRfcGViOiBJ
bmNyZWFzZSB0aGUgbnVtYmVyIG9mIGF0dGVtcHRzIHdoaWxlIGdldHRpbmcgUEVCDQoNCk9uIFNh
dCwgQXVnIDEwLCAyMDE5IGF0IDExOjUxIEFNIFpoaWhhbyBDaGVuZyA8Y2hlbmd6aGloYW8xQGh1
YXdlaS5jb20+IHdyb3RlOg0KPg0KPiBSdW5uaW5nIHN0cmVzcyB0ZXN0IGlvX3BhcmFsIChBIHBy
ZXNzdXJlIHViaSB0ZXN0IGluIG10ZC11dGlscykgb24gYW4gDQo+IFVCSSBkZXZpY2Ugd2l0aCBm
ZXdlciBQRUJzIChmYXN0bWFwIGVuYWJsZWQpIG1heSBjYXVzZSBFTk9TUEMgZXJyb3JzIA0KPiBh
bmQgbWFrZSBVQkkgZGV2aWNlIHJlYWQtb25seSwgYnV0IHRoZXJlIGFyZSBzdGlsbCBmcmVlIFBF
QnMgb24gdGhlIA0KPiBVQkkgZGV2aWNlLiBUaGlzIHByb2JsZW0gY2FuIGJlIGVhc2lseSByZXBy
b2R1Y2VkIGJ5IHBlcmZvcm1pbmcgdGhlIA0KPiBmb2xsb3dpbmcgc3RlcHMgb24gYSAyLWNvcmUg
bWFjaGluZToNCj4gICAkIG1vZHByb2JlIG5hbmRzaW0gZmlyc3RfaWRfYnl0ZT0weDIwIHNlY29u
ZF9pZF9ieXRlPTB4MzMgcGFydHM9ODANCj4gICAkIG1vZHByb2JlIHViaSBtdGQ9IjAsMCIgZm1f
YXV0b2NvbnZlcnQNCj4gICAkIC4vaW9fcGFyYWwgL2Rldi91YmkwDQo+DQo+IFdlIG1heSBzZWUg
dGhlIGZvbGxvd2luZyB2ZXJib3NlOg0KPiAob3V0cHV0KQ0KPiAgIFtpb19wYXJhbF0gdXBkYXRl
X3ZvbHVtZSgpOjEwODogZmFpbGVkIHRvIHdyaXRlIDM4MCBieXRlcyBhdCBvZmZzZXQNCj4gICA5
NTkyMCBvZiB2b2x1bWUgMg0KPiAgIFtpb19wYXJhbF0gdXBkYXRlX3ZvbHVtZSgpOjEwOTogdXBk
YXRlOiA5NzA4OCBieXRlcw0KPiAgIFtpb19wYXJhbF0gd3JpdGVfdGhyZWFkKCk6MjI3OiBmdW5j
dGlvbiBwd3JpdGUoKSBmYWlsZWQgd2l0aCBlcnJvciAyOA0KPiAgIChObyBzcGFjZSBsZWZ0IG9u
IGRldmljZSkNCj4gICBbaW9fcGFyYWxdIHdyaXRlX3RocmVhZCgpOjIyOTogY2Fubm90IHdyaXRl
IDE1ODcyIGJ5dGVzIHRvIG9mZnMgMzE3NDQsDQo+ICAgd3JvdGUgLTENCj4gKGRtZXNnKQ0KPiAg
IHViaTAgZXJyb3I6IHViaV93bF9nZXRfcGViIFt1YmldOiBVbmFibGUgdG8gZ2V0IGEgZnJlZSBQ
RUIgZnJvbSB1c2VyIFdMDQo+ICAgcG9vbA0KPiAgIHViaTAgd2FybmluZzogdWJpX2ViYV93cml0
ZV9sZWIgW3ViaV06IHN3aXRjaCB0byByZWFkLW9ubHkgbW9kZQ0KPiAgIENQVTogMCBQSUQ6IDIw
MjcgQ29tbTogaW9fcGFyYWwgTm90IHRhaW50ZWQgNS4zLjAtcmMyLTAwMDAxLWc1OTg2Y2QwICM5
DQo+ICAgdWJpMCB3YXJuaW5nOiB0cnlfd3JpdGVfdmlkX2FuZF9kYXRhIFt1YmldOiBmYWlsZWQg
dG8gd3JpdGUgVklEIGhlYWRlcg0KPiAgIHRvIExFQiAyOjUsIFBFQiAxOA0KPiAgIEhhcmR3YXJl
IG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIHJlbC0x
LjEyLjANCj4gICAtMC1nYTY5OGM4OTk1Zi1wcmVidWlsdC5xZW11Lm9yZyAwNC8wMS8yMDE0DQo+
ICAgQ2FsbCBUcmFjZToNCj4gICAgIGR1bXBfc3RhY2srMHg4NS8weGJhDQo+ICAgICB1YmlfZWJh
X3dyaXRlX2xlYisweGExZS8weGE0MCBbdWJpXQ0KPiAgICAgdm9sX2NkZXZfd3JpdGUrMHgzMDcv
MHg1MjAgW3ViaV0NCj4gICAgIHZmc193cml0ZSsweGZhLzB4MjgwDQo+ICAgICBrc3lzX3B3cml0
ZTY0KzB4YzUvMHhlMA0KPiAgICAgX194NjRfc3lzX3B3cml0ZTY0KzB4MjIvMHgzMA0KPiAgICAg
ZG9fc3lzY2FsbF82NCsweGJmLzB4NDQwDQo+DQo+IEluIGZ1bmN0aW9uIHViaV93bF9nZXRfcGVi
LCB0aGUgb3BlcmF0aW9uIG9mIGZpbGxpbmcgdGhlIHBvb2wNCj4gKHViaV91cGRhdGVfZmFzdG1h
cCkgd2l0aCBmcmVlIFBFQnMgYW5kIGZldGNoaW5nIGEgZnJlZSBQRUIgZnJvbSB0aGUgDQo+IHBv
b2wgaXMgbm90IGF0b21pYy4gQWZ0ZXIgdGhyZWFkIEEgZmlsbGluZyB0aGUgcG9vbCB3aXRoIGZy
ZWUgUEVCLCANCj4gZnJlZSBQRUIgbWF5IGJlIHRha2VuIGF3YXkgYnkgdGhyZWFkIEIuIFdoZW4g
dGhyZWFkIEEgY2hlY2tzIHRoZSANCj4gZXhwcmVzc2lvbiBhZ2FpbiwgdGhlIGNvbmRpdGlvbiBp
cyBzdGlsbCB1bnNhdGlzZmFjdG9yeS4gQXQgdGhpcyB0aW1lLCANCj4gdGhlcmUgbWF5IHN0aWxs
IGJlIGZyZWUgUEVCcyBvbiBVQkkgdGhhdCBjYW4gYmUgZmlsbGVkIGludG8gdGhlIHBvb2wuDQo+
DQo+IFRoaXMgcGF0Y2ggaW5jcmVhc2VzIHRoZSBudW1iZXIgb2YgYXR0ZW1wdHMgdG8gb2J0YWlu
IFBFQi4gQW4gZXh0cmVtZSANCj4gY2FzZSAoTm8gZnJlZSBQRUJzIGxlZnQgYWZ0ZXIgY3JlYXRp
bmcgdGVzdCB2b2x1bWVzKSBoYXMgYmVlbiB0ZXN0ZWQgDQo+IG9uIGRpZmZlcmVudCB0eXBlIG9m
IG1hY2hpbmVzIGZvciAxMDAgdGltZXMuIFRoZSBiaWdnZXN0IG51bWJlciBvZiANCj4gYXR0ZW1w
dHMgYXJlIHNob3duIGJlbG93Og0KPg0KPiAgICAgICAgICAgICAgeDg2XzY0ICAgICBhcm02NA0K
PiAgIDItY29yZSAgICAgICAgNCAgICAgICAgIDQNCj4gICA0LWNvcmUgICAgICAgIDggICAgICAg
ICA0DQo+ICAgOC1jb3JlICAgICAgICA0ICAgICAgICAgNA0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBa
aGloYW8gQ2hlbmcgPGNoZW5nemhpaGFvMUBodWF3ZWkuY29tPg0KDQpUaGFua3MgZm9yIGFkZHJl
c3NpbmcgdGhpcyENCkknbGwgdGFrZSB0aGlzIHZlcnNpb24uIDotKQ0KDQotLQ0KVGhhbmtzLA0K
Ly9yaWNoYXJkDQo=
