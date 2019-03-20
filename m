Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FAEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E0821850
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 11:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbfCTLRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 07:17:47 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48925 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726006AbfCTLRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 07:17:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-r2Cu1UssOci63w51Rzr1Vw-1; Wed, 20 Mar 2019 11:17:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Mar 2019 11:18:46 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Mar 2019 11:18:46 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "julien.thierry@arm.com" <julien.thierry@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "luto@amacapital.net" <luto@amacapital.net>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dvlasenk@redhat.com" <dvlasenk@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: RE: [PATCH 02/25] tracing: Improve "if" macro code generation
Thread-Topic: [PATCH 02/25] tracing: Improve "if" macro code generation
Thread-Index: AQHU3aLdi3oEk4fc9kGJYBZloKomkaYUYYEg
Date:   Wed, 20 Mar 2019 11:18:46 +0000
Message-ID: <f918ecb0b6bf43f3bf0f526084d8467b@AcuMS.aculab.com>
References: <20190318153840.906404905@infradead.org>
 <20190318155140.058627431@infradead.org>
In-Reply-To: <20190318155140.058627431@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: r2Cu1UssOci63w51Rzr1Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogPiBQZXRlciBaaWpsc3RyYQ0KPiBTZW50OiAxOCBNYXJjaCAyMDE5IDE1OjM5DQo+IA0K
PiBXaXRoIENPTkZJR19QUk9GSUxFX0FMTF9CUkFOQ0hFUywgdGhlICJpZiIgbWFjcm8gY29udmVy
dHMgdGhlDQo+IGNvbmRpdGlvbmFsIHRvIGFuIGFycmF5IGluZGV4LiAgVGhpcyBjYW4gY2F1c2Ug
R0NDIHRvIGNyZWF0ZSBob3JyaWJsZQ0KPiBjb2RlLiAgV2hlbiB0aGVyZSBhcmUgbmVzdGVkIGlm
cywgdGhlIGdlbmVyYXRlZCBjb2RlIHVzZXMgcmVnaXN0ZXINCj4gdmFsdWVzIHRvIGVuY29kZSBi
cmFuY2hpbmcgZGVjaXNpb25zLg0KPiANCj4gTWFrZSBpdCBlYXNpZXIgZm9yIEdDQyB0byBvcHRp
bWl6ZSBieSBrZWVwaW5nIHRoZSBjb25kaXRpb25hbCBhcyBhDQo+IGNvbmRpdGlvbmFsIHJhdGhl
ciB0aGFuIGNvbnZlcnRpbmcgaXQgdG8gYW4gaW50ZWdlci4gIFRoaXMgc2hyaW5rcyB0aGUNCj4g
Z2VuZXJhdGVkIGNvZGUgcXVpdGUgYSBiaXQsIGFuZCBhbHNvIG1ha2VzIHRoZSBjb2RlIHNhbmUg
ZW5vdWdoIGZvcg0KPiBvYmp0b29sIHRvIHVuZGVyc3RhbmQuDQouLi4NCj4gIGluY2x1ZGUvbGlu
dXgvY29tcGlsZXIuaCB8ICAgIDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gLS0tIGEvaW5jbHVkZS9saW51eC9jb21waWxlci5oDQo+
ICsrKyBiL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaA0KPiBAQCAtNjcsNyArNjcsNyBAQCB2b2lk
IGZ0cmFjZV9saWtlbHlfdXBkYXRlKHN0cnVjdCBmdHJhY2VfDQo+ICAJCQkJLmxpbmUgPSBfX0xJ
TkVfXywJCQlcDQo+ICAJCQl9OwkJCQkJCVwNCj4gIAkJX19fX19fciA9ICEhKGNvbmQpOwkJCQkJ
XA0KDQoJSXMgdGhhdCAob3IgbWF5YmUganVzdCB0aGUgISEpIG5lZWRlZCBhbnkgbW9yZT8/DQoN
Cj4gLQkJX19fX19fZi5taXNzX2hpdFtfX19fX19yXSsrOwkJCQkJXA0KPiArCQlfX19fX19yID8g
X19fX19fZi5taXNzX2hpdFsxXSsrIDogX19fX19fZi5taXNzX2hpdFswXSsrO1wNCj4gIAkJX19f
X19fcjsJCQkJCQlcDQo+ICAJfSkpDQo+ICAjZW5kaWYgLyogQ09ORklHX1BST0ZJTEVfQUxMX0JS
QU5DSEVTICovDQo+IA0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

