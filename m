Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFE9ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EA02217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 10:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfJOKsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 06:48:40 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25387 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfJOKsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 06:48:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-4-OcvsGto7M5O-CokwjfVoxg-1;
 Tue, 15 Oct 2019 11:48:35 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 15 Oct 2019 11:48:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 15 Oct 2019 11:48:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "yshuiv7@gmail.com" <yshuiv7@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Matthias Kaehlcke <mka@google.com>,
        "S, Shirish" <Shirish.S@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: AMDGPU and 16B stack alignment
Thread-Topic: AMDGPU and 16B stack alignment
Thread-Index: AQHVgyjgGlq8x7ABFEya7CGn/JANAKdbg66A
Date:   Tue, 15 Oct 2019 10:48:35 +0000
Message-ID: <309b52a1c174410f8c6c14fe69c32e51@AcuMS.aculab.com>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
 <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
In-Reply-To: <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: OcvsGto7M5O-CokwjfVoxg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAxNSBPY3RvYmVyIDIwMTkgMDg6MTkNCj4gDQo+
IE9uIFR1ZSwgT2N0IDE1LCAyMDE5IGF0IDk6MDggQU0gUywgU2hpcmlzaCA8c3NoYW5rYXJAYW1k
LmNvbT4gd3JvdGU6DQo+ID4gT24gMTAvMTUvMjAxOSAzOjUyIEFNLCBOaWNrIERlc2F1bG5pZXJz
IHdyb3RlOg0KPiANCj4gPiBNeSBnY2MgYnVpbGQgZmFpbHMgd2l0aCBiZWxvdyBlcnJvcnM6DQo+
ID4NCj4gPiBkY25fY2FsY3MuYzoxOjA6IGVycm9yOiAtbXByZWZlcnJlZC1zdGFjay1ib3VuZGFy
eT0zIGlzIG5vdCBiZXR3ZWVuIDQgYW5kIDEyDQo+ID4NCj4gPiBkY25fY2FsY19tYXRoLmM6MTow
OiBlcnJvcjogLW1wcmVmZXJyZWQtc3RhY2stYm91bmRhcnk9MyBpcyBub3QgYmV0d2VlbiA0IGFu
ZCAxMg0KPiA+DQo+ID4gV2hpbGUgR1BGIG9ic2VydmVkIG9uIGNsYW5nIGJ1aWxkcyBzZWVtIHRv
IGJlIGZpeGVkLg0KPiANCj4gT2ssIHNvIGl0IHNlZW1zIHRoYXQgZ2NjIGluc2lzdHMgb24gaGF2
aW5nIGF0IGxlYXN0IDJeNCBieXRlcyBzdGFjaw0KPiBhbGlnbm1lbnQgd2hlbg0KPiBTU0UgaXMg
ZW5hYmxlZCBvbiB4ODYtNjQsIGJ1dCBkb2VzIG5vdCBhY3R1YWxseSByZWx5IG9uIHRoYXQgZm9y
DQo+IGNvcnJlY3Qgb3BlcmF0aW9uDQo+IHVubGVzcyBpdCdzIHVzaW5nIHNzZTIuIFNvIC1tc3Nl
IGFsd2F5cyBoYXMgdG8gYmUgcGFpcmVkIHdpdGgNCj4gIC1tcHJlZmVycmVkLXN0YWNrLWJvdW5k
YXJ5PTMuDQo+IA0KPiBGb3IgY2xhbmcsIGl0IHNvdW5kcyBsaWtlIHRoZSBvcHBvc2l0ZSBpcyB0
cnVlOiB3aGVuIHBhc3NpbmcgMTYgYnl0ZQ0KPiBzdGFjayBhbGlnbm1lbnQNCj4gYW5kIGhhdmlu
ZyBzc2Uvc3NlMiBlbmFibGVkLCBpdCByZXF1aXJlcyB0aGUgaW5jb21pbmcgc3RhY2sgdG8gYmUg
MTYNCj4gYnl0ZSBhbGlnbmVkLA0KPiBidXQgcGFzc2luZyA4IGJ5dGUgYWxpZ25tZW50IG1ha2Vz
IGl0IGRvIHRoZSByaWdodCB0aGluZy4NCj4gDQo+IFNvLCBzaG91bGQgd2UganVzdCBhbHdheXMg
cGFzcyAkKGNhbGwgY2Mtb3B0aW9uLCAtbXByZWZlcnJlZC1zdGFjay1ib3VuZGFyeT00KQ0KPiB0
byBnZXQgdGhlIGRlc2lyZWQgb3V0Y29tZSBvbiBib3RoPw0KDQpJdCBwcm9iYWJseSB3b24ndCBz
b2x2ZSB0aGUgcHJvYmxlbS4NCllvdSBuZWVkIHRvIGZpbmQgYWxsIHRoZSBhc20gYmxvY2tzIHRo
YXQgY2FsbCBiYWNrIGludG8gQyBhbmQgZW5zdXJlIHRoZXkNCm1haW50YWluIHRoZSByZXF1aXJl
ZCBzdGFjayBhbGlnbm1lbnQuDQpUaGlzIG1pZ2h0IGJlIHBvc3NpYmxlIGluIHRoZSBrZXJuZWws
IGJ1dCBpcyBhbG1vc3QgaW1wb3NzaWJsZSBpbiB1c2Vyc3BhY2UuDQoNCklTVFIgdGhhdCBnY2Mg
YXJiaXRyYXJpbHkgY2hhbmdlZCB0aGUgc3RhY2sgYWxpZ25tZW50IGZvciBpMzg2IGEgZmV3IHll
YXJzIGFnby4NCldoaWxlIGl0IGhlbHBlZCBjb2RlIGdlbmVyYXRpb24gaXQgYnJva2UgYSBsb3Qg
b2YgdGhpbmdzLg0KSSBjYW4ndCByZW1lbWJlciB0aGUgY29ycmVjdCBzZXQgb2Ygb3B0aW9ucyB0
byBnZXQgdGhlIHN0YWNrIGFsaWdubWVudA0KY29kZSBhZGRlZCBvbmx5IHdoZXJlIGl0IHdhcyBu
ZWVkZWQgKGdlbmVyYXRlcyBhIGRvdWJsZSAlYnAgZnJhbWUpLg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

