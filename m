Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BF3C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BA520718
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 14:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfL3Ozt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 09:55:49 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59976 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbfL3Ozs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 09:55:48 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBUEtK3u018777, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBUEtK3u018777
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:55:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Mon, 30 Dec 2019 22:55:20 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 30 Dec 2019 22:55:20 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Mon, 30 Dec 2019 22:55:20 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 14/14] dt-bindings: reset: rtd1295: Add SB2 reset
Thread-Topic: [PATCH 14/14] dt-bindings: reset: rtd1295: Add SB2 reset
Thread-Index: AQHVqT34B9KUPlrEBUCEIqQuxCatIafS76Sw
Date:   Mon, 30 Dec 2019 14:55:20 +0000
Message-ID: <f5affd5149364bd0b94600f631821ef4@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-15-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-15-afaerber@suse.de>
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

PiBBZGQgYSBjb25zdGFudCBmb3IgcmVzZXQzIFNCMiwgYmFzZWQgb24gZG93bnN0cmVhbSBjcnRf
c3lzX3JlZy5oLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJl
ckBzdXNlLmRlPg0KPiAtLS0NCj4gIGluY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvcmVhbHRlayxy
dGQxMjk1LmggfCAzICsrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3MvcmVzZXQvcmVhbHRlayxydGQxMjk1
LmgNCj4gYi9pbmNsdWRlL2R0LWJpbmRpbmdzL3Jlc2V0L3JlYWx0ZWsscnRkMTI5NS5oDQo+IGlu
ZGV4IDJjMGNiNmFmZTgxNi4uZGQ4OWU0YzgwMjY0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2R0
LWJpbmRpbmdzL3Jlc2V0L3JlYWx0ZWsscnRkMTI5NS5oDQo+ICsrKyBiL2luY2x1ZGUvZHQtYmlu
ZGluZ3MvcmVzZXQvcmVhbHRlayxydGQxMjk1LmgNCj4gQEAgLTc1LDYgKzc1LDkgQEANCj4gICNk
ZWZpbmUgUlREMTI5NV9SU1ROX0NCVVNfVFgJCTMwDQo+ICAjZGVmaW5lIFJURDEyOTVfUlNUTl9T
RFNfUEhZCQkzMQ0KPiANCj4gKy8qIHNvZnQgcmVzZXQgMyAqLw0KPiArI2RlZmluZSBSVEQxMjk1
X1JTVE5fU0IyCQkwDQo+ICsNCj4gIC8qIHNvZnQgcmVzZXQgNCAqLw0KPiAgI2RlZmluZSBSVEQx
Mjk1X1JTVE5fRENQSFlfQ1JUCQkwDQo+ICAjZGVmaW5lIFJURDEyOTVfUlNUTl9EQ1BIWV9BTEVS
VF9SWAkxDQo+IC0tDQo+IDIuMTYuNA0KPiANCg0KQWNrZWQtYnk6IEphbWVzIFRhaSA8amFtZXMu
dGFpQHJlYWx0ZWsuY29tPg0KDQo=
