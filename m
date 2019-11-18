Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A01C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87BE2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 09:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbfKRJWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 04:22:39 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37256 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfKRJWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 04:22:38 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAI9MK2f001187, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAI9MK2f001187
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 18 Nov 2019 17:22:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 18 Nov 2019 17:22:20 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 18 Nov 2019 17:22:19 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926]) by
 RTEXMB03.realtek.com.tw ([fe80::5cc4:90a5:6821:926%8]) with mapi id
 15.01.1779.005; Mon, 18 Nov 2019 17:22:19 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
Thread-Topic: [PATCH v3 6/8] ARM: dts: rtd1195: Add reset nodes
Thread-Index: AQHVnRfWQHpokuCZUUmFW9fO0MELfKeQpIVQ
Date:   Mon, 18 Nov 2019 09:22:19 +0000
Message-ID: <20b3d0956bed4338a540216df07f16e5@realtek.com>
References: <20191117072109.20402-1-afaerber@suse.de>
 <20191117072109.20402-7-afaerber@suse.de>
In-Reply-To: <20191117072109.20402-7-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiArCQkJcmVzZXQxOiByZXNldC1jb250cm9sbGVyQDAgew0KPiArCQkJ
CWNvbXBhdGlibGUgPSAic25wcyxkdy1sb3ctcmVzZXQiOw0KPiArCQkJCXJlZyA9IDwweDAgMHg0
PjsNCj4gKwkJCQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQlyZXNl
dDI6IHJlc2V0LWNvbnRyb2xsZXJANCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJzbnBzLGR3LWxv
dy1yZXNldCI7DQo+ICsJCQkJcmVnID0gPDB4NCAweDQ+Ow0KPiArCQkJCSNyZXNldC1jZWxscyA9
IDwxPjsNCj4gKwkJCX07DQo+ICsNCj4gKwkJCXJlc2V0MzogcmVzZXQtY29udHJvbGxlckA4IHsN
Cj4gKwkJCQljb21wYXRpYmxlID0gInNucHMsZHctbG93LXJlc2V0IjsNCj4gKwkJCQlyZWcgPSA8
MHg4IDB4ND47DQo+ICsJCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArCQkJfTsNCj4gKw0KPiAr
CQkJaXNvX3Jlc2V0OiByZXNldC1jb250cm9sbGVyQDcwODggew0KPiArCQkJCWNvbXBhdGlibGUg
PSAic25wcyxkdy1sb3ctcmVzZXQiOw0KPiArCQkJCXJlZyA9IDwweDcwODggMHg0PjsNCj4gKwkJ
CQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ICsJCQl9Ow0KPiArDQoNCldlIGRvbid0IHVzZSB0aGUg
RGVzaWduV2FyZSBJUCBmb3IgdGhlIHJlc2V0IGNvbnRyb2xsZXIuDQoNCg0KUmVnYXJkcywNCkph
bWVzDQoNCg0K
