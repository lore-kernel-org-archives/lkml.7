Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202AAC04AB7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E769520879
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 01:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="azqV/TpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfEOB36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 21:29:58 -0400
Received: from mail-eopbgr150058.outbound.protection.outlook.com ([40.107.15.58]:16423
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726174AbfEOB35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 21:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4diZ8hrGb10riGKPDuQbxvNoJYPZSCRXCYI/nNHoRAE=;
 b=azqV/TpWFUqbx4qEu9e9mZskusB2O+xAS+hMhMBmqLrjWRWpCOWdZmzEUe8lxmBK2meK57lt88ODofxVQaQyNtrLKLIZZj1DgQFjIQPxUv3ITP72fg2Ti0fOD3E7pJFb00JcnAUnIEz2XLJJOwo0UE2ccf1B0Z/H3Rr62+iS7tc=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3724.eurprd04.prod.outlook.com (52.134.66.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.16; Wed, 15 May 2019 01:29:53 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1900.010; Wed, 15 May 2019
 01:29:53 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/3] dt-bindings: clock: imx8mm: Add SNVS clock
Thread-Topic: [PATCH 1/3] dt-bindings: clock: imx8mm: Add SNVS clock
Thread-Index: AQHVCr2yrHCSJQGcuE+Cdq63vYctyw==
Date:   Wed, 15 May 2019 01:29:53 +0000
Message-ID: <1557883490-22360-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR03CA0056.apcprd03.prod.outlook.com
 (2603:1096:202:17::26) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1b78dd3-d84c-4fc3-5974-08d6d8d4d449
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3724;
x-ms-traffictypediagnostic: DB3PR0402MB3724:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB3PR0402MB37243CEFA96016C41131A691F5090@DB3PR0402MB3724.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(316002)(256004)(50226002)(81166006)(14444005)(4326008)(6512007)(8936002)(71190400001)(6306002)(5660300002)(110136005)(71200400001)(52116002)(2906002)(86362001)(6506007)(386003)(68736007)(81156014)(25786009)(99286004)(102836004)(4744005)(36756003)(186003)(6116002)(3846002)(476003)(486006)(26005)(2201001)(2616005)(53936002)(64756008)(73956011)(66446008)(66476007)(66556008)(66946007)(2501003)(478600001)(966005)(14454004)(6436002)(305945005)(66066001)(7736002)(6486002)(8676002)(7416002)(921003)(32563001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3724;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pseOtm2w+0z5Ld0IrG/QGQqRFJk54VNDvOki4f15d8VC6Cz2bXiCRntJjM9Iq4BjMG9CyKvfcfkhnxom1RXNHiTqfnAJuWPTDp7YNUSpABRqWtoYPNLOd7NpkmQPf0daVVtk1RM77EiH1/0YjugCdMr36PHx36vv3M+GQ/OmMagpruJYpd3C0RGAh5TMe+Qo8hqRRCidM8X1GDiEbEcTc7OpYMuIyqxKXfDJ4f+z3Oaps+XPUr7lWecMMesO/OMBGWEWMQOcmJ3B2RhG4XbsFJbhj1eQSAMTLRZ4bQetIzlwSVqNglnPlDIguP7HaA54m4e8ebCtkr4fEU71GDuzAvlPN4TgWjFmwXvAd3dde1Jc7BMejKC47k7GasiBL+IeMPB6d2vPXUq0jNpo4OJcQmCWAgtbDM7NJHC42976KNw=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0B56FF142FDB6246A7385E3330CB0D7A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b78dd3-d84c-4fc3-5974-08d6d8d4d449
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 01:29:53.0370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro for the SNVS clock of the i.MX8MM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
This patch is based on patch: https://patchwork.kernel.org/patch/10939997/
---
 include/dt-bindings/clock/imx8mm-clock.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index fe47798..83f6673 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -245,6 +245,8 @@
 #define IMX8MM_CLK_GPIO4_ROOT			226
 #define IMX8MM_CLK_GPIO5_ROOT			227
=20
-#define IMX8MM_CLK_END				228
+#define IMX8MM_CLK_SNVS_ROOT			228
+
+#define IMX8MM_CLK_END				229
=20
 #endif
--=20
2.7.4

