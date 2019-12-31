Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91597C2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F824206E4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbfLaJre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:47:34 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33013 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:47:34 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9lMnY002990, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9lMnY002990
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:47:22 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:47:22 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:47:22 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:47:22 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 00/14] ARM: dts: realtek: Introduce syscon
Thread-Topic: [PATCH 00/14] ARM: dts: realtek: Introduce syscon
Thread-Index: AQHVqT1tCIX1ZXSGCk+vaypVa8/P5KfRoTOAgAKGd4A=
Date:   Tue, 31 Dec 2019 09:47:22 +0000
Message-ID: <996a6968f411467cb987a14a0764726d@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <0f4d6872-b764-1c5e-9c2a-4e4e415a4877@suse.de>
In-Reply-To: <0f4d6872-b764-1c5e-9c2a-4e4e415a4877@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.187]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiANCj4gSSdtIHdhaXRpbmcgZm9yIHlvdXIgQWNrZWQtYnkgb2YgdGhl
IGJsb2NrcyAmIG51bWJlcnMgaW4gdGhlc2UgcGF0Y2hlcy4NCj4gT3RoZXIgUmVhbHRlayBlbmdp
bmVlcnMgYXJlIGFsc28gaW52aXRlZCB0byByZXNwb25kLCBvZiBjb3Vyc2UuDQoNCkkgaGF2ZSBy
ZXZpZXdlZCB0aGVzZSBwYXRjaGVzLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29udHJpYnV0aW9u
Lg0KDQoNClJlZ2FyZHMsDQpKYW1lcw0KDQoNCg==
