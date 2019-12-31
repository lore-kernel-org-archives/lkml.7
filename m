Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E61AC2D0DD
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB1B206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfLaJ2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:28:53 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59914 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:28:53 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9ScZ5030135, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9ScZ5030135
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:28:38 +0800
Received: from RTEXMB05.realtek.com.tw (172.21.6.98) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:28:37 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:28:37 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:28:37 +0800
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
Subject: RE: [PATCH 08/14] ARM: dts: rtd1195: Add UART resets
Thread-Topic: [PATCH 08/14] ARM: dts: rtd1195: Add UART resets
Thread-Index: AQHVqT3zvNviF7MlYU6F83GAtd4KuKfUJsEA
Date:   Tue, 31 Dec 2019 09:28:37 +0000
Message-ID: <3ac5be654e104e349287981fffd84a0f@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-9-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-9-afaerber@suse.de>
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

PiBBc3NvY2lhdGUgdGhlIFVBUlQgbm9kZXMgd2l0aCB0aGUgY29ycmVzcG9uZGluZyByZXNldCBj
b250cm9sbGVyIGJpdHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWFzIEbDpHJiZXIgPGFm
YWVyYmVyQHN1c2UuZGU+DQo+IC0tLQ0KPiAgdjE6IEZyb20gUlREMTE5NSB2NCBzZXJpZXMNCj4g
DQo+ICBhcmNoL2FybS9ib290L2R0cy9ydGQxMTk1LmR0c2kgfCAzICsrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL3J0ZDExOTUuZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL3J0ZDExOTUuZHRzaQ0KPiBpbmRl
eCA4ODY4NDVlNTIyMDUuLjA5YWNiOTkwODNjMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9v
dC9kdHMvcnRkMTE5NS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3J0ZDExOTUuZHRz
aQ0KPiBAQCAtOCw2ICs4LDcgQEANCj4gIC9tZW1yZXNlcnZlLyAweDE3ZmZmMDAwIDB4MDAwMDEw
MDA7DQo+IA0KPiAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2Fy
bS1naWMuaD4NCj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC9yZWFsdGVrLHJ0ZDExOTUu
aD4NCj4gDQo+ICAvIHsNCj4gIAljb21wYXRpYmxlID0gInJlYWx0ZWsscnRkMTE5NSI7DQo+IEBA
IC0xNzksNiArMTgwLDcgQEANCj4gIAkJcmVnID0gPDB4ODAwIDB4NDAwPjsNCj4gIAkJcmVnLXNo
aWZ0ID0gPDI+Ow0KPiAgCQlyZWctaW8td2lkdGggPSA8ND47DQo+ICsJCXJlc2V0cyA9IDwmaXNv
X3Jlc2V0IFJURDExOTVfSVNPX1JTVE5fVVIwPjsNCj4gIAkJY2xvY2stZnJlcXVlbmN5ID0gPDI3
MDAwMDAwPjsNCj4gIAkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAl9Ow0KPiBAQCAtMTkwLDYg
KzE5Miw3IEBADQo+ICAJCXJlZyA9IDwweDIwMCAweDEwMD47DQo+ICAJCXJlZy1zaGlmdCA9IDwy
PjsNCj4gIAkJcmVnLWlvLXdpZHRoID0gPDQ+Ow0KPiArCQlyZXNldHMgPSA8JnJlc2V0MiBSVEQx
MTk1X1JTVE5fVVIxPjsNCj4gIAkJY2xvY2stZnJlcXVlbmN5ID0gPDI3MDAwMDAwPjsNCj4gIAkJ
c3RhdHVzID0gImRpc2FibGVkIjsNCj4gIAl9Ow0KPiAtLQ0KPiAyLjE2LjQNCj4gDQo+IA0KQWNr
ZWQtYnk6IEphbWVzIFRhaSA8amFtZXMudGFpQHJlYWx0ZWsuY29tPg0KDQo=
