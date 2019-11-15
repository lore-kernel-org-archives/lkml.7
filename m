Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9305C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A652073A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKOOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:42:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51672 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727427AbfKOOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:42:57 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAFEgTZu009752, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAFEgTZu009752
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Nov 2019 22:42:29 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 15 Nov 2019 22:42:29 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 15 Nov 2019 22:42:28 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Fri, 15 Nov
 2019 22:42:28 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "'DTML'" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1619 and Realtek Mjolnir EVB
Thread-Topic: [PATCH v3 1/2] dt-bindings: arm: realtek: Document RTD1619 and
 Realtek Mjolnir EVB
Thread-Index: AdWZPZ4hLyuFH8slSvOL26B5ueH3TQA5ONmAAGeERyA=
Date:   Fri, 15 Nov 2019 14:42:28 +0000
Message-ID: <597b7241d80c4e1fb0fe7dad33281ba5@realtek.com>
References: <d655415326064b079b9d1d791024c725@realtek.com>
 <420ad4a0-a583-c3b9-5ce6-ff4d12e71511@suse.de>
In-Reply-To: <420ad4a0-a583-c3b9-5ce6-ff4d12e71511@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiA+IERlZmluZSBjb21wYXRpYmxlIHN0cmluZ3MgZm9yIFJlYWx0ZWsg
UlREMTYxOSBTb0MgYW5kIFJlYWx0ZWsgTWpvbG5pciBFVkIuDQo+ID4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gDQo+IFRo
aXMgaXMgbWlzc2luZyB0aGUgcmVxdWVzdGVkIGNoYW5nZSBsb2cgaGVyZTogV2hhdCBjaGFuZ2Vk
IHNpbmNlIHYyPw0KPiANCj4gSWYgbm90aGluZyBjaGFuZ2VkLCB0aGVuIHlvdSBzaG91bGQndmUg
aW5zZXJ0ZWQgbXkgUmV2aWV3ZWQtYnkgZnJvbSB2Mg0KPiBiZWZvcmUgeW91ciBTaWduZWQtb2Zm
LWJ5Lg0KPiANCg0KVGhlcmUgaXMgbm90aGluZyBjaGFuZ2VkLiBJJ2xsIGNvcnJlY3QgdGhlIG1p
c3Rha2VzIGluIG5leHQgdmVyc2lvbi4NCg==
