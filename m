Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C625EC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6117206CC
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbfKQPj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 10:39:58 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59925 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfKQPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 10:39:58 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAHFdS5D030891, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw [172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTP id xAHFdS5D030891;
        Sun, 17 Nov 2019 23:39:28 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Sun, 17 Nov 2019 23:39:28 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 17 Nov 2019 23:39:28 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926]) by
 RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926%8]) with mapi id
 15.01.1779.005; Sun, 17 Nov 2019 23:39:28 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rob Herring" <robh+dt@kernel.org>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Topic: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSD//6UUgP/7v8ZQgA4x2AD//PfkIA==
Date:   Sun, 17 Nov 2019 15:39:28 +0000
Message-ID: <7c94c59649c04442886a98c057c07654@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
 <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
 <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
In-Reply-To: <279fd3a3-17dc-5796-f0b0-e39eb919081f@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.161.94]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiA+IFNvcnJ5IGZvciBteSBtaXN1bmRlcnN0YW5kaW5nLiBUaGUgUkFN
IHJlZ2lvbiBkb24ndCByZXF1aXJlIHR3byBjZWxscw0KPiA+IGZvciBtZW1vcnkgbm9kZXMsIHNv
IEknbGwgZml4IGl0IGluIHYzIHBhdGNoLg0KPiANCj4gU2hvdWxkIEkgdGhlbiBhbHNvIGNoYW5n
ZSBSVEQxMzk1IHRvIHVzZSBvbmx5IG9uZSBjZWxsLCBvciBkb2VzIGl0IHN1cHBvcnQNCj4gbW9y
ZSBSQU0gdGhhbiBSVEQxNjE5Pw0KDQpZZXMsIHlvdSBjYW4uIFRoZSBtZW1vcnkgY2FwYWNpdHkg
b2YgUlREMTM5NSBhbmQgUlREMTYxOSBhcmUgdGhlIHNhbWUuDQoNCj4gQnkgbXkgY2FsY3VsYXRp
b24gMHg5ODAwMDAwMCBpcyBsZXNzIHRoYW4gMi40IEdpQiEgU28sIGRvZXMgUkFNIGNvbnRpbnVl
DQo+IGJldHdlZW4gci1idXMgYW5kIEdJQywgc2ltaWxhciB0byBob3cgaXQgZG9lcyBvbiBSVEQx
MTk1PyBUaGVuIHdlIG5lZWQgdG8NCj4gZXhjbHVkZSB0aG9zZSBSQU0gcmFuZ2VzIGZyb20gdGhl
IFNvQyBub2RlIChhZGp1c3RpbmcgMHg2ODAwMDAwMCkuDQoNCldlIG5lZWQgdG8gcmVzZXJ2ZSBt
ZW1vcnkgYWRkcmVzcyBmb3Igci1idXMgYW5kIEdJQyBhbmQgZXhjbHVkZSB0aG9zZSBSQU0gcmFu
Z2UgZnJvbSB0aGUgU29DIG5vZGUuDQoNCg==
