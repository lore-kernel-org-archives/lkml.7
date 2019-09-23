Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12A2C3A5A2
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E4C720820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 02:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392100AbfIWC1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 22:27:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46132 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390293AbfIWC1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 22:27:36 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8N2Pj3o013232, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8N2Pj3o013232
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 23 Sep 2019 10:25:45 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Mon, 23 Sep
 2019 10:25:44 +0800
From:   James Tai <james.tai@realtek.com>
To:     "'Arnd Bergmann'" <arnd@arndb.de>
CC:     "jamestai.sky@gmail.com" <jamestai.sky@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        Paul Burton <paul.burton@mips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "Doug Anderson" <armlinux@m.disordat.com>,
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
Thread-Index: AQHVY67V+8blpY45FUyr2dN3mgK/RqccOwQAgAf67ACAAW8fgIASLtdg
Date:   Mon, 23 Sep 2019 02:25:43 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF8E7CA5@RTITMBSVM04.realtek.com.tw>
References: <20190905054647.1235-1-james.tai@realtek.com>
 <CAK8P3a13=VBZnj6E=s7mZk0o7Q3XkMHgcsL12s-3psuOWsfOtQ@mail.gmail.com>
 <43B123F21A8CFE44A9641C099E4196FFCF8DA1D0@RTITMBSVM04.realtek.com.tw>
 <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
In-Reply-To: <CAK8P3a39VrC1Xn+HZc5gvh1-nUYKywDGjTfO9WPCqim89WtGAg@mail.gmail.com>
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

