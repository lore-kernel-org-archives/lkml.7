Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF37C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2587206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404480AbfIWCd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:33:57 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46756 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404135AbfIWCd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:33:57 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8N2WsLZ016325, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8N2WsLZ016325
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Sep 2019 10:32:54 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Mon, 23 Sep
 2019 10:32:53 +0800
From:   James Tai <james.tai@realtek.com>
To:     "'Masahiro Yamada'" <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        "Mauro Carvalho Chehab" <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stefan Agner <stefan@agner.ch>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Thierry Reding" <treding@nvidia.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        "Rob Herring" <robh@kernel.org>,
        =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Phinex Hung <phinex@realtek.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Subject: RE: [PATCH] ARM: Add support for Realtek SOC
Thread-Topic: [PATCH] ARM: Add support for Realtek SOC
Thread-Index: AQHVY67V+8blpY45FUyr2dN3mgK/RqccOwQAgAf67ACAAW8fgIAABQEAgBI1EbA=
Date:   Mon, 23 Sep 2019 02:32:52 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF8E7CEE@RTITMBSVM04.realtek.com.tw>
References: <20190905054647.1235-1-james.tai@realtek.com>
 <CAK8P3a13=VBZnj6E=s7mZk0o7Q3XkMHgcsL12s-3psuOWsfOtQ@mail.gmail.com>
 <43B123F21A8CFE44A9641C099E4196FFCF8DA1D0@RTITMBSVM04.realtek.com.tw>
 <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
 <CAK7LNATpbAMGU1u6T_1tX57mHbCR-57q+kDwXMOHAJ2R5kvfrg@mail.gmail.com>
In-Reply-To: <CAK7LNATpbAMGU1u6T_1tX57mHbCR-57q+kDwXMOHAJ2R5kvfrg@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBBUk06IEFkZCBzdXBwb3J0IGZvciBSZWFsdGVrIFNPQw0K
PiANCj4gT24gV2VkLCBTZXAgMTEsIDIwMTkgYXQgNToxNyBQTSBBcm5kIEJlcmdtYW5uIDxhcm5k
QGFybmRiLmRlPiB3cm90ZToNCj4gPg0KPiA+IE9uIFdlZCwgU2VwIDExLCAyMDE5IGF0IDk6NDYg
QU0gSmFtZXMgVGFpW+aItOW/l+WzsF0NCj4gPGphbWVzLnRhaUByZWFsdGVrLmNvbT4gd3JvdGU6
DQo+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogQWRkIHN1cHBvcnQgZm9yIFJlYWx0
ZWsgU09DDQo+ID4NCj4gPiA+ID4gPiBAQCAtMTQ4LDYgKzE0OCw3IEBAIGVuZGlmDQo+ID4gPiA+
ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NU004WDYwKSA6PSAweDAwMjA4MDAwDQo+ID4gPiA+
ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NU004OTYwKSA6PSAweDAwMjA4MDAwDQo+ID4gPiA+
ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NRVNPTikgOj0gMHgwMDIwODAwMA0KPiA+ID4gPiA+
ICt0ZXh0b2ZzLSQoQ09ORklHX0FSQ0hfUkVBTFRFSykgOj0gMHgwMDIwODAwMA0KPiA+ID4gPiA+
ICB0ZXh0b2ZzLSQoQ09ORklHX0FSQ0hfQVhYSUEpIDo9IDB4MDAzMDgwMDANCj4gPiA+ID4NCj4g
PiA+ID4gQ2FuIHlvdSBleHBsYWluIHdoeSB0aGlzIGlzIG5lZWRlZCBmb3IgeW91ciBwbGF0Zm9y
bT8NCj4gPiA+ID4NCj4gPiA+IFdlIG5lZWQgdG8gcmVzZXJ2ZSBtZW1vcnkgKDB4MDAwMDAwMDAg
fiAweDAwMUIwMDAwKSBmb3Igcm9tIGFuZCBib290DQo+IGNvZGUuDQo+ID4NCj4gPiBPay4NCj4g
DQo+IA0KPiBJIGRvIG5vdCBsaWtlIHRoaXMgbXVjaC4NCj4gDQo+IFRoaXMgcGxhdGZvcm0gaXMg
QVJDSF9NVUxUSV9WNy4NCj4gDQo+IEFSTV9QQVRDSF9QSFlTX1ZJUlQgYWxsb3dzIHlvdSB0byBw
bGFjZSB0aGUga2VybmVsIGltYWdlIGFueXdoZXJlIGluDQo+IG1lbW9yeSBhcyBsb25nIGFzIHRo
ZSBiYXNlIGlzIGFsaWduZWQgYXQgMTZNQi4NCj4gDQo+IFRoZSBtaW5pbXVtICd0ZXh0b2ZzLXkg
Oj0gMHgwMDA4MDAwJyArIGV4dHJhIDE2TUIgb2Zmc2V0IHdpbGwgY3JlYXRlIGEgc3BhY2UNCj4g
KDB4MDAwMDAwMDAgfiAweDAxMDA4MDAwKS4NCj4gDQo+IFRoaXMgaXMgbW9yZSB0aGFuIG5lZWRl
ZCwgYnV0IGl0IGlzIG5vdCBhIGJpZyBkZWFsIHRvIHdhc3RlIHNvbWUgbWVnYWJ5dGVzIG9mDQo+
IG1lbW9yeS4NCj4gDQoNCk9LLiBJIHVuZGVyc3RhbmQuDQoNCj4gLS0NCj4gQmVzdCBSZWdhcmRz
DQo+IE1hc2FoaXJvIFlhbWFkYQ0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZp
cm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
