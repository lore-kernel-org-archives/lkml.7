Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF1C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECB720665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ObDf2nea"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfGOLKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:10:33 -0400
Received: from mail-eopbgr50078.outbound.protection.outlook.com ([40.107.5.78]:32211
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729698AbfGOLKd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:10:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKziwcywrssm0dxIhnhfg0Y+NKkr3STw+WBNvsBQXrU=;
 b=ObDf2neaJnDzWT18L61iZPsWfmQ7u7QKnMrtlC/39F71Y2nxUYAihCKVjcj/gZIH3kS04BpLDIi7WOjZ8CryqDLbEdaxxD927SI7Lvrll00nlGakYwICaLM9ewaQVIWqBFN8qH0J3Eyjv4O8YbWA7Uddt6WAyrjVNB1/Wh7lmTM=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5041.eurprd04.prod.outlook.com (20.176.214.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.18; Mon, 15 Jul 2019 11:10:28 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2073.012; Mon, 15 Jul 2019
 11:10:28 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Pavel Machek <pavel@ucw.cz>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Lucas Stach <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        Carlo Caione <ccaione@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] arm64: dts: imx8mq: Add MIPI D-PHY
Thread-Topic: [PATCH v2 1/2] arm64: dts: imx8mq: Add MIPI D-PHY
Thread-Index: AQHVOvoZN2tyYFG00UaL7nctnpGXwabLhduA
Date:   Mon, 15 Jul 2019 11:10:27 +0000
Message-ID: <20190715111027.a4wlpzex3taxymyr@fsr-ub1664-175>
References: <cover.1563187253.git.agx@sigxcpu.org>
 <30c7622bf590670190b93c9b5b6dd1e8f809bbb2.1563187253.git.agx@sigxcpu.org>
In-Reply-To: <30c7622bf590670190b93c9b5b6dd1e8f809bbb2.1563187253.git.agx@sigxcpu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9fcaa730-9ccd-43b7-2ca3-08d709150b09
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5041;
x-ms-traffictypediagnostic: AM0PR04MB5041:
x-microsoft-antispam-prvs: <AM0PR04MB504107C66FCABA19235B61D4F6CF0@AM0PR04MB5041.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00997889E7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(189003)(199004)(76176011)(446003)(11346002)(25786009)(2906002)(476003)(91956017)(6506007)(102836004)(99286004)(76116006)(53546011)(6916009)(6116002)(6246003)(316002)(26005)(44832011)(64756008)(66446008)(33716001)(53936002)(66556008)(66946007)(66066001)(66476007)(6512007)(9686003)(486006)(54906003)(186003)(81156014)(81166006)(14444005)(6486002)(256004)(478600001)(68736007)(6436002)(8936002)(5660300002)(3846002)(7416002)(229853002)(66574012)(1076003)(71200400001)(8676002)(71190400001)(86362001)(4326008)(305945005)(7736002)(14454004)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5041;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mMlL5jWwCBlVc3nPF0yXT4/UVIciINMhDa58/t71xSU/9GoLZdVpnxRWVd0CCSqvX6zMR3HO/hf2OrXVwyV5zsZxNI1k7bUP3RdgkjUyVa5s2hZQkD/cWjzYi/W1ochUbBRkVDSizZjgfwv6GP90M0rXJGNJs11biJq4nIEN1HLbKk9v9smpt+fYaz0Ug1QdW4vbvyibFuCmnp65SfhXAa+GlYjOKwJDLXgRMFf8p4p+WflBjq6T5rsSoD4dXShjWn8xjlH19FHwAsTfmilf8bZTY3dxruhPKbL6O6iDf96dBdWU6Lc9nPv+apI4fWEhT1O+lr7SWXKRfKa80HQzYF92WXWGv+3LJcH9USWlO5OU6QKB0FqEszz9aesPZmtGILMy8DRMt/8jSAM2NXUI6NtAGZwOpK13Ycw7UzjF6Vk=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4AB6BC72093B9A4CBF3A5D208EC97346@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcaa730-9ccd-43b7-2ca3-08d709150b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2019 11:10:27.8739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5041
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-15 12:43:05, Guido G=FCnther wrote:
> Add a node for the Mixel MIPI D-PHY, "disabled" by default.
>=20
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> Acked-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index d09b808eff87..891ee7578c2d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -728,6 +728,19 @@
>  				status =3D "disabled";
>  			};
> =20
> +			dphy: dphy@30a00300 {
> +				compatible =3D "fsl,imx8mq-mipi-dphy";
> +				reg =3D <0x30a00300 0x100>;
> +				clocks =3D <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +				clock-names =3D "phy_ref";
> +				assigned-clocks =3D <&clk IMX8MQ_CLK_DSI_PHY_REF>;
> +				assigned-clock-parents =3D <&clk IMX8MQ_VIDEO_PLL1_OUT>;
> +				assigned-clock-rates =3D <24000000>;

We have the following in the clk-imx8mq in the vendor tree:

	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_BYPASS], clks[IMX8MQ_VIDEO_PLL1]);

This unbypasses the video pll 1. And then we also have this:

	/* config video_pll1 clock */
	clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_27M]);
	clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);

But none of that is acceptable upstream since the clock provider should not
use clock consumer API.

So please update the assigned-clock* properties to something like this:
				assigned-clocks =3D <&clk IMX8MQ_VIDEO_PLL1_REF_SEL>,
						  <&clk IMX8MQ_VIDEO_PLL1_BYPASS>,
						  <&clk IMX8MQ_CLK_DSI_PHY_REF>,
						  <&clk IMX8MQ_VIDEO_PLL1>;
				assigned-clock-parents =3D <&clk IMX8MQ_CLK_27M>,
							 <&clk IMX8MQ_VIDEO_PLL1>,
							 <&clk IMX8MQ_VIDEO_PLL1_OUT>
							 <0>;
				assigned-clock-rates =3D <0>,
						       <0>,
						       <24000000>,            =20
						       <593999999>;

I've written this without testing, so please do test it on your setup.

> +				#phy-cells =3D <0>;
> +				power-domains =3D <&pgc_mipi>;
> +				status =3D "disabled";
> +			};
> +
>  			i2c1: i2c@30a20000 {
>  				compatible =3D "fsl,imx8mq-i2c", "fsl,imx21-i2c";
>  				reg =3D <0x30a20000 0x10000>;
> --=20
> 2.20.1
> =
