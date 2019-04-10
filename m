Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45930C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18F8F217D6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfDJKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:16:19 -0400
Received: from smtp.asem.it ([151.1.184.197]:64041 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbfDJKQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:16:19 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003804001.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 12:16:13 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 12:16:14 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 12:16:14 +0200
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
Subject: RE: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Thread-Topic: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Thread-Index: AQHU74JeNFL80xXXMkqa2oXufgu0kKY1CxCAgAAig0A=
Date:   Wed, 10 Apr 2019 10:16:14 +0000
Message-ID: <29d4b981e6224ee89db90bf71bdbf7e1@asem.it>
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
 <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
 <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
In-Reply-To: <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
Accept-Language: it-IT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.17.208]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SGHeloLookup-Result: hardfail smtp.helo=webmail.asem.it (does not match 172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A0B0201.5CADC26E.007F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA0LzEwLzE5IDEyOjQ3IFBNLCBGbGF2aW8gU3VsaWdvaSB3cm90ZToNCj4gPiBBZGQgYW4g
aW5mbyBtZXNzYWdlIGZvciB0aGUgUFhBMnh4IGRldmljZSBkcml2ZXIgc3RhcnQtdXAsDQo+ID4g
d2l0aCB0aGUgaW5kaWNhdGlvbiBvZjoNCj4gPg0KPiA+IC0gbW9kZSAoc2xhdmUgZGV2aWNlIG9y
IG1hc3RlciBjb250cm9sbGVyKQ0KPiA+IC0gdHJhbnNmZXIgbW9kZSAoRE1BIG9yIEdQSU8pDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBGbGF2aW8gU3VsaWdvaSA8Zi5zdWxpZ29pQGFzZW0uaXQ+
DQo+ID4gLS0tDQo+ID4NCj4gPiB2MToJLSBmaXJzdCB2ZXJzaW9uDQo+ID4gdjI6CS0gcmVtb3Zl
IHdhcm5pbmcgbWVzc2FnZSAibm8gRE1BIGNoYW5uZWxzIGF2YWlsYWJsZSwgdXNpbmcgUElPIg0K
PiA+IAktIGFkZCAic2xhdmUgZGV2aWNlIi8ibWFzdGVyIGNvbnRyb2xsZXIiIGluZGljYXRpb24g
bWVzc2FnZQ0KPiA+DQo+ID4gICBkcml2ZXJzL3NwaS9zcGktcHhhMnh4LmMgfCA1ICsrKystDQo+
ID4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zcGkvc3BpLXB4YTJ4eC5jIGIvZHJpdmVycy9zcGkv
c3BpLXB4YTJ4eC5jDQo+ID4gaW5kZXggZjcwNjhjYy4uYjllMDRlMiAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL3NwaS9zcGktcHhhMnh4LmMNCj4gPiArKysgYi9kcml2ZXJzL3NwaS9zcGktcHhh
Mnh4LmMNCj4gPiBAQCAtMTY5Niw3ICsxNjk2LDYgQEAgc3RhdGljIGludCBweGEyeHhfc3BpX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ID4gICAJaWYgKHBsYXRmb3Jt
X2luZm8tPmVuYWJsZV9kbWEpIHsNCj4gPiAgIAkJc3RhdHVzID0gcHhhMnh4X3NwaV9kbWFfc2V0
dXAoZHJ2X2RhdGEpOw0KPiA+ICAgCQlpZiAoc3RhdHVzKSB7DQo+ID4gLQkJCWRldl93YXJuKGRl
diwgIm5vIERNQSBjaGFubmVscyBhdmFpbGFibGUsIHVzaW5nIFBJT1xuIik7DQo+ID4gICAJCQlw
bGF0Zm9ybV9pbmZvLT5lbmFibGVfZG1hID0gZmFsc2U7DQo+ID4gICAJCX0gZWxzZSB7DQo+ID4g
ICAJCQljb250cm9sbGVyLT5jYW5fZG1hID0gcHhhMnh4X3NwaV9jYW5fZG1hOw0KPiA+IEBAIC0x
ODE4LDYgKzE4MTcsMTAgQEAgc3RhdGljIGludCBweGEyeHhfc3BpX3Byb2JlKHN0cnVjdA0KPiBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gICAJcG1fcnVudGltZV9zZXRfYWN0aXZlKCZwZGV2
LT5kZXYpOw0KPiA+ICAgCXBtX3J1bnRpbWVfZW5hYmxlKCZwZGV2LT5kZXYpOw0KPiA+DQo+ID4g
KwlkZXZfaW5mbyhkZXYsICJQWEEyeHggU1BJICVzICglcyBtb2RlKVxuIiwNCj4gPiArCQlwbGF0
Zm9ybV9pbmZvLT5pc19zbGF2ZSA/ICJzbGF2ZSBkZXZpY2UiIDogIm1hc3Rlcg0KPiBjb250cm9s
bGVyIiwNCj4gPiArCQlwbGF0Zm9ybV9pbmZvLT5lbmFibGVfZG1hID8gIkRNQSIgOiAiUElPIik7
DQo+ID4gKw0KPiANCj4gInNsYXZlIGRldmljZSIgaXMgYW1iaWd1b3VzLiBQbGVhc2UgdXNlICJj
b250cm9sbGVyIiB3aXRoIGJvdGgsIGkuZS4NCj4gIlBYQTJ4eCBTUEkgJXMgY29udHJvbGxlciAo
JXMgbW9kZSlcbiIsIC4uLiA/ICJzbGF2ZSIgOiAibWFzdGVyIiwgLi4uDQo+IA0KPiBXaXRoIHRo
YXQgY2hhbmdlZCB5b3UgbWF5IGFkZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBKYXJra28gTmlrdWxh
IDxqYXJra28ubmlrdWxhQGxpbnV4LmludGVsLmNvbT4NCg0KT2sNCg0KRmxhdmlvDQo=
