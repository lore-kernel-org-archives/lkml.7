Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E619C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBC720644
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 09:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfIBJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 05:02:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20508 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbfIBJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 05:02:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-194-rYYILk2VO0WqBm185IgfAA-1; Mon, 02 Sep 2019 10:02:09 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Sep 2019 10:02:09 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Sep 2019 10:02:09 +0100
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
Thread-Index: AQHVX1Liqj9VEXOMQ0SdqQ13OMpYJacYF/rQ
Date:   Mon, 2 Sep 2019 09:02:08 +0000
Message-ID: <e3111f698ba342ca8893f65610990624@AcuMS.aculab.com>
References: <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <20190829173458.skttfjlulbiz5s25@treble>
 <CAHk-=wi-epJZfBHDbKKDZ64us7WkF=LpUfhvYBmZSteO8Q0RAg@mail.gmail.com>
 <CAK8P3a1K5HgfACmJXr4dTTwDJFz5BeSCCa3RQWYbXGE-2q4TJQ@mail.gmail.com>
 <CAHk-=whuUdqrh2=LLNfRiW6oadx0zzGVkvqyx_O1cGLa2U6Jjg@mail.gmail.com>
 <20190830150208.jyk7tfzznqimc6ow@treble>
 <CAHk-=wgqAcRU99Dp20+ZAux7Mdgbnw5deOguwOjdCJY0eNnSkA@mail.gmail.com>
 <20190830164927.a2czlphx4ho3rhhf@treble>
