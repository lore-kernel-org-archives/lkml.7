Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F15C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F8A22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 14:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgABOc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 09:32:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:48084 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728425AbgABOc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 09:32:57 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 002EWdLl015008, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV02.realtek.com.tw[172.21.6.19])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 002EWdLl015008
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 2 Jan 2020 22:32:39 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCASV02.realtek.com.tw (172.21.6.19) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Thu, 2 Jan 2020 22:32:39 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 2 Jan 2020 22:32:39 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Thu, 2 Jan 2020 22:32:39 +0800
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
Subject: RE: [RFC 03/11] arm64: dts: realtek: rtd129x: Add chip info node
Thread-Topic: [RFC 03/11] arm64: dts: realtek: rtd129x: Add chip info node
Thread-Index: AQHVkedK7O6Ji1Cvt0Gs/gwTj0NGGKfXzwow
Date:   Thu, 2 Jan 2020 14:32:39 +0000
Message-ID: <55c8692a0650426db7b78d5ce77ed08f@realtek.com>
References: <20191103013645.9856-1-afaerber@suse.de>
 <20191103013645.9856-4-afaerber@suse.de>
In-Reply-To: <20191103013645.9856-4-afaerber@suse.de>
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

QWRkIFN0YW5sZXkgQ2hhbmcgZm9yIHJldmlldy4NCg0KPiBBZGQgYSBEVCBub2RlIGZvciBjaGlw
IGlkZW50aWZpY2F0aW9uLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxh
ZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4gIGFyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9y
dGQxMjl4LmR0c2kgfCA1ICsrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCsp
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9yZWFsdGVrL3J0ZDEyOXgu
ZHRzaQ0KPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvcmVhbHRlay9ydGQxMjl4LmR0c2kNCj4gaW5k
ZXggNDQzMzExNDQ3NmY1Li4xNWE3YzI0OTE1NWQgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQv
Ym9vdC9kdHMvcmVhbHRlay9ydGQxMjl4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0
cy9yZWFsdGVrL3J0ZDEyOXguZHRzaQ0KPiBAQCAtODQsNiArODQsMTEgQEANCj4gIAkJCXN0YXR1
cyA9ICJkaXNhYmxlZCI7DQo+ICAJCX07DQo+IA0KPiArCQljaGlwLWluZm9AOTgwMWEyMDAgew0K
PiArCQkJY29tcGF0aWJsZSA9ICJyZWFsdGVrLHJ0ZDExOTUtY2hpcCI7DQo+ICsJCQlyZWcgPSA8
MHg5ODAxYTIwMCAweDg+Ow0KPiArCQl9Ow0KPiArDQo+ICAJCXVhcnQxOiBzZXJpYWxAOTgwMWIy
MDAgew0KPiAgCQkJY29tcGF0aWJsZSA9ICJzbnBzLGR3LWFwYi11YXJ0IjsNCj4gIAkJCXJlZyA9
IDwweDk4MDFiMjAwIDB4MTAwPjsNCj4gLS0NCj4gMi4xNi40DQo+IA0KPiANCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtcmVhbHRlay1z
b2MgbWFpbGluZyBsaXN0DQo+IGxpbnV4LXJlYWx0ZWstc29jQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yZWFs
dGVrLXNvYw0KPiANCj4gLS0tLS0tUGxlYXNlIGNvbnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZv
cmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
