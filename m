Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11EF3C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E153C2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 15:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbfD2Pe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 11:34:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22625 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728311AbfD2Pe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 11:34:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-62-DYiISddmOvuraxlBQcgNxw-1; Mon, 29 Apr 2019 16:34:56 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 29 Apr 2019 16:34:55 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 29 Apr 2019 16:34:55 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Gustavo A. R. Silva'" <gustavo@embeddedor.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Thread-Topic: [PATCH] usbip: vhci_hcd: Mark expected switch fall-through
Thread-Index: AQHU/plu2318l/GBi0OLId5OVcMGj6ZTNpSw///1h4CAABKa0A==
Date:   Mon, 29 Apr 2019 15:34:55 +0000
Message-ID: <c3b730fde3ab44d1b339187518077bcf@AcuMS.aculab.com>
References: <20190429143957.GA6725@embeddedor>
 <1daec8c8929e4d18b2059ab1dfbfdf4a@AcuMS.aculab.com>
 <287c8504-eafa-ebbb-aa39-babb86fdeb94@embeddedor.com>
In-Reply-To: <287c8504-eafa-ebbb-aa39-babb86fdeb94@embeddedor.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: DYiISddmOvuraxlBQcgNxw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR3VzdGF2byBBLiBSLiBTaWx2YQ0KPiBTZW50OiAyOSBBcHJpbCAyMDE5IDE2OjA2DQo+
IE9uIDQvMjkvMTkgOTo0NCBBTSwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPiA+IEZyb206IEd1c3Rh
dm8gQS4gUi4gU2lsdmENCj4gPj4gU2VudDogMjkgQXByaWwgMjAxOSAxNTo0MA0KPiA+PiBJbiBw
cmVwYXJhdGlvbiB0byBlbmFibGluZyAtV2ltcGxpY2l0LWZhbGx0aHJvdWdoLCBtYXJrIHN3aXRj
aA0KPiA+PiBjYXNlcyB3aGVyZSB3ZSBhcmUgZXhwZWN0aW5nIHRvIGZhbGwgdGhyb3VnaC4NCj4g
PiAuLi4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL3VzYmlwL3ZoY2lfaGNkLmMgYi9k
cml2ZXJzL3VzYi91c2JpcC92aGNpX2hjZC5jDQo+ID4+IGluZGV4IDY2N2Q5YzBlYzkwNS4uMDAw
YWI3MjI1NzE3IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3VzYi91c2JpcC92aGNpX2hjZC5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvdXNiL3VzYmlwL3ZoY2lfaGNkLmMNCj4gPj4gQEAgLTUwOCw2
ICs1MDgsNyBAQCBzdGF0aWMgaW50IHZoY2lfaHViX2NvbnRyb2woc3RydWN0IHVzYl9oY2QgKmhj
ZCwgdTE2IHR5cGVSZXEsIHUxNiB3VmFsdWUsDQo+ID4+ICAJCWNhc2UgVVNCX1BPUlRfRkVBVF9V
MV9USU1FT1VUOg0KPiA+PiAgCQkJdXNiaXBfZGJnX3ZoY2lfcmgoDQo+ID4+ICAJCQkJIiBTZXRQ
b3J0RmVhdHVyZTogVVNCX1BPUlRfRkVBVF9VMV9USU1FT1VUXG4iKTsNCj4gPj4gKwkJCS8qIEZh
bGwgdGhyb3VnaCAqLw0KPiA+PiAgCQljYXNlIFVTQl9QT1JUX0ZFQVRfVTJfVElNRU9VVDoNCj4g
Pj4gIAkJCXVzYmlwX2RiZ192aGNpX3JoKA0KPiA+PiAgCQkJCSIgU2V0UG9ydEZlYXR1cmU6IFVT
Ql9QT1JUX0ZFQVRfVTJfVElNRU9VVFxuIik7DQo+ID4NCj4gPiBUaGF0IGRvZXNuJ3QgbG9vayBy
aWdodCwgYm90aCBkZWJ1ZyBtZXNzYWdlcyBzZWVtIHRvIGdldCBwcmludGVkLg0KPiA+DQo+IA0K
PiBBdCBmaXJzdCBzaWdodCwgSSB0aG91Z2h0IHRoZSBzYW1lIHdheSwgdGhlbiBJIHRvb2sgYSBs
b29rIGludG8NCj4gY29tbWl0Og0KPiANCj4gMWM5ZGU1YmY0Mjg2MTI0NTg0Mjc5NDNiNzI0YmVh
NTFhYmRlNTIwYQ0KPiANCj4gYW5kIG5vdGljZWQgdGhhdCB0aGUgb3JpZ2luYWwgZGV2ZWxvcGVy
IHByb3Blcmx5IGFkZGVkIGZhbGwtdGhyb3VnaA0KPiBjb21tZW50cyBpbiBvdGhlciBwbGFjZXMg
aW4gdGhlIHNhbWUgc3dpdGNoKCkgY29kZSwgdGhhdCBnYXZlIG1lIHRoZQ0KPiBpbXByZXNzaW9u
IGhlIGtuZXcgd2hhdCBoZSB3YXMgZG9pbmc7IHRoZW4gSSBub3RpY2VkIHRoZSBmb2xsb3dpbmcN
Cj4gZXJyb3IgbWVzc2FnZSBpbiBjYXNlIFVTQl9QT1JUX0ZFQVRfVTJfVElNRU9VVDoNCj4gDQo+
IAlpZiAoaGNkLT5zcGVlZCAhPSBIQ0RfVVNCMykgew0KPiAJCXByX2VycigiVVNCX1BPUlRfRkVB
VF9VMS8yX1RJTUVPVVQgcmVxIG5vdCAiDQo+IAkJICAgICAgICJzdXBwb3J0ZWQgZm9yIFVTQiAy
LjAgcm9vdGh1YlxuIik7DQo+IAkJZ290byBlcnJvcjsNCj4gCX0NCj4gDQo+IHRoaXMgZXJyb3Ig
bWVzc2FnZSBpcyB3aGF0IG1ha2VzIG1lIHRoaW5rIHRoZSBmYWxsLXRocm91Z2ggaXMNCj4gaW50
ZW50aW9uYWw7IG90aGVyd2lzZSBJIHRoaW5rIGl0IHdvdWxkIGxvb2sgbGlrZSB0aGlzIGluc3Rl
YWQ6DQo+IA0KPiAJaWYgKGhjZC0+c3BlZWQgIT0gSENEX1VTQjMpIHsNCj4gCQlwcl9lcnIoIlVT
Ql9QT1JUX0ZFQVRfVTJfVElNRU9VVCByZXEgbm90ICINCj4gCQkgICAgICAgInN1cHBvcnRlZCBm
b3IgVVNCIDIuMCByb290aHViXG4iKTsNCj4gCQlnb3RvIGVycm9yOw0KPiAJfQ0KDQpHb2QsIHRo
YXQgY29kZSBpcyB0cnVseSB1Z2x5IDotKA0KDQpJdCBzdGFydHMgb2ZmIGJhZCB3aXRoIGFsbCB0
aG9zZSAndTE2JyBwYXJhbWV0ZXJzIC0gdGhleSdsbCByZXF1aXJlIGENCm1hc2sgb3BlcmF0aW9u
IHNvbWV3aGVyZS4NCg0KVGhlbiB3ZSBoYXZlIHRoZSBjbGFzc2ljOg0KCXdJbmRleCA9ICgoX191
OCkod0luZGV4ICYgMHhmZikpOw0KU29tZSBjb21waWxlcnMgaGF2ZSBiZWVuIGtub3duIHRvIGFu
ZCB3aXRoIDB4ZmYgdHdpY2UgZm9yIGNvZGUgbGlrZSB0aGF0Lg0KU2luY2UgdGhlIHRhcmdldCBp
cyB1MTYgdGhlcmUgY291bGQgYmUgYSAzcmQgbWFzayB3aXRoIDB4ZmZmZiBvbiBub24teDg2Lg0K
DQpJIGxpa2UgdG8gcHV0IGEgYmxhbmsgbGluZSBiZWZvcmUgJ2Nhc2UnIGxpbmVzIC0gdGhlIG9u
bHkgb25lcyBpbiB0aGF0DQpmdW5jdGlvbiBhcmUgaW4gdGhlIG1pZGRsZSBvZiBuZXN0ZWQgY2Fz
ZSBibG9ja3MhDQoNCklmIHlvdSBoYXZlIHRvIHJlbHkgb24gdGhlIHVzYmlwX2RiZ192aGNpX3Jo
KCkgZGVidWcgbGluZXMgeW91J2xsDQp3aXNoIHRoZXkgY29udGFpbmVkIG1vcmUgY29udGV4dCEN
CnZoY2lfaHViX2NvbnRyb2woKSBoYXMgb25lIGVhcmx5IG9uOyB0aGUgcmVzdCBjb3VsZCBiZSBr
aWxsZWQgLQ0KdGhleSBjb250YWluIG5vIG1vcmUgaW5mb3JtYXRpb24uDQoNCglEYXZpZA0KDQot
DQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwg
TWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2Fs
ZXMpDQo=

