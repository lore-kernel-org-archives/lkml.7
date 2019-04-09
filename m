Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC3FC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3DB2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDIOLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:11:53 -0400
Received: from smtp.asem.it ([151.1.184.197]:59180 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIOLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:11:53 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003801894.MSG 
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 16:11:50 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Tue, 9
 Apr 2019 16:11:50 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Tue, 9 Apr 2019 16:11:49 +0200
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
Thread-Index: AQHU7h76xswpdz/DmEySUaMIIqbaa6Yzt/cAgAAk5kA=
Date:   Tue, 9 Apr 2019 14:11:49 +0000
Message-ID: <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
In-Reply-To: <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
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
X-SGOP-RefID: str=0001.0A0B0213.5CACA826.0037,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFya2tvLA0KDQo+IEhpDQo+IA0KPiBPbiA0LzgvMTkgNjoyMiBQTSwgRmxhdmlvIFN1bGln
b2kgd3JvdGU6DQo+ID4gQWRkIGFuIGluZm8gbWVzc2FnZSBmb3IgdGhlIFBYQTJ4eCBkZXZpY2Ug
ZHJpdmVyIHN0YXJ0LXVwLA0KPiA+IHdpdGggdGhlIGluZGljYXRpb24gb2YgdGhlIHRyYW5zZmVy
IG1vZGUgdXNlZCAoRE1BIG9yIEdQSU8pLg0KPiA+DQo+ID4gVGhpcyBpbmZvIGlzIHVzZWZ1bCB0
byBpbmRpdmlkdWF0ZSB0aGUgdGltaW5nIHdoZW4NCj4gPiB0aGUgbW9kdWxlIHN0YXJ0cy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZsYXZpbyBTdWxpZ29pIDxmLnN1bGlnb2lAYXNlbS5pdD4N
Cj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvc3BpL3NwaS1weGEyeHguYyB8IDMgKysrDQo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zcGkvc3BpLXB4YTJ4eC5jIGIvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jDQo+ID4gaW5k
ZXggZjcwNjhjYy4uZDQ0OTUwMSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3NwaS9zcGktcHhh
Mnh4LmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktcHhhMnh4LmMNCj4gPiBAQCAtMTgyNiw2
ICsxODI2LDkgQEAgc3RhdGljIGludCBweGEyeHhfc3BpX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAJCWdvdG8gb3V0X2Vycm9yX2Nsb2NrX2VuYWJsZWQ7DQo+
ID4gICAJfQ0KPiA+DQo+ID4gKwlkZXZfaW5mbyhkZXYsICJQWEEyeHggU1BJIG1hc3RlciBjb250
cm9sbGVyICglcyBtb2RlKVxuIiwNCj4gPiArCQkgcGxhdGZvcm1faW5mby0+ZW5hYmxlX2RtYSA/
ICJETUEiIDogIlBJTyIpOw0KPiA+ICsNCj4gPiAgIAlyZXR1cm4gc3RhdHVzOw0KPiA+DQo+IFdv
dWxkIHRoaXMgbG9vayBiZXR0ZXIgaWYgbW92ZWQgYmVmb3JlIGRldm1fc3BpX3JlZ2lzdGVyX2Nv
bnRyb2xsZXIoKQ0KPiBjYWxsPw0KDQpPaywgc28gaW4gY2FzZSBvZiBTUEkgcmVnaXN0ZXJpbmcg
ZmFpbHVyZSwgd2UgaGF2ZSB0d28gbWVzc2FnZXMsIGFzOg0KDQpweGEyeHgtc3BpIDgwODYwRjBF
OjAwOiBQWEEyeHggU1BJIG1hc3RlciBjb250cm9sbGVyIChETUEgbW9kZSkNCnB4YTJ4eC1zcGkg
ODA4NjBGMEU6MDA6IHByb2JsZW0gcmVnaXN0ZXJpbmcgc3BpIGNvbnRyb2xsZXINCg0KRG8geW91
IHRoaW5rIHRoYXQgaXQgaXMgbW9yZSBleHBsaWNhdGl2ZT8NCg0KRmxhdmlvDQo=
