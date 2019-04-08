Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21E3C282DD
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEF920B1F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 09:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfDHJTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 05:19:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20098 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfDHJTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 05:19:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-6-vU1T9PEqMxOxi8OtEiLheA-1; Mon, 08 Apr 2019 10:19:42 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 8 Apr 2019 10:20:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 8 Apr 2019 10:20:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] objtool: Don't use -Werror
Thread-Topic: [PATCH] objtool: Don't use -Werror
Thread-Index: AQHU68meTsW4XthB40qs85GeKW+DmKYtvJfg///yOYCAABLlUP//+1mAgAAR8yD///D5gACH9Y+Q
Date:   Mon, 8 Apr 2019 09:20:50 +0000
Message-ID: <4dcc5b4ce124408495a440511acfc4c4@AcuMS.aculab.com>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
 <20190405162109.4hv6lqpd6manzjju@treble>
 <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
 <20190405171207.jmi7zehu37ksg5a4@treble>
 <d24e8040cc8c47a48d1f85a5f06436a7@AcuMS.aculab.com>
 <20190405172235.pgsjnyb62hqkfwcl@treble>
In-Reply-To: <20190405172235.pgsjnyb62hqkfwcl@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: vU1T9PEqMxOxi8OtEiLheA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDUgQXByaWwgMjAxOSAxODoyMw0KPiBPbiBG
cmksIEFwciAwNSwgMjAxOSBhdCAwNToxNzoxNVBNICswMDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6
DQo+ID4gPiBIbSwgSSBkb24ndCBzZWUgdGhhdCBpbiBjbWRfb2JqdG9vbCwgb3IgYW55IGNvbW1p
dHMgZnJvbSB5b3UgaW4NCj4gPiA+IHNjcmlwdHMvTWFrZWZpbGUuYnVpbGQuDQo+ID4NCj4gPiBO
b3Qgc3VyZSBJIHJlbWVtYmVyIGFjdHVhbGx5IGNvbW1pdHRpbmcgdGhlbS4NCj4gPiBNYXliZSAn
Z2l0IGRpZmYnIGlzbid0IGRvaW5nIHdoYXQgSSBleHBlY3QgOi0pDQo+ID4gSSBoYXRlIGdpdC4N
Cj4gDQo+IERvIHlvdSBzZWUgaXQgaGVyZT8NCj4gDQo+ICAgaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L3RyZWUvc2NyaXB0
cy9NYWtlZmlsZS5idWlsZA0KDQpObywgSSBtdXN0IGhhdmUgaGFkIHRvIHRlbGwgZ2l0IHRvIGFw
cGx5IHRoZSBjaGFuZ2UgbG9jYWxseS4NCkkgY2FuJ3Qgc2VlIGhvdyB0byBnZXQgZ2l0IHRvIGRp
ZmYgYWdhaW5zdCB0aGUgJ3JlYWwnIGhlYWQuDQpBbnl3YXkgYSAncmFuZG9tJyBudW1iZXIgb2Yg
XiBhZnRlciBIRUFEIGdhdmUgbWU6DQoNCmRpZmYgLS1naXQgYS9zY3JpcHRzL01ha2VmaWxlLmJ1
aWxkIGIvc2NyaXB0cy9NYWtlZmlsZS5idWlsZA0KaW5kZXggZTc4ODlmNC4uYTJmN2FiZSAxMDA2
NDQNCi0tLSBhL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQNCisrKyBiL3NjcmlwdHMvTWFrZWZpbGUu
YnVpbGQNCkBAIC0xOTMsNyArMTkzLDkgQEAgZWxzZQ0KIGNtZF9jY19vX2MgPSAkKENDKSAkKGNf
ZmxhZ3MpIC1jIC1vICQoQEQpLy50bXBfJChARikgJDwNCg0KIGNtZF9tb2R2ZXJzaW9uc19jID0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBcDQotICAgICAgIGlmICQoT0JKRFVNUCkgLWggJChARCkvLnRtcF8kKEBGKSB8IGdyZXAgLXEg
X19rc3ltdGFiOyB0aGVuICAgICAgICAgICAgIFwNCisgICAgICAgaWYgISBvYmpfaGVhZGVycz0k
JCgkKE9CSkRVTVApIC1oICQoQEQpLy50bXBfJChARikpOyB0aGVuICAgICAgICAgICAgICAgXA0K
KyAgICAgICAgICAgICAgIGZhbHNlOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBcDQorICAgICAgIGVsaWYgZWNobyAiJCRvYmpfaGVhZGVy
cyIgfCBncmVwIC1xIF9fa3N5bXRhYjsgdGhlbiAgICAgICAgICAgICAgICAgICAgIFwNCiAgICAg
ICAgICAgICAgICAkKGNhbGwgY21kX2dlbnN5bXR5cGVzX2MsJChLQlVJTERfU1lNVFlQRVMpLCQo
QDoubz0uc3ltdHlwZXMpKSAgXA0KICAgICAgICAgICAgICAgICAgICA+ICQoQEQpLy50bXBfJChA
Rjoubz0udmVyKTsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBcDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFwNCkBAIC0yNzcsNyArMjc5LDE0IEBAIGVuZGlmDQogIyAnT0JKRUNUX0ZJ
TEVTX05PTl9TVEFOREFSRF9mb28ubyA6PSAnbic6IG92ZXJyaWRlIGRpcmVjdG9yeSBza2lwIGZv
ciBhIGZpbGUNCiBjbWRfb2JqdG9vbCA9ICQoaWYgJChwYXRzdWJzdCB5JSwsIFwNCiAgICAgICAg
JChPQkpFQ1RfRklMRVNfTk9OX1NUQU5EQVJEXyQoYmFzZXRhcmdldCkubykkKE9CSkVDVF9GSUxF
U19OT05fU1RBTkRBUkQpbiksIFwNCi0gICAgICAgJChfX29ianRvb2xfb2JqKSAkKG9ianRvb2xf
YXJncykgIiQob2JqdG9vbF9vKSI7KQ0KKyAgICAgICAkKF9fb2JqdG9vbF9vYmopICQob2JqdG9v
bF9hcmdzKSAiJChvYmp0b29sX28pIiAmJiB7IFwNCisgICAgICAgICAgICAgICAkKE9CSkRVTVAp
IC1oICIkKG9ianRvb2xfbykiID4vZGV2L251bGwgMj4mMSB8fCB7IFwNCisgICAgICAgICAgICAg
ICAgICAgICAgIGVjaG8gPiYyICIqKioqKioqIG9ianRvb2wgZ2VuZXJhdGVkIHRoZSBpbnZhbGlk
IGZpbGUgJChvYmp0b29sX28pIjsgXA0KKyAgICAgICAgICAgICAgICAgICAgICAgZWNobyA+JjIg
IioqKioqKiogVXBkYXRlIGxpYmVsZi5zbyBvciBkaXNhYmxlIHRoZSBPUkMgdW53aW5kZXIiOyBc
DQorICAgICAgICAgICAgICAgICAgICAgICAvYmluL2ZhbHNlOyBcDQorICAgICAgICAgICAgICAg
fTsgXA0KKyAgICAgICB9OykNCisNCiBvYmp0b29sX29iaiA9ICQoaWYgJChwYXRzdWJzdCB5JSws
IFwNCiAgICAgICAgJChPQkpFQ1RfRklMRVNfTk9OX1NUQU5EQVJEXyQoYmFzZXRhcmdldCkubykk
KE9CSkVDVF9GSUxFU19OT05fU1RBTkRBUkQpbiksIFwNCiAgICAgICAgJChfX29ianRvb2xfb2Jq
KSkNCg0KRG8geW91IHdhbnQgYSBmb3JtYWwgcGF0Y2g/DQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