PiA8amFtZXMudGFpQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIEFSTTogQWRkIHN1cHBvcnQgZm9yIFJlYWx0ZWsgU09DDQo+IA0KPiA+ID4gPiBAQCAtMTQ4
LDYgKzE0OCw3IEBAIGVuZGlmDQo+ID4gPiA+ICB0ZXh0b2ZzLSQoQ09ORklHX0FSQ0hfTVNNOFg2
MCkgOj0gMHgwMDIwODAwMA0KPiA+ID4gPiAgdGV4dG9mcy0kKENPTkZJR19BUkNIX01TTTg5NjAp
IDo9IDB4MDAyMDgwMDANCj4gPiA+ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9NRVNPTikgOj0g
MHgwMDIwODAwMA0KPiA+ID4gPiArdGV4dG9mcy0kKENPTkZJR19BUkNIX1JFQUxURUspIDo9IDB4
MDAyMDgwMDANCj4gPiA+ID4gIHRleHRvZnMtJChDT05GSUdfQVJDSF9BWFhJQSkgOj0gMHgwMDMw
ODAwMA0KPiA+ID4NCj4gPiA+IENhbiB5b3UgZXhwbGFpbiB3aHkgdGhpcyBpcyBuZWVkZWQgZm9y
IHlvdXIgcGxhdGZvcm0/DQo+ID4gPg0KPiA+IFdlIG5lZWQgdG8gcmVzZXJ2ZSBtZW1vcnkgKDB4
MDAwMDAwMDAgfiAweDAwMUIwMDAwKSBmb3Igcm9tIGFuZCBib290DQo+IGNvZGUuDQo+IA0KPiBP
ay4NCj4gDQo+ID4gPiA+ICtjb25maWcgQVJDSF9SVEQxNlhYDQo+ID4gPiA+ICsgICAgICAgYm9v
bCAiRW5hYmxlIHN1cHBvcnQgZm9yIFJURDE2MTkiDQo+ID4gPiA+ICsgICAgICAgZGVwZW5kcyBv
biBBUkNIX1JFQUxURUsNCj4gPiA+ID4gKyAgICAgICBzZWxlY3QgQVJNX0dJQ19WMw0KPiA+ID4g
PiArICAgICAgIHNlbGVjdCBBUk1fUFNDSQ0KPiA+ID4NCj4gPiA+IEFzIEkgdW5kZXJzdGFuZCwg
dGhpcyBjaGlwIHVzZXMgYSBDb3J0ZXgtQTU1LiBXaGF0IGlzIHRoZSByZWFzb24gZm9yDQo+ID4g
PiBhZGRpbmcgc3VwcG9ydCBvbmx5IHRvIHRoZSAzMi1iaXQgQVJNIGFyY2hpdGVjdHVyZSByYXRo
ZXIgdGhhbiA2NC1iaXQ/DQo+ID4NCj4gPiBUaGUgUlREMTZYWCBwbGF0Zm9ybSBhbHNvIHN1cHBv
cnQgdGhlIDY0LWJpdCBBUk0gYXJjaGl0ZWN0dXJlLg0KPiA+IEkgd2lsbCBhZGQgdGhlIDY0LWJp
dCBBUk0gYXJjaGl0ZWN0dXJlIGluIG5ldyB2ZXJzaW9uIHBhdGNoLg0KPiA+DQo+ID4gPiBNb3N0
IDY0LWJpdCBTb0NzIGFyZSBvbmx5IHN1cHBvcnRlZCB3aXRoIGFyY2gvYXJtNjQsIGJ1dCBnZW5l
cmFsbHkNCj4gPiA+IHNwZWFraW5nIHRoYXQgaXMgbm90IGEgcmVxdWlyZW1lbnQuIE15IHJ1bGUg
b2YgdGh1bWIgaXMgdGhhdCBvbg0KPiA+ID4gc3lzdGVtcyB3aXRoIDFHQiBvZiBSQU0gb3IgbW9y
ZSwgb25lIHdvdWxkIHdhbnQgdG8gcnVuIGEgNjQtYml0DQo+ID4gPiBrZXJuZWwsIHdoaWxlIHN5
c3RlbXMgd2l0aCBsZXNzIHRoYW4gdGhhdCBhcmUgYmV0dGVyIG9mZiB3aXRoIGENCj4gPiA+IDMy
LWJpdCBvbmUsIGJ1dCB0aGF0IGlzIGNsZWFybHkgbm90IHRoZSBvbmx5IHJlYXNvbiBmb3IgcGlj
a2luZyBvbmUgb3ZlciB0aGUNCj4gb3RoZXIuDQo+ID4gPg0KPiA+IFN1cHBvcnQgMzItYml0IEFS
TSBhcmNoaXRlY3R1cmUgaXMgZm9yIGFwcGxpY2F0aW9uIGNvbXBhdGliaWxpdHkuDQo+IA0KPiBH
ZW5lcmFsbHkgc3BlYWtpbmcsIGEgNjQtYml0IGtlcm5lbCBzaG91bGQgd29yayBiZXR0ZXIgb24g
NjQtYml0IGhhcmR3YXJlDQo+IGV2ZW4gd2hlbiB5b3UgYXJlIHJ1bm5pbmcgbW9zdGx5IDMyLWJp
dCBhcHBsaWNhdGlvbnMuIEhvd2V2ZXIsIHlvdSBtYXkgaGF2ZQ0KPiBkZXZpY2UgZHJpdmVycyB0
aGF0IGRvIG5vdCBjb3JyZWN0bHkgc2V0IGNvbXBhdF9pb2N0bCBoYW5kbGVycy4NCj4gDQo+IEFz
IEkgc2FpZCwgaXQncyBubyBwcm9ibGVtIHRvIGFsbG93IGJvdGgsIGp1c3QgZXhwbGFpbiB0aGlz
IGluIHRoZSBjaGFuZ2Vsb2cgdGV4dA0KPiBmb3IgdGhlIGRyaXZlciwgYWxvbmcgd2l0aCB0aGUg
bmVlZCBmb3IgdGhlIHRleHRvZnMgc2V0dGluZy4NCj4gDQpPSy4NCg0KPiA+ID4gSXQncyB2ZXJ5
IHVudXN1YWwgdG8gc2VlIGN1c3RvbSBzbXAgb3BlcmF0aW9ucyBvbiBhbiBBUk12OCBzeXN0ZW0s
DQo+ID4gPiBhcyB3ZSBub3JtYWxseSB1c2UgUFNDSSBoZXJlLiBDYW4geW91IGV4cGxhaW4gd2hh
dCBpcyBnb2luZyBvbiBoZXJlPw0KPiA+ID4gQXJlIHlvdSBhYmxlIHRvIHVzZSBhIGJvb3Qgd3Jh
cHBlciB0aGF0IGltcGxlbWVudHMgdGhlc2UgaW4gcHNjaSBpbnN0ZWFkPw0KPiA+ID4NCj4gPiBU
aGUgc21wIG9wZXJhdGlvbnMgaXMgcG9ydGluZyBmb3JtIG90aGVyIFJlYWx0ZWsgcGxhdGZvcm0u
DQo+ID4NCj4gPiBDdXJyZW50bHksIFRoZSBSVEQxNlhYIHBsYXRmb3JtIGNhbiB1c2UgdGhlIFBT
Q0kgbWV0aG9kLg0KPiA+IEkgd2lsbCBhZGQgUFNDSSBtZXRob2QgaW4gbmV3IHZlcnNpb24gcGF0
Y2guDQo+IA0KPiBPaywgcGVyZmVjdCENCj4gDQo+ID4gPiA+ICsgICAgICAgdGltZXJfcHJvYmUo
KTsNCj4gPiA+ID4gKyAgICAgICB0aWNrX3NldHVwX2hydGltZXJfYnJvYWRjYXN0KCk7IH0NCj4g
PiA+DQo+ID4gPiBXaGF0IGRvIHlvdSBuZWVkIHRpY2tfc2V0dXBfaHJ0aW1lcl9icm9hZGNhc3Qo
KSBmb3I/IEkgZG9uJ3Qgc2VlIGFueQ0KPiA+ID4gb3RoZXIgcGxhdGZvcm0gY2FsbGluZyB0aGlz
Lg0KPiA+ID4NCj4gPiBJIHdhbnQgdG8gaW5pdGlhbGl6ZSB0aGUgSFIgdGltZXIuDQo+IA0KPiBJ
J20gc3RpbGwgdW5zdXJlIGFib3V0IHRoaXMgb25lLiBNeSBmZWVsaW5nIGlzIHRoYXQgaXQgc2hv
dWxkIG5vdCBiZSBpbiB0aGUNCj4gcGxhdGZvcm0gY29kZSwgYnV0IEkgZG9uJ3QgcXVpdGUgdW5k
ZXJzdGFuZCB3aGljaCBoYXJkd2FyZSBuZWVkcyBpdC4gSSBzZWUgdGhhdA0KPiBMb3JlbnpvIFBp
ZXJhbGlzaSBhZGRlZCB0aGUgc2FtZSBjb2RlIHRvIGFybTY0IGluIGNvbW1pdCA5MzU4ZDc1NWJk
NWMNCj4gKCJhcm02NDoga2VybmVsOiBpbml0aWFsaXplIGJyb2FkY2FzdCBocnRpbWVyIGJhc2Vk
IGNsb2NrIGV2ZW50IGRldmljZSIpLCBidXQNCj4gbm90aGluZyBldmVyIGNhbGxzIGl0IG9uIDMy
LWJpdCBhcmNoL2FybSBldmVuIHRob3VnaCB0aGUgY29kZSBkb2VzIGdldCBidWlsdCBpbg0KPiB0
byB0aGUga2VybmVsLg0KDQpJIHdpbGwgYWRkIHRoZSAnaHJ0aW1lcicgaW5pdGlhbGl6YXRpb24g
ZmxvdyBpbiByZWxhdGVkIGRldmljZXMgZHJpdmVycy4NCg0KPiBNeSBmZWVsaW5nIGlzIHRoYXQg
ZWl0aGVyIHlvdSBkb24ndCByZWFsbHkgbmVlZCBpdCwgb3IgdGhpcyBpcyBzb21ldGhpbmcgdGhh
dCBvdGhlcg0KPiBwbGF0Zm9ybXMgc2hvdWxkIHJlYWxseSBkbyBhcyB3ZWxsLCBhbmQgaXQgc2hv
dWxkIGJlIGNhbGxlZCBmcm9tIHRoZSBnZW5lcmljDQo+IHRpbWVfaW5pdCgpIGZ1bmN0aW9uIGlu
IGFyY2gvYXJtL2tlcm5lbC90aW1lLmMgaW5zdGVhZC4NCj4gDQpPSy4gSSB1bmRlcnN0YW5kLg0K
DQo+IENhbiB5b3UgdHJ5IHRvIGZpbmQgb3V0IG1vcmUgb2YgdGhlIGJhY2tncm91bmQgaGVyZSwg
YW5kIHRoZW4gbW92ZSB0aGUgY2FsbCB0bw0KPiB0aW1lX2luaXQoKSBhc3N1bWluZyBpdCBpcyBp
bmRlZWQgdXNlZnVsPw0KDQpJIGFncmVlIHdpdGggeW91LiBJdCBpcyBub3QgbmVjZXNzYXJ5IHRv
IGNhbGwgJ3RpbWVfaW5pdCgpJyBmdW5jdGlvbiBpbiBwbGF0Zm9ybSBjb2RlLg0KDQo+ICAgICAg
ICBBcm5kDQo+IA0KPiAtLS0tLS1QbGVhc2UgY29uc2lkZXIgdGhlIGVudmlyb25tZW50IGJlZm9y
ZSBwcmludGluZyB0aGlzIGUtbWFpbC4NCg==
