Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948C2C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736A52068F
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 08:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbfKWIwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 03:52:50 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59696 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfKWIwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 03:52:50 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAN8qVea003935, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAN8qVea003935
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 23 Nov 2019 16:52:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Sat, 23 Nov 2019 16:52:31 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 23 Nov 2019 16:52:31 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::54f9:1e1e:4618:f740]) by
 RTEXMB03.realtek.com.tw ([fe80::54f9:1e1e:4618:f740%8]) with mapi id
 15.01.1779.005; Sat, 23 Nov 2019 16:51:52 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: RE: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Topic: [PATCH] arm64: dts: realtek: Add Realtek rtd1619 and mjolnir
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSACDOAZgAA+WRqQAEum34AATt+NIA==
Date:   Sat, 23 Nov 2019 08:51:52 +0000
Message-ID: <bc9c923789fe4f0586df3d2051e5721d@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <6182b89f-cd7e-ce7c-56f7-e2f500321cde@suse.de>
 <993d5da60a87443995347ee2a4c74959@realtek.com>
 <6d44e7f8-1ae5-ed3d-ac3c-0ee7903d660b@suse.de>
In-Reply-To: <6d44e7f8-1ae5-ed3d-ac3c-0ee7903d660b@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiA+PiBiYWNrIFJURDE2MTkgaXJxIG11eCBwYXRjaGVzIGZyb20gbXkg
aXJxY2hpcCB2NCBzZXJpZXMgWzFdLg0KPiA+Pg0KPiA+IEl0IGlzIGNvZGUgd3JvbmcuIFRoZSBV
UjAgc2hvdWxkIHJlbW92ZSBmcm9tICJpcnEtcnRkMTZ4eC5oIi4NCj4gDQo+IEFjdHVhbGx5LCBJ
IGp1c3QgdGVzdGVkIHRoYXQgVVIwIHdvcmtzISAocmV2IEEwMSkgU28gd2Ugc2hvdWxkbid0IHJl
bW92ZSBpdCBmcm9tDQo+IHRoZSBpcnFjaGlwIGRyaXZlciwgZ2l2ZW4gdGhlIG1hcHBpbmcgY2hh
bmdlcyByZXF1ZXN0ZWQgZm9yIHY1Lg0KDQpUaGUgVVIwIGhhcyBiZWVuIHJlbW92ZWQgZnJvbSB0
aGUgUlREMTYxOSBzcGVjaWZpY2F0aW9uLiANCkknbGwgY2hlY2sgaXQgYWdhaW4uDQoNCg0KUmVn
YXJkcywNCkphbWVzDQoNCg0K
