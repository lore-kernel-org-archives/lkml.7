Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D71C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C053E2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 08:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfDJIsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:48:00 -0400
Received: from smtp.asem.it ([151.1.184.197]:50750 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfDJIsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 04:48:00 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 5.5.0)
        with ESMTP id SG003803639.MSG 
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 10:47:54 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1261.35; Wed, 10
 Apr 2019 10:47:53 +0200
Received: from ASAS044.asem.intra ([::1]) by ASAS044.asem.intra ([::1]) with
 mapi id 15.01.1261.035; Wed, 10 Apr 2019 10:47:53 +0200
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
Thread-Index: AQHU7h76xswpdz/DmEySUaMIIqbaa6Yzt/cAgAAk5kCAAQrlgIAAJDOA///lTgCAACYk8A==
Date:   Wed, 10 Apr 2019 08:47:53 +0000
Message-ID: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
 <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
 <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
 <2a8b7e65d1334a5491b8bc9e9a96a685@asem.it>
 <400467d8-19d6-1796-5fa9-cb5b37d61792@linux.intel.com>
In-Reply-To: <400467d8-19d6-1796-5fa9-cb5b37d61792@linux.intel.com>
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
X-SGOP-RefID: str=0001.0A0B020E.5CADADBA.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiA0LzEwLzE5IDExOjEzIEFNLCBGbGF2aW8gU3VsaWdvaSB3cm90ZToNCj4gPj4gWyAgICA5
LjUwNjg5NV0gcHhhMnh4LXNwaSBweGEyeHgtc3BpLjEzOiBubyBETUEgY2hhbm5lbHMgYXZhaWxh
YmxlLA0KPiA+PiB1c2luZyBQSU8NCj4gPj4gWyAgICA5LjUxNjc3MF0gcHhhMnh4LXNwaSBweGEy
eHgtc3BpLjEzOiByZWdpc3RlcmVkIG1hc3RlciBzcGkyDQo+ID4+IFsgICAgOS41MTg1MjddIHB4
YTJ4eC1zcGkgcHhhMnh4LXNwaS4xMzogUFhBMnh4IFNQSSBtYXN0ZXIgY29udHJvbGxlcg0KPiA+
PiAoUElPIG1vZGUpDQo+ID4NCj4gPiBJIGhhdmUgYWRkZWQgdGhpcyBtZXNzYWdlIGJlY2F1c2Us
IHVzaW5nIGFuIHg4NiBtYWNoaW5lLCB0aGUgbWVzc2FnZToNCj4gPg0KPiA+ICJweGEyeHgtc3Bp
IHB4YTJ4eC1zcGkuMTM6IHJlZ2lzdGVyZWQgbWFzdGVyIHNwaTIiDQo+ID4NCj4gPiBkb2Vzbid0
IGFwcGVhciBpbiB0aGUga2VybmVsIG1lc3NhZ2VzIQ0KPiA+DQo+IFllYWgsIGl0IG5lZWRzIENP
TkZJR19TUElfREVCVUcuDQo+IA0KPiA+PiBBY3R1YWxseSB0aGlzIGluZm8gbWVzc2FnZSBkb2Vz
bid0IG5lY2Vzc2FyaWx5IHRlbGwgd2lsbCB0aGUgZHJpdmVyIGVuZA0KPiA+PiB1cCB1c2luZyBE
TUEgZm9yIHRyYW5zZmVycy4gU2VlIHB4YTJ4eF9zcGlfY2FuX2RtYSgpIGFuZA0KPiA+PiBweGEy
eHhfc3BpX3RyYW5zZmVyX29uZSgpLg0KPiA+Pg0KPiA+PiBIb3cgYWJvdXQgcmVwbGFjaW5nICJu
byBETUEgY2hhbm5lbHMgYXZhaWxhYmxlLCB1c2luZyBQSU8iIGFuZCBoYXZlDQo+ID4+IGluc3Rl
YWQgc2luZ2xlIGluZm8gbWVzc2FnZSB0ZWxsaW5nIGlzIHRoZSBETUEgYXZhaWxhYmxlIG9yIGRv
ZXMgdGhlDQo+ID4+IGRyaXZlciB1c2UgUElPIG9ubHk/DQo+ID4NCj4gPiBPaywgaXQncyBhIGdv
b2QgaWRlYSwgdG8gYXZvaWQgdG8gbWFueSBzaW1pbGFyIG1lc3NhZ2VzLg0KPiA+IFNvIEkgY2Fu
IHNpbXBseSByZW1vdmUgdGhlOg0KPiA+DQo+ID4gIm5vIERNQSBjaGFubmVscyBhdmFpbGFibGUs
IHVzaW5nIFBJTyINCj4gPg0KPiA+IGFuZCBsZWF2ZSBvbmx5IHRoZSBuZXc6DQo+ID4NCj4gPiAi
IHB4YTJ4eC1zcGkgcHhhMnh4LXNwaS4xMzogUFhBMnh4IFNQSSBtYXN0ZXIgY29udHJvbGxlciAo
UElPIG1vZGUpIg0KPiA+DQo+IFllcywgc29tZXRoaW5nIGxpa2UgdGhhdC4NCj4gDQo+IE5vdyBJ
IHJlbWVtYmVyLCBwbGVhc2UgYWxzbyB0YWtlIGludG8gYWNjb3VudCBkcml2ZXIgaXMgZHVhbCBy
b2xlIHNpbmNlDQo+IGNvbW1pdCBlYzkzY2I2ZjgyN2IgKCJzcGk6IHB4YTJ4eDogQWRkIHNsYXZl
IG1vZGUgc3VwcG9ydCIpLg0KDQpPaywgcmlnaHQsIEkgaGF2ZSB0byBjb25zaWRlciB0aGUgc2xh
dmUgbW9kZSwgdG9vLg0KDQpUaGFua3MgSmFya2tvIQ0KDQpGbGF2aW8NCg==
