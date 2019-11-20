Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07041C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03CC222DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 09:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfKTJXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:23:08 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60704 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKTJXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 04:23:08 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xAK9KEv0032545, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xAK9KEv0032545
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Nov 2019 17:20:14 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Wed, 20 Nov 2019 17:20:14 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 20 Nov 2019 17:20:13 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9]) by
 RTEXMB03.realtek.com.tw ([fe80::a4bf:5be3:6e60:69f9%8]) with mapi id
 15.01.1779.005; Wed, 20 Nov 2019 17:20:13 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
CC:     "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Topic: [PATCH 5/7] ARM: dts: rtd1195: Introduce r-bus
Thread-Index: AQHVmD0XE9qksqLMuUeBNyO+ccQCh6eIaL1AgAJ0nQCABXPOcIABjY0AgAHm7YA=
Date:   Wed, 20 Nov 2019 09:20:13 +0000
Message-ID: <734600434d7d4cce871353b33ef22a6f@realtek.com>
References: <20191111030434.29977-1-afaerber@suse.de>
 <20191111030434.29977-6-afaerber@suse.de>
 <a43d184d74c34e269714858b2635c35e@realtek.com>
 <960a80b9-b1bf-3709-bbb7-fc2a3c3ae1da@suse.de>
 <753c18eee3fb4e9ea25d42798542b3dd@realtek.com>
 <ed66e712-4ceb-374c-dd36-476d79706251@suse.de>
In-Reply-To: <ed66e712-4ceb-374c-dd36-476d79706251@suse.de>
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

SGkgQW5kcmVhcywNCg0KPiBQbGVhc2Ugc2VlIFsxXSAtIEkgaGFkIGFscmVhZHkgdXBkYXRlZCB0
aGUgc2Vjb25kIHJlc2VydmF0aW9uIHRvIHN0YXJ0IGF0DQo+IDB4YTgwMCBhbmQgZXh0ZW5kZWQg
aXQgdG8gMHgxMDAwMDAgYmVmb3JlIHlvdXIgcmVzcG9uc2UgaGVyZS4NCg0KVGhhbmsgeW91Lg0K
DQo+IFRoZSBwcmV2aW91cyAiYm9vdGNvZGUiIHNpemUgb2YgMHhjMDAwIGNhbiBiZSBmb3VuZCBo
ZXJlOg0KPiBodHRwczovL2dpdGh1Yi5jb20vQlBJLVNJTk9WT0lQL0JQSS1NNC1ic3AvYmxvYi9t
YXN0ZXIvbGludXgtcnRrL2FyY2gvYXJtDQo+IC9tYWNoLXJ0ZDExOXgvaW5jbHVkZS9tYWNoL21l
bW9yeS5oDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9CUEktU0lOT1ZPSVAvQlBJLU00LWJzcC9ibG9i
L21hc3Rlci9saW51eC1ydGsvYXJjaC9hcm0NCj4gL2Jvb3QvZHRzL3JlYWx0ZWsvcnRkMTE5eC9y
dGQtMTE5eC1ob3JzZXJhZGlzaC5kdHMNCj4gDQo+IEFzIHlvdSBjYW4gc2VlIHRoZSAweGMwMDAg
YW5kIDB4ZjQwMDAgd2VyZSBoYXJkY29kZWQgYW5kIGRpZCBub3QgZGVwZW5kIG9uDQo+IFNZU19C
T09UQ09ERV9NRU1TSVpFLi4uDQo+IEZvciBsYXRlciBTb0NzIEkgc2F3IHNvbWUgRklYTUUoPykg
Y29tbWVudCB0aGF0IGFyZWEgdXAgdG8gMHgxMDAwMDAgd2FzDQo+IHJlc2VydmVkIGR1ZSB0byBz
b21lIEppcmEgdGlja2V0IGFuZCBzaG91bGQgZ2V0IGZpeGVkPyBBbnkgaW5zaWdodHMgb24gd2hh
dCBpcw0KPiBpbiB0aGF0IG1lbW9yeSByYW5nZSBjYXVzaW5nIHByb2JsZW1zPw0KPiANClRoZSBw
cm9ibGVtIGlzIHNvbHZlZC4gKG1lbW9yeSBvdmVyd3JpdGUgYnkgRlcpDQoNClJlZ2FyZHMsDQpK
YW1lcw0KDQoNCg==
