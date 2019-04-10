Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464BAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE7620818
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfDJIEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:04:20 -0400
Received: from smtp.asem.it ([151.1.184.197]:64288 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbfDJIEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:04:20 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003803464.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:04:13 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 10:04:12 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 10:04:12 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Rob Herring <robh@kernel.org>
CC:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Topic: [PATCH 1/2] dt-bindings: rtc: add battery-low-hw-alarm property
Thread-Index: AQHU6izzMP9bJdl0YUGdR5AsgVFjFaYuiBOAgAByKgCAAuR9QIABD44AgAIjV3A=
Date:   Wed, 10 Apr 2019 08:04:12 +0000
Message-ID: <795c8ed2df204658832a93d06caef444@asem.it>
References: <1554303165-24813-1-git-send-email-f.suligoi@asem.it>
 <5ca84214.1c69fb81.e3ace.21e5@mx.google.com>
 <20190406125550.GA7480@piout.net> <58b8e1bc2b064abcb67db04369cf9c6e@asem.it>
 <CAL_JsqLO20u39Vds_Z_S325D2My1aYKM6BS6RKdWSmyEVh-DtQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLO20u39Vds_Z_S325D2My1aYKM6BS6RKdWSmyEVh-DtQ@mail.gmail.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0202.5CADA37C.00B6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLA0KDQo+IE9uIE1vbiwgQXByIDgsIDIwMTkgYXQgMjoyMiBBTSBGbGF2aW8gU3VsaWdv
aSA8Zi5zdWxpZ29pQGFzZW0uaXQ+IHdyb3RlOg0KPiA+DQo+ID4gSEksDQo+ID4NCj4gPiA+IE9u
IDA2LzA0LzIwMTkgMDE6MDc6MTMtMDUwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gPiA+IE9u
IFdlZCwgQXByIDAzLCAyMDE5IGF0IDA0OjUyOjQ0UE0gKzAyMDAsIEZsYXZpbyBTdWxpZ29pIHdy
b3RlOg0KPiA+ID4gPiA+IFNvbWUgUlRDIGRldmljZXMgaGF2ZSBhIGJhdHRlcnktbG93IGF1dG9t
YXRpYyBkZXRlY3Rpb24gY2lyY3VpdC4NCj4gPiA+ID4gPiBUaGUgYmF0dGVyeS1sb3cgZXZlbnQg
aXMgdXN1YWxseSByZXBvcnRlZCB3aXRoOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLSBhIGJpdCBj
aGFuZ2UgaW4gYSBSVEMgc3RhdHVzIHJlZ2lzdGVyDQo+ID4gPiA+ID4gLSBhIGh3IHNpZ25hbGlu
ZyAoZ2VuZXJhbGx5IHVzaW5nIGFuIGludGVycnVwdCBnZW5lcmF0aW9uKSwNCj4gY2hhbmdpbmcN
Cj4gPiA+ID4gPiAgIHRoZSBodyBsZXZlbCBvZiBhIHNwZWNpZmljIHBpbjsNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+IFRoZSBuZXcgcHJvcGVydHkgImJhdHRlcnktbG93LWh3LWFsYXJtIiBlbmFibGUg
dGhlIFJUQyB0byBnZW5lcmF0ZQ0KPiB0aGUNCj4gPiA+ID4gPiBodyBzaWduYWxpbmcgaW4gY2Fz
ZSBvZiBiYXR0ZXJ5LWxvdyBldmVudC4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEZsYXZpbyBTdWxpZ29pIDxmLnN1bGlnb2lAYXNlbS5pdD4NCj4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9ydGMudHh0IHwg
MyArKysNCj4gPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9ydGMvcnRjLnR4dA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvcnRjL3J0Yy50eHQNCj4gPiA+ID4gPiBpbmRleCBhOTdmYzZhLi5mOTNhNDRkIDEwMDY0NA0K
PiA+ID4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvcnRj
LnR4dA0KPiA+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9y
dGMvcnRjLnR4dA0KPiA+ID4gPiA+IEBAIC0zMSw2ICszMSw5IEBAIGJlbG93Lg0KPiA+ID4gPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXhwcmVzc2VkIGluIGZlbXRvIEZhcmFkIChm
RikuDQo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUaGUgZGVmYXVsdCB2
YWx1ZSBzaGFsbCBiZSBsaXN0ZWQgKGlmDQo+ID4gPiBvcHRpb25hbCksDQo+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhbmQgbGlrZXdpc2UgYWxsIHZhbGlkIHZhbHVlcy4N
Cj4gPiA+ID4gPiArLSBiYXR0ZXJ5LWxvdy1ody1hbGFybSA6ICAgIEVuYWJsZSB0aGUgImJhdHRl
cnktbG93IiBvdXRwdXQgcGluLg0KPiBUaGlzDQo+ID4gPiBmdW5jdGlvbg0KPiA+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaXMgYXZhaWxhYmxlIG9uIHRoZSBmb2xsb3dpbmcN
Cj4gZGV2aWNlczoNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gcGNm
MjEyNyAtIHBpbiB1c2VkIGZvciBhbGFybTogSU5Ubg0KPiA+ID4gPg0KPiA+ID4gPiBCb29sZWFu
PyBJZiB0aGVyZSdzIGNhc2VzIHdoZXJlIHdoaWNoIHBpbiBpcyBzZWxlY3RhYmxlLCB0aGVuIHdl
J2QNCj4gbmVlZA0KPiA+ID4gPiB0aGlzIHRvIHRha2UgYSB2YWx1ZS4gTm90IHN1cmUgaG93IGxp
a2VseSB0aGF0IGlzPw0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEluZGVlZCwgdGhlcmUgaXMgYXQg
bGVhc3QgdGhlIHBjZjg1MzYzIHRoYXQgaGFzIHR3byBwb3NzaWJsZSBwaW5zIGZvcg0KPiA+ID4g
dGhhdCBpbnRlcnJ1cHQuIEhvdyB3b3VsZCB5b3Ugc2VsZWN0IHRoZSBwaW4gdGhlbj8gYSB6ZXJv
IGJhc2VkIGluZGV4Pw0KPiBhDQo+ID4gPiBzdHJpbmc/DQo+IA0KPiBJIHByZWZlciBhbiBpbmRl
eC4NCg0KT2ssIHNvIHdlIGNhbiBjYWxsIHRoaXMgcHJvcGVydHkgYXM6DQoNCmxvdy12b2x0YWdl
LWFsYXJtDQoNCmFuZCB3ZSBjYW4gc2VsZWN0IHRoZSBwaW4gdXNpbmcgYSB6ZXJvLWJhc2UgaW5k
ZXgsDQphbHNvIGZvciBmdXR1cmUgZGV2ZWxvcG1lbnRzLg0KDQo+IA0KPiA+IEkgdGhpbmsgdGhl
IHN0cmluZyBjb3VsZCBiZSBjbGVhcmVyIGZvciB0aGUgZmluYWwgdXNlciBhbmQgd291bGQgZ2l2
ZQ0KPiA+IG1vcmUgZnJlZWRvbSBmb3IgZnV0dXJlIGNoYW5nZXMuDQo+ID4gRm9yIGV4YW1wbGUs
IHdlIGNhbiBjYWxsIHRoaXMgcHJvcGVydHksIGluc3RlYWQgb2YgImJhdHRlcnktbG93LWFsYXJt
Ig0KPiBvcg0KPiA+ICJsb3ctdm9sdGFnZS1hbGFybSIsIHNpbXBseTogImFsYXJtLXBpbl8xIiBh
bmQgdGhlbiB0aGUgc3RyaW5nIGFyZ3VtZW50DQo+ID4gY2FuIGRlc2NyaWJlIHRoZSBmdW5jdGlv
biB1c2VkOyBmb3IgZXhhbXBsZToNCj4gPg0KPiA+IGFsYXJtLXBpbl8xID0gImJhY2t1cC1zdXBw
bHktbG93LXZvbHRhZ2UtYWxhcm0iOw0KPiA+IGFsYXJtLXBpbl8yID0gIi4uLi4uLiI7DQo+IA0K
PiBIb3cgbWFueSBwaW5zIGFuZCBmdW5jdGlvbnMgdGhlbj8gQW5kIGhvdyBkb2VzIHRoaXMgcmVs
YXRlIHRvIGFueQ0KPiBpbnRlcnJ1cHRzPw0KDQpJZiB3ZSB1c2UgaW5kZXgsIHdlIGRvbid0IHVz
ZSBzdHJpbmdzIGFueSBtb3JlLg0K
