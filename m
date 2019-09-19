Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B9CC49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A437B21927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfISHRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:17:48 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:39798 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbfISHRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:17:47 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id E59A367AB45;
        Thu, 19 Sep 2019 09:17:44 +0200 (CEST)
Received: from sntmail14r.snt-is.com (10.203.32.184) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Sep
 2019 09:17:44 +0200
Received: from sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8]) by
 sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8%3]) with mapi id
 15.01.1713.004; Thu, 19 Sep 2019 09:17:44 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "leonard.crestez@nxp.com" <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "ping.bai@nxp.com" <ping.bai@nxp.com>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "jun.li@nxp.com" <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "abel.vesa@nxp.com" <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Linux-imx@nxp.com" <Linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's ipg
 clk
Thread-Topic: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's
 ipg clk
Thread-Index: AQHVbqhJada8Xsj3oEetJoKRBs2eSKcyddCA
Date:   Thu, 19 Sep 2019 07:17:44 +0000
Message-ID: <c680d114-1c14-6bf8-226c-2fdd98350158@kontron.de>
References: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
 <1568869559-28611-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1568869559-28611-2-git-send-email-Anson.Huang@nxp.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <F14B5A1009A44548B13FE27527380192@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: E59A367AB45.A1B78
X-SnT-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-SnT-MailScanner-SpamCheck: 
X-SnT-MailScanner-From: frieder.schrempf@kontron.de
X-SnT-MailScanner-To: abel.vesa@nxp.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, angus@akkea.ca, anson.huang@nxp.com,
        ccaione@baylibre.com, daniel.baluta@nxp.com,
        daniel.lezcano@linaro.org, devicetree@vger.kernel.org,
        festevam@gmail.com, jun.li@nxp.com, kernel@pengutronix.de,
        l.stach@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, ping.bai@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5zb24sDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uLCB0aGF0IGlzIG5vdCBkaXJlY3RseSByZWxh
dGVkIHRvIHRoaXMgcGF0Y2guDQpJIHNlZSB0aGF0IGZvciB0aGUgdXNkaGMxIGFuZCB1c2RoYzMg
bm9kZXMsIHRoZXJlIGlzIGFuICdhc3NpZ25lZC1jbG9jaycgDQphbmQgJ2Fzc2lnbmVkLWNsb2Nr
LXJhdGVzJyBwcm9wZXJ0eSBidXQgbm90IGZvciB1c2RoYzIuIFRoZSBzYW1lIGFwcGxpZXMgDQp0
byB0aGUgbXg4bXEgYW5kIG14OG1uIGR0c2kgZmlsZS4NCg0KSXMgdGhlcmUgYW55IHJlYXNvbiBm
b3IgdGhpcz8gSWYgbm90IGNhbiB5b3UgZml4IGl0Pw0KDQpUaGFua3MsDQpGcmllZGVyDQoNCk9u
IDE5LjA5LjE5IDA3OjA1LCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gT24gaS5NWDhNTSwgdXNkaGMn
cyBpcGcgY2xvY2sgaXMgZnJvbSBJTVg4TU1fQ0xLX0lQR19ST09ULA0KPiBhc3NpZ24gaXQgZXhw
bGljaXRseSBpbnN0ZWFkIG9mIHVzaW5nIElNWDhNTV9DTEtfRFVNTVkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBBbnNvbiBIdWFuZyA8QW5zb24uSHVhbmdAbnhwLmNvbT4NCj4gLS0tDQo+ICAgYXJj
aC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgfCA2ICsrKy0tLQ0KPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRzaQ0KPiBpbmRleCA3YzRkY2NlLi44
YWFmYWQyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4
bW0uZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0uZHRz
aQ0KPiBAQCAtNjk0LDcgKzY5NCw3IEBADQo+ICAgCQkJCWNvbXBhdGlibGUgPSAiZnNsLGlteDht
bS11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMiOw0KPiAgIAkJCQlyZWcgPSA8MHgzMGI0MDAwMCAw
eDEwMDAwPjsNCj4gICAJCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDIyIElSUV9UWVBFX0xFVkVM
X0hJR0g+Ow0KPiAtCQkJCWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfRFVNTVk+LA0KPiArCQkJ
CWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfSVBHX1JPT1Q+LA0KPiAgIAkJCQkJIDwmY2xrIElN
WDhNTV9DTEtfTkFORF9VU0RIQ19CVVM+LA0KPiAgIAkJCQkJIDwmY2xrIElNWDhNTV9DTEtfVVNE
SEMxX1JPT1Q+Ow0KPiAgIAkJCQljbG9jay1uYW1lcyA9ICJpcGciLCAiYWhiIiwgInBlciI7DQo+
IEBAIC03MTAsNyArNzEwLDcgQEANCj4gICAJCQkJY29tcGF0aWJsZSA9ICJmc2wsaW14OG1tLXVz
ZGhjIiwgImZzbCxpbXg3ZC11c2RoYyI7DQo+ICAgCQkJCXJlZyA9IDwweDMwYjUwMDAwIDB4MTAw
MDA+Ow0KPiAgIAkJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMjMgSVJRX1RZUEVfTEVWRUxfSElH
SD47DQo+IC0JCQkJY2xvY2tzID0gPCZjbGsgSU1YOE1NX0NMS19EVU1NWT4sDQo+ICsJCQkJY2xv
Y2tzID0gPCZjbGsgSU1YOE1NX0NMS19JUEdfUk9PVD4sDQo+ICAgCQkJCQkgPCZjbGsgSU1YOE1N
X0NMS19OQU5EX1VTREhDX0JVUz4sDQo+ICAgCQkJCQkgPCZjbGsgSU1YOE1NX0NMS19VU0RIQzJf
Uk9PVD47DQo+ICAgCQkJCWNsb2NrLW5hbWVzID0gImlwZyIsICJhaGIiLCAicGVyIjsNCj4gQEAg
LTcyNCw3ICs3MjQsNyBAQA0KPiAgIAkJCQljb21wYXRpYmxlID0gImZzbCxpbXg4bW0tdXNkaGMi
LCAiZnNsLGlteDdkLXVzZGhjIjsNCj4gICAJCQkJcmVnID0gPDB4MzBiNjAwMDAgMHgxMDAwMD47
DQo+ICAgCQkJCWludGVycnVwdHMgPSA8R0lDX1NQSSAyNCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gLQkJCQljbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPiwNCj4gKwkJCQljbG9ja3Mg
PSA8JmNsayBJTVg4TU1fQ0xLX0lQR19ST09UPiwNCj4gICAJCQkJCSA8JmNsayBJTVg4TU1fQ0xL
X05BTkRfVVNESENfQlVTPiwNCj4gICAJCQkJCSA8JmNsayBJTVg4TU1fQ0xLX1VTREhDM19ST09U
PjsNCj4gICAJCQkJY2xvY2stbmFtZXMgPSAiaXBnIiwgImFoYiIsICJwZXIiOw0KPiA=
