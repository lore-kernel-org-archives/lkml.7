Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE3C432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431B520719
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfKWIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:40:47 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59492 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKWIkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:40:46 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAN8e5Jq003004, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAN8e5Jq003004
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Nov 2019 16:40:05 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Sat, 23 Nov 2019 16:40:05 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 23 Nov 2019 16:40:05 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::54f9:1e1e:4618:f740]) by
 RTEXMB03.realtek.com.tw ([fe80::54f9:1e1e:4618:f740%8]) with mapi id
 15.01.1779.005; Sat, 23 Nov 2019 16:40:05 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        Marc Zyngier <maz@misterjones.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Topic: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSD//6UUgP/7v8ZQgA4x2AD//PfkIIAOmDuAgAAzz4D//i+x8A==
Date:   Sat, 23 Nov 2019 08:40:04 +0000
Message-ID: <4235c5641f0f4946beeeea8adfd74970@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
 <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
 <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
 <7c94c59649c04442886a98c057c07654@realtek.com>
 <23f44f6f4aec90b412d5d7ff6f4d95f1@www.loen.fr>
 <80d0aed8-3b85-1312-1091-0ced3ab1f5d2@suse.de>
In-Reply-To: <80d0aed8-3b85-1312-1091-0ced3ab1f5d2@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.143.78]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiANCj4gTU1JTywgZm9yIEdJQ0QgYW5kIEdJQ1IuIEl0J3MgYWJvdXQg
Zml4aW5nIHRoZSByYW5nZXMgb2YgdGhlIC9zb2Mgbm9kZToNCj4gDQo+IE15IHByb3Bvc2VkDQo+
IHJhbmdlcyA9IDwweDk4MDAwMDAwIDB4OTgwMDAwMDAgMHg2ODAwMDAwMD47IG5lZWRzIHRvIGJl
IHNwbGl0LCB3aXRoIGEgZ2FwDQo+IGJldHdlZW4gci1idXMgYW5kIEdJQyBmb3IgY29udGludWVk
IFJBTS4NCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9hZmFlcmJlci9saW51eC9jb21taXQvMTg4
NGVjNmE1MzNjOWQ1YzJiNmNhNDBlZTEzOGZmDQo+IDdlODMxMmI2YzgNCj4gDQo+IFRoaXMgZ29l
cyBiYWNrIHRvIFJvYidzIHJldmlldyBvZiBSVEQxMjk1IFsxXSwgd2hlcmUgd2UgdGhlbiBmb3Ig
bGFjayBvZg0KPiBtZW1vcnkgc3BhY2UgZG9jdW1lbnRhdGlvbiBhc3N1bWVkIHRoYXQgZXZlcnl0
aGluZyBiZXlvbmQgMiBHaUIgd291bGQNCj4gYmUgcG90ZW50aWFsIHJlZ2lzdGVyIHNwYWNlLiBI
ZXJlIHdlJ3JlIGRlYWxpbmcgd2l0aCB1cCB0byA0IEdpQiB0aG91Z2guDQo+IA0KPiANCj4gSmFt
ZXMsIGFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIGZpeC11cCBwYXRjaCBoZXJlPyBJZiBub3Qs
IHlvdSdsbCBuZWVkIHRvIHRlbGwNCj4gbWUgd2hhdCB2YWx1ZXMgdG8gdXNlLCBlLmcuLCBpcyB0
aGVyZSBhIE5PUiBmbGFzaCByZWdpb24gb24gUlREMTYxOSwgYW5kIGRvZXMNCj4gUkFNIGNvbnRp
bnVlIGFsc28gaW4gYmV0d2VlbiBhbmQgYWZ0ZXIgR0lDLCBvciBpcyB0aGVyZSBzb21lIHRpbWVy
IHJlZ2lzdGVyDQo+IGJlaGluZCBpdCwgbGlrZSBvbiBSVEQxMTk1Pw0KPiANCj4gcmFuZ2VzID0g
PDB4MDAwMDAwMDAgMHgwMDAwMDAwMCAweDAwMDMwMDAwPiwgLy8gPz8/IGJvb3QgUk9NIHNpemUN
Cj4gICAgICAgICAgPDB4OTgwMDAwMDAgMHg5ODAwMDAwMCAweDAwMjAwMDAwPiwgLy8gci1idXMN
Cj4gICAgICAgICAgLy8gYW55dGhpbmcgaGVyZT8gZS5nLiwgTk9SIGZsYXNoPw0KPiAgICAgICAg
ICA8MHhmZjEwMDAwMCAweGZmMTAwMDAwIDB4MDAwMTAwMDA+LCAvLyBHSUNEDQo+ICAgICAgICAg
IDwweGZmMTQwMDAwIDB4ZmYxNDAwMDAgMHgwMDBjMDAwMD47IC8vIEdJQ1INCj4gICAgICAgICAg
Ly8gYW55dGhpbmcgaGVyZT8gZS5nLiwgdGltZXIgZW5hYmxlPw0KPiANCj4gcmFuZ2VzID0gPDB4
MDAwMDAwMDAgMHgwMDAwMDAwMCAweDAwMDMwMDAwPiwNCj4gICAgICAgICAgPDB4OTgwMDAwMDAg
MHg5ODAwMDAwMCAweDAwMjAwMDAwPiwNCj4gICAgICAgICAgPDB4ZmYxMDAwMDAgMHhmZjEwMDAw
MCAweDAwMTAwMDAwPjsgLy8gd2hvbGUgR0lDPw0KPiANCg0KWWVzLCBJJ2xsIHNlbmQgYSBmaXgt
dXAgcGF0Y2guDQoNCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
