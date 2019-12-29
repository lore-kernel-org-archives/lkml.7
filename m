Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86970C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4AC208C4
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfL2H5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 02:57:38 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60849 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfL2H5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 02:57:38 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBT7vM7H015574, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBT7vM7H015574
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Sun, 29 Dec 2019 15:57:22 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Sun, 29 Dec 2019 15:57:22 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sun, 29 Dec 2019 15:57:21 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Sun, 29 Dec 2019 15:57:21 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB support
Thread-Topic: [PATCH v2 0/2] Initial RTD1319 SoC and Realtek PymParticle EVB
 support
Thread-Index: AQHVvZBnw+MU9IFQeki5qI/vGuhs8afP46uAgADZpxA=
Date:   Sun, 29 Dec 2019 07:57:21 +0000
Message-ID: <4a8a2899c2e140b39db251b456a77959@realtek.com>
References: <20191228150553.6210-1-james.tai@realtek.com>
 <9fbe4392-5028-3718-8c97-547a46efad2a@suse.de>
In-Reply-To: <9fbe4392-5028-3718-8c97-547a46efad2a@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.128.25]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KPiBUaGlzIHRpbWUgeW91IENDJ2VkIG1lIG9ubHkgb24gdGhlIGNvdmVy
IGxldHRlciwgc28gdGhhdCBJIGRpZG4ndCBnZXQgbm90aWZpZWQgb2YsDQo+IGUuZy4sIE1hcmMn
cyByZXZpZXcgY29tbWVudHMuIEkgd29uZGVyIHdoeTogcmVhbHRlay55YW1sIGlzIGluIE1BSU5U
QUlORVJTLA0KPiBhbmQgc28gaXMgZHRzL3JlYWx0ZWsvLCBzbyBnZXRfbWFpbnRhaW5lcnMucGwg
c2hvdWxkJ3ZlIHBpY2tlZCBtZSB1cCwgZXZlbiBpZg0KPiB5b3UgZm9yZ290IHRvIGV4cGxpY2l0
bHkgQ0MgbWU/IFBsZWFzZSBjaGVjayB3aGF0IHdlbnQgd3JvbmcgdGhlcmUgYW5kIG1ha2UNCj4g
c3VyZSBpdCBkb2Vzbid0IGhhcHBlbiBhZ2FpbiBmb3IgdGhlIG5leHQgc3VibWlzc2lvbi4NCj4g
DQpJIHdpbGwgY2hlY2sgaXQgYW5kIG1ha2Ugc3VyZSBpdCBkb2Vzbid0IGhhcHBlbiBhZ2FpbiBm
b3IgdGhlIG5leHQgc3VibWlzc2lvbi4NCg0KVGhhbmtzLg0KDQpSZWdhcmRzLA0KSmFtZXMNCg0K
DQo=
