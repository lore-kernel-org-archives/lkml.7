Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC51C20823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 15:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfC1PHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 11:07:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:59061 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726185AbfC1PHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 11:07:52 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-181-6sUimdxLNSiynXGaL8Tj-w-1; Thu, 28 Mar 2019 15:07:44 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu,
 28 Mar 2019 15:08:49 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 28 Mar 2019 15:08:49 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Quentin Monnet' <quentin.monnet@netronome.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "df@google.com" <df@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?utf-8?B?UkU6IFtQQVRDSF0gYnBmOiBicGZ0b29sOiBjb252ZXJ0IOKAmGNvbnN0IGNo?=
 =?utf-8?B?YXIgKuKAmSB0eXBlIGludG8gJ2NoYXIgKicgaW4gYXNzaWdubWVudA==?=
Thread-Topic: =?utf-8?B?W1BBVENIXSBicGY6IGJwZnRvb2w6IGNvbnZlcnQg4oCYY29uc3QgY2hhciAq?=
 =?utf-8?B?4oCZIHR5cGUgaW50byAnY2hhciAqJyBpbiBhc3NpZ25tZW50?=
Thread-Index: AQHU5XL+iRzQPqPBmUuLwkWNW4o/KaYhJMfA
Date:   Thu, 28 Mar 2019 15:08:49 +0000
Message-ID: <ebf3f6b747cb4400b8357e361b1f522a@AcuMS.aculab.com>
References: <20190328141652.wssqboyekxmp6tkw@yubo-2>
 <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
In-Reply-To: <d870f83e-48fa-7372-7664-e268aa1acf6c@netronome.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 6sUimdxLNSiynXGaL8Tj-w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUXVlbnRpbiBNb25uZXQNCj4gU2VudDogMjggTWFyY2ggMjAxOSAxNDozMQ0KPiAyMDE5
LTAzLTI4IDEwOjE2IFVUQy0wNDAwIH4gQm8gWVUgPHRzdS55dWJvQGdtYWlsLmNvbT4NCj4gPiBX
aGVuIGNvbXBpbGluZyB3aXRoIGNoZWNrIGZsYWc6IG1ha2UgLUMgdG9vbHMvYnBmL2JwZnRvb2wv
DQo+ID4gZ2NjIHdpbGwgd2FybmluZzoNCj4gPg0KPiA+IGppdF9kaXNhc20uYzoxMTk6Mjk6IHdh
cm5pbmc6IGFzc2lnbm1lbnQgZGlzY2FyZHMg4oCYY29uc3TigJkgcXVhbGlmaWVyIGZyb20NCj4g
PiBwb2ludGVyIHRhcmdldCB0eXBlIFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KPiA+IMKgIGlu
Zm8uZGlzYXNzZW1ibGVyX29wdGlvbnMgPSBkaXNhc3NlbWJsZXJfb3B0aW9uczsNCj4gPg0KPiA+
IFNvIGNvbnZlcnQgJ2NvbnN0IGNoYXIgKicgdHlwZSBpbnRvICdjaGFyIConIHRvIGZpeCB0aGUg
d2FybmluZy4NCj4gPg0KLi4uDQo+ID4gLS0tIGEvdG9vbHMvYnBmL2JwZnRvb2wvaml0X2Rpc2Fz
bS5jDQo+ID4gKysrIGIvdG9vbHMvYnBmL2JwZnRvb2wvaml0X2Rpc2FzbS5jDQo+ID4gQEAgLTEx
Niw3ICsxMTYsNyBAQCB2b2lkIGRpc2FzbV9wcmludF9pbnNuKHVuc2lnbmVkIGNoYXIgKmltYWdl
LCBzc2l6ZV90DQo+ID4gbGVuLCBpbnQgb3Bjb2RlcywNCj4gPiDCoMKgwqDCoGluZm8uYXJjaCA9
IGJmZF9nZXRfYXJjaChiZmRmKTsNCj4gPiDCoMKgwqDCoGluZm8ubWFjaCA9IGJmZF9nZXRfbWFj
aChiZmRmKTsNCj4gPiDCoMKgwqDCoGlmIChkaXNhc3NlbWJsZXJfb3B0aW9ucykNCj4gPiAtwqDC
oMKgwqDCoMKgwqAgaW5mby5kaXNhc3NlbWJsZXJfb3B0aW9ucyA9IGRpc2Fzc2VtYmxlcl9vcHRp
b25zOw0KPiA+ICvCoMKgwqDCoMKgwqDCoCBpbmZvLmRpc2Fzc2VtYmxlcl9vcHRpb25zID0gKGNo
YXIgKilkaXNhc3NlbWJsZXJfb3B0aW9uczsNCj4gPiDCoMKgwqDCoGluZm8uYnVmZmVyID0gaW1h
Z2U7DQo+ID4gwqDCoMKgwqBpbmZvLmJ1ZmZlcl9sZW5ndGggPSBsZW47DQoNCkF0IHNvbWUgcG9p
bnQgc29tZW9uZSBtYXkgZGVjaWRlIHRvIGJ1aWxkIHdpdGggLVdjYXN0LWNvbnN0DQphdCB3aGlj
aCBwb2ludCB5b3UndmUganVzdCBnZW5lcmF0ZWQgYSBkaWZmZXJlbnQgZXJyb3IuDQoNClRoZSAo
cHJvYmFibHkpIGNvcnJlY3QgZml4IGlzIHRvIG1ha2UgaW5mby5kaXNhc3NlbXBsZXJfb3B0aW9u
cyAnY29uc3QgY2hhciAqJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

