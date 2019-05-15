Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424A4C04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C1C20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mWXbE5uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEOBJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:09:30 -0400
Received: from mail-eopbgr40064.outbound.protection.outlook.com ([40.107.4.64]:39045
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbfEOBJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:09:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlaZHZlW9EYYSPZqa9cgIB0Ac0/aHzBRg9/HrsxiOVg=;
 b=mWXbE5uqq8yY6x+8fx6Bp14gHj5DW6QX6DRrK+jnygdXaS+U8Rjok+kZ9pI0xTUqs1K1W6y/g9qnErLe2KuEbRUe/olbiCyfagfr9aA0GKZ5H0t6kwzQNYpWBrBMBeSGe0G5FwXwgSuZnKtDT/fIUgexmQEBakADGhWSy/r7Xbs=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3675.eurprd04.prod.outlook.com (52.134.69.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 01:09:24 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 01:09:24 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Abel Vesa <abel.vesa@nxp.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: clock: imx8mq: Add SNVS clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mq: Add SNVS clock
Thread-Index: AQHVCrrVEeSa7rFIWkyl1S849ZKcvw==
Date:   Wed, 15 May 2019 01:09:24 +0000
Message-ID: <1557882259-3353-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR06CA0022.apcprd06.prod.outlook.com
 (2603:1096:202:2e::34) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8cfd6b46-1b1f-4329-5c13-08d6d8d1f7c2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3675;
x-ms-traffictypediagnostic: DB3PR0402MB3675:
x-microsoft-antispam-prvs: <DB3PR0402MB36750998907AD738DF3CD878F5090@DB3PR0402MB3675.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(386003)(6506007)(26005)(7736002)(305945005)(68736007)(81166006)(99286004)(81156014)(73956011)(66946007)(8676002)(52116002)(186003)(4744005)(5660300002)(486006)(102836004)(36756003)(476003)(2616005)(71200400001)(71190400001)(256004)(14444005)(2906002)(66476007)(6116002)(6486002)(6436002)(316002)(3846002)(6512007)(478600001)(14454004)(66446008)(64756008)(66556008)(8936002)(50226002)(110136005)(2501003)(7416002)(53936002)(25786009)(86362001)(4326008)(66066001)(2201001)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3675;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uiCdCT17QpS3pQGtbERpPCuZKHqGoCh0UfFCYg/yelJFeFuYH5Iwczyf35uNjel/sbCKHiCdiy9FvW5jOcdTOy5A4m9sZGvubSb5vchrv/jBEMfAelYlkQT+RGDbhCrD3xpIZhPiCoVaeTtDg6DuElXYgI8qkYBjWhoGESwduoay/r8zI1CJcrN9GJ43AvKJ/8n0JMueNAHyPr11cK4jo19wJbVf1b/V6l3bxAR6jCXGj1vKsBlvjHeCgxlgt/bTZunoF5ArOwxC1fsAa3giwJrlFMjy4CpFaqW9QAx0CT8OazJPGmt1wuuvWcaPwNCfbUolB7ZZ15hjeRB/uPIsQ+dT4kMDChXo2AdEZfuZF6QjGH0PT6gCWh+XJEDa0GdhApRiOMXwogs0dYkhq/6EVZedZQPN3MGIP1r0B6lj89k=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F79890AAE8E69040BD66092F454597A8@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cfd6b46-1b1f-4329-5c13-08d6d8d1f7c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 01:09:24.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro for the SNVS clock of the i.MX8MQ.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 include/dt-bindings/clock/imx8mq-clock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mq-clock.h b/include/dt-bindings=
/clock/imx8mq-clock.h
index 6677e92..0233bb1 100644
--- a/include/dt-bindings/clock/imx8mq-clock.h
+++ b/include/dt-bindings/clock/imx8mq-clock.h
@@ -400,5 +400,7 @@
 #define IMX8MQ_CLK_GPIO4_ROOT			262
 #define IMX8MQ_CLK_GPIO5_ROOT			263
=20
-#define IMX8MQ_CLK_END				264
+#define IMX8MQ_CLK_SNVS_ROOT			264
+
+#define IMX8MQ_CLK_END				265
 #endif /* __DT_BINDINGS_CLOCK_IMX8MQ_H */
--=20
2.7.4

