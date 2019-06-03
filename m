Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967C5C04AB6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BC12405D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 07:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nRCNfiQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfFCHeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 03:34:05 -0400
Received: from mail-eopbgr140072.outbound.protection.outlook.com ([40.107.14.72]:54498
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725974AbfFCHeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 03:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGAIrsrhHG1fpms8X3f1sXEoTRyoi+dVQ7c2976BJzE=;
 b=nRCNfiQqoIKWxLLMmO86C21QjUDwdobVUqCmzuhodtknjq1sd7HxYgytm50Ms2o8IjA5GvhhtzQO3fBxFz1ApkB9jP2pDwdFg7h4G5aa2Lcz0wJ8qrudDhxMeKSf/66stJJbTbhhCAm33Heq6CI02CLD1l+5KcMOcSglDXvQUGE=
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com (20.178.127.224) by
 VI1PR04MB4112.eurprd04.prod.outlook.com (52.133.14.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.18; Mon, 3 Jun 2019 07:33:57 +0000
Received: from VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e]) by VI1PR04MB5790.eurprd04.prod.outlook.com
 ([fe80::607a:a473:5c73:7d7e%5]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 07:33:57 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
        "marex@denx.de" <marex@denx.de>, Jacky Bai <ping.bai@nxp.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        Leo Li <leoyang.li@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Bhaskar Upadhaya <bhaskar.upadhaya@nxp.com>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        Vabhav Sharma <vabhav.sharma@nxp.com>,
        Pramod Kumar <pramod.kumar_1@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 3/3] arm64: dts: freescale: Add i.MX8MN DDR4 EVK board
 support
Thread-Topic: [PATCH V2 3/3] arm64: dts: freescale: Add i.MX8MN DDR4 EVK board
 support
Thread-Index: AQHVGatZTl9F/dTNxUOw6Q1ZubNyH6aJihGA
Date:   Mon, 3 Jun 2019 07:33:57 +0000
Message-ID: <20190603073357.b3d3he5lbqt7xaei@fsr-ub1664-175>
References: <20190603012747.38921-1-Anson.Huang@nxp.com>
 <20190603012747.38921-3-Anson.Huang@nxp.com>
