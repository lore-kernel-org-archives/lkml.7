Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7237FC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E542072C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgABPCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:02:43 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49114 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728625AbgABPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:02:43 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 002F2WAx027963, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 002F2WAx027963
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 2 Jan 2020 23:02:32 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 2 Jan 2020 23:02:32 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 2 Jan 2020 23:02:32 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Thu, 2 Jan 2020 23:02:32 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and RTD1295
Thread-Topic: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and
 RTD1295
Thread-Index: AQHVkedcJ4CFLsLliUi6huLyOdRzNafXzdIQ//99FgCAAIaBcA==
Date:   Thu, 2 Jan 2020 15:02:32 +0000
Message-ID: <e7f7ceb5f0bf4a58ae5712cdcca94ebc@realtek.com>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-3-afaerber@suse.de>
 <93eeece5be0640488096f20a9beb3d1d@realtek.com>
 <5792d721-cd67-5e19-dac2-1310894ef7c2@suse.de>
In-Reply-To: <5792d721-cd67-5e19-dac2-1310894ef7c2@suse.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.37.143.250]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbSAwMi4wMS4yMCB1bSAxNToyOSBzY2hyaWViIEphbWVzIFRhaToNCj4gPiBBZGQgU3Rhbmxl
eSBDaGFuZyBmb3IgcmV2aWV3Lg0KPiANCj4gRGlkIHlvdSBmb3JnZXQgdG8gQ0MgaGltPw0KDQpO
bywgU3RhbmxleSBDaGFuZyBpcyBpbiBsaW51eC1yZWFsdGVrLXNvYyBtYWlsaW5nIGxpc3QuDQoN
ClRoYW5rcy4NCg0KUmVnYXJkcywNCkphbWVzDQoNCg0K
