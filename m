Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3783C73C69
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716C620645
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 04:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AWPejwbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfGJENm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 00:13:42 -0400
Received: from mail-eopbgr20055.outbound.protection.outlook.com ([40.107.2.55]:47114
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725856AbfGJENl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 00:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA2knaqHcsWhG3WxuMgsw9SlhANhWDuoivatKmcXKuM=;
 b=AWPejwbSaq4IQMioMVOJdx1EfNs2nSLONVXX7ovOM9tCHJfj7ODJsQ3LVNgzJUR5tfleiWQjuznwXFh3DHr9OLsQydTPj65vEFI71XZFKO/DvZij73Ox3AGA+bKob5SuzPwdaBbe2rd/+Wjg+KsKj+s2XFuQvvRDMgvhezafeY0=
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com (20.177.33.203) by
 AM6PR04MB6695.eurprd04.prod.outlook.com (20.179.247.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.20; Wed, 10 Jul 2019 04:13:37 +0000
Received: from AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::cd8e:f990:731d:a5b2]) by AM6PR04MB4936.eurprd04.prod.outlook.com
 ([fe80::cd8e:f990:731d:a5b2%7]) with mapi id 15.20.2052.020; Wed, 10 Jul 2019
 04:13:37 +0000
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
Subject: [RESEND PATCH 1/2] clk: imx8mm: rename lcdif pixel clock
Thread-Topic: [RESEND PATCH 1/2] clk: imx8mm: rename lcdif pixel clock
Thread-Index: AQHVNtXYsppc9iHvSUKCRoa1/AmVEQ==
Date:   Wed, 10 Jul 2019 04:13:37 +0000
Message-ID: <20190710041546.23422-1-chen.fang@nxp.com>
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
x-ms-office365-filtering-correlation-id: 0e2709b6-3b75-40c8-a001-08d704ecfb21
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB6695;
x-ms-traffictypediagnostic: AM6PR04MB6695:
x-microsoft-antispam-prvs: <AM6PR04MB669598E080BC8DAB55AF0821F3F00@AM6PR04MB6695.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(386003)(7736002)(478600001)(50226002)(4326008)(5660300002)(99286004)(6436002)(66066001)(7416002)(2906002)(52116002)(2501003)(186003)(26005)(54906003)(110136005)(8936002)(6506007)(256004)(316002)(102836004)(6486002)(305945005)(1076003)(81156014)(81166006)(25786009)(486006)(6116002)(86362001)(68736007)(3846002)(8676002)(53936002)(6512007)(2201001)(476003)(36756003)(2616005)(66446008)(66476007)(66556008)(64756008)(14454004)(66946007)(71200400001)(71190400001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6695;H:AM6PR04MB4936.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aY4rFDJlLh7mlmGumTAqLUlnSyYEr+aJZswKZ3EXPGZF2AfkLArLwwiMHy4+qZm3dxxj6bE6fk+rjptQyKWaPDO9uxW20hM2nBGhh4d7vzXzYUXbFvzmK4+DqoJW+HXm8trFMhpx5W47XGaFY/4kGZO6n+D+PxTRSPHlJZUx6CIgArV3rq5Q8Z479ZTv34CnpMV+8uvQudnaT0v3xzM6bOjP36ilo7GaXRKEPUosFTz6VHFxez1UFXOyV3e4kRJWn9lG1VfQY26Gzoow+FO1rNzE6hO4yL+ujYARwKIPtc5sEhtUzB7VlV80zXqmUxh4a1edJZ5B7ZjZxsECXs6doJGWLXUIV3UgSdhwPr/yyM5zuFv1xZfsyL0UfN6k90m96+Cf1xDB7a9jK6Da6AxsP0D5YeH5cLDvbson4ZfjT8A=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2709b6-3b75-40c8-a001-08d704ecfb21
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 04:13:37.0900
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

Rename 'lcdif' pixel clock related names to 'disp' names, since:

First, the lcdif pixel clock is not supplied to LCDIF controller
directly, but to some LPCG clock in display mix. So rename it to
'disp' pixel clock is more accurate.

Second, in the imx8mn CCM specification which is designed after
imx8mm, this same pixel root clock name has been modified from
'LCDIF_PIXEL_CLK_ROOT' to 'DISPLAY_PIXEL_CLK_ROOT'.

Signed-off-by: Fancy Fang <chen.fang@nxp.com>
---
 drivers/clk/imx/clk-imx8mm.c             | 4 ++--
 include/dt-bindings/clock/imx8mm-clock.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index 6b8e75df994d..42f1227a4952 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -210,7 +210,7 @@ static const char *imx8mm_pcie1_aux_sels[] =3D {"osc_24=
m", "sys_pll2_200m", "sys_p
 static const char *imx8mm_dc_pixel_sels[] =3D {"osc_24m", "video_pll1_out"=
, "audio_pll2_out", "audio_pll1_out",
 					     "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", }=
;
=20
-static const char *imx8mm_lcdif_pixel_sels[] =3D {"osc_24m", "video_pll1_o=
ut", "audio_pll2_out", "audio_pll1_out",
+static const char *imx8mm_disp_pixel_sels[] =3D {"osc_24m", "video_pll1_ou=
t", "audio_pll2_out", "audio_pll1_out",
 						"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
=20
 static const char *imx8mm_sai1_sels[] =3D {"osc_24m", "audio_pll1_out", "a=
udio_pll2_out", "video_pll1_out",
@@ -535,7 +535,7 @@ static int __init imx8mm_clocks_init(struct device_node=
 *ccm_node)
 	clks[IMX8MM_CLK_PCIE1_PHY] =3D imx8m_clk_composite("pcie1_phy", imx8mm_pc=
ie1_phy_sels, base + 0xa380);
 	clks[IMX8MM_CLK_PCIE1_AUX] =3D imx8m_clk_composite("pcie1_aux", imx8mm_pc=
ie1_aux_sels, base + 0xa400);
 	clks[IMX8MM_CLK_DC_PIXEL] =3D imx8m_clk_composite("dc_pixel", imx8mm_dc_p=
ixel_sels, base + 0xa480);
-	clks[IMX8MM_CLK_LCDIF_PIXEL] =3D imx8m_clk_composite("lcdif_pixel", imx8m=
m_lcdif_pixel_sels, base + 0xa500);
+	clks[IMX8MM_CLK_DISP_PIXEL] =3D imx8m_clk_composite("disp_pixel", imx8mm_=
disp_pixel_sels, base + 0xa500);
 	clks[IMX8MM_CLK_SAI1] =3D imx8m_clk_composite("sai1", imx8mm_sai1_sels, b=
ase + 0xa580);
 	clks[IMX8MM_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mm_sai2_sels, b=
ase + 0xa600);
 	clks[IMX8MM_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mm_sai3_sels, b=
ase + 0xa680);
diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindings=
/clock/imx8mm-clock.h
index 07e6c686f3ef..91ef77efebd9 100644
--- a/include/dt-bindings/clock/imx8mm-clock.h
+++ b/include/dt-bindings/clock/imx8mm-clock.h
@@ -119,7 +119,7 @@
 #define IMX8MM_CLK_PCIE1_PHY			104
 #define IMX8MM_CLK_PCIE1_AUX			105
 #define IMX8MM_CLK_DC_PIXEL			106
-#define IMX8MM_CLK_LCDIF_PIXEL			107
+#define IMX8MM_CLK_DISP_PIXEL			107
 #define IMX8MM_CLK_SAI1				108
 #define IMX8MM_CLK_SAI2				109
 #define IMX8MM_CLK_SAI3				110
--=20
2.17.1