In-Reply-To: <20190603012747.38921-3-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d733004d-11d8-440a-acad-08d6e7f5d6f7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB4112;
x-ms-traffictypediagnostic: VI1PR04MB4112:
x-microsoft-antispam-prvs: <VI1PR04MB4112DFCDAB0F3CF6F416286FF6140@VI1PR04MB4112.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(39860400002)(346002)(376002)(136003)(366004)(396003)(199004)(189003)(25786009)(1076003)(316002)(14454004)(102836004)(53546011)(6506007)(9686003)(6512007)(86362001)(5660300002)(6862004)(4326008)(64756008)(33716001)(53936002)(76176011)(186003)(229853002)(26005)(66946007)(73956011)(6246003)(76116006)(11346002)(7736002)(71200400001)(66446008)(66476007)(446003)(478600001)(66556008)(8676002)(71190400001)(2906002)(81156014)(8936002)(3846002)(6116002)(6636002)(81166006)(305945005)(54906003)(476003)(6436002)(99286004)(66066001)(256004)(14444005)(486006)(6486002)(68736007)(7416002)(44832011)(414714003)(473944003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4112;H:VI1PR04MB5790.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2BRTrCfUm87eX8/FBeWTgkkEa+CFwDxbxiRnmfCUt/Zfs9zZ9KlQe7+YN/WwwMwmY7OeZyl5UpDV+YsWGIjNRjuDdE7+XQ4Mo/vm/FFlK+PQoLpHQWTMglRd6nN2FzEDo5SDNH2LPfPsEkOqEYeXoQruWm41rYUKnne4k2EDZlbi0eBNrL4d1LVzn8sYYd6CQr9WfT9whnxTg8EJonkLxWrriQNY8rdEHXEgvZ6C3nuDIXrDYsoGQv2eJareDUTBQYVEoXV81hFLM8IubCkx7/aPdcI9qvkF4JfxZYpHAEQ2jb0W6wJtBE1VYhDT3m4EAVqaZZV4PN9Agvo2RHB8H71e7SUruWMUyPmcgSaXAI/9c8eO4+ILXESIP3L/vTGXuaMctdNlW15DUfdxozLzGD5LU59AGHzb81fBZq0JN2Q=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E19139743FF337498099BF61FFEEE00E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d733004d-11d8-440a-acad-08d6e7f5d6f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 07:33:57.7864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4112
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-03 09:27:47, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> This patch adds basic i.MM8MN DDR4 EVK board support.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No changes.
> ---
>  arch/arm64/boot/dts/freescale/Makefile            |   1 +
>  arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 217 ++++++++++++++++=
++++++
>  2 files changed, 218 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
>=20
> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts=
/freescale/Makefile
> index 0bd122f..2cdd4cc 100644
> --- a/arch/arm64/boot/dts/freescale/Makefile
> +++ b/arch/arm64/boot/dts/freescale/Makefile
> @@ -20,6 +20,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-ls2088a-rdb.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-qds.dtb
>  dtb-$(CONFIG_ARCH_LAYERSCAPE) +=3D fsl-lx2160a-rdb.dtb
> =20
> +dtb-$(CONFIG_ARCH_MXC) +=3D imx8mn-ddr4-evk.dtb

Nitpick: Move this bellow imx8mm-evk.dtb to keep them alphabetically ordere=
d.

>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mm-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-evk.dtb
>  dtb-$(CONFIG_ARCH_MXC) +=3D imx8mq-zii-ultra-rmb3.dtb
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm=
64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> new file mode 100644
> index 0000000..da552c2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
> @@ -0,0 +1,217 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright 2019 NXP
> + */
> +
> +/dts-v1/;
> +
> +#include "imx8mn.dtsi"
> +
> +/ {
> +	model =3D "NXP i.MX8MNano DDR4 EVK board";
> +	compatible =3D "fsl,imx8mn-ddr4-evk", "fsl,imx8mn";
> +
> +	chosen {
> +		stdout-path =3D &uart2;
> +	};
> +
> +	reg_usdhc2_vmmc: regulator-usdhc2 {
> +		compatible =3D "regulator-fixed";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> +		regulator-name =3D "VSD_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +
> +	pinctrl_fec1: fec1grp {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_ENET_MDC_ENET1_MDC		0x3
> +			MX8MN_IOMUXC_ENET_MDIO_ENET1_MDIO	0x3
> +			MX8MN_IOMUXC_ENET_TD3_ENET1_RGMII_TD3	0x1f
> +			MX8MN_IOMUXC_ENET_TD2_ENET1_RGMII_TD2	0x1f
> +			MX8MN_IOMUXC_ENET_TD1_ENET1_RGMII_TD1	0x1f
> +			MX8MN_IOMUXC_ENET_TD0_ENET1_RGMII_TD0	0x1f
> +			MX8MN_IOMUXC_ENET_RD3_ENET1_RGMII_RD3	0x91
> +			MX8MN_IOMUXC_ENET_RD2_ENET1_RGMII_RD2	0x91
> +			MX8MN_IOMUXC_ENET_RD1_ENET1_RGMII_RD1	0x91
> +			MX8MN_IOMUXC_ENET_RD0_ENET1_RGMII_RD0	0x91
> +			MX8MN_IOMUXC_ENET_TXC_ENET1_RGMII_TXC	0x1f
> +			MX8MN_IOMUXC_ENET_RXC_ENET1_RGMII_RXC	0x91
> +			MX8MN_IOMUXC_ENET_RX_CTL_ENET1_RGMII_RX_CTL	0x91
> +			MX8MN_IOMUXC_ENET_TX_CTL_ENET1_RGMII_TX_CTL	0x1f
> +			MX8MN_IOMUXC_SAI2_RXC_GPIO4_IO22	0x19
> +		>;
> +	};
> +
> +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmc {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_SD2_RESET_B_GPIO2_IO19	0x41
> +		>;
> +	};
> +
> +	pinctrl_uart2: uart2grp {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_UART2_RXD_UART2_DCE_RX	0x140
> +			MX8MN_IOMUXC_UART2_TXD_UART2_DCE_TX	0x140
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_gpio: usdhc2grpgpio {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_GPIO1_IO15_GPIO1_IO15	0x1c4
> +		>;
> +	};
> +
> +	pinctrl_usdhc2: usdhc2grp {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x190
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d0
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d0
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d0
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_100mhz: usdhc2grp100mhz {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x194
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d4
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d4
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d4
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc2_200mhz: usdhc2grp200mhz {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_SD2_CLK_USDHC2_CLK		0x196
> +			MX8MN_IOMUXC_SD2_CMD_USDHC2_CMD		0x1d6
> +			MX8MN_IOMUXC_SD2_DATA0_USDHC2_DATA0	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA1_USDHC2_DATA1	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA2_USDHC2_DATA2	0x1d6
> +			MX8MN_IOMUXC_SD2_DATA3_USDHC2_DATA3	0x1d6
> +			MX8MN_IOMUXC_GPIO1_IO04_USDHC2_VSELECT	0x1d0
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000190
> +			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d0
> +			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d0
> +			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d0
> +			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d0
> +			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d0
> +			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d0
> +			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d0
> +			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d0
> +			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d0
> +			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x190
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_100mhz: usdhc3grp100mhz {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000194
> +			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d4
> +			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d4
> +			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d4
> +			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d4
> +			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d4
> +			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d4
> +			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d4
> +			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d4
> +			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d4
> +			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x194
> +		>;
> +	};
> +
> +	pinctrl_usdhc3_200mhz: usdhc3grp200mhz {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_NAND_WE_B_USDHC3_CLK		0x40000196
> +			MX8MN_IOMUXC_NAND_WP_B_USDHC3_CMD		0x1d6
> +			MX8MN_IOMUXC_NAND_DATA04_USDHC3_DATA0		0x1d6
> +			MX8MN_IOMUXC_NAND_DATA05_USDHC3_DATA1		0x1d6
> +			MX8MN_IOMUXC_NAND_DATA06_USDHC3_DATA2		0x1d6
> +			MX8MN_IOMUXC_NAND_DATA07_USDHC3_DATA3		0x1d6
> +			MX8MN_IOMUXC_NAND_RE_B_USDHC3_DATA4		0x1d6
> +			MX8MN_IOMUXC_NAND_CE2_B_USDHC3_DATA5		0x1d6
> +			MX8MN_IOMUXC_NAND_CE3_B_USDHC3_DATA6		0x1d6
> +			MX8MN_IOMUXC_NAND_CLE_USDHC3_DATA7		0x1d6
> +			MX8MN_IOMUXC_NAND_CE1_B_USDHC3_STROBE		0x196
> +		>;
> +	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins =3D <
> +			MX8MN_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
> +		>;
> +	};
> +};
> +
> +&fec1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_fec1>;
> +	phy-mode =3D "rgmii-id";
> +	phy-handle =3D <&ethphy0>;
> +	fsl,magic-packet;
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		ethphy0: ethernet-phy@0 {
> +			compatible =3D "ethernet-phy-ieee802.3-c22";
> +			reg =3D <0>;
> +			at803x,led-act-blind-workaround;
> +			at803x,eee-disabled;
> +			at803x,vddio-1p8v;
> +		};
> +	};
> +};
> +
> +&uart2 { /* console */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart2>;
> +	status =3D "okay";
> +};
> +
> +&usdhc2 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> +	cd-gpios =3D <&gpio1 15 GPIO_ACTIVE_LOW>;
> +	bus-width =3D <4>;
> +	vmmc-supply =3D <&reg_usdhc2_vmmc>;
> +	status =3D "okay";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	pinctrl-1 =3D <&pinctrl_usdhc3_100mhz>;
> +	pinctrl-2 =3D <&pinctrl_usdhc3_200mhz>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	status =3D "okay";
> +};
> +
> +&wdog1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status =3D "okay";
> +};
> --=20
> 2.7.4
> =
