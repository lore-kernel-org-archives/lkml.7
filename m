Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EB0C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 740F420663
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 12:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbfLLMWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 07:22:05 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:56894 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729118AbfLLMWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 07:22:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-211-j2x193sjOcyT9q_RXUdAGA-1; Thu, 12 Dec 2019 12:22:02 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Dec 2019 12:22:01 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Dec 2019 12:22:01 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Borislav Petkov' <bp@alien8.de>,
        =?utf-8?B?VmFsZGlzIEtsxJN0bmlla3M=?= <valdis.kletnieks@vt.edu>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/microcode: make stub function static inline
Thread-Topic: [PATCH] x86/microcode: make stub function static inline
Thread-Index: AQHVsGtUZ1hUqIYymE206Nv4nSPAKqe2bGYg
Date:   Thu, 12 Dec 2019 12:22:01 +0000
Message-ID: <0ae7fa04e531439484087575bb7defdf@AcuMS.aculab.com>
References: <52170.1575603873@turing-police> <20191211213819.GG14821@zn.tnic>
In-Reply-To: <20191211213819.GG14821@zn.tnic>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: j2x193sjOcyT9q_RXUdAGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBCb3Jpc2xhdiBQZXRrb3YNCj4gU2VudDogMTEgRGVjZW1iZXIgMjAxOSAyMTozOA0KPiBP
biBUaHUsIERlYyAwNSwgMjAxOSBhdCAxMDo0NDozM1BNIC0wNTAwLCBWYWxkaXMgS2zEk3RuaWVr
cyB3cm90ZToNCj4gPiBXaGVuIGJ1aWxkaW5nIHdpdGggQz0xIFc9MSwgYm90aCBzcGFyc2UgYW5k
IGdjYyBjb21wbGFpbjoNCj4gPg0KPiA+ICAgQ0hFQ0sgICBhcmNoL3g4Ni9rZXJuZWwvY3B1L21p
Y3JvY29kZS9jb3JlLmMNCj4gPiAuL2FyY2gveDg2L2luY2x1ZGUvYXNtL21pY3JvY29kZV9hbWQu
aDo1Njo2OiB3YXJuaW5nOiBzeW1ib2wgJ3JlbG9hZF91Y29kZV9hbWQnIHdhcyBub3QgZGVjbGFy
ZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/DQo+ID4gICBDQyAgICAgIGFyY2gveDg2L2tlcm5lbC9j
cHUvbWljcm9jb2RlL2NvcmUubw0KPiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBhcmNoL3g4Ni9r
ZXJuZWwvY3B1L21pY3JvY29kZS9jb3JlLmM6MzY6DQo+ID4gLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9taWNyb2NvZGVfYW1kLmg6NTY6Njogd2FybmluZzogbm8gcHJldmlvdXMgcHJvdG90eXBlIGZv
ciAncmVsb2FkX3Vjb2RlX2FtZCcgWy1XbWlzc2luZy1wcm90b3R5cGVzDQo+ID4gXQ0KPiANCj4g
SG1tLCBJIGRvbid0IHNlZSB0aGlzIHdpdGggZ2NjIDkuMiBhbmQgc3BhcnNlIDAuNi4xIGhlcmUu
DQoNCklTVFIgaXQgaXMgZ2NjLXZlcnNpb24gZGVwZW5kYW50Lg0KDQoJRGF2aWQNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

