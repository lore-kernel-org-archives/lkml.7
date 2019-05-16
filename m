Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA931C04AB4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39C420862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 09:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfEPJIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 05:08:19 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:36430 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726336AbfEPJIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 05:08:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-118-hKkcUSsiNiK25XXdRTeazA-1; Thu, 16 May 2019 10:08:16 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 16 May 2019 10:08:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 16 May 2019 10:08:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [GIT PULL] tracing: Updates for 5.2
Thread-Topic: [GIT PULL] tracing: Updates for 5.2
Thread-Index: AQHVC3ZtXgJGNgyaZk6kEqffd6pbOqZtdmCA
Date:   Thu, 16 May 2019 09:08:15 +0000
Message-ID: <3d476a88ffc6486099dd29acdd242436@AcuMS.aculab.com>
References: <20190515133614.31dcbbe0@oasis.local.home>
 <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
In-Reply-To: <CAHk-=wihYB8w__YQjgYjYZsVniu5CtkTcFycmCGdqVg8GUje7g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: hKkcUSsiNiK25XXdRTeazA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGNvZGU6DQo+IA0KPiAgICAgICAgICAgICAgICAgLyogcmVzZXQgYWxsIGJ1dCB0ciwg
dHJhY2UsIGFuZCBvdmVycnVucyAqLw0KPiAgICAgICAgICAgICAgICAgbWVtc2V0KCZpdGVyLnNl
cSwgMCwNCj4gICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHRyYWNlX2l0ZXJh
dG9yKSAtDQo+ICAgICAgICAgICAgICAgICAgICAgICAgb2Zmc2V0b2Yoc3RydWN0IHRyYWNlX2l0
ZXJhdG9yLCBzZXEpKTsNCj4gDQo+IG5vdCBvbmx5IGhhcyBhIGNvbXBsZXRlbHkgbWlzbGVhZGlu
ZyBjb21tZW50IChpdCByZXNldHMgYSBsb3QgbW9yZQ0KPiB0aGFuIHRoZSBjb21tZW50IHN0YXRl
cyksIGJ1dCBtb2Rlcm4gZ2NjIGxvb2tzIGF0IHRoYXQgY29kZSBhbmQgc2F5cw0KPiAib2gsIHlv
dSdyZSBwYXNzaW5nIGl0IGEgcG9pbnRlciB0byAnaXRlci5zZXEnLCBidXQgdGhlbiBjbGVhcmlu
ZyBhDQo+IGxvdCBtb3JlIHRoYW4gYSAndHJhY2Vfc2VxJyI6DQo+IA0KPiAgIEluIGZ1bmN0aW9u
IOKAmG1lbXNldOKAmSwNCj4gICAgICAgaW5saW5lZCBmcm9tIOKAmGZ0cmFjZV9kdW1w4oCZIGF0
IGtlcm5lbC90cmFjZS90cmFjZS5jOjg5MTQ6MzoNCj4gIC9pbmNsdWRlL2xpbnV4L3N0cmluZy5o
OjM0NDo5OiB3YXJuaW5nOiDigJhfX2J1aWx0aW5fbWVtc2V04oCZIG9mZnNldA0KPiBbODUwNSwg
ODU2MF0gZnJvbSB0aGUgb2JqZWN0IGF0IOKAmGl0ZXLigJkgaXMgb3V0IG9mIHRoZSBib3VuZHMg
b2YNCj4gcmVmZXJlbmNlZCBzdWJvYmplY3Qg4oCYc2Vx4oCZIHdpdGggdHlwZSDigJhzdHJ1Y3Qg
dHJhY2Vfc2Vx4oCZIGF0IG9mZnNldCA0MzY4DQo+IFstV2FycmF5LWJvdW5kc10NCj4gICAgIDM0
NCB8ICByZXR1cm4gX19idWlsdGluX21lbXNldChwLCBjLCBzaXplKTsNCj4gICAgICAgICB8ICAg
ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gSXQncyBhIHNvbWV3aGF0
IGFubm95aW5nIHdhcm5pbmcgYmVjYXVzZSB0aGUgY29kZSBpdHNlbGYgaXMNCj4gdGVjaG5pY2Fs
bHkgY29ycmVjdCwgYnV0IGF0IHRoZSBzYW1lIHRpbWUsIEkgdGhpbmsgdGhlIGdjYyB3YXJuaW5n
IGlzDQo+IHJlYXNvbmFibGUuIFlvdSAqYXJlKiBwYXNzaW5nIGl0IGEgJ3N0cnVjdCB0cmFjZV9z
ZXEnIHBvaW50ZXIsIGFuZA0KPiB0aGVuIHlvdSdyZSBjbGVhcmluZyBhIHdob2xlIGxvdCBtb3Jl
IHRoYW4gdGhhdC4NCj4gDQo+IE9uZSBvcHRpb24gaXMgdG8ganVzdCByZXdyaXRlIGl0IHNvbWV0
aGluZyBsaWtlDQo+IA0KPiAgICAgICAgIGNvbnN0IHVuc2lnbmVkIGludCBvZmZzZXQgPSBvZmZz
ZXRvZihzdHJ1Y3QgdHJhY2VfaXRlcmF0b3IsIHNlcSk7DQo+ICAgICAgICAgbWVtc2V0KG9mZnNl
dCsodm9pZCAqKSZpdGVyLCAwLCBzaXplb2YoaXRlcikgLSBvZmZzZXQpOw0KDQpJJ2QgZG8gKGNv
bnN0IGNoYXIgKikmaXRlciArIG9mZnNldCAuLi4NCg0KQSBxdWljayBmaXggaXMgKHByb2JhYmx5
KSBqdXN0Og0KCW1lbXNldCgodm9pZCAqKShsb25nKSZpdGVyLnNlcSwgLi4uDQoNCglEYXZpZA0K
DQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFy
bSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAo
V2FsZXMpDQo=

