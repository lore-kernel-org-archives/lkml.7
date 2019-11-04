Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08F9CA9ED3
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E56E205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 07:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfKDHlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 02:41:01 -0500
Received: from skedge04.snt-world.com ([91.208.41.69]:45378 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfKDHlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 02:41:01 -0500
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 6FFD76FE12D;
        Mon,  4 Nov 2019 08:40:56 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 4 Nov 2019
 08:40:55 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Mon, 4 Nov 2019 08:40:55 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 06/11] ARM: dts: imx6ul-kontron-n6x1x-s: Specify
 bus-width for SD card and eMMC
Thread-Topic: [PATCH v3 06/11] ARM: dts: imx6ul-kontron-n6x1x-s: Specify
 bus-width for SD card and eMMC
Thread-Index: AQHVj/bhrI8+Sinp0EmCHJdFZK6p5Kd6koeAgAADKYA=
Date:   Mon, 4 Nov 2019 07:40:55 +0000
Message-ID: <23694e57-029a-d8aa-b900-ef608ab2370e@kontron.de>
References: <20191031142112.12431-1-frieder.schrempf@kontron.de>
 <20191031142112.12431-7-frieder.schrempf@kontron.de>
 <20191104072936.GQ24620@dragon>
In-Reply-To: <20191104072936.GQ24620@dragon>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6E6C12BA347DF438E99A64D5025974A@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 6FFD76FE12D.A2056
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

T24gMDQuMTEuMTkgMDg6MjksIFNoYXduIEd1byB3cm90ZToNCj4gT24gVGh1LCBPY3QgMzEsIDIw
MTkgYXQgMDI6MjQ6MThQTSArMDAwMCwgU2NocmVtcGYgRnJpZWRlciB3cm90ZToNCj4+IEZyb206
IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+DQo+PiBC
b3RoLCB0aGUgU0QgY2FyZCBhbmQgdGhlIGVNTUMgYXJlIGNvbm5lY3RlZCB0byB0aGUgdXNkaGMg
Y29udHJvbGxlcg0KPj4gYnkgZm91ciBkYXRhIGxpbmVzLiBUaGVyZWZvcmUgd2Ugc2V0ICdidXMt
d2lkdGggPSA8ND4nIGZvciBib3RoDQo+PiBpbnRlcmZhY2VzLg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEZyaWVkZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4+IEZp
eGVzOiAxZWE0Yjc2Y2RmZGUgKCJBUk06IGR0czogaW14NnVsLWtvbnRyb24tbjYzMTA6IEFkZCBL
b250cm9uIGkuTVg2VUwgTjYzMTAgU29NIGFuZCBib2FyZHMiKQ0KPj4gLS0tDQo+PiAgIGFyY2gv
YXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42eDF4LXMuZHRzaSB8IDIgKysNCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9pbXg2dWwta29udHJvbi1uNngxeC1zLmR0c2kNCj4+IGluZGV4IDdjOThhMWE0NmZiMS4uMjI5
OWNhZDkwMGFmIDEwMDY0NA0KPj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRy
b24tbjZ4MXgtcy5kdHNpDQo+PiArKysgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJv
bi1uNngxeC1zLmR0c2kNCj4+IEBAIC0yMDksNiArMjA5LDcgQEANCj4+ICAgCXdha2V1cC1zb3Vy
Y2U7DQo+PiAgIAl2bW1jLXN1cHBseSA9IDwmcmVnXzN2Mz47DQo+PiAgIAl2b2x0YWdlLXJhbmdl
cyA9IDwzMzAwIDMzMDA+Ow0KPj4gKwlidXMtd2lkdGggPSA8ND47DQo+IA0KPiBJc24ndCBpdCBh
bHJlYWR5IHNldCBpbiBhcmNoL2FybS9ib290L2R0cy9pbXg2dWwuZHRzaSBhcyB0aGUgZGVmYXVs
dD8NCg0KUmlnaHQsIEkgc29tZWhvdyBtaXNzZWQgdGhpcy4gU28gdGhpcyBwYXRjaCBjYW4gYmUg
aWdub3JlZC4NCg0KPiANCj4gU2hhd24NCj4gDQo+PiAgIAluby0xLTgtdjsNCj4+ICAgCXN0YXR1
cyA9ICJva2F5IjsNCj4+ICAgfTsNCj4+IEBAIC0yMjMsNiArMjI0LDcgQEANCj4+ICAgCXdha2V1
cC1zb3VyY2U7DQo+PiAgIAl2bW1jLXN1cHBseSA9IDwmcmVnXzN2Mz47DQo+PiAgIAl2b2x0YWdl
LXJhbmdlcyA9IDwzMzAwIDMzMDA+Ow0KPj4gKwlidXMtd2lkdGggPSA8ND47DQo+PiAgIAluby0x
LTgtdjsNCj4+ICAgCXN0YXR1cyA9ICJva2F5IjsNCj4+ICAgfTsNCj4+IC0tIA0KPj4gMi4xNy4x
DQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0K
PiBsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdA0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsDQo+IA==
