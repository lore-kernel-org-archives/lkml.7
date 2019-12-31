Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCEC2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E582206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 09:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLaJaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 04:30:55 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60036 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfLaJaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 04:30:55 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID xBV9UUbh030702, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS12.realtek.com.tw[172.21.6.16])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id xBV9UUbh030702
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Dec 2019 17:30:31 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTITCAS12.realtek.com.tw (172.21.6.16) with Microsoft SMTP Server (TLS) id
 14.3.468.0; Tue, 31 Dec 2019 17:30:30 +0800
Received: from RTEXMB03.realtek.com.tw (172.21.6.96) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 31 Dec 2019 17:30:30 +0800
Received: from RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d]) by
 RTEXMB03.realtek.com.tw ([fe80::71dc:5fb1:bef0:757d%8]) with mapi id
 15.01.1779.005; Tue, 31 Dec 2019 17:30:30 +0800
From:   James Tai <james.tai@realtek.com>
To:     =?utf-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 10/14] ARM: dts: rtd1195: Add SB2 and SCPU Wrapper syscon nodes
Thread-Topic: [PATCH 10/14] ARM: dts: rtd1195: Add SB2 and SCPU Wrapper syscon
 nodes
Thread-Index: AQHVqT1w3e0DCQM4MUy3rWx8/bISHqfUJzhw
Date:   Tue, 31 Dec 2019 09:30:30 +0000
Message-ID: <0f3c6ae55b524367913a68fe3f7faa47@realtek.com>
References: <20191202182205.14629-1-afaerber@suse.de>
 <20191202182205.14629-11-afaerber@suse.de>
In-Reply-To: <20191202182205.14629-11-afaerber@suse.de>
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

PiBBZGQgc3lzY29uIG1mZCBub2RlcyBmb3IgU0IyIGFuZCBTQ1BVIFdyYXBwZXIgdG8gUlREMTE5
NSBEVC4NCj4gDQo+IENjOiBKYW1lcyBUYWkgPGphbWVzLnRhaUByZWFsdGVrLmNvbT4NCj4gU2ln
bmVkLW9mZi1ieTogQW5kcmVhcyBGw6RyYmVyIDxhZmFlcmJlckBzdXNlLmRlPg0KPiAtLS0NCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL3J0ZDExOTUuZHRzaSB8IDE4ICsrKysrKysrKysrKysrKysrKw0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9ydGQxMTk1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9ydGQxMTk1
LmR0c2kNCj4gaW5kZXggMDlhY2I5OTA4M2MxLi4yMTg5NzIxMGQ5ZDAgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3J0ZDExOTUuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9ydGQxMTk1LmR0c2kNCj4gQEAgLTExOSw2ICsxMTksMTUgQEANCj4gIAkJCQlyYW5nZXMgPSA8
MHgwIDB4NzAwMCAweDEwMDA+Ow0KPiAgCQkJfTsNCj4gDQo+ICsJCQlzYjI6IHN5c2NvbkAxYTAw
MCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ICsJCQkJ
cmVnID0gPDB4MWEwMDAgMHgxMDAwPjsNCj4gKwkJCQlyZWctaW8td2lkdGggPSA8ND47DQo+ICsJ
CQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICsJ
CQkJcmFuZ2VzID0gPDB4MCAweDFhMDAwIDB4MTAwMD47DQo+ICsJCQl9Ow0KPiArDQo+ICAJCQlt
aXNjOiBzeXNjb25AMWIwMDAgew0KPiAgCQkJCWNvbXBhdGlibGUgPSAic3lzY29uIiwgInNpbXBs
ZS1tZmQiOw0KPiAgCQkJCXJlZyA9IDwweDFiMDAwIDB4MTAwMD47DQo+IEBAIC0xMjcsNiArMTM2
LDE1IEBADQo+ICAJCQkJI3NpemUtY2VsbHMgPSA8MT47DQo+ICAJCQkJcmFuZ2VzID0gPDB4MCAw
eDFiMDAwIDB4MTAwMD47DQo+ICAJCQl9Ow0KPiArDQo+ICsJCQlzY3B1X3dyYXBwZXI6IHN5c2Nv
bkAxZDAwMCB7DQo+ICsJCQkJY29tcGF0aWJsZSA9ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+
ICsJCQkJcmVnID0gPDB4MWQwMDAgMHgxMDAwPjsNCj4gKwkJCQlyZWctaW8td2lkdGggPSA8ND47
DQo+ICsJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJI3NpemUtY2VsbHMgPSA8MT47
DQo+ICsJCQkJcmFuZ2VzID0gPDB4MCAweDFkMDAwIDB4MTAwMD47DQo+ICsJCQl9Ow0KPiAgCQl9
Ow0KPiANCj4gIAkJZ2ljOiBpbnRlcnJ1cHQtY29udHJvbGxlckBmZjAxMTAwMCB7DQo+IC0tDQo+
IDIuMTYuNA0KPiANCj4gDQpBY2tlZC1ieTogSmFtZXMgVGFpIDxqYW1lcy50YWlAcmVhbHRlay5j
b20+DQoNCg==
