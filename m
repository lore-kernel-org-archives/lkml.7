Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8F5C73C68
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B82020645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ElPFEvgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfGJENq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:13:46 -0400
Received: from mail-eopbgr150081.outbound.protection.outlook.com ([40.107.15.81]:52030
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfGJENn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cgc0G8QrBlss85FuBtnb8WhTAc34pLGCv84LZclZDUg=;
 b=ElPFEvgUF3uwsjfX2uABYhExCsgeDIRRcpQqRBh6mR1wCENtYT6Aq0ELhURM9CxMYKKIDr7ieGRf13fQk5rabk7meTo66GeB+JskPGr2fkUVPJNJ1n/DRenwvtJAh39ht3Q2R0BB2GbJFTB70DnkacLybXHdNAkHBplyq/nsP/w=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.33.203) by
 AM6PR04MB6695.eurprd04.prod.outlook.com (20.179.247.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 04:13:41 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::cd8e:f990:731d:a5b2]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::cd8e:f990:731d:a5b2%7]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 04:13:41 +0000
From:   Fancy Fang <chen.fang@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
CC:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: [RESEND PATCH 2/2] clk: imx8mm: rename 'share_count_dcss' to
 'share_count_disp'
Thread-Topic: [RESEND PATCH 2/2] clk: imx8mm: rename 'share_count_dcss' to
 'share_count_disp'
Thread-Index: AQHVNtXbgK4OG4KMHEO9sgOp9y1opQ==
Date:   Wed, 10 Jul 2019 04:13:41 +0000
Message-ID: <20190710041546.23422-2-chen.fang@nxp.com>
References: <20190710041546.23422-1-chen.fang@nxp.com>
In-Reply-To: <20190710041546.23422-1-chen.fang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To AM6PR04MB4936.eurprd04.prod.outlook.com
 (2603:10a6:20b:7::11)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=chen.fang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 30045cbb-f3b7-44f6-5281-08d704ecfd83
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6695;
x-ms-traffictypediagnostic: AM6PR04MB6695:
x-microsoft-antispam-prvs: <AM6PR04MB6695C85F279FA5EA30B92BB2F3F00@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(386003)(7736002)(76176011)(478600001)(50226002)(4326008)(5660300002)(99286004)(6436002)(66066001)(7416002)(2906002)(52116002)(2501003)(186003)(26005)(54906003)(110136005)(8936002)(6506007)(256004)(316002)(102836004)(6486002)(305945005)(1076003)(11346002)(81156014)(81166006)(25786009)(486006)(446003)(6116002)(86362001)(68736007)(3846002)(8676002)(53936002)(6512007)(2201001)(476003)(36756003)(2616005)(66446008)(66476007)(66556008)(64756008)(14454004)(66946007)(71200400001)(71190400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6695;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vy+MKuQyk+HmDnAb9SLbx1tIDAT04kORb/gQKjP4kh/9O5H+i3rEpmbu1P0Ruj3MwqgCev/HZjihdImngEPJWQtHi/lIdjniLvjUKhMu+bDfZSa3cBGu55phAlRJNV04ymVopExeHx25bxlAI/POiR9Z70j91LLcm6TB3U/crxrOAU209tCTfcOoqRV09F++6cyQKYmqC9ZIiEF/He1PL5EmeMr4BhYLnXiiuP0Ji+nl49Ry0sv1G3HlEpDqm9vDiPyrDVZEV535/UFmG2zA6oKzXPsveQMgdGTnPaGwPj9EdCBnRgRA2ODc5jlPgVrxI90lop5jFzxKjcFrhs6DdQNNMNhaBclOOUGxyECVLAhPBHoaBWF0pyPPmsHXkGMlB2qsSuqgtqKHZXnrRuU/92qavNHhUfCRf9lCLXipYC4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30045cbb-f3b7-44f6-5281-08d704ecfd83
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 04:13:41.0588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chen.fang@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6695
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename 'share_count_dcss' to 'share_count_disp', since the
DCSS module does not exist on imx8mm platform. So rename it
to avoid any unnecessary confusion.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 42f1227a4952..42cb33edf8e5 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -22,7 +22,7 @@ static u32 share_count_sai3;
 static u32 share_count_sai4;
 static u32 share_count_sai5;
 static u32 share_count_sai6;
-static u32 share_count_dcss;
+static u32 share_count_disp;
 static u32 share_count_pdm;
 static u32 share_count_nand;
=20
@@ -644,10 +644,10 @@ static int __init imx8mm_clocks_init(struct device_no=
de *ccm_node)
 	clks[IMX8MM_CLK_VPU_G2_ROOT] =3D imx_clk_gate4("vpu_g2_root_clk", "vpu_g2=
", base + 0x45a0, 0);
 	clks[IMX8MM_CLK_PDM_ROOT] =3D imx_clk_gate2_shared2("pdm_root_clk", "pdm"=
, base + 0x45b0, 0, &share_count_pdm);
 	clks[IMX8MM_CLK_PDM_IPG]  =3D imx_clk_gate2_shared2("pdm_ipg_clk", "ipg_a=
udio_root", base + 0x45b0, 0, &share_count_pdm);
-	clks[IMX8MM_CLK_DISP_ROOT] =3D imx_clk_gate2_shared2("disp_root_clk", "di=
sp_dc8000", base + 0x45d0, 0, &share_count_dcss);
-	clks[IMX8MM_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_root_=
clk", "disp_axi", base + 0x45d0, 0, &share_count_dcss);
-	clks[IMX8MM_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_root_=
clk", "disp_apb", base + 0x45d0, 0, &share_count_dcss);
-	clks[IMX8MM_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_rtrm_root=
_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_dcss);
+	clks[IMX8MM_CLK_DISP_ROOT] =3D imx_clk_gate2_shared2("disp_root_clk", "di=
sp_dc8000", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_AXI_ROOT]  =3D imx_clk_gate2_shared2("disp_axi_root_=
clk", "disp_axi", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_APB_ROOT]  =3D imx_clk_gate2_shared2("disp_apb_root_=
clk", "disp_apb", base + 0x45d0, 0, &share_count_disp);
+	clks[IMX8MM_CLK_DISP_RTRM_ROOT] =3D imx_clk_gate2_shared2("disp_rtrm_root=
_clk", "disp_rtrm", base + 0x45d0, 0, &share_count_disp);
 	clks[IMX8MM_CLK_USDHC3_ROOT] =3D imx_clk_gate4("usdhc3_root_clk", "usdhc3=
", base + 0x45e0, 0);
 	clks[IMX8MM_CLK_TMU_ROOT] =3D imx_clk_gate4("tmu_root_clk", "ipg_root", b=
ase + 0x4620, 0);
 	clks[IMX8MM_CLK_VPU_DEC_ROOT] =3D imx_clk_gate4("vpu_dec_root_clk", "vpu_=
bus", base + 0x4630, 0);
--=20
2.17.1

