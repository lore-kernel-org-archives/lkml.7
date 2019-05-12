Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968AAC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 615A22146F
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 10:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pplr2pZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfELKRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 06:17:15 -0400
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:60800
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfELKRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 06:17:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOPRo2eHC36xTG99awF8ld5DbNbRBboZQqG/BUMC+HM=;
 b=Pplr2pZrWQQ0e8oYpezNWEKWi6xYO3/AusdKfO+fwSg9n3zR+6slWS4QkeIc1bhZBxeBfQVWknQZLq8tYclHAkWD3t4L8ObWHxDfUKhnJqBVau4Z1zMmcdT8+hdDvk1cknAvdU+WVk3FIP3mUEUQYWOWjhlG/etkuMQwGPx28Vw=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (52.134.72.18) by
 DB3PR0402MB3946.eurprd04.prod.outlook.com (52.134.72.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Sun, 12 May 2019 10:17:08 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::d035:3bd0:a56a:189d%2]) with mapi id 15.20.1878.022; Sun, 12 May 2019
 10:17:08 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH RESEND 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Topic: [PATCH RESEND 1/3] dt-bindings: clock: imx8mm: Add GPIO clocks
Thread-Index: AQHVCKvbpEmt/hab6E+Z8qYp1xLf/g==
Date:   Sun, 12 May 2019 10:17:08 +0000
Message-ID: <1557655926-12915-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK0P153CA0044.APCP153.PROD.OUTLOOK.COM
 (2603:1096:203:17::32) To DB3PR0402MB3916.eurprd04.prod.outlook.com
 (2603:10a6:8:10::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b0667f3-7665-4187-7475-08d6d6c2fd57
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DB3PR0402MB3946;
x-ms-traffictypediagnostic: DB3PR0402MB3946:
x-microsoft-antispam-prvs: <DB3PR0402MB3946C401F813E43F3C2E92FEF50E0@DB3PR0402MB3946.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0035B15214
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(39860400002)(366004)(136003)(199004)(189003)(52116002)(2906002)(110136005)(386003)(102836004)(14454004)(478600001)(4326008)(8936002)(2501003)(68736007)(99286004)(6486002)(25786009)(50226002)(66066001)(3846002)(7416002)(53936002)(6116002)(14444005)(66946007)(256004)(66476007)(64756008)(66446008)(66556008)(73956011)(7736002)(486006)(305945005)(5660300002)(2616005)(476003)(71190400001)(71200400001)(26005)(186003)(4744005)(86362001)(2201001)(8676002)(6436002)(81166006)(6506007)(36756003)(316002)(81156014)(6512007)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3946;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2CRxnPPJDX9Jii5V4Smmn6vIW+9yHsqAExk8pzfitrbXnhQYGgM9PCWVGeo4oiLDGHM8lUSlhLQ47QzpqIrDJy1qUGRcFlOHHWVQCAkmNL7jykBuBum+03qdc/1rUBPaZu3YGEt+JTOSa6TyqcJ7Pmbfnh1D9oJkPEBa975LYnhLKGbe2WtapdJqFvuODGBgcnsaW3bnGBBqKoHnPDTbBPruwNaWMymMg1HElBLrmR8qILGe6aj0jgaTv5lolRxMkITqgBeH/DEMwZGbGMA/+G4YoIYaG8nvyKRn7gZQkiTEiI+Ii4ANWsGehTkI5ie+3lXKIF4G1KV0GLLEFs01GFXwwA6J0BuRVU7ENnIi/YTmobU8PKEcpCdypoBywjb1eavbvAVEyGr+XsxHQnBMo3kJx0NeZqLUMoh4fI9IODg=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <08E01C7B0B1DA14D9F5AB10C0C2AF991@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0667f3-7665-4187-7475-08d6d6c2fd57
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2019 10:17:08.6263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3946
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macro for the GPIO clocks of the i.MX8MM.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
---
No change, just resend patch with correct encoding.
---
 include/dt-bindings/clock/imx8mm-clock.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index 1b4353e..fe47798 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -239,6 +239,12 @@
=20
 #define IMX8MM_CLK_NAND_USDHC_BUS_RAWNAND_CLK	222
=20
-#define IMX8MM_CLK_END				223
+#define IMX8MM_CLK_GPIO1_ROOT			223
+#define IMX8MM_CLK_GPIO2_ROOT			224
+#define IMX8MM_CLK_GPIO3_ROOT			225
+#define IMX8MM_CLK_GPIO4_ROOT			226
+#define IMX8MM_CLK_GPIO5_ROOT			227
+
+#define IMX8MM_CLK_END				228
=20
 #endif
--=20
2.7.4

