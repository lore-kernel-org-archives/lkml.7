Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB544C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E6A320863
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 14:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gjk1q8c2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732655AbfB1O3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 09:29:21 -0500
Received: from mail-eopbgr50055.outbound.protection.outlook.com ([40.107.5.55]:47478
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727874AbfB1O3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 09:29:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRM8KH7Nuhqzfndhj0MuyCRXliCrZJ9wF+6M4j529zc=;
 b=Gjk1q8c2UsVwEYjPBILoRbBqmRTS2FqaPeoh/MHns6H0+VD1ltKJCE8HZOnH0nIKbCEGXtVh7zOEa0tIlVZEWjhASEpH8+VV2TyamQTs0RgeuciBhxDVaWyAq5adw9ISs8DrknbYkKlHe2bgHL7uqW5Gwc3JTO0O8qojlI6GCkc=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4675.eurprd04.prod.outlook.com (52.135.144.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.21; Thu, 28 Feb 2019 14:29:16 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::ec4e:4756:a9dc:914c%3]) with mapi id 15.20.1643.022; Thu, 28 Feb 2019
 14:29:16 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>
CC:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/3] arm64: dts: imx8mq: Add the buck vdd_arm regulator
Thread-Topic: [PATCH v2 2/3] arm64: dts: imx8mq: Add the buck vdd_arm
 regulator
Thread-Index: AQHUxVlMid01fUo1802jjVCZ5QXkdqX1VX8AgAADxIA=
Date:   Thu, 28 Feb 2019 14:29:16 +0000
Message-ID: <20190228142915.l76oaxyjrsosoh7x@fsr-ub1664-175>
References: <1550254032-16451-1-git-send-email-abel.vesa@nxp.com>
 <1550254032-16451-3-git-send-email-abel.vesa@nxp.com>
 <20190228141543.GA29231@dragon>
In-Reply-To: <20190228141543.GA29231@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [95.76.156.53]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf48f40f-a0cb-4883-23a0-08d69d891e27
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4675;
x-ms-traffictypediagnostic: AM0PR04MB4675:
x-ms-exchange-purlcount: 1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB4675;23:TLPYa6NF5d04MEyqDmuIKSXKiKGEXeYU0f8dMJRUN?=
 =?us-ascii?Q?f0+12Qaikz0xX47VyAkvtwOXTXiJiaMyx1roFEwM70u1r/gryjTziMdhpDlS?=
 =?us-ascii?Q?6VWS3BO2b1+7gZa+LE8V4CU5knJIsktIqUBdvHIej8yx51yElFnOVgK4zksC?=
 =?us-ascii?Q?rq49Zlm9y7naFakMie5X8X+rqQu99V7IAMjVRYmG7CYDghMkJ8JzuDztzdET?=
 =?us-ascii?Q?I+QpbxHA9ACZ9bTqdndtnx1d8Z/tvOAGQtGU/N6YsVzf1otHlrx+C6xjXWqU?=
 =?us-ascii?Q?AnzdGD3ukibaBNVpjtxEWemvLe48l9Iqiv1jpEuB5Z2qULpSac66P03nb/cv?=
 =?us-ascii?Q?FRArYH+UPRhCb2BomoDITn8aD1Ih3aJumrrcWvRgorfq2tumii0qyF0KhL67?=
 =?us-ascii?Q?ue9oVZEZRfC/Ff4CvXn4Pn22Znv+4/9YDwXqTp/GTfnhQZzUcorWqfGYc7c6?=
 =?us-ascii?Q?HOwNumW+S1oRC5955WPhSagsIz51+19xBWi/5+VyqEYgylu+lL/rtGQ7B5xZ?=
 =?us-ascii?Q?WSuOHd+rXbikWWU7ZwVEPR0uFBbEesVqR0SxhuKBCBopgrLMBZlvLTWmSF1B?=
 =?us-ascii?Q?F5nYnuqgTOXjiLDlJlxy6l3n5L2Yqgh4gpYsEbQEU+jVEi4ts31Dsp+4vScZ?=
 =?us-ascii?Q?aH8jI/RCcRHT758ycV/jts7hReg7j7SP6XMovbsiX4qELgjL22IgqGWxDXlm?=
 =?us-ascii?Q?/E5/QOyzhHfdJnZAjpiEFyu//wqTUfZhR2cXYFBPkX8uwFQrvng0aEsg1ehC?=
 =?us-ascii?Q?J/4/8PYoA6KBj5h3Avn5Xg9u73j5gnN+tYlrJi7nCUa3Gf2yYhbpw0lNMUM1?=
 =?us-ascii?Q?/xSr+KEExkhLffs2c5Y3tVgJgYNRNFJzpRu1n7yPeTLMWWgl7Reh+AO9k+qT?=
 =?us-ascii?Q?JWtU9n7l3qE2twvT4mWxraQEnY4BNOupPHfpdGOSbBCEVdPm+dHZzXGNHUjr?=
 =?us-ascii?Q?IF25Ji1hvdeFk0ypoHzilNH34yY41uM9n+kDVEeLxurPeqZowqMGQpVjKdEe?=
 =?us-ascii?Q?aG0/Cx/qSizDJtWB0jOgSck7TlQ0kuzD21aJKpl7PE2s0ZtgTZ0UwVsFkvZK?=
 =?us-ascii?Q?djqinoZIl84viGY1NidTHvEfLT06QbE7zfKgSboAnsAuv4dHgYreJq+WNPKX?=
 =?us-ascii?Q?mCwQWtZsUaAEoWg/ag6KC3zEdnz23qg0L0+4fzxkr5mZSRiSLEXEE1CZ/Iyi?=
 =?us-ascii?Q?sDtiG2WeJLkNcUIvY3fjuJIgQTb+9IF6Mp8/vzQoNspaD9peqfBIbpjcTvky?=
 =?us-ascii?Q?Sbp3BxV4fG8jQ1p3W7qHJYw2zQe7bNdLRCKU2I20mfIG8koSQbyx1nmrzBtu?=
 =?us-ascii?Q?Ek19fOPfUlZ+YudEC5nljNXoVVA03QFyG6Z3IL2ZJxw9NQ/dsFC7e7H1Xj70?=
 =?us-ascii?Q?jnPxFBKpNxMlJGvL0xNKiFWwtwVkpHN8hasQR0mn8pCQebu?=
