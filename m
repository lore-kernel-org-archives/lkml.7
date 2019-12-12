Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5EEC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0F7214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbfLLQXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:23:30 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:28329 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729809AbfLLQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:23:29 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-221-WVyEuAo8NiemHoq8iN0FNA-1; Thu, 12 Dec 2019 16:23:26 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Dec 2019 16:23:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Dec 2019 16:23:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
CC:     "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, "Will Deacon" <will@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVsQWE6yBAo1s5f0Kws0hZvGpx8qe2riCg
Date:   Thu, 12 Dec 2019 16:23:25 +0000
Message-ID: <d0f592aa5b7a454fb412bea8844fe608@AcuMS.aculab.com>
References: <20191212130421.GX2827@hirez.programming.kicks-ass.net>
 <A1D491D5-0079-487C-A834-FB504EDD8782@amacapital.net>
In-Reply-To: <A1D491D5-0079-487C-A834-FB504EDD8782@amacapital.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: WVyEuAo8NiemHoq8iN0FNA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQW5keSBMdXRvbWlyc2tpDQo+IFNlbnQ6IDEyIERlY2VtYmVyIDIwMTkgMTY6MDINCi4u
Lg0KPiBNRkVOQ0UgYWxzbyBpbXBsaWVzIExGRU5DRSwgYW5kIExGRU5DRSBpcyBmYWlybHkgc2xv
dyBkZXNwaXRlIGhhdmluZyBubyBhcmNoaXRlY3R1cmFsIHNlbWFudGljcyBvdGhlciB0aGFuIGJs
b2NraW5nIHNwZWN1bGF0aXZlDQo+IGV4ZWN1dGlvbi4gQUZBSUNULCBpbiB0aGUgYWJzZW5jZSBv
ZiBzaWRlIGNoYW5uZWxzIHRpbWluZyBvZGRpdGllcywgdGhlcmUgaXMgbm8gY29kZSB3aGF0c29l
dmVyIHRoYXQgd291bGQgYmUgY29ycmVjdCB3aXRoIExGRU5DRQ0KPiBidXQgaW5jb3JyZWN0IHdp
dGhvdXQgaXQuIOKAnFNlcmlhbGl6YXRpb27igJ0gaXMsIHRvIHNvbWUgZXh0ZW50LCBhIHdlYWtl
ciBleGFtcGxlIG9mIHRoaXMg4oCUIE1PViB0byBDUjIgaXMgKm11Y2gqIHNsb3dlciB0aGFuIE1G
RU5DRSBvcg0KPiBMT0NLIGRlc3BpdGUgdGhlIGZhY3QgdGhhdCwgYXMgZmFyIGFzIHRoZSBtZW1v
cnkgbW9kZWwgaXMgY29uY2VybmVkLCBpdCBkb2VzbuKAmXQgZG8gYSB3aG9sZSBsb3QgbW9yZS4N
Cg0KSUlSQyBMRkVOQ0UgZG9lcyBhZmZlY3QgdGhpbmdzIHdoZW4geW91IGFyZSBtaXhpbmcgbm9u
LXRlbXBvcmFsIGFuZC9vciB3cml0ZS1jb21iaW5pbmcNCm1lbW9yeSBhY2Nlc3Nlcy4NCg0KSSBh
bHNvIHRob3VnaHQgdGhlcmUgd2FzIGEgY2FzZSB3aGVyZSB5b3UgbmVlZGVkIHRvIHN0b3AgdGhl
IHNwZWN1bGF0aXZlIHJlYWRzLg0KQnV0IGNhbid0IHJlbWVtYmVyIHdoeS4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

