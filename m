Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A10DC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257E222CF4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 09:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfGZJsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 05:48:39 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:51456 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZJsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 05:48:39 -0400
Received: from sntmail14r.snt-is.com (unknown [10.203.32.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 0B4A967A878;
        Fri, 26 Jul 2019 11:48:33 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail14r.snt-is.com
 (10.203.32.184) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 26 Jul
 2019 11:48:32 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Fri, 26 Jul 2019 11:48:32 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
Thread-Topic: [PATCH v2 1/2] dt-bindings: vendor-prefixes: Add Admatec AG
Thread-Index: AQHVQ3nM8O6SL9DjWUGGlVFpIsOB6KbchhcA
Date:   Fri, 26 Jul 2019 09:48:32 +0000
Message-ID: <963ba555-dde0-9c3c-1e15-740ca200853f@kontron.de>
References: <20190726061705.14764-1-krzk@kernel.org>
In-Reply-To: <20190726061705.14764-1-krzk@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <FD3553CB4E67864AB93C592883C382A4@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 0B4A967A878.A18CA
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

T24gMjYuMDcuMTkgMDg6MTcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IEFkZCB2ZW5k
b3IgcHJlZml4IGZvciBBZG1hdGVjIEFHLg0KDQpXZSBnZXQgdGhlIGRpc3BsYXlzIHVzZWQgd2l0
aCB0aGUgS29udHJvbiBldmFsIGtpdHMgZnJvbSAiYWRtYXRlYyBHbWJIIiANCmluIEhhbWJ1cmcs
IG5vdCAiQWRtYXRlYyBBRyIgaW4gU3dpdHplcmxhbmQuIEkgdGhpbmsgd2UgaGF2ZSB0byANCmRp
ZmZlcmVudGlhdGUgaGVyZS4NCg0KSSB3aWxsIHJldmlldyBwYXRjaCAyLzIgc29vbi4uLg0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+
DQo+IA0KPiAtLS0NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IE5ldyBwYXRjaA0KPiAtLS0N
Cj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdmVuZG9yLXByZWZpeGVzLnlh
bWwgfCAyICsrDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4
ZXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4
ZXMueWFtbA0KPiBpbmRleCA2OTkyYmJiYmZmYWIuLjk0YzgxNmY3NDIwOSAxMDA2NDQNCj4gLS0t
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3ZlbmRvci1wcmVmaXhlcy55YW1s
DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92ZW5kb3ItcHJlZml4
ZXMueWFtbA0KPiBAQCAtNDMsNiArNDMsOCBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gICAgICAg
ZGVzY3JpcHRpb246IEFEIEhvbGRpbmdzIFBsYy4NCj4gICAgICJeYWRpLC4qIjoNCj4gICAgICAg
ZGVzY3JpcHRpb246IEFuYWxvZyBEZXZpY2VzLCBJbmMuDQo+ICsgICJeYWRtYXRlYywuKiI6DQo+
ICsgICAgZGVzY3JpcHRpb246IEFkbWF0ZWMgQUcNCj4gICAgICJeYWR2YW50ZWNoLC4qIjoNCj4g
ICAgICAgZGVzY3JpcHRpb246IEFkdmFudGVjaCBDb3Jwb3JhdGlvbg0KPiAgICAgIl5hZXJvZmxl
eGdhaXNsZXIsLioiOg0KPiA=
