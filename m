Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48045C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ACB523407
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3Pjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:39:37 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58670 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727434AbfH3Pjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:39:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-142-RaVDy-0kN-m9dL8Z73xTag-1; Fri, 30 Aug 2019 16:39:32 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 16:39:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 16:39:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: RE: objtool warning "uses BP as a scratch register" with clang-9
Thread-Topic: objtool warning "uses BP as a scratch register" with clang-9
Thread-Index: AQHVX0Ptqj9VEXOMQ0SdqQ13OMpYJacT0mzQ
Date:   Fri, 30 Aug 2019 15:39:31 +0000
Message-ID: <71c29f9ae371444f8b8e42bdf364a470@AcuMS.aculab.com>
References: <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
 <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
 <20190830150208.jyk7tfzznqimc6ow@treble>
In-Reply-To: <20190830150208.jyk7tfzznqimc6ow@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: RaVDy-0kN-m9dL8Z73xTag-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMzAgQXVndXN0IDIwMTkgMTY6MDINCj4gT24g
VGh1LCBBdWcgMjksIDIwMTkgYXQgMDM6MjY6MzBQTSAtMDcwMCwgTGludXMgVG9ydmFsZHMgd3Jv
dGU6DQo+ID4gT24gVGh1LCBBdWcgMjksIDIwMTkgYXQgMToyMiBQTSBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPiB3cm90ZToNCj4gPiA+DQo+ID4gPiBNYXliZSB3ZSBjYW4ganVzdCBwYXNz
IC1mbm8tYnVpbHRpbi1tZW1jcHkgLWZuby1idWlsdGluLW1lbXNldA0KPiA+ID4gZm9yIGNsYW5n
IHdoZW4gQ09ORklHX0tBU0FOIGlzIHNldCBhbmQgaG9wZSBmb3IgdGhlIGJlc3Q/DQo+ID4NCj4g
PiBJIHJlYWxseSBoYXRlIGhvdyB0aGF0IGRpc2FibGVzIGNvbnZlcnNpb25zIGJvdGggd2F5cywg
d2hpY2ggaXMga2luZA0KPiA+IG9mIHBvaW50bGVzcyBhbmQgd3JvbmcuICBJdCdzIHJlYWxseSBq
dXN0ICJ3ZSBkb24ndCB3YW50IHN1cnByaXNpbmcNCj4gPiBtZW1jcHkgY2FsbHMgZm9yIHNpbmds
ZSB3cml0ZXMiLg0KPiA+DQo+ID4gRGlzYWJsaW5nIGFsbCB0aGUgKmdvb2QqICJvcHRpbWl6ZSBt
ZW1zZXQvbWVtY3B5IiBjYXNlcyBpcyByZWFsbHkgc2FkLg0KPiA+DQo+ID4gV2UgYWN0dWFsbHkg
aGF2ZSBhIGxvdCBvZiBzbWFsbCBzdHJ1Y3R1cmVzIGluIHRoZSBrZXJuZWwgb24gcHVycG9zZQ0K
PiA+IChvZnRlbiBmb3IgdHlwZSBzYWZldHkpLCBhbmQgSSBiZXQgd2UgdXNlIG1lbWNweSBvbiB0
aGVtIG9uIHB1cnBvc2UgYXQNCj4gPiB0aW1lcy4gSSdkIGhhdGUgdG8gc2VlIHRoYXQgYmVjb21l
IGEgZnVuY3Rpb24gY2FsbCByYXRoZXIgdGhhbiAiY29weQ0KPiA+IHR3byB3b3JkcyBieSBoYW5k
Ii4NCj4gPg0KPiA+IEV2ZW4gZm9yIEtBU0FOLg0KPiA+DQo+ID4gQW5kIEkgZ3Vlc3MgdGhhdCB3
aGVuIHRoZSBjb21waWxlciBzZWVzIDIwKyAic2V0IHRvIHplcm8iIGl0J3MgcXVpdGUNCj4gPiBy
ZWFzb25hYmxlIHRvIHNheSAianVzdCB0dXJuIGl0IGludG8gYSBtZW1zZXQiLg0KPiANCj4gRm9y
IEtBU0FOLCB0aGUgQ2xhbmcgdGhyZXNob2xkIGZvciBpbnNlcnRpbmcgbWVtc2V0KCkgaXMgKjIq
IGNvbnNlY3V0aXZlDQo+IHdyaXRlcyBpbnN0ZWFkIG9mIDE3LiAgSXNuJ3QgdGhhdCBsaWtlbHkg
dG8gY2F1c2UgdGVhcmluZy1yZWxhdGVkDQo+IHN1cnByaXNlcz8NCg0KSG1tbS4uLiBJIGRvbid0
IHRoaW5rIEknZCBldmVyIHdhbnQgYSBjb21waWxlciB0byBjb252ZXJ0IGEgc2VxdWVuY2UNCm9m
IHplcm8gd3JpdGVzIGludG8gYSBtZW1zZXQuDQoNCkl0IGlzIGFzIGJhZCBhcyBhIGNlcnRhaW4g
Y29tcGlsZXIgY29udmVydGluZzoNCglmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQ0KCQl0Z3RbaV0g
PSBzcmNbaV07DQppbnRvIGEgJ3JlcCBtb3ZzJyBpbnN0cnVjdGlvbi4NCklubGluaW5nIG1lbWNw
eSgpIGFzICdyZXAgbW92cycgaXMgb25lIHRoaW5nLCB0aGUgb3Bwb3NpdGUgaXMgd3JvbmcuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

