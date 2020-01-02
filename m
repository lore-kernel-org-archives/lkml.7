Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0622AC2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6123206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgABOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:36:24 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:48172 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgABOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:36:24 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 002EZqPs015545, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 002EZqPs015545
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 Jan 2020 22:35:53 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 2 Jan 2020 22:35:52 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 2 Jan 2020 22:35:52 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Thu, 2 Jan 2020 22:35:52 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 06/11] soc: realtek: chip: Detect RTD1296
Thread-Topic: [RFC 06/11] soc: realtek: chip: Detect RTD1296
Thread-Index: AQHVked+8ysSEPXOXEWoR+Z6QJyNe6fXz/Og
Date:   Thu, 2 Jan 2020 14:35:52 +0000
Message-ID: <e23f24e7c018440bbf72317fbcc1b22f@realtek.com>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-7-afaerber@suse.de>
In-Reply-To: <20191103013645.9856-7-afaerber@suse.de>
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

PiBEZXRlY3Rpb24gbG9naWMgZnJvbSBkb3duc3RyZWFtIGRyaXZlcnMvc29jL3JlYWx0ZWsvcnRk
MTI5eC9ydGtfY2hpcC5jLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxh
ZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL3JlYWx0ZWsvY2hpcC5jIHwg
MTggKysrKysrKysrKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL3JlYWx0ZWsv
Y2hpcC5jIGIvZHJpdmVycy9zb2MvcmVhbHRlay9jaGlwLmMgaW5kZXgNCj4gOWQxMzQyMmU5OTM2
Li5iYTY1M2MwOTc2NDQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL3JlYWx0ZWsvY2hpcC5j
DQo+ICsrKyBiL2RyaXZlcnMvc29jL3JlYWx0ZWsvY2hpcC5jDQo+IEBAIC01MCw5ICs1MCwyNSBA
QCBzdGF0aWMgY29uc3QgY2hhciAqZGVmYXVsdF9uYW1lKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4g
Y29uc3Qgc3RydWN0IHJ0ZF9zb2MgKnMpDQo+ICAJcmV0dXJuIHMtPmZhbWlseTsNCj4gIH0NCj4g
DQo+ICtzdGF0aWMgY29uc3QgY2hhciAqcnRkMTI5NV9uYW1lKHN0cnVjdCBkZXZpY2UgKmRldiwg
Y29uc3Qgc3RydWN0DQo+ICtydGRfc29jICpzKSB7DQo+ICsJdm9pZCBfX2lvbWVtICpiYXNlOw0K
PiArDQo+ICsJYmFzZSA9IG9mX2lvbWFwKGRldi0+b2Zfbm9kZSwgMSk7DQo+ICsJaWYgKGJhc2Up
IHsNCj4gKwkJdTMyIGNoaXBpbmZvMSA9IHJlYWRsX3JlbGF4ZWQoYmFzZSk7DQo+ICsJCWlvdW5t
YXAoYmFzZSk7DQo+ICsJCWlmIChjaGlwaW5mbzEgJiBCSVQoMTEpKSB7DQo+ICsJCQlyZXR1cm4g
IlJURDEyOTYiOw0KPiArCQl9DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuICJSVEQxMjk1IjsNCj4g
K30NCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBydGRfc29jIHJ0ZF9zb2NfZmFtaWxpZXNb
XSA9IHsNCj4gIAl7IDB4MDAwMDYzMjksICJSVEQxMTk1IiwgZGVmYXVsdF9uYW1lLCBydGQxMTk1
X3JldmlzaW9ucywgIlBob2VuaXgiIH0sDQo+IC0JeyAweDAwMDA2NDIxLCAiUlREMTI5NSIsIGRl
ZmF1bHRfbmFtZSwgcnRkMTI5NV9yZXZpc2lvbnMsICJLeWxpbiIgfSwNCj4gKwl7IDB4MDAwMDY0
MjEsICJSVEQxMjk1IiwgcnRkMTI5NV9uYW1lLCBydGQxMjk1X3JldmlzaW9ucywgIkt5bGluIiB9
LA0KPiAgfTsNCj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IHJ0ZF9zb2MgKnJ0ZF9zb2NfYnlf
Y2hpcF9pZCh1MzIgY2hpcF9pZCkNCj4gLS0NCj4gMi4xNi40DQo+IA0KQWNrZWQtYnk6IEphbWVz
IFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPg0KDQo=
