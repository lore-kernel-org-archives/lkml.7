Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540DC17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF177207FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 02:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKC7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 21:59:02 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:45369 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbfKKC7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 21:59:02 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAB2wPMa006243, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAB2wPMa006243
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Nov 2019 10:58:26 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 11 Nov 2019 10:58:25 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 Nov 2019 10:58:24 +0800
Received: from RTEXMB03.realtek.com.tw ([::1]) by RTEXMB03.realtek.com.tw
 ([fe80::3d7d:f7db:e1fb:307b%12]) with mapi id 15.01.1779.005; Mon, 11 Nov
 2019 10:58:24 +0800
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
Thread-Index: AdWTrwRiu8TDC5guRneVMItRk6mPLwAihi8AAIJriSD//6UUgP/7v8ZQ
Date:   Mon, 11 Nov 2019 02:58:24 +0000
Message-ID: <309cd67da48e4702ae3dcc4ca8ab4309@realtek.com>
References: <43B123F21A8CFE44A9641C099E4196FFCF91BEFA@RTITMBSVM04.realtek.com.tw>
 <25fdd8eb-f1a0-82ae-9c4b-22325b163b0e@suse.de>
 <43B123F21A8CFE44A9641C099E4196FFCF920024@RTITMBSVM04.realtek.com.tw>
 <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
In-Reply-To: <7a05ac2c-00bc-b2ac-0a33-be0242d33188@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiBIb3cgbXVjaD8gTW9yZSB0aGFuIDB4OTgwMDAwMDA/IFRoZSBSVEQx
Mzk1IGRhdGFzaGVldCBzYXlzIHVwIHRvIDQgR0IgLQ0KPiBkb2VzIHRoYXQgbWVhbiBpdCBjb250
aW51ZXMgaW4gYSBzZWNvbmQgcmVnaW9uIGJleW9uZCAweGZmZmZmZmZmPyBUaG9zZQ0KPiBsb2Nh
dGlvbnMgc2hvdWxkIGJlIGV4Y2x1ZGVkIGluIHRoZSBzb2Mgbm9kZSByYW5nZXMgKHdoaWNoIHlv
dSBzYWRseSBhcHBlYXIgdG8NCj4gaGF2ZSBkcm9wcGVkIGluIHYyKS4NCj4gDQoNClNvcnJ5IGZv
ciBteSBtaXN1bmRlcnN0YW5kaW5nLiBUaGUgUkFNIHJlZ2lvbiBkb24ndCByZXF1aXJlIA0KdHdv
IGNlbGxzIGZvciBtZW1vcnkgbm9kZXMsIHNvIEknbGwgZml4IGl0IGluIHYzIHBhdGNoLg0KDQpS
ZWdhcmRzLA0KSmFtZXMNCg0KDQo=
