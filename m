Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24BBFCA9ECF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0518D208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 13:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfJaNMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 09:12:02 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:48832 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJaNMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 09:12:01 -0400
Received: from sntmail12r.snt-is.com (unknown [10.203.32.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 3B4B160CB06;
        Thu, 31 Oct 2019 14:11:58 +0100 (CET)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail12r.snt-is.com
 (10.203.32.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 31 Oct
 2019 14:11:57 +0100
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 31 Oct 2019 14:11:57 +0100
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] ARM: dts: imx6ul-kontron-n6310-s-43: Add missing
 includes for GPIOs and IRQs
Thread-Topic: [PATCH v2 11/11] ARM: dts: imx6ul-kontron-n6310-s-43: Add
 missing includes for GPIOs and IRQs
Thread-Index: AQHVjkv1caDmIh8k/USvzgDB9794sqd0qwcAgAABJwA=
Date:   Thu, 31 Oct 2019 13:11:57 +0000
Message-ID: <83173997-c3dd-319f-35bc-503485d80131@kontron.de>
References: <20191029112655.15058-1-frieder.schrempf@kontron.de>
 <20191029112655.15058-12-frieder.schrempf@kontron.de>
 <20191031130748.GC27967@pi3>
In-Reply-To: <20191031130748.GC27967@pi3>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <C6362DCFD56BBC4DA3EA755A016B9B8F@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 3B4B160CB06.AE926
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

T24gMzEuMTAuMTkgMTQ6MDcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9uIFR1ZSwg
T2N0IDI5LCAyMDE5IGF0IDExOjI4OjE2QU0gKzAwMDAsIFNjaHJlbXBmIEZyaWVkZXIgd3JvdGU6
DQo+PiBGcm9tOiBGcmllZGVyIFNjaHJlbXBmIDxmcmllZGVyLnNjaHJlbXBmQGtvbnRyb24uZGU+
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRnJpZWRlciBTY2hyZW1wZiA8ZnJpZWRlci5zY2hyZW1w
ZkBrb250cm9uLmRlPg0KPj4gRml4ZXM6IDFlYTRiNzZjZGZkZSAoIkFSTTogZHRzOiBpbXg2dWwt
a29udHJvbi1uNjMxMDogQWRkIEtvbnRyb24gaS5NWDZVTCBONjMxMCBTb00gYW5kIGJvYXJkcyIp
DQo+PiAtLS0NCj4+ICAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtcy00
My5kdHMgfCAzICsrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEwLXMt
NDMuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtcy00My5kdHMN
Cj4+IGluZGV4IDViYWQyOTY4M2NjMy4uMjk1YmMzMTM4ZmVhIDEwMDY0NA0KPj4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnVsLWtvbnRyb24tbjYzMTAtcy00My5kdHMNCj4+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZ1bC1rb250cm9uLW42MzEwLXMtNDMuZHRzDQo+PiBAQCAtNyw2
ICs3LDkgQEANCj4+ICAgDQo+PiAgICNpbmNsdWRlICJpbXg2dWwta29udHJvbi1uNjMxMC1zLmR0
cyINCj4+ICAgDQo+PiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVy
L2lycS5oPg0KPj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5ncy9ncGlvL2dwaW8uaD4NCj4gDQo+IFRo
aXMgaXMgbm90IG5lZWRlZC4gVGhpcyBpbmNsdWRlcyBpbXg2dWwta29udHJvbi1uNjMxMC1zLmR0
cywgd2hpY2gNCj4gaW5jbHVkZXMgaW14NnVsLWtvbnRyb24tbjYzMTAtc29tLmR0c2kgd2hpY2gg
aGFzIHByb3BlciBHUElPIGluY2x1ZGUuIEl0DQo+IGFsc28gcG9sbHMgaW14NnVsLmR0c2kgd2hp
Y2ggaGFzIHRoZSBJUlEgZGVmaW5lcy4NCj4gDQo+IE15IGNvbW1lbnQgZnJvbSB2MSB3YXMgZm9y
IGEgY2FzZSB3aGVyZSB5b3UgaGF2ZSBhIERUU0kgc3RhbmRpbmcgb24gaXRzDQo+IG93bi4gSWYg
aXQgZG9lcyBub3QgaW5jbHVkZSBhbnl0aGluZyBlbHNlLCB0aGVuIGl0IHNob3VsZCBoYXZlIGFs
bA0KPiBuZWNlc3NhcnkgaW5jbHVzaW9ucyAobm90IG9ubHkgR1BJTyBidXQgYWxzbyBpTVgtc3Bl
Y2lmaWMgcGluY3RybCBhbmQgY2xvY2spLg0KDQpPaywgZ290IGl0LiBUaGFua3MgZm9yIGNsYXJp
ZnlpbmcuDQpUaGlzIHBhdGNoIGNhbiBiZSBkcm9wcGVkIHRoZW4uDQoNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gS3J6eXN6dG9mDQo+IA0KPiANCj4+ICsNCj4+ICAgLyB7DQo+PiAgIAltb2RlbCA9
ICJLb250cm9uIE42MzEwIFMgNDMiOw0KPj4gICAJY29tcGF0aWJsZSA9ICJrb250cm9uLGlteDZ1
bC1uNjMxMC1zLTQzIiwgImtvbnRyb24saW14NnVsLW42MzEwLXMiLA0KPj4gLS0gDQo+PiAyLjE3
LjE=
