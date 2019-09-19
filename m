Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A47AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5A9207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389027AbfISJ44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:56:56 -0400
Received: from skedge03.snt-world.com ([91.208.41.68]:57976 "EHLO
        skedge03.snt-world.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388819AbfISJ44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:56:56 -0400
Received: from sntmail11s.snt-is.com (unknown [10.203.32.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by skedge03.snt-world.com (Postfix) with ESMTPS id 13C5767B341;
        Thu, 19 Sep 2019 11:56:52 +0200 (CEST)
Received: from sntmail14r.snt-is.com (10.203.32.184) by sntmail11s.snt-is.com
 (10.203.32.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 19 Sep
 2019 11:56:51 +0200
Received: from sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8]) by
 sntmail14r.snt-is.com ([fe80::c8f3:eae9:52c2:11a8%3]) with mapi id
 15.01.1713.004; Thu, 19 Sep 2019 11:56:51 +0200
From:   Schrempf Frieder <frieder.schrempf@kontron.de>
To:     Anson Huang <Anson.Huang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Missing 'assigned-clocks' in usdhc node of i.MX8MQ/MM/MN dtsi?
Thread-Topic: Missing 'assigned-clocks' in usdhc node of i.MX8MQ/MM/MN dtsi?
Thread-Index: AQHVbtCPIpmeLD1Wgkq8yfUNmKVWtQ==
Date:   Thu, 19 Sep 2019 09:56:51 +0000
Message-ID: <e6ce599e-597a-6f67-d5d1-5487f50c7d0d@kontron.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.9.193]
x-c2processedorg: 51b406b7-48a2-4d03-b652-521f56ac89f3
Content-Type: text/plain; charset="utf-8"
Content-ID: <000AF8B8BF44EA4F81E89ED1E2CF7D13@snt-world.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SnT-MailScanner-Information: Please contact the ISP for more information
X-SnT-MailScanner-ID: 13C5767B341.A2528
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

SGksDQoNCkkgd29uZGVyIHdoeSBpbXg4bXEuZHRzaSwgaW14OG1tLmR0c2kgYW5kIGlteDhtbi5k
dHNpIGhhdmUgDQonYXNzaWduZWQtY2xvY2tzJyBhbmQgJ2Fzc2lnbmVkLWNsb2NrLXJhdGVzJyBz
ZXQgZm9yIGFsbCB1c2RoYyBub2RlcywgDQpleGNlcHQgZm9yIHVzZGhjMi4NCg0KSXMgdGhpcyBv
biBwdXJwb3NlPyBJcyBpdCBhIGZsYXc/DQoNClRoYW5rcywNCkZyaWVkZXINCg0KRXh0cmFjdCBm
cm9tIGlteDhtbS5kdHNpOg0KDQp1c2RoYzE6IG1tY0AzMGI0MDAwMCB7DQoJWy4uLl0NCglhc3Np
Z25lZC1jbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX1VTREhDMT47DQoJYXNzaWduZWQtY2xvY2st
cmF0ZXMgPSA8NDAwMDAwMDAwPjsNCglbLi4uXQ0KfTsNCg0KdXNkaGMyOiBtbWNAMzBiNTAwMDAg
ew0KCWNvbXBhdGlibGUgPSAiZnNsLGlteDhtbS11c2RoYyIsICJmc2wsaW14N2QtdXNkaGMiOw0K
CXJlZyA9IDwweDMwYjUwMDAwIDB4MTAwMDA+Ow0KCWludGVycnVwdHMgPSA8R0lDX1NQSSAyMyBJ
UlFfVFlQRV9MRVZFTF9ISUdIPjsNCgljbG9ja3MgPSA8JmNsayBJTVg4TU1fQ0xLX0RVTU1ZPiwN
CgkJIDwmY2xrIElNWDhNTV9DTEtfTkFORF9VU0RIQ19CVVM+LA0KCQkgPCZjbGsgSU1YOE1NX0NM
S19VU0RIQzJfUk9PVD47DQoJY2xvY2stbmFtZXMgPSAiaXBnIiwgImFoYiIsICJwZXIiOw0KCWZz
bCx0dW5pbmctc3RhcnQtdGFwID0gPDIwPjsNCglmc2wsdHVuaW5nLXN0ZXA9IDwyPjsNCglidXMt
d2lkdGggPSA8ND47DQoJc3RhdHVzID0gImRpc2FibGVkIjsNCn07DQoNCnVzZGhjMzogbW1jQDMw
YjYwMDAwIHsNCglbLi4uXQ0KCWFzc2lnbmVkLWNsb2NrcyA9IDwmY2xrIElNWDhNTV9DTEtfVVNE
SEMzX1JPT1Q+Ow0KCWFzc2lnbmVkLWNsb2NrLXJhdGVzID0gPDQwMDAwMDAwMD47DQoJWy4uLl0N
Cn07DQo=
