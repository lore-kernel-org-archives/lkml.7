Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A223C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5443E22CE9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728333AbfH3Pzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:55:50 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22743 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727926AbfH3Pzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:55:50 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-162-f_2tIRpBNluQeo7ZqbvEUQ-1; Fri, 30 Aug 2019 16:55:48 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 16:55:47 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 16:55:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: RE: objtool warning "uses BP as a scratch register" with clang-9
Thread-Topic: objtool warning "uses BP as a scratch register" with clang-9
Thread-Index: AQHVX0pqqj9VEXOMQ0SdqQ13OMpYJacT10cw
Date:   Fri, 30 Aug 2019 15:55:47 +0000
Message-ID: <d1af87f139b54346b420d06855297cfa@AcuMS.aculab.com>
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
 <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
In-Reply-To: <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: f_2tIRpBNluQeo7ZqbvEUQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgQXVndXN0IDIwMTkgMTY6NDkNCj4gT24g
RnJpLCBBdWcgMzAsIDIwMTkgYXQgODowMiBBTSBKb3NoIFBvaW1ib2V1ZiA8anBvaW1ib2VAcmVk
aGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGb3IgS0FTQU4sIHRoZSBDbGFuZyB0aHJlc2hvbGQg
Zm9yIGluc2VydGluZyBtZW1zZXQoKSBpcyAqMiogY29uc2VjdXRpdmUNCj4gPiB3cml0ZXMgaW5z
dGVhZCBvZiAxNy4gIElzbid0IHRoYXQgbGlrZWx5IHRvIGNhdXNlIHRlYXJpbmctcmVsYXRlZA0K
PiA+IHN1cnByaXNlcz8NCj4gDQo+IFRlYXJpbmcgaXNuJ3QgbGlrZWx5IHRvIGJlIGEgcHJvYmxl
bS4NCj4gDQo+IEl0J3Mgbm90IGxpa2UgbWVtY3B5KCkgZG9lcyBieXRlLWJ5LWJ5dGUgY29waWVz
LiBJZiB5b3UgcGFzcyBpdCBhDQo+IHdvcmQtYWxpZ25lZCBwb2ludGVyLCBpdCB3aWxsIGRvIHdv
cmQtYWxpZ25lZCBhY2Nlc3NlcyBzaW1wbHkgZm9yDQo+IHBlcmZvcm1hbmNlIHJlYXNvbnMuDQo+
IA0KPiBFdmVuIG9uIHg4Niwgd2hlcmUgd2UgdXNlICJyZXAgbW92c2IiLCB3ZSAoYSkgdGVuZCB0
byBkaXNhYmxlIGl0IGZvcg0KPiBzbWFsbCBjb3BpZXMgYW5kIChiKSBpdCB0dXJucyBvdXQgdGhh
dCBtaWNyb2NvZGUgdGhhdCBkb2VzIHRoZQ0KPiBvcHRpbWl6ZWQgbW92c2IgKHdoaWNoIGlzIHRo
ZSBvbmx5IGNhc2Ugd2UgdXNlIGl0KSBwcm9iYWJseSBlbmRzIHVwDQo+IGRvaW5nIGF0b21pYyB0
aGluZ3MgYW55d2F5LiBOb3RlIHRoZSAicHJvYmFibHkiLiBJIGRvbid0IGhhdmUNCj4gbWljcm9j
b2RlIHNvdXJjZSBjb2RlLCBidXQgdGhlcmUgYXJlIG90aGVyIGluZGljYXRpb25zIGxpa2UgIndl
IGtub3cNCj4gaXQgZG9lc24ndCB0YWtlIGludGVycnVwdHMgb24gYSBieXRlLXBlci1ieXRlIGxl
dmVsLCBvbmx5IG9uIHRoZQ0KPiBjYWNoZWxpbmUgbGV2ZWwiLg0KPiANCj4gU28gaXQncyBwcm9i
YWJseSBub3QgYW4gaXNzdWUgZnJvbSBhIHRlYXJpbmcgc3RhbmRwb2ludCAtIGJ1dCBpdA0KPiB3
b3JyaWVzIG1lIGJlY2F1c2Ugb2YgInRoaXMgaGFzIHRvIGJlIGEgbGVhZiBmdW5jdGlvbiIga2lu
ZCBvZiBpc3N1ZXMNCj4gd2hlcmUgd2UgbWF5IGJlIHVzaW5nIGluZGl2aWR1YWwgc3RvcmVzIG9u
IHB1cnBvc2UuIFdlIGRvIGhhdmUgdGhpbmdzDQo+IGxpa2UgdGhhdC4NCg0KRXZlbiBpbiB1c2Vy
c3BhY2UgeW91IG1pZ2h0IGJlIGFjY2Vzc2luZyBtbWFwKCllZCBQQ0llIGRldmljZSBtZW1vcnku
DQpUaGUgbGFzdCB0aGluZyB5b3Ugd2FudCBpcyB0aGUgY29tcGlsZXIgY29udmVydGluZyBhbnl0
aGluZyBpbnRvDQoncmVwIG1vdnNiJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

