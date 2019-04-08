Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E312C282DE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697C920870
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfDHJx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:53:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:29193 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725983AbfDHJx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:53:56 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-166-5mVXfh7ONdefGJDZ8ozDoQ-1; Mon, 08 Apr 2019 10:53:52 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 8 Apr 2019 10:55:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Apr 2019 10:55:00 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Lyude Paul' <lyude@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade
 Stealth
Thread-Topic: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade
 Stealth
Thread-Index: AQHU7ZUSkPdkw/c760Gm06JTgZ9iKaYyBMIg
Date:   Mon, 8 Apr 2019 09:55:00 +0000
Message-ID: <28dc38a55c45467dad6f11e9ea459172@AcuMS.aculab.com>
References: <20190407213735.10658-1-lyude@redhat.com>
         <20190407221034.GA162359@dtor-ws>
 <0ac9aef48f4cf974f4f7046aad1267ab5c8fe525.camel@redhat.com>
In-Reply-To: <0ac9aef48f4cf974f4f7046aad1267ab5c8fe525.camel@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 5mVXfh7ONdefGJDZ8ozDoQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTHl1ZGUgUGF1bA0KPiBTZW50OiAwNyBBcHJpbCAyMDE5IDIzOjU1DQo+IE9uIFN1biwg
MjAxOS0wNC0wNyBhdCAxNToxMCAtMDcwMCwgRG1pdHJ5IFRvcm9raG92IHdyb3RlOg0KPiA+IEhp
IEx5dWRlLA0KPiA+DQo+ID4gT24gU3VuLCBBcHIgMDcsIDIwMTkgYXQgMDU6Mzc6MzRQTSAtMDQw
MCwgTHl1ZGUgUGF1bCB3cm90ZToNCj4gPiA+IFRoZSBsYXRlIDIwMTYgbW9kZWwgb2YgdGhlIFJh
emVyIEJsYWRlIFN0ZWFsdGggaGFzIGEgYnVpbHQtaW4gVVNCDQo+ID4gPiBrZXlib2FyZCwgYnV0
IGZvciBzb21lIHJlYXNvbiB0aGUgQklPUyBleHBvc2VzIGFuIGk4MDQyIGNvbnRyb2xsZXIgd2l0
aA0KPiA+ID4gYSBjb25uZWN0ZWQgS0JEIHBvcnQuIFdoaWxlIHRoaXMgZmFrZSBBVCBLZXlib2Fy
ZCBkZXZpY2UgZG9lc24ndCBhcHBlYXINCj4gPiA+IHRvIHJlcG9ydCBhbnkgZXZlbnRzLCBhdHRl
bXB0aW5nIHRvIGNoYW5nZSB0aGUgc3RhdGUgb2YgdGhlIGNhcHMgbG9jaw0KPiA+ID4gTEVEIG9u
IGl0IGZyb20gb24gdG8gb2ZmIGNhdXNlcyB0aGUgZW50aXJlIHN5c3RlbSB0byBoYW5nLg0KPiA+
ID4NCj4gPiA+IFNvLCBpbnRyb2R1Y2UgYSBxdWlyayB0YWJsZSBmb3IgZGlzYWJsaW5nIGtleWJv
YXJkIHByb2JpbmcgYnkgZGVmYXVsdCwNCj4gPiA+IGk4MDQyX2RtaV9ub2tiZF90YWJsZSwgYW5k
IGFkZCB0aGlzIHNwZWNpZmljIG1vZGVsIG9mIFJhemVyIGxhcHRvcCB0bw0KPiA+ID4gdGhhdCB0
YWJsZS4NCj4gPg0KPiA+IFdoYXQgZG9lcyBkbWVzZyBzaG93IGFib3V0IGk4MDQyIGZvciB0aGlz
IGRldmljZT8gRXNwZWNpYWxseSBsaW5lICJQTlA6DQo+ID4gUFMvMiBDb250cm9sbGVyICAuLi4i
Pw0KPiA+DQo+IA0KPiBBcHIgMDcgMTg6NDI6NDYgbWFsYWNoaXRlIGtlcm5lbDogaTgwNDI6IFBO
UDogTm8gUFMvMiBjb250cm9sbGVyIGZvdW5kLg0KPiBBcHIgMDcgMTg6NDI6NDYgbWFsYWNoaXRl
IGtlcm5lbDogaTgwNDI6IFByb2JpbmcgcG9ydHMgZGlyZWN0bHkuDQo+IEFwciAwNyAxODo0Mjo0
NiBtYWxhY2hpdGUga2VybmVsOiBzZXJpbzogaTgwNDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGly
cSAxDQo+IEFwciAwNyAxODo0Mjo0NiBtYWxhY2hpdGUga2VybmVsOiBzZXJpbzogaTgwNDIgQVVY
IHBvcnQgYXQgMHg2MCwweDY0IGlycSAxMg0KPiBBcHIgMDcgMTg6NDI6NDYgbWFsYWNoaXRlIGtl
cm5lbDogbW91c2VkZXY6IFBTLzIgbW91c2UgZGV2aWNlIGNvbW1vbiBmb3IgYWxsIG1pY2UNCg0K
VGhhdCBpcyB0aGUgJ2RlZmF1bHQnIHByb2JlIG9mIHRoZSBwcy8yIHNlcmlhbCBwb3J0cy4NCkxv
b2tzIGxpa2UgdGhlIEJJT1MgaXMgY29ycmVjdCBpbiBub3QgZXhwb3NpbmcgdGhlIHBzLzIgY29u
dHJvbGxlci4NClVzdWFsbHkgdGhleSBqdXN0IGZhaWwgdG8gZXhwb3NlIHRoZSBtb3VzZSB3aGVu
IGl0IG5lZWRzIGEgcHMvMiBzcGxpdHRlciA6LSgNCg0KSSBkbyB3b25kZXIgd2hhdCB0aGV5J3Zl
IGNvbm5lY3RlZCBpdCB0byB0aG91Z2guDQpJdCBpcyBleHRyZW1lbHkgdW5saWtlbHkgdGhleSd2
ZSBmb3VuZCBhbiB4ODYgY2hpcHNldCB0aGF0IGRvZXNuJ3QNCmhhdmUgdGhlIHBzLzIgc2VyaWFs
IHBvcnRzIGF0IHRoZSBzdGFuZGFyZCBpbyBhZGRyZXNzZXMuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

