Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7FEC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3FC023427
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 16:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfH3QMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 12:12:08 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:53784 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbfH3QMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 12:12:08 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-8-vPgvCSCrNQKAFRHlhul29Q-1;
 Fri, 30 Aug 2019 17:12:05 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 30 Aug 2019 17:12:04 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 30 Aug 2019 17:12:04 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arnd Bergmann' <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: objtool warning "uses BP as a scratch register" with clang-9
Thread-Topic: objtool warning "uses BP as a scratch register" with clang-9
Thread-Index: AQHVX0vKqj9VEXOMQ0SdqQ13OMpYJacT3FgA
Date:   Fri, 30 Aug 2019 16:12:04 +0000
Message-ID: <7fb03b2951e04c5f9b2529a6b8d5c746@AcuMS.aculab.com>
References: <20190827192255.wbyn732llzckmqmq@treble>
 <CAK8P3a2DWh54eroBLXo+sPgJc95aAMRWdLB2n-pANss1RbLiBw@mail.gmail.com>
 <CAKwvOdnD1mEd-G9sWBtnzfe9oGTeZYws6zNJA7opS69DN08jPg@mail.gmail.com>
 <CAK8P3a0nJL+3hxR0U9kT_9Y4E86tofkOnVzNTEvAkhOFxOEA3Q@mail.gmail.com>
 <CAK8P3a0bY9QfamCveE3P4H+Nrs1e6CTqWVgiY+MCd9hJmgMQZg@mail.gmail.com>
 <20190828152226.r6pl64ij5kol6d4p@treble>
 <CAK8P3a2ATzqRSqVeeKNswLU74+bjvwK_GmG0=jbMymVaSp2ysw@mail.gmail.com>
 <CAK8P3a1CONyt0AwBr2wQXZNo5+jpwAT8T3WfXe73=j799Jnv6A@mail.gmail.com>
 <20190829232439.w3whzmci2vqtq53s@treble>
 <CAK8P3a0ddxbGVj974XS+PM_mSJDu=aGfTGarjmqMCuLKn81mRg@mail.gmail.com>
 <20190830151422.o4pbvjyravrz2wre@treble>
 <CAK8P3a33LQAzsReSUyB_aZxkws28RP=oJocQXonYbxxBky7aaQ@mail.gmail.com>
In-Reply-To: <CAK8P3a33LQAzsReSUyB_aZxkws28RP=oJocQXonYbxxBky7aaQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vPgvCSCrNQKAFRHlhul29Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogQXJuZCBCZXJnbWFubg0KPiBTZW50OiAzMCBBdWd1c3QgMjAxOSAxNjo1OQ0KLi4uDQo+
ID4gT3IgZXZlbiBiZXR0ZXIsIGl0IHdvdWxkIGJlIGdyZWF0IGlmIHdlIGNvdWxkIGdldCBDbGFu
ZyB0byBjaGFuZ2UgdGhlaXINCj4gPiBtZW1zZXQoKSBpbnNlcnRpb24gaGV1cmlzdGljcywgc28g
dGhhdCBLQVNBTiBhY3RzIG1vcmUgbGlrZSBub24tS0FTQU4NCj4gPiBjb2RlIGluIHRoYXQgcmVn
YXJkLg0KPiANCj4gSSBzdXNwZWN0IHRoYXQncyBnb2luZyB0byBiZSBoYXJkZXIuIFRoZSBjbGFu
Zy05IHJlbGVhc2UgaXMgZ29pbmcgdG8gYmUNCj4gc29vbiwgYW5kIHRoYXQgY2hhbmdlIHByb2Jh
Ymx5IHdvdWxkbid0IGJlIGNvbnNpZGVyZWQgYSByZWdyZXNzaW9uIGZpeC4NCj4gDQo+IE1heWJl
IE5pY2sgY2FuIGZpbmQgd2hhdCBoYXBwZW5zLCBidXQgSSBkb24ndCBhY3R1YWxseSBzZWUgYW55
IHJlZmVyZW5jZQ0KPiB0byBLQVNBTiBpbiB0aGUgbGx2bSBzb3VyY2UgY29kZSByZWxhdGVkIHRv
IHRoZSBtZW1zZXQgZ2VuZXJhdGlvbi4NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtLW1p
cnJvci9jbGFuZy9ibG9iL21hc3Rlci9saWIvQ29kZUdlbi9DR0V4cHJBZ2cuY3BwI0wxODAzDQo+
IGhhcyBhIGNoZWNrIGZvciA+MTYgYnl0ZXMsIGJ1dCB0aGF0IGFnYWluIGRvZXMgbm90IG1hdGNo
IG15IG9ic2VydmF0aW9uLg0KDQpUaGF0IGxvb2tzIGxpa2UgdGhlIGNvZGUgZm9yIGluaXRpYWxp
c2luZyBhIGxvY2FsIHN0cnVjdHVyZSB2YXJpYWJsZSwNCm5vdCBmb3IgbWVyZ2luZyAncmFuZG9t
JyB3cml0ZXMgaW50byBhIG1lbXNldCgpLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

