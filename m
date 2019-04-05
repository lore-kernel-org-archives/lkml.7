Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA27DC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F7121738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 16:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731583AbfDEQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 12:34:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28119 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729269AbfDEQeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 12:34:46 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-188-W7t3GGLlMV2RrwvroR2Fig-1; Fri, 05 Apr 2019 17:34:43 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 5 Apr 2019 17:35:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 5 Apr 2019 17:35:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josh Poimboeuf' <jpoimboe@redhat.com>
CC:     'Luis Ressel' <aranea@aixah.de>,
        Peter Zijlstra <peterz@infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] objtool: Don't use -Werror
Thread-Topic: [PATCH] objtool: Don't use -Werror
Thread-Index: AQHU68meTsW4XthB40qs85GeKW+DmKYtvJfg///yOYCAABLlUA==
Date:   Fri, 5 Apr 2019 16:35:50 +0000
Message-ID: <d3cb290b12974f1895ea235680f90ead@AcuMS.aculab.com>
References: <20190405110151.2461-1-aranea@aixah.de>
 <20190405123909.tupbgueie4czg2dd@treble>
 <20190405142443.rgpwbgyym76xizad@vega.skynet.aixah.de>
 <20190405143926.wmrkjsazlheeg6qs@treble>
 <20190405160550.62arkmvj67zm6oc2@vega.skynet.aixah.de>
 <a9dfc08702044b3db89c0584c0f79229@AcuMS.aculab.com>
 <20190405162109.4hv6lqpd6manzjju@treble>
In-Reply-To: <20190405162109.4hv6lqpd6manzjju@treble>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: W7t3GGLlMV2RrwvroR2Fig-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9zaCBQb2ltYm9ldWYNCj4gU2VudDogMDUgQXByaWwgMjAxOSAxNzoyMQ0KLi4NCj4g
PiBGV0lXIEkgaGFkIHRvIHVwZGF0ZSBsaWJlbGYuc28gZnJvbSB2ZXJzaW9uIDAuMTUzIHRvIDAu
MTY1IGluDQo+ID4gb3JkZXIgZm9yIHRoZSBhbWQ2NCBvcmMgdW53aW5kZXIgY29kZSBpbiBvYmp0
b29sIHRvIG5vdCBnZW5lcmF0ZQ0KPiA+IGNvcnJ1cHQgb3V0cHV0IGZpbGVzLg0KPiA+IFRoYXQg
aXMgYW4gVWJ1bnR1IDEzLjA0IHN5c3RlbSAtIG5vdGhpbmcgbGlrZSAxMCB5ZWFycyBvbGQuDQo+
IA0KPiBBaC4gIEl0IHdvdWxkIGJlIGdyZWF0IGlmIHdlIGhhZCBhIHBhdGNoIHRvIGZhaWwgdGhl
IGJ1aWxkIGZvciBvbGQNCj4gdmVyc2lvbnMgb2YgZWxmdXRpbHMtbGliZWxmIGFzIHdlbGwuDQoN
CkkgdGhpbmsgdGhlIGNoZWNrIEkgYWRkZWQgZm9yIHRoYXQgc3BlY2lmaWMgZXJyb3IgZ290IGNv
bW1pdHRlZC4NCkxvb2sgYXQgdGhlIGRlZmludGlvbiBvZiBjbWRfb2JqdG9vbCBpbiBzY3JpcHRz
L01ha2VmaWxlLmJ1aWxkLg0KDQpBbHRob3VnaCBJIHNlZW0gdG8gaGF2ZSBhIGxvY2FsIGNoYW5n
ZSB0byB0aGUgZGVmaW5pdGlvbiBvZg0KY21kX21vZHZlcnNpb25zX2MuDQpJdCBtaWdodCBiZSB0
aGF0IHRoZSB2ZXJzaW9uIG9mIGEgY2hhbmdlIEkgbWFkZSB0aGF0IGdvdCBjb21taXR0ZWQNCmlz
IG1pc3NpbmcgYW4gZXh0cmEgJCB3aGVuIHByb2Nlc3NpbmcgdGhlIHNhdmVkIG91dHB1dCBmcm9t
ICdvYmpkdW1wIC1oJy4NCkl0IHVzZWQgdG8ganVzdCBwaXBlIGludG8gZ3JlcCAtIHNvIGxvc3Qg
dGhlIGVycm9yIHJlc3VsdCBmcm9tIG9iamR1bXAuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

