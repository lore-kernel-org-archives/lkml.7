Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6D3C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C9CA206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLaJ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:26:22 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59793 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:26:22 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9Pp7m029306, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9Pp7m029306
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:25:52 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:25:51 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:25:51 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:25:51 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 06/14] dt-bindings: reset: Add Realtek RTD1195
Thread-Topic: [PATCH 06/14] dt-bindings: reset: Add Realtek RTD1195
Thread-Index: AQHVqT33UyBET913+UCfJNYfDE38aKfUJdjg
Date:   Tue, 31 Dec 2019 09:25:50 +0000
Message-ID: <7d794ee055c74c6aae473073a094de29@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-7-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-7-afaerber@suse.de>
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

PiBBZGQgYSBoZWFkZXIgd2l0aCBzeW1ib2xpYyByZXNldCBpbmRpY2VzIGZvciBSZWFsdGVrIFJU
RDExOTUgU29DLg0KPiBOYW1pbmcgd2FzIGRlcml2ZWQgZnJvbSBCU1AgcmVnaXN0ZXIgZGVzY3Jp
cHRpb24gaGVhZGVycy4NCj4gDQo+IEFja2VkLWJ5OiBQaGlsaXBwIFphYmVsIDxwLnphYmVsQHBl
bmd1dHJvbml4LmRlPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0K
PiAtLS0NCj4gIHYxOiBGcm9tIFJURDExOTUgdjQgc2VyaWVzDQo+IA0KPiAgaW5jbHVkZS9kdC1i
aW5kaW5ncy9yZXNldC9yZWFsdGVrLHJ0ZDExOTUuaCB8IDc0DQo+ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzQgaW5zZXJ0aW9ucygrKQ0KPiAgY3Jl
YXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvcmVhbHRlayxydGQxMTk1
LmgNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L3JlYWx0ZWss
cnRkMTE5NS5oDQo+IGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9yZXNldC9yZWFsdGVrLHJ0ZDExOTUu
aA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjI3OTAyYWJm
OTM1Yg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQv
cmVhbHRlayxydGQxMTk1LmgNCj4gQEAgLTAsMCArMSw3NCBAQA0KPiArLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IChHUEwtMi4wLW9yLWxhdGVyIE9SIEJTRC0yLUNsYXVzZSkgKi8NCj4gKy8q
DQo+ICsgKiBSZWFsdGVrIFJURDExOTUgcmVzZXQgY29udHJvbGxlcnMNCj4gKyAqDQo+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMTcgQW5kcmVhcyBGw6RyYmVyDQo+ICsgKi8NCj4gKyNpZm5kZWYgRFRf
QklORElOR1NfUkVTRVRfUlREMTE5NV9IDQo+ICsjZGVmaW5lIERUX0JJTkRJTkdTX1JFU0VUX1JU
RDExOTVfSA0KPiArDQo+ICsvKiBzb2Z0IHJlc2V0IDEgKi8NCj4gKyNkZWZpbmUgUlREMTE5NV9S
U1ROX01JU0MJCTANCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX1JORwkJMQ0KPiArI2RlZmluZSBS
VEQxMTk1X1JTVE5fVVNCM19QT1cJCTINCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0dTUEkJCTMN
Cj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX1VTQjNfUDBfTURJTwk0DQo+ICsjZGVmaW5lIFJURDEx
OTVfUlNUTl9WRV9IMjY1CQk1DQo+ICsjZGVmaW5lIFJURDExOTVfUlNUTl9VU0IJCTYNCj4gKyNk
ZWZpbmUgUlREMTE5NV9SU1ROX1VTQl9QSFkwCQk4DQo+ICsjZGVmaW5lIFJURDExOTVfUlNUTl9V
U0JfUEhZMQkJOQ0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fSERNSVJYCQkxMQ0KPiArI2RlZmlu
ZSBSVEQxMTk1X1JTVE5fSERNSQkJMTINCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0VUTgkJMTQN
Cj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0FJTwkJMTUNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1RO
X0dQVQkJMTYNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX1ZFX0gyNjQJCTE3DQo+ICsjZGVmaW5l
IFJURDExOTVfUlNUTl9WRV9KUEVHCQkxOA0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fVFZFCQkx
OQ0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fVk8JCQkyMA0KPiArI2RlZmluZSBSVEQxMTk1X1JT
VE5fTFZEUwkJMjENCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX1NFCQkJMjINCj4gKyNkZWZpbmUg
UlREMTE5NV9SU1ROX0RDVQkJMjMNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0RDX1BIWQkJMjQN
Cj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0NQCQkJMjUNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1RO
X01ECQkJMjYNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX1RQCQkJMjcNCj4gKyNkZWZpbmUgUlRE
MTE5NV9SU1ROX0FFCQkJMjgNCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX05GCQkJMjkNCj4gKyNk
ZWZpbmUgUlREMTE5NV9SU1ROX01JUEkJCTMwDQo+ICsNCj4gKy8qIHNvZnQgcmVzZXQgMiAqLw0K
PiArI2RlZmluZSBSVEQxMTk1X1JTVE5fQUNQVQkJMA0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5f
VkNQVQkJMQ0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fUENSCQk5DQo+ICsjZGVmaW5lIFJURDEx
OTVfUlNUTl9DUgkJCTEwDQo+ICsjZGVmaW5lIFJURDExOTVfUlNUTl9FTU1DCQkxMQ0KPiArI2Rl
ZmluZSBSVEQxMTk1X1JTVE5fU0RJTwkJMTINCj4gKyNkZWZpbmUgUlREMTE5NV9SU1ROX0kyQ181
CQkxOA0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fUlRDCQkyMA0KPiArI2RlZmluZSBSVEQxMTk1
X1JTVE5fSTJDXzQJCTIzDQo+ICsjZGVmaW5lIFJURDExOTVfUlNUTl9JMkNfMwkJMjQNCj4gKyNk
ZWZpbmUgUlREMTE5NV9SU1ROX0kyQ18yCQkyNQ0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fSTJD
XzEJCTI2DQo+ICsjZGVmaW5lIFJURDExOTVfUlNUTl9VUjEJCTI4DQo+ICsNCj4gKy8qIHNvZnQg
cmVzZXQgMyAqLw0KPiArI2RlZmluZSBSVEQxMTk1X1JTVE5fU0IyCQkwDQo+ICsNCj4gKy8qIGlz
byBzb2Z0IHJlc2V0ICovDQo+ICsjZGVmaW5lIFJURDExOTVfSVNPX1JTVE5fVkZECQkwDQo+ICsj
ZGVmaW5lIFJURDExOTVfSVNPX1JTVE5fSVIJCTENCj4gKyNkZWZpbmUgUlREMTE5NV9JU09fUlNU
Tl9DRUMwCQkyDQo+ICsjZGVmaW5lIFJURDExOTVfSVNPX1JTVE5fQ0VDMQkJMw0KPiArI2RlZmlu
ZSBSVEQxMTk1X0lTT19SU1ROX0RQCQk0DQo+ICsjZGVmaW5lIFJURDExOTVfSVNPX1JTVE5fQ0JV
U1RYCQk1DQo+ICsjZGVmaW5lIFJURDExOTVfSVNPX1JTVE5fQ0JVU1JYCQk2DQo+ICsjZGVmaW5l
IFJURDExOTVfSVNPX1JTVE5fRUZVU0UJCTcNCj4gKyNkZWZpbmUgUlREMTE5NV9JU09fUlNUTl9V
UjAJCTgNCj4gKyNkZWZpbmUgUlREMTE5NV9JU09fUlNUTl9HTUFDCQk5DQo+ICsjZGVmaW5lIFJU
RDExOTVfSVNPX1JTVE5fR1BIWQkJMTANCj4gKyNkZWZpbmUgUlREMTE5NV9JU09fUlNUTl9JMkNf
MAkJMTENCj4gKyNkZWZpbmUgUlREMTE5NV9JU09fUlNUTl9JMkNfNgkJMTINCj4gKyNkZWZpbmUg
UlREMTE5NV9JU09fUlNUTl9DQlVTCQkxMw0KPiArDQo+ICsjZW5kaWYNCj4gLS0NCj4gMi4xNi40
DQo+IA0KQWNrZWQtYnk6IEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPg0KDQo=