In-Reply-To: <20190830164927.a2czlphx4ho3rhhf@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: rYYILk2VO0WqBm185IgfAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMzAgQXVndXN0IDIwMTkgMTc6NDkNCj4gT24g
RnJpLCBBdWcgMzAsIDIwMTkgYXQgMDg6NDg6NDlBTSAtMDcwMCwgTGludXMgVG9ydmFsZHMgd3Jv
dGU6DQo+ID4gT24gRnJpLCBBdWcgMzAsIDIwMTkgYXQgODowMiBBTSBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4gPg0KPiA+ID4gRm9yIEtBU0FOLCB0aGUg
Q2xhbmcgdGhyZXNob2xkIGZvciBpbnNlcnRpbmcgbWVtc2V0KCkgaXMgKjIqIGNvbnNlY3V0aXZl
DQo+ID4gPiB3cml0ZXMgaW5zdGVhZCBvZiAxNy4gIElzbid0IHRoYXQgbGlrZWx5IHRvIGNhdXNl
IHRlYXJpbmctcmVsYXRlZA0KPiA+ID4gc3VycHJpc2VzPw0KPiA+DQo+ID4gVGVhcmluZyBpc24n
dCBsaWtlbHkgdG8gYmUgYSBwcm9ibGVtLg0KPiA+DQo+ID4gSXQncyBub3QgbGlrZSBtZW1jcHko
KSBkb2VzIGJ5dGUtYnktYnl0ZSBjb3BpZXMuIElmIHlvdSBwYXNzIGl0IGENCj4gPiB3b3JkLWFs
aWduZWQgcG9pbnRlciwgaXQgd2lsbCBkbyB3b3JkLWFsaWduZWQgYWNjZXNzZXMgc2ltcGx5IGZv
cg0KPiA+IHBlcmZvcm1hbmNlIHJlYXNvbnMuDQo+ID4NCj4gPiBFdmVuIG9uIHg4Niwgd2hlcmUg
d2UgdXNlICJyZXAgbW92c2IiLCB3ZSAoYSkgdGVuZCB0byBkaXNhYmxlIGl0IGZvcg0KPiA+IHNt
YWxsIGNvcGllcyBhbmQgKGIpIGl0IHR1cm5zIG91dCB0aGF0IG1pY3JvY29kZSB0aGF0IGRvZXMg
dGhlDQo+ID4gb3B0aW1pemVkIG1vdnNiICh3aGljaCBpcyB0aGUgb25seSBjYXNlIHdlIHVzZSBp
dCkgcHJvYmFibHkgZW5kcyB1cA0KPiA+IGRvaW5nIGF0b21pYyB0aGluZ3MgYW55d2F5LiBOb3Rl
IHRoZSAicHJvYmFibHkiLiBJIGRvbid0IGhhdmUNCj4gPiBtaWNyb2NvZGUgc291cmNlIGNvZGUs
IGJ1dCB0aGVyZSBhcmUgb3RoZXIgaW5kaWNhdGlvbnMgbGlrZSAid2Uga25vdw0KPiA+IGl0IGRv
ZXNuJ3QgdGFrZSBpbnRlcnJ1cHRzIG9uIGEgYnl0ZS1wZXItYnl0ZSBsZXZlbCwgb25seSBvbiB0
aGUNCj4gPiBjYWNoZWxpbmUgbGV2ZWwiLg0KPiANCj4gVGhlIG1pY3JvY29kZSBhcmd1bWVudCBp
cyBub3QgYWxsIHRoYXQgY29tZm9ydGluZyA6LSkNCj4gDQo+IEFsc28gd2hhdCBhYm91dCB1bmFs
aWduZWQgYWNjZXNzZXMsIGUuZy4gaWYgYSBzdHJ1Y3QgbWVtYmVyIGlzbid0IG9uIGENCj4gd29y
ZCBib3VuZGFyeT8gIEFybmQncyBnb2Rib2x0IGxpbmsgc2hvd2VkIHRob3NlIGNhbiBnZXQgY29t
YmluZWQgdG9vLg0KDQpJJ2QgZ3Vlc3MgdGhhdCBpdCBoYXMgdG8gJ2NvbXBsZXRlJyBhIHBhcnRp
YWwgY29weS4NCkFmdGVyIGFsbCB0aGVyZSBhcmUgbm8gbWlkLWluc3RydWN0aW9uIGludGVycnVw
dCBzdGF0ZXMgc28gdGhlIGludGVycnVwdA0KcmV0dXJucyB0byBhIG5ldyAncmVwIG1vdnNiJyBp
bnN0cnVjdGlvbiAodGhlIGlzciBjYW4gY2hhbmdlIHNpL2RpL2N4KS4NCkVpdGhlciB0aGUgc291
cmNlLCBvciBkZXN0aW5hdGlvbiBpcyBhbG1vc3QgY2VydGFpbmx5IGNhY2hlIGxpbmUgYWxpZ25l
ZC4NCg0KPiBJIGRvbid0IHNlZSB4ODYgbWVtY3B5KCkgZG9pbmcgYW55IGRlc3RpbmF0aW9uIGFs
aWdubWVudCBjaGVja3MuDQoNCkkgZG9uJ3QgdGhpbmsgYW55b25lIGhhcyB0cmllZCB0byBpbnN0
cnVtZW50IHdoZXRoZXIgaXQgaXMgYmV0dGVyIHRvDQpkbyBtaXNhbGlnbmVkIHJlYWRzIG9yIHdy
aXRlcyAoYW5kIGl0IHByb2JhYmx5IGRlcGVuZHMgb24gdGhlIGNwdSkuDQpUaGUgY29kZSB3aWxs
IHByb2JhYmx5IGJlIG1vcmUgY3JpdGljYWwgb24gdGhlIHJlYWRzLg0KVGhlIHJlYWwgZ2FpbiB3
aWxsIGJlIHdoZW4gdGhlIHNvdXJjZSBhbmQgZGVzdGluYXRpb24gaGF2ZSB0aGUgc2FtZQ0KbWlz
LWFsaWdubWVudC4NCg0KLi4uDQo+ID4gU28gaXQncyBwcm9iYWJseSBub3QgYW4gaXNzdWUgZnJv
bSBhIHRlYXJpbmcgc3RhbmRwb2ludCAtIGJ1dCBpdA0KPiA+IHdvcnJpZXMgbWUgYmVjYXVzZSBv
ZiAidGhpcyBoYXMgdG8gYmUgYSBsZWFmIGZ1bmN0aW9uIiBraW5kIG9mIGlzc3Vlcw0KPiA+IHdo
ZXJlIHdlIG1heSBiZSB1c2luZyBpbmRpdmlkdWFsIHN0b3JlcyBvbiBwdXJwb3NlLiBXZSBkbyBo
YXZlIHRoaW5ncw0KPiA+IGxpa2UgdGhhdC4NCj4gDQo+IEl0IHNvdW5kcyBsaWtlIGV2ZXJ5Ym9k
eSdzIGluIGFncmVlbWVudCB0aGF0IHJlcGxhY2luZyBhY2Nlc3NlcyB3aXRoDQo+IG1lbXNldC9t
ZW1jcHkgaXMgYmFkIGluIGEga2VybmVsIGNvbnRleHQuICBTaG91bGQgd2UgcHVzaCBmb3IgYSBu
ZXcNCj4gZmluZS1ncmFpbmVkIGNvbXBpbGVyIG9wdGlvbiB0byBkaXNhYmxlIGl0Pw0KDQpJJ20g
bm90IHN1cmUgaXQgaXMgYSBnb29kIGlkZWEgaW4gQU5ZIGNvbnRleHQuDQpJdCBzZWVtcyBsaWtl
IHNvbWV0aGluZyB0aGUgY29tcGlsZXIgcGVvcGxlIGhhcyBkaXNjb3ZlcmVkIHRoZXkgY2FuIGRv
DQp3aXRob3V0IGFjdHVhbGx5IGRlY2lkaW5nIHdoZXRoZXIgaXQgaXMgdXNlZnVsLg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K

