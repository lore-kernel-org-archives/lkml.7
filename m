Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6FCC32771
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B41421734
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgACFHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:07:40 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36217 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgACFHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:07:40 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00357O1g010673, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00357O1g010673
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Jan 2020 13:07:24 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Fri, 3 Jan 2020 13:07:24 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 3 Jan 2020 13:07:24 +0800
Received: from RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999]) by
 RTEXMB04.realtek.com.tw ([fe80::d9c5:a079:495e:b999%6]) with mapi id
 15.01.1779.005; Fri, 3 Jan 2020 13:07:24 +0800
From:   =?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
To:     James Tai <james.tai@realtek.com>,
        =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [RFC 03/11] arm64: dts: realtek: rtd129x: Add chip info node
Thread-Topic: [RFC 03/11] arm64: dts: realtek: rtd129x: Add chip info node
Thread-Index: AQHVkedK7O6Ji1Cvt0Gs/gwTj0NGGKfXzwowgADzu9A=
Date:   Fri, 3 Jan 2020 05:07:23 +0000
Message-ID: <bcaaec45356449e9bb98a103a6ec3c55@realtek.com>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-4-afaerber@suse.de>
 <55c8692a0650426db7b78d5ce77ed08f@realtek.com>
In-Reply-To: <55c8692a0650426db7b78d5ce77ed08f@realtek.com>
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

SGkgQW5kcmVhcywNCg0KVGhpcyBwYXRjaCBpcyB3b3JrIGluIG15IHBsYXRmb3JtLg0KDQo+IEFk
ZCBTdGFubGV5IENoYW5nIGZvciByZXZpZXcuDQo+IA0KPiA+IEFkZCBhIERUIG5vZGUgZm9yIGNo
aXAgaWRlbnRpZmljYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJi
ZXIgPGFmYWVyYmVyQHN1c2UuZGU+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtNjQvYm9vdC9kdHMv
cmVhbHRlay9ydGQxMjl4LmR0c2kgfCA1ICsrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL3Jl
YWx0ZWsvcnRkMTI5eC5kdHNpDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3JlYWx0ZWsvcnRk
MTI5eC5kdHNpDQo+ID4gaW5kZXggNDQzMzExNDQ3NmY1Li4xNWE3YzI0OTE1NWQgMTAwNjQ0DQo+
ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDEyOXguZHRzaQ0KPiA+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMjl4LmR0c2kNCj4gPiBAQCAtODQs
NiArODQsMTEgQEANCj4gPiAgCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAgCQl9Ow0KPiA+
DQo+ID4gKwkJY2hpcC1pbmZvQDk4MDFhMjAwIHsNCj4gPiArCQkJY29tcGF0aWJsZSA9ICJyZWFs
dGVrLHJ0ZDExOTUtY2hpcCI7DQo+ID4gKwkJCXJlZyA9IDwweDk4MDFhMjAwIDB4OD47DQo+ID4g
KwkJfTsNCj4gPiArDQo+ID4gIAkJdWFydDE6IHNlcmlhbEA5ODAxYjIwMCB7DQo+ID4gIAkJCWNv
bXBhdGlibGUgPSAic25wcyxkdy1hcGItdWFydCI7DQo+ID4gIAkJCXJlZyA9IDwweDk4MDFiMjAw
IDB4MTAwPjsNCj4gPiAtLQ0KPiA+IDIuMTYuNA0KPiA+DQoNClRlc3RlZC1ieTogU3RhbmxleSBD
aGFuZyA8c3RhbmxleV9jaGFuZ0ByZWFsdGVrLmNvbT4NClJldmlld2VkLWJ5OiBTdGFubGV5IENo
YW5nIDxzdGFubGV5X2NoYW5nQHJlYWx0ZWsuY29tPg0KDQpUaGFua3MsDQpTdGFubGV5DQo=
