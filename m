Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5991C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1522084E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbfKMCTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:19:33 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:40616 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfKMCTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:19:31 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD2J7lm030129, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD2J7lm030129
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 10:19:07 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 13 Nov 2019 10:19:07 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 13 Nov 2019 10:19:07 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Wed, 13 Nov
 2019 10:19:06 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v2 0/2] Initial RTD1619 SoC and Realtek Mjolnir EVB support
Thread-Topic: [PATCH v2 0/2] Initial RTD1619 SoC and Realtek Mjolnir EVB
 support
Thread-Index: AdWWGJhW6hHY3ZYJQ8qKkqaxghH5QQB63IcAAHDoKfA=
Date:   Wed, 13 Nov 2019 02:19:06 +0000
Message-ID: <569a8645d951428cbc1ce4bab3f42f3b@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91F9CB@RTITMBSVM04.realtek.com.tw>
 <f2ce8745-e056-06a5-3d55-b00ab4d82414@suse.de>
In-Reply-To: <f2ce8745-e056-06a5-3d55-b00ab4d82414@suse.de>
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

SGkgQW5kcmVhcywNCiANCj4gMSkgVGhlIHBhdGNoZXMgMS8yIGFuZCAyLzIgYXJlIGV4cGVjdGVk
IHRvIGJlIHRocmVhZGVkIHRvIDAvMiAoYnV0IG5vdA0KPiAyLzIgdG8gMS8yKS4gUGxlYXNlIGNo
ZWNrIHlvdXIgZ2l0IFtzZW5kZW1haWxdIGNvbmZpZyBvciB1c2UgLS10aHJlYWQNCj4gLS1uby1j
aGFpbi1yZXBseS10by4gVGhhdCBoZWxwcyBrZWVwIHRoZSBzZXJpZXMgdG9nZXRoZXIgd2hlbiBw
ZW9wbGUgc3RhcnQNCj4gcmVwbHlpbmcgdG8gaW5kaXZpZHVhbCBwYXRjaGVzLiBJZiB5b3VyIEdp
dCBjb25maWcgc2VlbXMgY29ycmVjdCwgaXQgbWlnaHQgYWxzbyBiZQ0KPiBhbiBpc3N1ZSB3aXRo
IHlvdXIgU01UUCBzZXJ2ZXIuDQoNClRoZSBnaXQgY29uZmlnIGlzIGNvcnJlY3QuIEknbGwgY2hl
Y2sgbXkgU01UUCBzZXJ2ZXIuDQoNClJlZ2FyZHMsDQpKYW1lcw0KDQoNCg==
