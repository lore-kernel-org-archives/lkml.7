Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346CEC10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A25217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 01:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfDKBvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 21:51:32 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2524 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725782AbfDKBvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 21:51:32 -0400
Received: from DGGEML401-HUB.china.huawei.com (unknown [172.30.72.56])
        by Forcepoint Email with ESMTP id 42CCB7DAFB5C248C3242;
        Thu, 11 Apr 2019 09:51:30 +0800 (CST)
Received: from DGGEML512-MBX.china.huawei.com ([169.254.2.151]) by
 DGGEML401-HUB.china.huawei.com ([fe80::89ed:853e:30a9:2a79%31]) with mapi id
 14.03.0415.000; Thu, 11 Apr 2019 09:51:26 +0800
From:   xiaojiangfeng <xiaojiangfeng@huawei.com>
To:     Frank Rowand <frowand.list@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UmU6IFxcIOetlOWkjTogW1BBVENIXSBvZjogZGVsIHJlZHVuZGFudCB0eXBl?=
 =?utf-8?Q?_conversion?=
Thread-Topic: =?utf-8?B?XFwg562U5aSNOiBbUEFUQ0hdIG9mOiBkZWwgcmVkdW5kYW50IHR5cGUgY29u?=
 =?utf-8?Q?version?=
Thread-Index: AdTwCQoU8Jmrv994RDuEBnLEvo5c2w==
Date:   Thu, 11 Apr 2019 01:51:26 +0000
Message-ID: <BE69D0C4DC96EF4BA3F03246F234C4BD01FDE17F@dggeml512-mbx.china.huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.65.87.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TXkgcGxlYXN1cmUuDQoNCkkgYW0gdmVyeSBuZXcgdG8gc3BhcnNlLg0KDQpJIGd1ZXNzIHRoZSB3
YXJuaW5nIGlzIGNhdXNlZCBieSB0aGUgbWFjcm8gbWluLg0KDQpUaGVuIEkgc3VibWl0dGVkIG15
IGNoYW5nZXMuDQoNClRoYW5rcyBmb3IgY29kZSByZXZpZXcuDQoNCg0KLS0tLS3pgq7ku7bljp/k
u7YtLS0tLQ0K5Y+R5Lu25Lq6OiBGcmFuayBSb3dhbmQgW21haWx0bzpmcm93YW5kLmxpc3RAZ21h
aWwuY29tXSANCuWPkemAgeaXtumXtDogMjAxOeW5tDTmnIgxMeaXpSAyOjUwDQrmlLbku7bkuro6
IHhpYW9qaWFuZ2ZlbmcgPHhpYW9qaWFuZ2ZlbmdAaHVhd2VpLmNvbT47IHJvYmgrZHRAa2VybmVs
Lm9yZzsgcm9iaEBrZXJuZWwub3JnDQrmioTpgIE6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQrkuLvpopg6IFJlOiBbUEFUQ0hdIG9mOiBk
ZWwgcmVkdW5kYW50IHR5cGUgY29udmVyc2lvbg0KDQpPbiA0LzEwLzE5IDE6MjkgQU0sIHhpYW9q
aWFuZ2Zlbmcgd3JvdGU6DQo+IFRoZSB0eXBlIG9mIHZhcmlhYmxlIGwgaW4gZWFybHlfaW5pdF9k
dF9zY2FuX2Nob3NlbiBpcyBpbnQsIHRoZXJlIGlzIA0KPiBubyBuZWVkIHRvIGNvbnZlcnQgdG8g
aW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogeGlhb2ppYW5nZmVuZyA8eGlhb2ppYW5nZmVuZ0Bo
dWF3ZWkuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvb2YvZmR0LmMgfCAyICstDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL29mL2ZkdC5jIGIvZHJpdmVycy9vZi9mZHQuYyBpbmRleCANCj4gNDczNDIyMy4u
ZGU4OTNjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9vZi9mZHQuYw0KPiArKysgYi9kcml2ZXJz
L29mL2ZkdC5jDQo+IEBAIC0xMDkxLDcgKzEwOTEsNyBAQCBpbnQgX19pbml0IGVhcmx5X2luaXRf
ZHRfc2Nhbl9jaG9zZW4odW5zaWduZWQgbG9uZyBub2RlLCBjb25zdCBjaGFyICp1bmFtZSwNCj4g
IAkvKiBSZXRyaWV2ZSBjb21tYW5kIGxpbmUgKi8NCj4gIAlwID0gb2ZfZ2V0X2ZsYXRfZHRfcHJv
cChub2RlLCAiYm9vdGFyZ3MiLCAmbCk7DQo+ICAJaWYgKHAgIT0gTlVMTCAmJiBsID4gMCkNCj4g
LQkJc3RybGNweShkYXRhLCBwLCBtaW4oKGludClsLCBDT01NQU5EX0xJTkVfU0laRSkpOw0KPiAr
CQlzdHJsY3B5KGRhdGEsIHAsIG1pbihsLCBDT01NQU5EX0xJTkVfU0laRSkpOw0KPiAgDQo+ICAJ
LyoNCj4gIAkgKiBDT05GSUdfQ01ETElORSBpcyBtZWFudCB0byBiZSBhIGRlZmF1bHQgaW4gY2Fz
ZSBub3RoaW5nIGVsc2UNCj4gDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhlIHJlZHVuZGFudCBj
YXN0Lg0KDQpUaGVyZSBpcyBhIHNlY29uZCBwcm9ibGVtIGRldGVjdGVkIGJ5IHNwYXJzZSBvbiB0
aGF0IGxpbmU6DQoNCiAgZHJpdmVycy9vZi9mZHQuYzoxMDk0OjM0OiB3YXJuaW5nOiBleHByZXNz
aW9uIHVzaW5nIHNpemVvZih2b2lkKQ0KDQpDYW4geW91IHBsZWFzZSBmaXggYm90aCBpc3N1ZXM/
DQoNClRoYW5rcywNCg0KRnJhbmsNCg==
