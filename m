Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C56FCA9EC3
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF3F20830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbfJ2LcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:32:24 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:51404 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfJ2LcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:32:24 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id 703DF7CDEAF;
        Tue, 29 Oct 2019 12:32:17 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 29 Oct
 2019 12:32:17 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Tue, 29 Oct 2019 12:32:17 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] ARM: dts: imx6ul-kontron-n6310-s-43: Add missing
 includes for GPIOs and IRQs
Thread-Topic: [PATCH v2 11/11] ARM: dts: imx6ul-kontron-n6310-s-43: Add
 missing includes for GPIOs and IRQs
Thread-Index: AQHVjkv1caDmIh8k/USvzgDB9794sqdxa6wA
Date:   Tue, 29 Oct 2019 11:32:16 +0000
Message-ID: <baa2fd65-bd8b-cf76-9e9e-d01daf6b57a4@kontron.de>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
 <20191029112655.15058-12-frieder.schrempf@kontron.de>
In-Reply-To: <20191029112655.15058-12-frieder.schrempf@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CFBE93490D5BE4CA54C80D868C04CD1@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 703DF7CDEAF.A4761
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

T24gMjkuMTAuMTkgMTI6MjgsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6DQo+IEZyb206IEZyaWVk
ZXIgU2NocmVtcGYgPGZyaWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCg0KU29ycnksIHRoZSBj
b21taXQgbWVzc2FnZSBoZXJlIGdvdCBsb3N0Og0KDQpUaGUgSVJRIGFuZCBHUElPIG1hY3JvcyBh
cmUgdXNlZCBpbiB0aGlzIGZpbGUuIFRoZXJlZm9yZSB3ZSBhZGQgdGhlIA0KbWlzc2luZyBoZWFk
ZXIgaW5jbHVkZXMuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEZyaWVkZXIgU2NocmVtcGYgPGZy
aWVkZXIuc2NocmVtcGZAa29udHJvbi5kZT4NCj4gRml4ZXM6IDFlYTRiNzZjZGZkZSAoIkFSTTog
ZHRzOiBpbXg2dWwta29udHJvbi1uNjMxMDogQWRkIEtvbnRyb24gaS5NWDZVTCBONjMxMCBTb00g
YW5kIGJvYXJkcyIpDQo+IC0tLQ0KPiAgIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9u
LW42MzEwLXMtNDMuZHRzIHwgMyArKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24t
bjYzMTAtcy00My5kdHMgYi9hcmNoL2FybS9ib290L2R0cy9pbXg2dWwta29udHJvbi1uNjMxMC1z
LTQzLmR0cw0KPiBpbmRleCA1YmFkMjk2ODNjYzMuLjI5NWJjMzEzOGZlYSAxMDA2NDQNCj4gLS0t
IGEvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtcy00My5kdHMNCj4gKysr
IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtcy00My5kdHMNCj4gQEAg
LTcsNiArNyw5IEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgImlteDZ1bC1rb250cm9uLW42MzEwLXMu
ZHRzIg0KPiAgIA0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2lycS5oPg0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiArDQo+ICAg
LyB7DQo+ICAgCW1vZGVsID0gIktvbnRyb24gTjYzMTAgUyA0MyI7DQo+ICAgCWNvbXBhdGlibGUg
PSAia29udHJvbixpbXg2dWwtbjYzMTAtcy00MyIsICJrb250cm9uLGlteDZ1bC1uNjMxMC1zIiwN
Cj4g
