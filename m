Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6143C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3C82196E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfKMCmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:42:36 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:44621 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfKMCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:42:36 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD2gJXc006446, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD2gJXc006446
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Nov 2019 10:42:19 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 13 Nov 2019 10:42:19 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 13 Nov 2019 10:42:18 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Wed, 13 Nov
 2019 10:42:18 +0800
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
Subject: RE: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
Thread-Topic: [PATCH 3/7] arm64: dts: realtek: rtd129x: Introduce r-bus
Thread-Index: AQHVmD0LJFqIXtM2kU2Y99tlfWut1aeIZHww
Date:   Wed, 13 Nov 2019 02:42:18 +0000
Message-ID: <f70d00d8b1f8446fb138b36c61d952f4@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-4-afaerber@suse.de>
In-Reply-To: <20191111030434.29977-4-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiArCQlyYnVzOiByLWJ1c0A5ODAwMDAwMCB7DQo+ICsJCQljb21wYXRp
YmxlID0gInNpbXBsZS1idXMiOw0KPiArCQkJcmVnID0gPDB4OTgwMDAwMDAgMHgxMDAwMDA+Ow0K
PiArCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
KwkJCXJhbmdlcyA9IDwweDAgMHg5ODAwMDAwMCAweDEwMDAwMD47DQo+ICsNCg0KVGhlIHItYnVz
IHNpemUgb2YgUlREMTM5NSBpcyAweDIwMDAwMC4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
