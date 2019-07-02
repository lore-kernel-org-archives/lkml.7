Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D988C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BF121721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 11:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q0B5Du3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfGBLps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 07:45:48 -0400
Received: from mail-eopbgr40041.outbound.protection.outlook.com ([40.107.4.41]:49086
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725767AbfGBLpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 07:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl2hrmuB6iUCeVR3BZgMfhCmzZ47paNqJX57ARDY4Ho=;
 b=Q0B5Du3x8UKq+29h450EpdpA1Lbj7OlvjMWztPRp1cBmtCMzddBLsOCq2lnqB7xaGaDUezPdCtigGYMD1j9apkVUXyo74YeHnkitNOW1X6tMWgwij8LpwHj5F/m4jD0OvsiXlczeBpd36TUacGJxvhrpjZAjG0J1LEZicrq1GLo=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB5732.eurprd04.prod.outlook.com (20.178.117.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 11:45:43 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 11:45:43 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Andra Danciu <andradanciu1997@gmail.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Anson Huang <anson.huang@nxp.com>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mq: Add sai6 node
Thread-Topic: [PATCH] arm64: dts: imx8mq: Add sai6 node
Thread-Index: AQHVMMsRKx0kk913gkG41z6iIMo/Oaa3NcQA
Date:   Tue, 2 Jul 2019 11:45:43 +0000
Message-ID: <20190702114542.2eoc6nm2kyhode43@fsr-ub1664-175>
References: <20190702114102.1254-1-andradanciu1997@gmail.com>
In-Reply-To: <20190702114102.1254-1-andradanciu1997@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b065002-f472-4adc-06ee-08d6fee2d0a7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5732;
x-ms-traffictypediagnostic: AM0PR04MB5732:
x-microsoft-antispam-prvs: <AM0PR04MB573244E413686D540A52B719F6F80@AM0PR04MB5732.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:81;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(199004)(189003)(66556008)(66946007)(73956011)(68736007)(6116002)(3846002)(66476007)(91956017)(64756008)(66446008)(86362001)(5660300002)(478600001)(66066001)(305945005)(7736002)(1411001)(81166006)(76116006)(4326008)(81156014)(25786009)(8936002)(26005)(6486002)(76176011)(446003)(11346002)(44832011)(6512007)(9686003)(14454004)(256004)(486006)(53936002)(7416002)(102836004)(14444005)(53546011)(2906002)(476003)(54906003)(6506007)(8676002)(33716001)(229853002)(71190400001)(71200400001)(316002)(6436002)(1076003)(99286004)(6916009)(6246003)(186003)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5732;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: AZlKDosgEzmi1eL4BssCxys0i8851aJr70pwgxuLYY0/RJO7se9yCNwoq/TQLmcIOTh9pUsBDCpusCKFvGnNNgyiW3HKpq2C0UEZbSm9/rOhfgetHyd6Ttv+eZ7Fl4HaybXeJJX23iBOYFvjraIP5n379O2j8WoiThobKOdiNoLVVf+Q81nr6fnOkTa4to+3HbN10KKcnTyMtSuo4pmYCdncVPC9Rgi5RtKaQzztUGJ8D+tphwaCF3Tga6BN5X0LmWb4IbfQ5QIkL6nx87pvTG8vN+NtHr88R31ZcyIlols4nnsPhSZDUWIibydBBBlYTc6OyZk5hoZr8jXRs6Sjr9W7BKaygXbauegC9HIb0PbrBhKBhxqk5NqoSX/yAe9RzzJUiOyudLnhec5ROXCPdiEaW/hzZKUwP+IdZoSvSC8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F3B412D4A179564BBCAB6261F2913C80@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b065002-f472-4adc-06ee-08d6fee2d0a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 11:45:43.5205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5732
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-02 14:41:02, Andra Danciu wrote:

Missing commit message here. Please add one.

> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index d09b808eff87..1ff664523f56 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -278,6 +278,20 @@
>  			#size-cells =3D <1>;
>  			ranges =3D <0x30000000 0x30000000 0x400000>;
> =20
> +			sai6: sai@30030000 {
> +				compatible =3D "fsl,imx8mq-sai",
> +					"fsl,imx6sx-sai";
> +				reg =3D <0x30030000 0x10000>;
> +				interrupts =3D <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks =3D <&clk IMX8MQ_CLK_SAI6_IPG>,
> +					<&clk IMX8MQ_CLK_SAI6_ROOT>,
> +					<&clk IMX8MQ_CLK_DUMMY>, <&clk IMX8MQ_CLK_DUMMY>;
> +				clock-names =3D "bus", "mclk1", "mclk2", "mclk3";
> +				dmas =3D <&sdma2 4 24 0>, <&sdma2 5 24 0>;
> +				dma-names =3D "rx", "tx";
> +				status =3D "disabled";
> +			};
> +
>  			gpio1: gpio@30200000 {
>  				compatible =3D "fsl,imx8mq-gpio", "fsl,imx35-gpio";
>  				reg =3D <0x30200000 0x10000>;
> --=20
> 2.11.0
> =
