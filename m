Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4514CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59F0218BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfKDHxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:53:52 -0500
Received: from skedge03.snt-world.com ([91.208.41.68]:46402 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:53:52 -0500
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 80CC660CAEC;
        Mon,  4 Nov 2019 08:53:46 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 08:53:46 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 08:53:46 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 08/11] ARM: dts: imx6ul-kontron-n6x1x-s: Remove an
 obsolete comment and fix indentation
Thread-Topic: [PATCH v3 08/11] ARM: dts: imx6ul-kontron-n6x1x-s: Remove an
 obsolete comment and fix indentation
Thread-Index: AQHVj/blw8f6Q1Cpm0KB/jM6FijR+6d6k4aAgAAFwIA=
Date:   Mon, 4 Nov 2019 07:53:45 +0000
Message-ID: <a0c4f2cf-a7dd-c112-331d-31bc52482a25@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-9-frieder.schrempf@kontron.de>
 <20191104073310.GS24620@dragon>
In-Reply-To: <20191104073310.GS24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B9C990A48851B429ABA03B829CE7F76@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 80CC660CAEC.A0963
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDQuMTEuMTkgMDg6MzMsIFNoYXduIEd1byB3cm90ZToNCj4gT24gVGh1LCBPY3QgMzEsIDIw
MTkgYXQgMDI6MjQ6MjRQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEZyb206
IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBU
aGUgRUNTUEkxIGlzIG5vdCB1c2VkIGZvciBhIEZSQU0gY2hpcCwgc28gcmVtb3ZlIHRoZSBjb21t
ZW50Lg0KPj4gV2hpbGUgYXQgaXQsIGFsc28gY2hhbmdlIHNvbWUgd2hpdGVzcGFjZXMgdG8gdGFi
cyB0byBjb21wbHkgd2l0aCB0aGUNCj4+IGluZGVudGF0aW9uIHN0eWxlIG9mIHRoZSByZXN0IG9m
IHRoZSBmaWxlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVk
ZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+IEZpeGVzOiAxZWE0Yjc2Y2RmZGUgKCJBUk06IGR0
czogaW14NnVsLWtvbnRyb24tbjYzMTA6IEFkZCBLb250cm9uIGkuTVg2VUwgTjYzMTAgU29NIGFu
ZCBib2FyZHMiKQ0KPiANCj4gSXQncyBub3QgYSBidWcgZml4Lg0KDQpSaWdodC4NCg0KPiANCj4g
U2hhd24NCj4gDQo+PiAtLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24t
bjZ4MXgtcy5kdHNpIHwgMTMgKysrKysrLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0c2kNCj4+IGluZGV4IGQzZWIyMWFhOTAxNC4uZTE4
YThiZDIzOWJlIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRy
b24tbjZ4MXgtcy5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJv
bi1uNngxeC1zLmR0c2kNCj4+IEBAIC0yNTYsNyArMjU2LDYgQEANCj4+ICAgCQk+Ow0KPj4gICAJ
fTsNCj4+ICAgDQo+PiAtCS8qIEZSQU0gKi8NCj4+ICAgCXBpbmN0cmxfZWNzcGkxOiBlY3NwaTFn
cnAgew0KPj4gICAJCWZzbCxwaW5zID0gPA0KPj4gICAJCQlNWDZVTF9QQURfQ1NJX0RBVEEwN19f
RUNTUEkxX01JU08JMHgxMDBiMQ0KPj4gQEAgLTI4MSw4ICsyODAsOCBAQA0KPj4gICANCj4+ICAg
CXBpbmN0cmxfZW5ldDJfbWRpbzogZW5ldDJtZGlvZ3JwIHsNCj4+ICAgCQlmc2wscGlucyA9IDwN
Cj4+IC0JCQlNWDZVTF9QQURfR1BJTzFfSU8wN19fRU5FVDJfTURDICAgICAgICAgMHgxYjBiMA0K
Pj4gLQkJCU1YNlVMX1BBRF9HUElPMV9JTzA2X19FTkVUMl9NRElPICAgICAgICAweDFiMGIwDQo+
PiArCQkJTVg2VUxfUEFEX0dQSU8xX0lPMDdfX0VORVQyX01EQwkJMHgxYjBiMA0KPj4gKwkJCU1Y
NlVMX1BBRF9HUElPMV9JTzA2X19FTkVUMl9NRElPCTB4MWIwYjANCj4+ICAgCQk+Ow0KPj4gICAJ
fTsNCj4+ICAgDQo+PiBAQCAtMjk1LDEwICsyOTQsMTAgQEANCj4+ICAgDQo+PiAgIAlwaW5jdHJs
X2dwaW86IGdwaW9ncnAgew0KPj4gICAJCWZzbCxwaW5zID0gPA0KPj4gLQkJCU1YNlVMX1BBRF9T
TlZTX1RBTVBFUjVfX0dQSU81X0lPMDUJMHgxYjBiMCAvKiBET1VUMSAqLw0KPj4gLQkJCU1YNlVM
X1BBRF9TTlZTX1RBTVBFUjRfX0dQSU81X0lPMDQJMHgxYjBiMCAvKiBESU4xICovDQo+PiAtCQkJ
TVg2VUxfUEFEX1NOVlNfVEFNUEVSMV9fR1BJTzVfSU8wMQkweDFiMGIwIC8qIERPVVQyICovDQo+
PiAtCQkJTVg2VUxfUEFEX1NOVlNfVEFNUEVSMF9fR1BJTzVfSU8wMAkweDFiMGIwIC8qIERJTjIg
Ki8NCj4+ICsJCQlNWDZVTF9QQURfU05WU19UQU1QRVI1X19HUElPNV9JTzA1CTB4MWIwYjAJLyog
RE9VVDEgKi8NCj4+ICsJCQlNWDZVTF9QQURfU05WU19UQU1QRVI0X19HUElPNV9JTzA0CTB4MWIw
YjAJLyogRElOMSAqLw0KPj4gKwkJCU1YNlVMX1BBRF9TTlZTX1RBTVBFUjFfX0dQSU81X0lPMDEJ
MHgxYjBiMAkvKiBET1VUMiAqLw0KPj4gKwkJCU1YNlVMX1BBRF9TTlZTX1RBTVBFUjBfX0dQSU81
X0lPMDAJMHgxYjBiMAkvKiBESU4yICovDQo+PiAgIAkJPjsNCj4+ICAgCX07DQo+PiAgIA0KPj4g
LS0gDQo+PiAyLjE3LjE=
