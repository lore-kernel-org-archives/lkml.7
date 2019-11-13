Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28847C17441
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE88204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKMC5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:57:51 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:48798 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbfKMC5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:57:50 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAD2vVB1014710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAD2vVB1014710
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 13 Nov 2019 10:57:32 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 13 Nov 2019 10:57:31 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 13 Nov 2019 10:57:30 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Wed, 13 Nov
 2019 10:57:30 +0800
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
Subject: RE: [PATCH 7/7] arm64: dts: realtek: Add RTD1395 and BPi-M4
Thread-Topic: [PATCH 7/7] arm64: dts: realtek: Add RTD1395 and BPi-M4
Thread-Index: AQHVmD0Zjtr/ttyrCU29swF/t1P59aeIat+w
Date:   Wed, 13 Nov 2019 02:57:30 +0000
Message-ID: <c0dfa7d415ed4883ade0a903547270b3@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-8-afaerber@suse.de>
In-Reply-To: <20191111030434.29977-8-afaerber@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiArCXNvYyB7DQo+ICsJCWNvbXBhdGlibGUgPSAic2ltcGxlLWJ1cyI7
DQo+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiArCQkjc2l6ZS1jZWxscyA9IDwxPjsNCj4g
KwkJcmFuZ2VzID0gPDB4OTgwMDAwMDAgMHgwIDB4OTgwMDAwMDAgMHg2ODAwMDAwMD47DQo+ICsN
Cj4gKwkJcmJ1czogci1idXNAOTgwMDAwMDAgew0KPiArCQkJY29tcGF0aWJsZSA9ICJzaW1wbGUt
YnVzIjsNCj4gKwkJCXJlZyA9IDwweDk4MDAwMDAwIDB4MTAwMDAwPjsNCj4gKwkJCSNhZGRyZXNz
LWNlbGxzID0gPDE+Ow0KPiArCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJCQlyYW5nZXMgPSA8
MHgwIDB4OTgwMDAwMDAgMHgxMDAwMDA+Ow0KDQpUaGUgci1idXMgc2l6ZSBvZiBSVEQxMzk1IGlz
IDB4MjAwMDAw4oCsLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0KDQo=
