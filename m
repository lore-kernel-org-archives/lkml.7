Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90608C74A4D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2D320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 08:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lv+SyOtL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbfGKIRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 04:17:48 -0400
Received: from mail-eopbgr40082.outbound.protection.outlook.com ([40.107.4.82]:48150
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727929AbfGKIRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 04:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BcQ8ST1TCyJRhGaB26DYgyyMidy+dNZNN8FpCr9uDk=;
 b=lv+SyOtLvrnm9lz00pmKGJH5KgKHhOdJDKJDvhIwTAJWD8BTdcnEVoePTsd7cWnmMb3SLpMYSs9wkTeJZZCryEg5wUw99lioO3Uj668mpdiftOX6IdJjfyKOlpsefEulUy5IB/SFHzP0eQWJaVoCOUKOpWvP4cZS18cjYnBMr7M=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4626.eurprd04.prod.outlook.com (52.135.151.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Thu, 11 Jul 2019 08:17:44 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2052.022; Thu, 11 Jul 2019
 08:17:44 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Fancy Fang <chen.fang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [RESEND PATCH 1/2] clk: imx8mm: rename lcdif pixel clock
Thread-Topic: [RESEND PATCH 1/2] clk: imx8mm: rename lcdif pixel clock
Thread-Index: AQHVNtXYsppc9iHvSUKCRoa1/AmVEabFFI6A
Date:   Thu, 11 Jul 2019 08:17:43 +0000
Message-ID: <20190711081743.r73g5zqtrgdw5xlp@fsr-ub1664-175>
References: <20190710041546.23422-1-chen.fang@nxp.com>
In-Reply-To: <20190710041546.23422-1-chen.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4681e66-2fdc-45e5-2399-08d705d84001
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4626;
x-ms-traffictypediagnostic: AM0PR04MB4626:
x-microsoft-antispam-prvs: <AM0PR04MB46265BDE847E9164CFF2B4DBF6F30@AM0PR04MB4626.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(136003)(376002)(39860400002)(366004)(396003)(346002)(189003)(199004)(186003)(256004)(26005)(6246003)(478600001)(7736002)(305945005)(1076003)(71190400001)(86362001)(68736007)(71200400001)(5660300002)(66066001)(91956017)(66946007)(76116006)(64756008)(66476007)(66556008)(66446008)(102836004)(6506007)(53546011)(11346002)(476003)(44832011)(446003)(33716001)(6862004)(2906002)(54906003)(25786009)(316002)(6486002)(4326008)(76176011)(6116002)(3846002)(8936002)(14454004)(9686003)(6512007)(229853002)(81156014)(99286004)(8676002)(81166006)(53936002)(6436002)(486006)(7416002)(6636002)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4626;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XcdkKHSCVaZKZl2+v+Ss6YQ1arLDVJdMEHgrSpreNLXXCQSLjvBibpYfqB6c1YlFtKE+r+eofJQhkJA1JK2kpE5fHEoiVOQiNFonoDDXWiLb1rE6cyqQ3JgQ/SthqHF7mwezZOJ/jMypsJnIoQU6wZRZgT3Wyo2kUG+4V3NzDS7FzkxdyaZs0YWMmaxUccSJXFAe1AdcDdOJ8LDL0KyQCv3ufDdVM5jKsQ3l0lHr1ZeUZQK73Jo5mBu6vdW17wCr5dGTlTI2tNsYkI6Xo78nzuTVWJuWbMKFhU72wF2HKaK8ywJnpuvf33+ZNN3UyRbXNVCRfM8HGiO1rq3/cifo9XIzy7lfnaIeiEd3hGbm0b/3MEfmCxs0IwZ0M3tjOmbCTyguwwLuR64R9Q42DPU77IkQu0oGEDcQdvKOB+LMDQ8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0031DD8A96E813439B342C5DCC30EFC0@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4681e66-2fdc-45e5-2399-08d705d84001
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 08:17:43.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-10 04:13:37, Fancy Fang wrote:
> Rename 'lcdif' pixel clock related names to 'disp' names, since:
>=20
> First, the lcdif pixel clock is not supplied to LCDIF controller
> directly, but to some LPCG clock in display mix. So rename it to
> 'disp' pixel clock is more accurate.
>=20
> Second, in the imx8mn CCM specification which is designed after
> imx8mm, this same pixel root clock name has been modified from
> 'LCDIF_PIXEL_CLK_ROOT' to 'DISPLAY_PIXEL_CLK_ROOT'.
>=20
> Signed-off-by: Fancy Fang <chen.fang@nxp.com>

For the entire series.

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  drivers/clk/imx/clk-imx8mm.c             | 4 ++--
>  include/dt-bindings/clock/imx8mm-clock.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 6b8e75df994d..42f1227a4952 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -210,7 +210,7 @@ static const char *imx8mm_pcie1_aux_sels[] =3D {"osc_=
24m", "sys_pll2_200m", "sys_p
>  static const char *imx8mm_dc_pixel_sels[] =3D {"osc_24m", "video_pll1_ou=
t", "audio_pll2_out", "audio_pll1_out",
>  					     "sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4",=
 };
> =20
> -static const char *imx8mm_lcdif_pixel_sels[] =3D {"osc_24m", "video_pll1=
_out", "audio_pll2_out", "audio_pll1_out",
> +static const char *imx8mm_disp_pixel_sels[] =3D {"osc_24m", "video_pll1_=
out", "audio_pll2_out", "audio_pll1_out",
>  						"sys_pll1_800m", "sys_pll2_1000m", "sys_pll3_out", "clk_ext4", };
> =20
>  static const char *imx8mm_sai1_sels[] =3D {"osc_24m", "audio_pll1_out", =
"audio_pll2_out", "video_pll1_out",
> @@ -535,7 +535,7 @@ static int __init imx8mm_clocks_init(struct device_no=
de *ccm_node)
>  	clks[IMX8MM_CLK_PCIE1_PHY] =3D imx8m_clk_composite("pcie1_phy", imx8mm_=
pcie1_phy_sels, base + 0xa380);
>  	clks[IMX8MM_CLK_PCIE1_AUX] =3D imx8m_clk_composite("pcie1_aux", imx8mm_=
pcie1_aux_sels, base + 0xa400);
>  	clks[IMX8MM_CLK_DC_PIXEL] =3D imx8m_clk_composite("dc_pixel", imx8mm_dc=
_pixel_sels, base + 0xa480);
> -	clks[IMX8MM_CLK_LCDIF_PIXEL] =3D imx8m_clk_composite("lcdif_pixel", imx=
8mm_lcdif_pixel_sels, base + 0xa500);
> +	clks[IMX8MM_CLK_DISP_PIXEL] =3D imx8m_clk_composite("disp_pixel", imx8m=
m_disp_pixel_sels, base + 0xa500);
>  	clks[IMX8MM_CLK_SAI1] =3D imx8m_clk_composite("sai1", imx8mm_sai1_sels,=
 base + 0xa580);
>  	clks[IMX8MM_CLK_SAI2] =3D imx8m_clk_composite("sai2", imx8mm_sai2_sels,=
 base + 0xa600);
>  	clks[IMX8MM_CLK_SAI3] =3D imx8m_clk_composite("sai3", imx8mm_sai3_sels,=
 base + 0xa680);
> diff --git a/include/dt-bindings/clock/imx8mm-clock.h b/include/dt-bindin=
gs/clock/imx8mm-clock.h
> index 07e6c686f3ef..91ef77efebd9 100644
> --- a/include/dt-bindings/clock/imx8mm-clock.h
> +++ b/include/dt-bindings/clock/imx8mm-clock.h
> @@ -119,7 +119,7 @@
>  #define IMX8MM_CLK_PCIE1_PHY			104
>  #define IMX8MM_CLK_PCIE1_AUX			105
>  #define IMX8MM_CLK_DC_PIXEL			106
> -#define IMX8MM_CLK_LCDIF_PIXEL			107
> +#define IMX8MM_CLK_DISP_PIXEL			107
>  #define IMX8MM_CLK_SAI1				108
>  #define IMX8MM_CLK_SAI2				109
>  #define IMX8MM_CLK_SAI3				110
> --=20
> 2.17.1
> =
