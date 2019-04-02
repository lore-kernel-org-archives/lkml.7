Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647D3C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E09206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbfDBLoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:44:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:23742 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726716AbfDBLoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:44:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-57-JBKtKZidP6OeCylcTurrsg-1; Tue, 02 Apr 2019 12:44:15 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue,
 2 Apr 2019 12:45:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 2 Apr 2019 12:45:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexander Potapenko' <glider@google.com>,
        "paulmck@linux.ibm.com" <paulmck@linux.ibm.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "jyknight@google.com" <jyknight@google.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: RE: [PATCH v2] x86/asm: fix assembly constraints in bitops
Thread-Topic: [PATCH v2] x86/asm: fix assembly constraints in bitops
Thread-Index: AQHU6UdY5ims1sqDDECRt8+l+UbnY6YovS9A
Date:   Tue, 2 Apr 2019 11:45:20 +0000
Message-ID: <4c6a1e592fd345618ef7b7d5bee592da@AcuMS.aculab.com>
References: <20190402112813.193378-1-glider@google.com>
In-Reply-To: <20190402112813.193378-1-glider@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: JBKtKZidP6OeCylcTurrsg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQWxleGFuZGVyIFBvdGFwZW5rbw0KPiBTZW50OiAwMiBBcHJpbCAyMDE5IDEyOjI4DQo+
IA0KPiAxLiBVc2UgbWVtb3J5IGNsb2JiZXIgaW4gYml0b3BzIHRoYXQgdG91Y2ggYXJiaXRyYXJ5
IG1lbW9yeQ0KPiANCj4gQ2VydGFpbiBiaXQgb3BlcmF0aW9ucyB0aGF0IHJlYWQvd3JpdGUgYml0
cyB0YWtlIGEgYmFzZSBwb2ludGVyIGFuZCBhbg0KPiBhcmJpdHJhcmlseSBsYXJnZSBvZmZzZXQg
dG8gYWRkcmVzcyB0aGUgYml0IHJlbGF0aXZlIHRvIHRoYXQgYmFzZS4NCg0KQWx0aG91Z2ggeDg2
XzY0IGNhbiB1c2UgYSBzaWduZWQgNjRiaXQgYml0IG51bWJlciwgbG9va2luZyBhdCBhcm0gYW5k
IGFybTY0DQp0aGV5IHVzZSAnaW50IG5yJyB0aHJvdWdob3V0IGFzIGRvIHRoZSBnZW5lcmljIGZ1
bmN0aW9ucy4NCk1heWJlIHg4NiBvdWdodCB0byBiZSBjb25zaXN0ZW50IGhlcmUuDQpJIGRvdWJ0
IG5lZ2F0aXZlIGJpdCBudW1iZXJzIGFyZSBleHBlY3RlZCB0byB3b3JrPw0KDQpEaWQgeW91IHRy
eSB0ZWxsaW5nIGdjYyB0aGF0IGEgYmlnIGJ1ZmZlciAoMjUwTUIgaXMgdGhlIGxpbWl0IGZvciAz
MmJpdCkNCmZyb20gdGhlIHBvaW50ZXIgbWlnaHQgYmUgY2hhbmdlZD8NClRoYXQgb3VnaHQgdG8g
YmUgc29mdGVyIHRoYW4gYSBmdWxsICdtZW1vcnknIGNsb2JiZXIgYXMgaXQgc2hvdWxkDQpvbmx5
IGFmZmVjdCBtZW1vcnkgdGhhdCBjb3VsZCBiZSBhY2Nlc3NlZCB0aHJvdWdoIHRoZSBwb2ludGVy
Lg0KDQouLi4uDQo+IC0jZGVmaW5lIEJJVE9QX0FERFIoeCkgIittIiAoKih2b2xhdGlsZSBsb25n
ICopICh4KSkNCj4gKyNkZWZpbmUgUkxPTkdfQUREUih4KSAibSIgKCoodm9sYXRpbGUgbG9uZyAq
KSAoeCkpDQo+ICsjZGVmaW5lIFdCWVRFX0FERFIoeCkgIittIiAoKih2b2xhdGlsZSBjaGFyICop
ICh4KSkNCj4gDQo+IC0jZGVmaW5lIEFERFIJCQkJQklUT1BfQUREUihhZGRyKQ0KPiArI2RlZmlu
ZSBBRERSCQkJCVJMT05HX0FERFIoYWRkcikNCg0KSXMgaXQgd29ydGgganVzdCBraWxsaW5nIEFE
RFIgPw0KKGFzIGEgZGlmZmVyZW50IHBhdGNoKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBB
ZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMs
IE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

