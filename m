Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F67FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E90DA21882
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKHPg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 10:36:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45987 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbfKHPg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 10:36:29 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xA8Fa8BD019745, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xA8Fa8BD019745
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 8 Nov 2019 23:36:08 +0800
Received: from RTITMBSVM04.realtek.com.tw ([fe80::e404:880:2ef1:1aa1]) by
 RTITCASV01.realtek.com.tw ([::1]) with mapi id 14.03.0468.000; Fri, 8 Nov
 2019 23:36:08 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Topic: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSA=
Date:   Fri, 8 Nov 2019 15:36:07 +0000
Message-ID: <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
In-Reply-To: <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.6.95]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlldy4NCg0KWy4uLl0NCj4gSnVz
dCB0byBiZSBzdXJlOiBUaGlzIGlzIG9uZSBjbHVzdGVyIG9mIDYgQ1BVcz8gT3IgaXMgaXQgc29t
ZSA0KzIgYmlnLkxJVFRMRSwNCj4gRHluYW1pUSBvciB3aGF0ZXZlciBtdWx0aS1jbHVzdGVyIGNv
bmZpZ3VyYXRpb24gd2l0aCBkaWZmZXJlbnQgZnJlcXVlbmNpZXMsDQo+IHBvd2VyIGRvbWFpbnMg
b3Igc29tZXRoaW5nPw0KPiANClllcywgaXQgaXMgb25lIGNsdXN0ZXIgb2YgNiBDUFVzLg0KDQpb
Li4uXQ0KPiA+ICsNCj4gPiArCQlsMjogbDItY2FjaGUgew0KPiA+ICsJCQljb21wYXRpYmxlID0g
ImNhY2hlIjsNCj4gPiArCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmbDM+Ow0KPiA+ICsNCj4gPiAr
CQl9Ow0KPiA+ICsNCj4gPiArCQlsMzogbDMtY2FjaGUgew0KPiA+ICsJCQljb21wYXRpYmxlID0g
ImNhY2hlIjsNCj4gPiArCQl9Ow0KPiANCj4gQ2FjaGVzIGxvb2sgd2VpcmQgLSBvbmx5IGNwdTAg
dXNlcyBMMiBhbmQgYWxsIG90aGVycyB1c2UgTDMgZGlyZWN0bHk/DQo+IA0KWWVzLCBvbmx5IGNw
dTAgdXNlcyBMMiBhbmQgb3RoZXJzIHVzZSBMMyBkaXJlY3RseS4NCg0KWy4uLl0NCj4gR2VuZXJp
YyBxdWVzdGlvbiBhbHNvIGFwcGx5aW5nIHRvIG15IFJURDEyOTUvUlREMTE5NSBwYXRjaGVzOiBB
cmUgeW91IHN1cmUNCj4gYWJvdXQgR0lDX0NQVV9NQVNLX1JBVygweGYpIG9yIGNvdWxkIHRoaXMg
YmUgR0lDX0NQVV9NQVNLX1NJTVBMRSg2KQ0KPiBpbiB0aGlzIGNhc2U/IFRoaXMgaGVyZSB3b3Vs
ZCBzZWVtIGVxdWl2YWxlbnQgb2YgR0lDX0NQVV9NQVNLX1NJTVBMRSg4KS4NCj4NClRoZSBHSUN2
MyBkb2VzIG5vdCBoYXZlIGFmZmluaXR5IGJpdG1hcCBpbiB0aGUgYmluZGluZyBmb3IgUFBJDQpp
bnRlcnJ1cHRzLiBTbyByZW1vdmUgdGhlIEdJQ19DUFVfTUFTS19SQVcoKSBtYWNyby4NCg0KWy4u
Ll0gDQo+IA0KPiBBbmQgZG91YmxlLWNoZWNrIHdoZXRoZXIgeW91IGFjdHVhbGx5IG5lZWQgPDI+
IC0gY29tcGFyZSBydGQxMjl4LmR0c2kgdXNpbmcNCj4gPDE+IGJlY2F1c2Ugbm90aGluZyB3ZW50
IGJleW9uZCAzMi1iaXQgYWRkcmVzcyBzcGFjZS4gSXQgd2FzIGEgcmV2aWV3DQo+IHJlcXVlc3Qg
YmFjayB0aGVuLiBDYW4gUlREMTYxOSBoYXZlIG1vcmUgdGhhbiAyIEdpQiBSQU0sIHdpdGggYSBz
ZWNvbmQNCj4gUkFNIHJlZ2lvbiBpbiBoaWdoIG1lbSwgcmVxdWlyaW5nIHR3byBjZWxscyBmb3Ig
bWVtb3J5IG5vZGVzPw0KPiANClRoZSBSVEQxNjE5IGNhbiBzdXBwb3J0IG1vcmUgdGhhbiAyIEdp
QiBSQU0uDQoNClsuLi5dDQo+IA0KPiBJcyB0aGUgVUFSVCBubyBsb25nZXIgYmVoaW5kIGFuIElS
USBtdXggb24gUlREMTYxOSwgb3IgaXMgdGhlIGFib3ZlIHRoZSBJUlENCj4gbXV4IGludGVycnVw
dCBhcyBhIHdvcmthcm91bmQgZm9yIGxhY2sgb2YgaW4tdHJlZSBpcnFjaGlwIGRyaXZlcj8NCj4g
DQpZZXMsIHRoZSBVQVJUIG5vIGxvbmdlciBiZWhpbmQgYW4gSVJRIG11eCBvbiBSVEQxNjE5Lg0K
DQpbLi4uXSANCj4gQXJlIHlvdSBzdXJlIHlvdSBkb24ndCBoYXZlIEdJQ0MsIEdJQ0gsIEdJQ1Yg
YW5kIElSUT8gTm8gTUJJIHN1cHBvcnQ/DQo+IA0KVGhlIFJURDE2MTkgZG9uJ3QgaGF2ZSBHSUND
LCBHSUNILCBHSUNWIGFuZCBubyBzdXBwb3J0IE1CSS4NCg0KPiBGb3IgUlREMTI5NSBJIGV4dGVu
ZGVkIHRoZSBHSUN2MiBub2RlIGR1cmluZyByZXZpZXcsIGFuZCBLVk0gaW5pdGlhbGl6ZWQNCj4g
ZmluZSwgYWx0aG91Z2ggSSdtIG5vdCBzdXJlIHdoZXRoZXIgSSd2ZSBydW4gYW4gYWN0dWFsIGd1
ZXN0IHlldCwgZ2l2ZW4gaG93DQo+IG1hbnkgZHJpdmVycyB3ZXJlIG1pc3Npbmcgc3RpbGwuDQo+
IA0KPiAoSSdkIGFsc28gYXBwcmVjaWF0ZSBSZWFsdGVrIHRvIHJldmlldyBteSBSVEQxMTk1IHBh
dGNoJ3MgR0lDIFsxXSBmb3Igd2hldGhlcg0KPiB3ZSBzaG91bGQgaGF2ZSBhbGwgZm91ciByZWdp
b25zIGFuZCBzb21lIGludGVycnVwdCB0aGVyZSAtIHRoZSBPRU0ncyBVLUJvb3QNCj4gZG9lc24n
dCBib290IGluIEhZUCBtb2RlLCBzbyBJIGNhbid0IHRlc3QgbXlzZWxmLikNCj4gDQpJIHdpbGwg
aGVscCB3aXRoIHJldmlldy4NCg0KWy4uLl0NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
