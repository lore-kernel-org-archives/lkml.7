Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195DC10F00
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7CC2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 08:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="usY2ctcd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731383AbfB1I4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 03:56:06 -0500
Received: from mail-eopbgr20051.outbound.protection.outlook.com ([40.107.2.51]:33925
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbfB1I4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 03:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQGEMEop7jlak2hJPYjpjy0+TtVvy3nHgPKkC4TChYM=;
 b=usY2ctcdRtFpYVPf/XyARhBHarIoIr7Yerq81AdFjXP80tHi9S8Qk8rACm2iUq6r8lzuE4jnDIkA2FaRr6oMKFgf+0rXtHz3lBV13x4vBbM1vepd+HrCTy3q+0GwjqTh3UI65xPHBck7XtuH33WKBo/rnlGdd8LAFYi8z27Lbyc=
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com (52.133.37.151) by
 AM0PR0402MB3491.eurprd04.prod.outlook.com (52.133.48.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 08:56:00 +0000
Received: from AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec]) by AM0PR0402MB3905.eurprd04.prod.outlook.com
 ([fe80::e995:ae25:6f87:2bec%7]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 08:56:00 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: [PATCH 1/2] clk: imx7ulp: remove snvs clock
Thread-Topic: [PATCH 1/2] clk: imx7ulp: remove snvs clock
Thread-Index: AQHUz0NtVPRcCCKjzkOVq1EKU+GmAg==
Date:   Thu, 28 Feb 2019 08:56:00 +0000
Message-ID: <1551343889-6674-1-git-send-email-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.7.4
x-clientproxiedby: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To AM0PR0402MB3905.eurprd04.prod.outlook.com
 (2603:10a6:208:b::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=anson.huang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cd5753a7-0e15-4e59-bc9a-08d69d5a8f67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3491;
x-ms-traffictypediagnostic: AM0PR0402MB3491:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR0402MB3491;23:FyfEUaqIod99v7Skg1Glcvwsnr9u+KJp89utc?=
 =?iso-8859-1?Q?E6lX/S5S3cuXEc4J4UAO1JzzQQHvHkMBGYVPWRkxXeXBZMxxZX3S+1pnX0?=
 =?iso-8859-1?Q?Unr/7o6xNi8fzQR+HXqXSioScklSrSdISfl7z987uhHQRFGAn4eC0qiRIG?=
 =?iso-8859-1?Q?ZyX0C6ttnvcdjgcVIaDkntUClfN5YLZgleDmIJTwBYBCP9cQNRx8tqcIyz?=
 =?iso-8859-1?Q?2yvL2nCqF6KexfCfJjkuSBwKrAECHqXy6Q865CZstkEpVZFpuWeHbykpmF?=
 =?iso-8859-1?Q?FRL6y1CLRqPCdEsXACEeYidFHXI2gqnflE8y0CpxAP+uvO0/8iMIMYM7WI?=
 =?iso-8859-1?Q?7+flsUahE481HLSWiXO8D/5lkqitGnz9oI5iUZKqDkkWGTFWRhApUiWE3H?=
 =?iso-8859-1?Q?TgBcNOxehZqTiNXwM9J2eRY4qZYD6HhX4NrTZ3bh1Z3U9TuYNLpfWDg8op?=
 =?iso-8859-1?Q?tmgBE5AiK1pr05XWm6RxJdZwLOh12R/pdx6SKlneoKsPl1oHEZidFHtHY7?=
 =?iso-8859-1?Q?jyK2J05zH6wHbji+HYdaIFJGsoIoqIH4mhFBre4ukEBWcf4pPcW8mJCcTP?=
 =?iso-8859-1?Q?D+9+OShuO7GdAJ3KT0hE/154EDcmgH60NOsdZ04yolo3HDwqtEZNcD3ti0?=
 =?iso-8859-1?Q?d4DEGXi0Pokr363y1kjCVNx8JXbGK9Sygkvtbqwg1490k4MCRyT9ASy0qy?=
 =?iso-8859-1?Q?ri/7L7mw1CHXlL/WI3/FfcBdKGG2cywrVLBoVhk/Kpt5AE8t0HhAvLSwDi?=
 =?iso-8859-1?Q?QApZHF3Rhsj9Usm3sw/KKzocTxyeRUEV9zN8nAAIgCdS7PyIW1ZyA0iUV/?=
 =?iso-8859-1?Q?umhDANHejRrfO5OGiOaA7x6mQBqip8QIr/tguwm1XFX6LKG20AebZtvC0s?=
 =?iso-8859-1?Q?7GVVZK37zZFFnfPGjQ+oGTb0jSHn+fZnbCoWL+JmrZSceBDsHPsDkSRMQu?=
 =?iso-8859-1?Q?BWx8eOd1UPENfx9UCyvN5y3KPtjIEuGP6rGb7F9OG1hoUOthZLi83b7A14?=
 =?iso-8859-1?Q?OwmCKnqQkcR0ZKK2IhE2NKFqSnw2sKwyMp4KzVw72t02JKpkfYGLZYveqZ?=
 =?iso-8859-1?Q?dlSzBNSrNVKI6pMb01TrgiqYOg1IoQJDvN0Ud76pzO2iUCSPo0g2NLaAEC?=
 =?iso-8859-1?Q?MtK1FneZ4xu+vXAs93D+cEDOi5vbUSrt3YHOCn4wI16no96lQdgPaelVIj?=
 =?iso-8859-1?Q?OTT0H8Z2BT5N3o3uJ8YaA74Pp0rv4gdOoxQtCq+C+QmuQQX+qAV2TfFypD?=
 =?iso-8859-1?Q?wHAa0rWX8OPKCcT+WH4y9WungGWOl1BXLWe+DI4yA=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR0402MB349111072E897FAE8B934AC9F5750@AM0PR0402MB3491.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(256004)(4326008)(14444005)(2501003)(99286004)(2906002)(66066001)(52116002)(5660300002)(110136005)(71190400001)(2201001)(316002)(86362001)(25786009)(71200400001)(97736004)(3846002)(6116002)(478600001)(6436002)(8676002)(81156014)(81166006)(26005)(6486002)(106356001)(2616005)(105586002)(476003)(14454004)(6512007)(7416002)(486006)(186003)(7736002)(53936002)(6506007)(8936002)(386003)(102836004)(305945005)(50226002)(36756003)(68736007)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3491;H:AM0PR0402MB3905.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: R9gFGGH4uB8ASHKliDcrboyL55MnwrUijSDw9qXTzitc4QC2P+U8NhMm54en/GMu80bbjH6e37zfjbNS1gXLJYgUTb1bRE4JWSH8YTiAIeBtzJHFpECzs6jkIwg0ZPC8FRTTSq5oqx2NTeVuSCdL9fG/sGZQlBl94b81Np+OQiRJ03u/intRRIc7bq6q+bZnC5c6kCgYAQ7eIzk+DRUxVdSB7cwUe+treEhSw7EqJQyGHTsWT9aKCpf4LlTjQCk26Z5sNXBIIyJ48t+6HqE/R5WfIDxaGs2fdOIJGg03govK4YL4WXM7t1F2casYO3FdOFrwC8k74W0TJN7hsddmgxfeVp7csF2ZgxzTyJIJIeTLFMou5l+ao7H6nLgjP9IF2fBvGgz3y6B/BaLJ17Ch4LppFSjG3zCmnNh0231jrSc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5753a7-0e15-4e59-bc9a-08d69d5a8f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 08:55:54.8835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i.MX7ULP B0 chip, the SNVS module is moved into M4
domain and its clock is also moved into PCC0 which is
contorlled by M4, Linux kernel should NOT add it into
clock tree.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx7ulp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7ulp.c b/drivers/clk/imx/clk-imx7ulp.c
index ce30663..6668210 100644
--- a/drivers/clk/imx/clk-imx7ulp.c
+++ b/drivers/clk/imx/clk-imx7ulp.c
@@ -151,7 +151,6 @@ static void __init imx7ulp_clk_pcc2_init(struct device_=
node *np)
 	clks[IMX7ULP_CLK_DMA1]		=3D imx_clk_hw_gate("dma1", "nic1_clk", base + 0x=
20, 30);
 	clks[IMX7ULP_CLK_RGPIO2P1]	=3D imx_clk_hw_gate("rgpio2p1", "nic1_bus_clk"=
, base + 0x3c, 30);
 	clks[IMX7ULP_CLK_DMA_MUX1]	=3D imx_clk_hw_gate("dma_mux1", "nic1_bus_clk"=
, base + 0x84, 30);
-	clks[IMX7ULP_CLK_SNVS]		=3D imx_clk_hw_gate("snvs", "nic1_bus_clk", base =
+ 0x8c, 30);
 	clks[IMX7ULP_CLK_CAAM]		=3D imx_clk_hw_gate("caam", "nic1_clk", base + 0x=
90, 30);
 	clks[IMX7ULP_CLK_LPTPM4]	=3D imx7ulp_clk_composite("lptpm4",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x94);
 	clks[IMX7ULP_CLK_LPTPM5]	=3D imx7ulp_clk_composite("lptpm5",  periph_bus_=
sels, ARRAY_SIZE(periph_bus_sels), true, false, true, base + 0x98);
--=20
2.7.4

