Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7728C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A875221734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgACFHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:07:31 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36208 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgACFHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:07:31 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00357Dx1010637, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00357Dx1010637
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 13:07:13 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 3 Jan 2020 13:07:13 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jan 2020 13:07:12 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 3 Jan 2020 13:07:12 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     James Tai <james.tai@realtek.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and RTD1295
Thread-Topic: [RFC 02/11] soc: Add Realtek chip info driver for RTD1195 and
 RTD1295
Thread-Index: AQHVkedcJ4CFLsLliUi6huLyOdRzNafXzdIQgADxX0A=
Date:   Fri, 3 Jan 2020 05:07:12 +0000
Message-ID: <0cd79474f707499d8c5d58b4f3250a68@realtek.com>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-3-afaerber@suse.de>
 <93eeece5be0640488096f20a9beb3d1d@realtek.com>
In-Reply-To: <93eeece5be0640488096f20a9beb3d1d@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.21.190.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVhcywNCg0KSSBoYXZlIHRlc3RlZCB0aGlzIHBhdGNoIGluIG15IGxvY2FsIHBsYXRm
b3JtLg0KQW5kIHRoaXMgcGF0Y2ggaXMgZmluZSBhbmQgaXQgY2FuIHdvcmsuDQoNCj4gDQo+IEFk
ZCBTdGFubGV5IENoYW5nIGZvciByZXZpZXcuDQo+IA0KPiA+IEFkZCBhIHNvYyBidXMgZHJpdmVy
IHRvIHByaW50IGNoaXAgbW9kZWwgYW5kIHJldmlzaW9uIGRldGFpbHMuDQo+ID4NCj4gPiBSZXZp
c2lvbnMgZnJvbSBkb3duc3RyZWFtIGRyaXZlcnMvc29jL3JlYWx0ZWsvcnRkezExOXgsMTI5eH0v
cnRrX2NoaXAuYy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZh
ZXJiZXJAc3VzZS5kZT4NCj4gPiAtLS0NCj4gPiAgTmFtaW5nOiBXaGF0IHRvIGNhbGwgdGhlIGZh
bWlseSB2cy4gc29jX2lkPw0KPiA+DQo+ID4gIGRyaXZlcnMvc29jL0tjb25maWcgICAgICAgICAg
fCAgIDEgKw0KPiA+ICBkcml2ZXJzL3NvYy9NYWtlZmlsZSAgICAgICAgIHwgICAxICsNCj4gPiAg
ZHJpdmVycy9zb2MvcmVhbHRlay9LY29uZmlnICB8ICAxMyArKysrDQo+ID4gIGRyaXZlcnMvc29j
L3JlYWx0ZWsvTWFrZWZpbGUgfCAgIDIgKw0KPiA+ICBkcml2ZXJzL3NvYy9yZWFsdGVrL2NoaXAu
YyAgIHwgMTY0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDE4MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL3NvYy9yZWFsdGVrL0tjb25maWcgIGNyZWF0ZSBtb2RlIDEwMDY0
NA0KPiA+IGRyaXZlcnMvc29jL3JlYWx0ZWsvTWFrZWZpbGUgIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IGRyaXZlcnMvc29jL3JlYWx0ZWsvY2hpcC5jDQoNClRlc3RlZC1ieTogU3RhbmxleSBDaGFu
ZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NClJldmlld2VkLWJ5OiBTdGFubGV5IENoYW5n
IDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
