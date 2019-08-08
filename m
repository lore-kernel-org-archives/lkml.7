Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D9DC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 676E921743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 18:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbfHHSJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 14:09:11 -0400
Received: from skedge04.snt-world.com ([91.208.41.69]:53206 "EHLO
        skedge04.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727096AbfHHSJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 14:09:11 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge04.snt-world.com (Postfix) with ESMTPS id C03B467A8D8;
        Thu,  8 Aug 2019 20:09:05 +0200 (CEST)
Received: from sntmail12r.snt-is.com (10.203.32.182) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 8 Aug 2019
 20:09:05 +0200
Received: from sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305]) by
 sntmail12r.snt-is.com ([fe80::e551:8750:7bba:3305%3]) with mapi id
 15.01.1713.004; Thu, 8 Aug 2019 20:09:05 +0200
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
CC:     "notify@kernel.org" <notify@kernel.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Thread-Topic: [PATCH v4 2/3] dt-bindings: eeprom: at25: Add Anvo ANV32E61W
Thread-Index: AQHVTg5uKuaOwni6qUqr2zRHpkgjtKbxaxUA
Date:   Thu, 8 Aug 2019 18:09:05 +0000
Message-ID: <de032954-2b6e-5aa9-0d91-c37417c8e162@kontron.de>
References: <20190808172616.11728-1-krzk@kernel.org>
 <20190808172616.11728-2-krzk@kernel.org>
In-Reply-To: <20190808172616.11728-2-krzk@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C7E3CA83525024C90313252A9756400@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: C03B467A8D8.A186B
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: devicetree@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        notify@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDguMTkgMTk6MjYsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IERvY3VtZW50
IHRoZSBjb21wYXRpYmxlIGZvciBBTlYzMkU2MVcgRUVQUk9NIGNoaXAuDQoNClRoaXMgY2hpcCBp
cyBhY3R1YWxseSBub3QgYW4gRUVQUk9NLCBidXQgYSBTUEkgbnZTUkFNLiBJdCBjYW4gYmUgDQpp
bnRlcmZhY2VkIGJ5IHRoZSBhdDI1IGRyaXZlciBzaW1pbGFyIHRvIGFuIEVFUFJPTS4gVGhpcyBp
cyBub3QgdGhlIA0KaWRlYWwgc29sdXRpb24sIGJ1dCBpdCB3b3JrcyB1bnRpbCB0aGVyZSdzIGEg
cHJvcGVyIGRyaXZlciBmb3Igc3VjaCANCmNoaXBzLiBNYXliZSB5b3UgY2FuIGFkZCBzb21lIG9m
IHRoZXNlIGRldGFpbHMgdG8gdGhlIGNvbW1pdCBtZXNzYWdlIA0KaGVyZS4gQWxzbyB0aGVyZSBp
cyBtb3JlIGluZm9ybWF0aW9uIG9uIHRoaXMgdG9waWMgaGVyZTogDQpodHRwczovL3BhdGNod29y
ay5vemxhYnMub3JnL3BhdGNoLzEwNDM5NTAvLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IFJldmlld2VkLWJ5OiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IA0KPiAtLS0NCj4gDQo+IE5ldyBwYXRjaA0K
PiAtLS0NCj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZWVwcm9tL2F0MjUu
dHh0IHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VlcHJvbS9hdDI1LnR4
dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZXByb20vYXQyNS50eHQNCj4g
aW5kZXggYjNiZGU5N2RjMTk5Li40MjU3N2RkMTEzZGQgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9lZXByb20vYXQyNS50eHQNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2VlcHJvbS9hdDI1LnR4dA0KPiBAQCAtMyw2ICsz
LDcgQEAgRUVQUk9NcyAoU1BJKSBjb21wYXRpYmxlIHdpdGggQXRtZWwgYXQyNS4NCj4gICBSZXF1
aXJlZCBwcm9wZXJ0aWVzOg0KPiAgIC0gY29tcGF0aWJsZSA6IFNob3VsZCBiZSAiPHZlbmRvcj4s
PHR5cGU+IiwgYW5kIGdlbmVyaWMgdmFsdWUgImF0bWVsLGF0MjUiLg0KPiAgICAgRXhhbXBsZSAi
PHZlbmRvcj4sPHR5cGU+IiB2YWx1ZXM6DQo+ICsgICAgImFudm8sYW52MzJlNjF3Ig0KPiAgICAg
ICAibWljcm9jaGlwLDI1bGMwNDAiDQo+ICAgICAgICJzdCxtOTVtMDIiDQo+ICAgICAgICJzdCxt
OTUyNTYiDQo+IA==
