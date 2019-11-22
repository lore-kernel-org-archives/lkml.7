Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A059C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF0620708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 09:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfKVJq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 04:46:26 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48687 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727016AbfKVJqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 04:46:24 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-168-zOi8G6s8PYCcEIlNqSrD_g-1; Fri, 22 Nov 2019 09:46:18 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 22 Nov 2019 09:46:16 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 22 Nov 2019 09:46:16 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Lutomirski' <luto@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: RE: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Topic: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by
 kernel parameter
Thread-Index: AQHVoI7WvnywFDJ0u0KDgd00OvHm6qeV5GjQgAAC9YCAAQghMA==
Date:   Fri, 22 Nov 2019 09:46:16 +0000
Message-ID: <397239502dad4bc3819c49c7d569c70c@AcuMS.aculab.com>
References: <1574297603-198156-1-git-send-email-fenghua.yu@intel.com>
 <1574297603-198156-7-git-send-email-fenghua.yu@intel.com>
 <20191121060444.GA55272@gmail.com>
 <20191121130153.GS4097@hirez.programming.kicks-ass.net>
 <20191121171214.GD12042@gmail.com>
 <3481175cbe14457a947f934343946d52@AcuMS.aculab.com>
 <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
In-Reply-To: <CALCETrW+qxrE633qetS4c1Rn2AX_hk5OgneZRtoZPFN1J395Ng@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: zOi8G6s8PYCcEIlNqSrD_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbSBBbmR5IEx1dG9taXJza2kNCj4gU2VudDogMjEgTm92ZW1iZXIgMjAxOSAxNzo1MQ0KPiBP
biBUaHUsIE5vdiAyMSwgMjAxOSBhdCA5OjQzIEFNIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRnJvbTogSW5nbyBNb2xuYXINCj4gPiA+IFNl
bnQ6IDIxIE5vdmVtYmVyIDIwMTkgMTc6MTINCj4gPiA+ICogUGV0ZXIgWmlqbHN0cmEgPHBldGVy
ekBpbmZyYWRlYWQub3JnPiB3cm90ZToNCj4gPiAuLi4NCj4gPiA+ID4gVGhpcyBmZWF0dXJlIE1V
U1QgYmUgZGVmYXVsdCBlbmFibGVkLCBvdGhlcndpc2UgZXZlcnl0aGluZyB3aWxsDQo+ID4gPiA+
IGJlL3JlbWFpbiBicm9rZW4gYW5kIHdlJ2xsIGVuZCB1cCBpbiB0aGUgc2l0dWF0aW9uIHdoZXJl
IHlvdSBjYW4ndCB1c2UNCj4gPiA+ID4gaXQgZXZlbiBpZiB5b3Ugd2FudGVkIHRvLg0KPiA+ID4N
Cj4gPiA+IEFncmVlZC4NCj4gPg0KPiA+IEJlZm9yZSBpdCBjYW4gYmUgZW5hYmxlZCBieSBkZWZh
dWx0IHNvbWVvbmUgbmVlZHMgdG8gZ28gdGhyb3VnaCB0aGUNCj4gPiBrZXJuZWwgYW5kIGZpeCBh
bGwgdGhlIGNvZGUgdGhhdCBhYnVzZXMgdGhlICdiaXQnIGZ1bmN0aW9ucyBieSB1c2luZyB0aGVt
DQo+ID4gb24gaW50W10gaW5zdGVhZCBvZiBsb25nW10uDQo+ID4NCj4gPiBJJ3ZlIG9ubHkgc2Vl
biBvbmUgZml4IGdvIHRocm91Z2ggZm9yIG9uZSB1c2UgY2FzZSBvZiBvbmUgcGllY2Ugb2YgY29k
ZQ0KPiA+IHRoYXQgcmVwZWF0ZWRseSB1c2VzIHBvdGVudGlhbGx5IG1pc2FsaWduZWQgaW50W10g
YXJyYXlzIGZvciBiaXRtYXNrcy4NCj4gPg0KPiANCj4gQ2FuIHdlIHJlYWxseSBub3QganVzdCBj
aGFuZ2UgdGhlIGxvY2sgYXNtIHRvIHVzZSAzMi1iaXQgYWNjZXNzZXMgZm9yDQo+IHNldF9iaXQo
KSwgZXRjPyAgU3VyZSwgaXQgd2lsbCBmYWlsIGlmIHRoZSBiaXQgaW5kZXggaXMgZ3JlYXRlciB0
aGFuDQo+IDJeMzIsIGJ1dCB0aGF0IHNlZW1zIG51dHMuDQoNCkZvciBsaXR0bGUgZW5kaWFuIDY0
Yml0IGNwdSBpdCBpcyBzYWZlKGlzaCkgdG8gY2FzdCBpbnQgW10gdG8gbG9uZyBbXSBmb3IgdGhl
IGJpdG9wcy4NCk9uIEJFIDY0Yml0IGNwdSBhbGwgaGVsbCBicmVha3MgbG9vc2UgaWYgeW91IGRv
IHRoYXQuDQpJdCByZWFsbHkgd2Fzbid0IG9idmlvdXMgdGhhdCBhbGwgdGhlIGNhc3RzIEkgZm91
bmQgd2VyZSBhbnl3aGVyZSBuZWFyIHJpZ2h0DQpvbiA2NGJpdCBCRSBzeXN0ZW1zLg0KDQpTbyB3
aGlsZSBpdCBpcyBhbG1vc3QgY2VydGFpbmx5IHNhZmUgdG8gY2hhbmdlIHRoZSB4ODYtNjQgYml0
b3BzIHRvIHVzZQ0KMzIgYml0IGFjY2Vzc2VzLCBzb21lIG9mIHRoZSBjb2RlIGlzIGhvcnJpYmx5
IGJyb2tlbi4NCg0KPiAoV2h5IHRoZSAqaGVsbCogZG8gdGhlIGJpdG9wcyB1c2UgbG9uZyBhbnl3
YXk/ICBUaGV5J3JlICpiaXQgbWFza3MqDQo+IGZvciBjcnlpbmcgb3V0IGxvdWQuICBBcyBpbiwg
dXNlcnMgZ2VuZXJhbGx5IHdhbnQgdG8gb3BlcmF0ZSBvbiBmaXhlZA0KPiBudW1iZXJzIG9mIGJp
dHMuKQ0KDQpUaGUgYml0b3BzIGZ1bmN0aW9ucyB3ZXJlIChwcm9iYWJseSkgd3JpdHRlbiBmb3Ig
bGFyZ2UgYml0bWFwcyB0aGF0DQphcmUgYmlnZ2VyIHRoYW4gdGhlIHNpemUgb2YgYSAnd29yZCcg
ICg+IDMyIGJpdHMpIGFuZCBsaWtlbHkgdG8gYmUNCnZhcmlhYmxlIHNpemUuDQpRdWl0ZSB3aHkg
dGhleSB1c2UgbG9uZyBbXSBpcyBhbnlib2R5J3MgZ3Vlc3MsIGJ1dCB0aGF0IGlzIHRoZSBkZWZp
bml0aW9uLg0KSXQgYWxzbyBpc24ndCBxdWl0ZSBjbGVhciB0byBtZSB3aHkgdGhhdCBhcmUgcmVx
dWlyZWQgdG8gYmUgYXRvbWljLg0KT24geDg2IGF0b21pY2l0eSBkb2Vzbid0IGNvc3QgbXVjaCwg
b24gb3RoZXIgYXJjaGl0ZWN0dXJlcyB0aGUgY29zdA0KaXMgc2lnbmlmaWNhbnQuDQoNCglEYXZp
ZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQg
RmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4
NiAoV2FsZXMpDQo=

