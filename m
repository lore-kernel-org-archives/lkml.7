Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B3C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4906D20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfJJPqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:46:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:21004 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726453AbfJJPqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:46:20 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-13-oDfPCZz3PYyTN3ZJuZIDKw-1; Thu, 10 Oct 2019 16:46:16 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 10 Oct 2019 16:46:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 10 Oct 2019 16:46:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'dsterba@suse.cz'" <dsterba@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Joe Perches <joe@perches.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Markus Elfring <Markus.Elfring@web.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: RE: [PATCH] string.h: Mark 34 functions with __must_check
Thread-Topic: [PATCH] string.h: Mark 34 functions with __must_check
Thread-Index: AQHVf3bZWoZwBrQ0EEKCNRVPCPIi9qdUA/tQ
Date:   Thu, 10 Oct 2019 15:46:15 +0000
Message-ID: <3b133d6f8742472e8a99a76fb0bd3b11@AcuMS.aculab.com>
References: <75f70e5e-9ece-d6d1-a2c5-2f3ad79b9ccb@web.de>
 <20191009110943.7ff3a08a@gandalf.local.home>
 <CAKwvOdk3OTaAVmbV9Cu+Dzg8zuojjU6ENZfu4cUPaKS2a58d3w@mail.gmail.com>
 <4d890cae9cbbd873096cb1fadb477cf4632ddb9a.camel@perches.com>
 <CAKwvOdntBXd3OPiCV5adcDjXor886-XnsSxcStAjYBJpuEBrqQ@mail.gmail.com>
 <20191010142733.GT2751@twin.jikos.cz>
In-Reply-To: <20191010142733.GT2751@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: oDfPCZz3PYyTN3ZJuZIDKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRGF2aWQgU3RlcmJhDQo+IFNlbnQ6IDEwIE9jdG9iZXIgMjAxOSAxNToyOA0KLi4uDQo+
ID4gQ2FuIHdlIHBpY2sgYSBzdHlsZSBhbmQgZW5mb3JjZSBpdCB2aWEgY2hlY2twYXRjaD8gKEl0
J3MgcHJvYmFibHkgbm90DQo+ID4gZnVuIHRvIGNoZWNrIGZvciBlYWNoIGZ1bmN0aW9uIGF0dHJp
YnV0ZSBpbg0KPiA+IGluY2x1ZGUvbGludXgvY29tcGlsZXJfYXR0cmlidXRlcy5oKS4NCj4gDQo+
IEFueXRoaW5nIHRoYXQgaGFzIHRoZSByZXR1cm4gdHlwZSwgYXR0cmlidXRlcyBhbmQgZnVuY3Rp
b24gbmFtZSBvbiBvbmUNCj4gbGluZSB3b3JrcyBmb3IgbWUsIGJ1dCBJIGtub3cgdGhhdCB0aGVy
ZSBhcmUgb3RoZXIgc3R5bGUgcHJlZmVyZW5jZXMNCj4gdGhhdCBwdXQgZnVuY3Rpb24gbmFtZSBh
cyB0aGUgZmlyc3Qgd29yZCBvbiBhIHNlcGFyYXRlIGxpbmUuDQoNCkhhdmluZyB0aGUgZnVuY3Rp
b24gbmFtZSBmaXJzdCBtYWtlcyBpdCBtdWNoIGVhc2llciB0byBmaW5kIHRoZSBmdW5jdGlvbiBp
dHNlbGYuDQpJbiB0aGUgbGludXgga2VybmVsIHRyZWUgc2VhcmNoaW5nIGZvciAnRVhQT1JULipm
dW5jdGlvbl9uYW1lJyB3b3JrcyBtb3N0IGYgdGhlIHRpbWUuDQoNCj4gTXkgcmVhc29ucyBhcmUg
Zm9yIGJldHRlciBzZWFyY2ggcmVzdWx0cywgaWUuDQo+IA0KPiAgIGV4dGVudF9tYXAuYzp2b2lk
IF9fY29sZCBleHRlbnRfbWFwX2V4aXQodm9pZCkNCj4gICBleHRlbnRfbWFwLmg6dm9pZCBfX2Nv
bGQgZXh0ZW50X21hcF9leGl0KHZvaWQpOw0KPiAgIGZpbGUuYzp2b2lkIF9fY29sZCBidHJmc19h
dXRvX2RlZnJhZ19leGl0KHZvaWQpDQo+ICAgaW5vZGUuYzp2b2lkIF9fY29sZCBidHJmc19kZXN0
cm95X2NhY2hlcCh2b2lkKQ0KPiAgIG9yZGVyZWQtZGF0YS5jOnZvaWQgX19jb2xkIG9yZGVyZWRf
ZGF0YV9leGl0KHZvaWQpDQo+ICAgb3JkZXJlZC1kYXRhLmg6dm9pZCBfX2NvbGQgb3JkZXJlZF9k
YXRhX2V4aXQodm9pZCk7DQo+IA0KPiBpcyBiZXR0ZXIgdGhhbg0KPiANCj4gICBzZW5kLmM6X19j
b2xkDQo+ICAgc3VwZXIuYzpfX2NvbGQNCj4gICBzdXBlci5jOl9fY29sZA0KPiAgIHN1cGVyLmM6
X19jb2xkDQo+IA0KPiB3aGljaCBJIG1pZ2h0IGdldCB0byBmaXggZXZlbnR1YWxseS4NCg0KVGhh
dCBpcyB3aGF0IC1BMSBpbiBmb3IgOi0pDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

