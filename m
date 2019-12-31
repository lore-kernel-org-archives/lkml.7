Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6059DC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E158206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfLaJ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:27:49 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59884 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:27:49 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9RTs5029675, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9RTs5029675
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:27:30 +0800
Received: from RTEXMB02.realtek.com.tw (172.21.6.95) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:27:29 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:27:29 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:27:29 +0800
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
Subject: RE: [PATCH 07/14] ARM: dts: rtd1195: Add reset nodes
Thread-Topic: [PATCH 07/14] ARM: dts: rtd1195: Add reset nodes
Thread-Index: AQHVqT3zGGAWvF//wkGLVSeos/JNSKfUJmug
Date:   Tue, 31 Dec 2019 09:27:29 +0000
Message-ID: <242bc41594564f3f9ef286ac9467efc4@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-8-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-8-afaerber@suse.de>
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

PiBBZGQgcmVzZXQgY29udHJvbGxlciBub2RlcyBmb3IgUmVhbHRlayBSVEQxMTk1IFNvQy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYXMgRsOkcmJlciA8YWZhZXJiZXJAc3VzZS5kZT4NCj4g
LS0tDQo+ICB2MTogRnJvbSBSVEQxMTk1IHY0IHNlcmllcyAoSmFtZXMgd2FudHMgdG8gY2hhbmdl
IHRoZSBjb21wYXRpYmxlIHN0cmluZykNCj4gDQo+ICBhcmNoL2FybS9ib290L2R0cy9ydGQxMTk1
LmR0c2kgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQs
IDI2IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9y
dGQxMTk1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9ydGQxMTk1LmR0c2kNCj4gaW5kZXggYWMz
NzM2NmZmN2M0Li44ODY4NDVlNTIyMDUgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRz
L3J0ZDExOTUuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9ydGQxMTk1LmR0c2kNCj4g
QEAgLTE0MSw3ICsxNDEsMzMgQEANCj4gIAl9Ow0KPiAgfTsNCj4gDQo+ICsmY3J0IHsNCj4gKwly
ZXNldDE6IHJlc2V0LWNvbnRyb2xsZXJAMCB7DQo+ICsJCWNvbXBhdGlibGUgPSAic25wcyxkdy1s
b3ctcmVzZXQiOw0KPiArCQlyZWcgPSA8MHgwIDB4ND47DQo+ICsJCSNyZXNldC1jZWxscyA9IDwx
PjsNCj4gKwl9Ow0KPiArDQo+ICsJcmVzZXQyOiByZXNldC1jb250cm9sbGVyQDQgew0KPiArCQlj
b21wYXRpYmxlID0gInNucHMsZHctbG93LXJlc2V0IjsNCj4gKwkJcmVnID0gPDB4NCAweDQ+Ow0K
PiArCQkjcmVzZXQtY2VsbHMgPSA8MT47DQo+ICsJfTsNCj4gKw0KPiArCXJlc2V0MzogcmVzZXQt
Y29udHJvbGxlckA4IHsNCj4gKwkJY29tcGF0aWJsZSA9ICJzbnBzLGR3LWxvdy1yZXNldCI7DQo+
ICsJCXJlZyA9IDwweDggMHg0PjsNCj4gKwkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArCX07DQo+
ICt9Ow0KPiArDQo+ICAmaXNvIHsNCj4gKwlpc29fcmVzZXQ6IHJlc2V0LWNvbnRyb2xsZXJAODgg
ew0KPiArCQljb21wYXRpYmxlID0gInNucHMsZHctbG93LXJlc2V0IjsNCj4gKwkJcmVnID0gPDB4
ODggMHg0PjsNCj4gKwkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArCX07DQo+ICsNCj4gIAl3ZHQ6
IHdhdGNoZG9nQDY4MCB7DQo+ICAJCWNvbXBhdGlibGUgPSAicmVhbHRlayxydGQxMjk1LXdhdGNo
ZG9nIjsNCj4gIAkJcmVnID0gPDB4NjgwIDB4MTAwPjsNCj4gLS0NCj4gMi4xNi40DQo+IA0KQWNr
ZWQtYnk6IEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPg0KDQo=
