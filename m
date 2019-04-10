Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385F7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DB52083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbfDJINL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:13:11 -0400
Received: from smtp.asem.it ([151.1.184.197]:63095 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfDJINK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:13:10 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003803501.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:13:04 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 10:13:05 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 10:13:04 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        "Robert Jarzmik" <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Thread-Topic: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Thread-Index: AQHU7h76xswpdz/DmEySUaMIIqbaa6Yzt/cAgAAk5kCAAQrlgIAAJDOA
Date:   Wed, 10 Apr 2019 08:13:04 +0000
Message-ID: <2a8b7e65d1334a5491b8bc9e9a96a685@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
 <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
 <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
In-Reply-To: <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
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
X-SGOP-RefID: str=0001.0A0B0215.5CADA591.0045,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFya2tvLA0KDQo+ID4NCj4gPj4gSGkNCj4gPj4NCj4gPj4gT24gNC84LzE5IDY6MjIgUE0s
IEZsYXZpbyBTdWxpZ29pIHdyb3RlOg0KPiA+Pj4gQWRkIGFuIGluZm8gbWVzc2FnZSBmb3IgdGhl
IFBYQTJ4eCBkZXZpY2UgZHJpdmVyIHN0YXJ0LXVwLA0KPiA+Pj4gd2l0aCB0aGUgaW5kaWNhdGlv
biBvZiB0aGUgdHJhbnNmZXIgbW9kZSB1c2VkIChETUEgb3IgR1BJTykuDQo+ID4+Pg0KPiA+Pj4g
VGhpcyBpbmZvIGlzIHVzZWZ1bCB0byBpbmRpdmlkdWF0ZSB0aGUgdGltaW5nIHdoZW4NCj4gPj4+
IHRoZSBtb2R1bGUgc3RhcnRzLg0KPiA+Pj4NCj4gPj4+IFNpZ25lZC1vZmYtYnk6IEZsYXZpbyBT
dWxpZ29pIDxmLnN1bGlnb2lAYXNlbS5pdD4NCj4gPj4+IC0tLQ0KPiA+Pj4gICAgZHJpdmVycy9z
cGkvc3BpLXB4YTJ4eC5jIHwgMyArKysNCj4gPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKykNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLXB4YTJ4
eC5jIGIvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4+PiBpbmRleCBmNzA2OGNjLi5kNDQ5
NTAxIDEwMDY0NA0KPiA+Pj4gLS0tIGEvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4+PiAr
KysgYi9kcml2ZXJzL3NwaS9zcGktcHhhMnh4LmMNCj4gPj4+IEBAIC0xODI2LDYgKzE4MjYsOSBA
QCBzdGF0aWMgaW50IHB4YTJ4eF9zcGlfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZQ0K
PiA+PiAqcGRldikNCj4gPj4+ICAgIAkJZ290byBvdXRfZXJyb3JfY2xvY2tfZW5hYmxlZDsNCj4g
Pj4+ICAgIAl9DQo+ID4+Pg0KPiA+Pj4gKwlkZXZfaW5mbyhkZXYsICJQWEEyeHggU1BJIG1hc3Rl
ciBjb250cm9sbGVyICglcyBtb2RlKVxuIiwNCj4gPj4+ICsJCSBwbGF0Zm9ybV9pbmZvLT5lbmFi
bGVfZG1hID8gIkRNQSIgOiAiUElPIik7DQo+ID4+PiArDQo+ID4+PiAgICAJcmV0dXJuIHN0YXR1
czsNCj4gPj4+DQo+ID4+IFdvdWxkIHRoaXMgbG9vayBiZXR0ZXIgaWYgbW92ZWQgYmVmb3JlIGRl
dm1fc3BpX3JlZ2lzdGVyX2NvbnRyb2xsZXIoKQ0KPiA+PiBjYWxsPw0KPiA+DQo+ID4gT2ssIHNv
IGluIGNhc2Ugb2YgU1BJIHJlZ2lzdGVyaW5nIGZhaWx1cmUsIHdlIGhhdmUgdHdvIG1lc3NhZ2Vz
LCBhczoNCj4gPg0KPiA+IHB4YTJ4eC1zcGkgODA4NjBGMEU6MDA6IFBYQTJ4eCBTUEkgbWFzdGVy
IGNvbnRyb2xsZXIgKERNQSBtb2RlKQ0KPiA+IHB4YTJ4eC1zcGkgODA4NjBGMEU6MDA6IHByb2Js
ZW0gcmVnaXN0ZXJpbmcgc3BpIGNvbnRyb2xsZXINCj4gPg0KPiA+IERvIHlvdSB0aGluayB0aGF0
IGl0IGlzIG1vcmUgZXhwbGljYXRpdmU/DQo+ID4NCj4gSSB0aGluayB5ZXMgYW5kIGl0IHNob3Vs
ZCBub3QgY2F1c2UgY29uZnVzaW9uIHNpbmNlIHRoZSBlcnJvciBtZXNzYWdlIGlzDQo+IHRoZSBs
YXN0IG9uZS4NCj4gDQo+IEkgd2FzIHRoaW5raW5nIHRoZSBzdWNjZXNzZnVsIHJlZ2lzdHJhdGlv
biBjYXNlIHdoZW4gRE1BIGlzIG5vdA0KPiBhdmFpbGFibGUuIEZpcnN0IHRoZXJlIGlzIGEgd2Fy
bmluZywgZm9sbG93ZWQgYnkgYSBkZWJ1ZyBtZXNzYWdlIGZyb20NCj4gU1BJIGNvcmUgKGlmIENP
TkZJR19TUElfREVCVUcpIGFuZCB0aGVuIGluZm8gbWVzc2FnZS4NCj4gDQo+IFsgICAgOS41MDY4
OTVdIHB4YTJ4eC1zcGkgcHhhMnh4LXNwaS4xMzogbm8gRE1BIGNoYW5uZWxzIGF2YWlsYWJsZSwN
Cj4gdXNpbmcgUElPDQo+IFsgICAgOS41MTY3NzBdIHB4YTJ4eC1zcGkgcHhhMnh4LXNwaS4xMzog
cmVnaXN0ZXJlZCBtYXN0ZXIgc3BpMg0KPiBbICAgIDkuNTE4NTI3XSBweGEyeHgtc3BpIHB4YTJ4
eC1zcGkuMTM6IFBYQTJ4eCBTUEkgbWFzdGVyIGNvbnRyb2xsZXINCj4gKFBJTyBtb2RlKQ0KDQpJ
IGhhdmUgYWRkZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2UsIHVzaW5nIGFuIHg4NiBtYWNoaW5lLCB0
aGUgbWVzc2FnZToNCg0KInB4YTJ4eC1zcGkgcHhhMnh4LXNwaS4xMzogcmVnaXN0ZXJlZCBtYXN0
ZXIgc3BpMiINCg0KZG9lc24ndCBhcHBlYXIgaW4gdGhlIGtlcm5lbCBtZXNzYWdlcyENCg0KPiBB
Y3R1YWxseSB0aGlzIGluZm8gbWVzc2FnZSBkb2Vzbid0IG5lY2Vzc2FyaWx5IHRlbGwgd2lsbCB0
aGUgZHJpdmVyIGVuZA0KPiB1cCB1c2luZyBETUEgZm9yIHRyYW5zZmVycy4gU2VlIHB4YTJ4eF9z
cGlfY2FuX2RtYSgpIGFuZA0KPiBweGEyeHhfc3BpX3RyYW5zZmVyX29uZSgpLg0KPiANCj4gSG93
IGFib3V0IHJlcGxhY2luZyAibm8gRE1BIGNoYW5uZWxzIGF2YWlsYWJsZSwgdXNpbmcgUElPIiBh
bmQgaGF2ZQ0KPiBpbnN0ZWFkIHNpbmdsZSBpbmZvIG1lc3NhZ2UgdGVsbGluZyBpcyB0aGUgRE1B
IGF2YWlsYWJsZSBvciBkb2VzIHRoZQ0KPiBkcml2ZXIgdXNlIFBJTyBvbmx5Pw0KDQpPaywgaXQn
cyBhIGdvb2QgaWRlYSwgdG8gYXZvaWQgdG8gbWFueSBzaW1pbGFyIG1lc3NhZ2VzLg0KU28gSSBj
YW4gc2ltcGx5IHJlbW92ZSB0aGU6DQoNCiJubyBETUEgY2hhbm5lbHMgYXZhaWxhYmxlLCB1c2lu
ZyBQSU8iDQoNCmFuZCBsZWF2ZSBvbmx5IHRoZSBuZXc6DQoNCiIgcHhhMnh4LXNwaSBweGEyeHgt
c3BpLjEzOiBQWEEyeHggU1BJIG1hc3RlciBjb250cm9sbGVyIChQSU8gbW9kZSkiDQoNCkZsYXZp
bw0K
