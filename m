Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA56AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6EFB21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 10:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389134AbfISKEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 06:04:43 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:60388 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388956AbfISKEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 06:04:43 -0400
Received: from sntmail10s.snt-is.com (unknown [10.203.32.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 7B5A667B344;
        Thu, 19 Sep 2019 12:04:41 +0200 (CEST)
Received: from sntmail14r.snt-is.com (10.203.32.184) by sntmail10s.snt-is.com
 (10.203.32.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Sep
 2019 12:04:41 +0200
Received: from sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8]) by
 sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8%3]) with mapi id
 15.01.1713.004; Thu, 19 Sep 2019 12:04:40 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, Jun Li <jun.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's ipg
 clk
Thread-Topic: [PATCH 2/3] arm64: dts: imx8mm: Use correct clock for usdhc's
 ipg clk
Thread-Index: AQHVbqhJada8Xsj3oEetJoKRBs2eSKcyddCAgAAlboCAAAk3AA==
Date:   Thu, 19 Sep 2019 10:04:40 +0000
Message-ID: <c1c08d49-3473-b4b1-4ed1-f30276ffbbf1@kontron.de>
References: <1568869559-28611-1-git-send-email-Anson.Huang@nxp.com>
 <1568869559-28611-2-git-send-email-Anson.Huang@nxp.com>
 <c680d114-1c14-6bf8-226c-2fdd98350158@kontron.de>
 <DB3PR0402MB3916B0DE9EBC0B0F6664CE34F5890@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB3916B0DE9EBC0B0F6664CE34F5890@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <2798A0465DE2B140910482FC94ED1272@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 7B5A667B344.AF6E0
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

SGkgQW5zb24sDQoNCk9uIDE5LjA5LjE5IDExOjMxLCBBbnNvbiBIdWFuZyB3cm90ZToNCj4gSGks
IFNjaHJlbXBmDQo+IA0KPj4gSGkgQW5zb24sDQo+Pg0KPj4gSSBoYXZlIGEgcXVlc3Rpb24sIHRo
YXQgaXMgbm90IGRpcmVjdGx5IHJlbGF0ZWQgdG8gdGhpcyBwYXRjaC4NCj4+IEkgc2VlIHRoYXQg
Zm9yIHRoZSB1c2RoYzEgYW5kIHVzZGhjMyBub2RlcywgdGhlcmUgaXMgYW4gJ2Fzc2lnbmVkLWNs
b2NrJw0KPj4gYW5kICdhc3NpZ25lZC1jbG9jay1yYXRlcycgcHJvcGVydHkgYnV0IG5vdCBmb3Ig
dXNkaGMyLiBUaGUgc2FtZSBhcHBsaWVzIHRvDQo+PiB0aGUgbXg4bXEgYW5kIG14OG1uIGR0c2kg
ZmlsZS4NCj4+DQo+PiBJcyB0aGVyZSBhbnkgcmVhc29uIGZvciB0aGlzPyBJZiBub3QgY2FuIHlv
dSBmaXggaXQ/DQo+IA0KPiBUaGlzIHBhdGNoIHNlcmllcyBpcyBOT1QgcmVsYXRlZCB0byAnYXNz
aWduZWQtY2xvY2snIG9yICdhc3NpZ25lZC1jbG9jay1yYXRlcycNCj4gcHJvcGVydHksDQoNClRo
YXQncyBleGFjdGx5IHdoYXQgSSdtIHNheWluZy4gVG8gbm90IGNhdXNlIG1vcmUgY29uZnVzaW9u
LCBJIGhhdmUgc2VudCANCmEgbWVzc2FnZSBpbiBhIG5ldyB0aHJlYWQ6IA0KaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFybS1rZXJuZWwvMjAxOS1TZXB0ZW1iZXIv
NjgxNDI2Lmh0bWwNCg0KPiBpdCBpcyBqdXN0IGZvciBjb3JyZWN0aW5nIGNsb2NrIHNvdXJjZSBh
Y2NvcmRpbmcgdG8gcmVmZXJlbmNlIG1hbnVhbCwNCj4gdGhlICdpcGcnIGNsb2NrIGlzIGZyb20g
c3lzdGVtJ3MgSVBHX1JPT1QgY2xvY2sgYWNjb3JkaW5nIHRvIHJlZmVyZW5jZSBtYW51YWwgQ0NN
DQo+IGNoYXB0ZXIsIHVzaW5nIERVTU1ZIGNsb2NrIGlzIE5PVCBhIGdvb2Qgb3B0aW9uLCB0aGUg
J2lwZycgY2xvY2sgaXMgc3VwcG9zZWQNCj4gdG8gYmUgdGhlIGNsb2NrIGZvciBhY2Nlc3Npbmcg
cmVnaXN0ZXIsIGFuZCBpdCBzaG91bGQgTk9UIGJlIERVTU1ZIGlmIHdlIGtub3cNCj4gd2hhdCBl
eGFjdGx5IHRoZSBjbG9jayBzb3VyY2UgaXMgdXNlZC4NCg0KVGhhdCdzIHByb2JhYmx5IHJpZ2h0
IGFuZCBJIGRpZG4ndCBtZWFuIHRvIHF1ZXN0aW9uIHRoZSBwYXRjaCBhdCBhbGwuDQoNClRoYW5r
cywNCkZyaWVkZXI=