x-microsoft-antispam-prvs: <AM0PR04MB46757D710B0B28ED5644D065F6750@AM0PR04MB4675.eurprd04.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(366004)(346002)(136003)(396003)(39860400002)(199004)(189003)(316002)(97736004)(76176011)(6506007)(53546011)(486006)(6246003)(102836004)(54906003)(106356001)(99286004)(14454004)(229853002)(6486002)(44832011)(2906002)(105586002)(476003)(9686003)(6306002)(53936002)(6512007)(8676002)(6436002)(11346002)(45080400002)(25786009)(6116002)(66066001)(186003)(966005)(4326008)(81166006)(81156014)(5660300002)(86362001)(446003)(26005)(33716001)(256004)(6916009)(3846002)(7736002)(478600001)(1076003)(305945005)(8936002)(71190400001)(68736007)(71200400001)(21314003)(32563001)(473944003)(414714003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4675;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: XjRlRUoMNrHTjPfGU9WYCXIEtdaFuO2Faan92iiWsI5dknX+uBCKNk3/CNjo3fMLT/ImtGgvqrPXYFcLhjcDyM7zaKep0NbgQksnVoTWYadztZgwaXnCpFPtnlMwVm1L3g3ZtWdv1eCg4rp7tP3yxHsALlAEkfa3D1wt3v7XN0d/hVI3+0ak2m37dUu0PvAFZswIuAgIH7cyQEDAAmFfXTUkOj5QIvRidUNcng+4nxXIuNsPJEstq4moz+5yACDuzgeKAPv9mh0xdPf+4+uodR9aAawDpHbkE9LaoRNDAt80M1/eZsOb6VKrQ7elayh6depqTwFR1NJZt5XOzSDAHOqBfOCQmC4yGK2Wqa7LwRx0c3xQK1UJlEHW0CjJ7TlrUGtSzKhlKAE+tSnjQLuwCL/TP4UY/JwC5sdb1bkrDQQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4E1545967CACDF48A213374551BB4ED4@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf48f40f-a0cb-4883-23a0-08d69d891e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 14:29:16.0284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4675
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-02-28 22:15:46, Shawn Guo wrote:
> On Fri, Feb 15, 2019 at 06:07:23PM +0000, Abel Vesa wrote:
> > According to the schematics, this is a MP2147 switch converter
> > which is controlled by GPIO1_IO13. When set the gpio is set to
> > high the regulator output is set to 0.9V. When the gpio is set
> > to low the regulator output is set to 1V.
> >=20
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 36 ++++++++++++++++++++=
++++++++
> >  1 file changed, 36 insertions(+)
> >=20
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/=
boot/dts/freescale/imx8mq-evk.dts
> > index 54737bf..e5da3dd 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> > @@ -31,6 +31,35 @@
> >  		gpio =3D <&gpio2 19 GPIO_ACTIVE_HIGH>;
> >  		enable-active-high;
> >  	};
> > +
> > +	buck2_reg: buck2 {
>=20
> Please follow regulator-xxx naming convention.
>=20

Will do.

> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_buck2>;
> > +		compatible =3D "regulator-gpio";
> > +		regulator-name =3D "vdd_arm";
> > +		regulator-min-microvolt =3D <900000>;
> > +		regulator-max-microvolt =3D <1000000>;
> > +		gpios =3D <&gpio1 13 GPIO_ACTIVE_HIGH>;
> > +		states =3D <1000000 0x0
> > +			  900000 0x1>;
> > +		enable-active-high;
>=20
> The property only makes sense when enable-gpio is present?
>=20

Will remove it.

> Shawn
>=20
> > +	};
> > +};
> > +
> > +&A53_0 {
> > +	cpu-supply =3D <&buck2_reg>;
> > +};
> > +
> > +&A53_1 {
> > +	cpu-supply =3D <&buck2_reg>;
> > +};
> > +
> > +&A53_2 {
> > +	cpu-supply =3D <&buck2_reg>;
> > +};
> > +
> > +&A53_3 {
> > +	cpu-supply =3D <&buck2_reg>;
> >  };
> > =20
> >  &fec1 {
> > @@ -203,6 +232,13 @@
> >  };
> > =20
> >  &iomuxc {
> > +	pinctrl_buck2: vddarmgrp {
> > +		fsl,pins =3D <
> > +			MX8MQ_IOMUXC_GPIO1_IO13_GPIO1_IO13		0x19
> > +		>;
> > +
> > +	};
> > +
> >  	pinctrl_fec1: fec1grp {
> >  		fsl,pins =3D <
> >  			MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC			0x3
> > --=20
> > 2.7.4
> >=20
> >=20
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flis=
ts.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=3D02%7C01=
%7Cabel.vesa%40nxp.com%7C7f571130a0114fb84fe408d69d87606f%7C686ea1d3bc2b4c6=
fa92cd99c5c301635%7C0%7C0%7C636869602101094479&amp;sdata=3DvsNlfbgqglUuVsFy=
ULjTMm5Hqwd6chpsVa0V05ugDG0%3D&amp;reserved=3D0=
