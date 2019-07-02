Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F069C5B57D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F76216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 07:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqJ+1Fta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGBHLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 03:11:01 -0400
Received: from mail-eopbgr40081.outbound.protection.outlook.com ([40.107.4.81]:15589
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725802AbfGBHLB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 03:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml8b3bmleiJ+EnnNbsC/cfZEUZOZ5DfDOhuK5hwN9zM=;
 b=TqJ+1FtaPs4svkf9KHdXrh6I8tNfzC5TnaXXznLb/qDMh9qddsD9vpyQyZrnP9p5Si24xvQqSQ1bfSibyCi6GD6NufjpNnF2qmbX5LslPk59W7CiNkkMZ1xU1O5SMRdAurjgXZy6PHr8ZxWTtOWITWPkSNwbfS8cLbJmgeQGXLE=
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com (20.178.202.151) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (52.135.144.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Tue, 2 Jul 2019 07:10:55 +0000
Received: from AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367]) by AM0PR04MB5779.eurprd04.prod.outlook.com
 ([fe80::a126:d121:200:367%7]) with mapi id 15.20.2032.019; Tue, 2 Jul 2019
 07:10:55 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        Jacky Bai <ping.bai@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "angus@akkea.ca" <angus@akkea.ca>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 1/2] arm64: dts: imx8mq: Add gpio-ranges property
Thread-Topic: [PATCH 1/2] arm64: dts: imx8mq: Add gpio-ranges property
Thread-Index: AQHVMHjq3v4Y93P/8kSdLqwCVV5mEqa26aEA
Date:   Tue, 2 Jul 2019 07:10:55 +0000
Message-ID: <20190702071054.t7v4fis436klmgdv@fsr-ub1664-175>
References: <20190702014400.33554-1-Anson.Huang@nxp.com>
In-Reply-To: <20190702014400.33554-1-Anson.Huang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=abel.vesa@nxp.com; 
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c79e1b-52b7-457e-c958-08d6febc6cca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB4659;
x-ms-traffictypediagnostic: AM0PR04MB4659:
x-microsoft-antispam-prvs: <AM0PR04MB4659EA7D8730C11BD0287DF7F6F80@AM0PR04MB4659.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-forefront-prvs: 008663486A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(376002)(136003)(346002)(39860400002)(396003)(366004)(199004)(189003)(4326008)(256004)(26005)(66556008)(186003)(1076003)(5660300002)(66476007)(66946007)(6862004)(25786009)(91956017)(76116006)(64756008)(14454004)(66066001)(6506007)(6116002)(99286004)(76176011)(3846002)(86362001)(68736007)(53546011)(102836004)(6636002)(6486002)(305945005)(2906002)(73956011)(229853002)(8936002)(66446008)(53936002)(6246003)(8676002)(54906003)(81156014)(81166006)(316002)(9686003)(6512007)(486006)(478600001)(476003)(6436002)(7416002)(44832011)(71190400001)(71200400001)(11346002)(446003)(7736002)(33716001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:AM0PR04MB5779.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ComcYnyxFhySALoTX5PEsZQpWkkN/p8wk6gTcvt3jW+3khhBp2I1MuOntVhDfrSC0SUwoH6LBikWyd4+IhJRvO+CKVMzu2dGfBqqL5nUQXPj7phrvVygY3k+eVCOaM+TuOP2/b5GeXny5gpunsOf4Gy2PZiQnCbUDLPx956LBVi9Kl1DIbPXys1cXycaRFSHTMMnRUTOxX5LbObeVBoO7MOoqVF+jRzBKjmbiGiG7W5rUJjGKNAzV+40PJK0jbRnzBPVsRfmA+6OGhC9PxZNCZPBA2sCPX2IbCOO3Al+7K5sVQCl5PqP5wYJCj7fLEUiHMnwAbELlKUzjLGl51T9NOeS7grlBVCkHjh8E75vpJZBjJrD00KY9GyM/sr+KVD2PUIRTeAjxqi9i1z3cdyTCKdeVXEJVtL6q0y1HHu80t4=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <61459D010418E24189C3AAB936B4F9BA@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c79e1b-52b7-457e-c958-08d6febc6cca
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2019 07:10:55.1010
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: abel.vesa@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-07-02 09:43:59, Anson.Huang@nxp.com wrote:
> From: Anson Huang <Anson.Huang@nxp.com>
>=20
> Add "gpio-ranges" property to establish connections between GPIOs
> and PINs on i.MX8MQ pinctrl driver.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

For both patches:

Reviewed-by: Abel Vesa <abel.vesa@nxp.com>

> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mq.dtsi
> index 477c523..3187428 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -287,6 +287,7 @@
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
>  				#interrupt-cells =3D <2>;
> +				gpio-ranges =3D <&iomuxc 0 10 30>;
>  			};
> =20
>  			gpio2: gpio@30210000 {
> @@ -299,6 +300,7 @@
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
>  				#interrupt-cells =3D <2>;
> +				gpio-ranges =3D <&iomuxc 0 40 21>;
>  			};
> =20
>  			gpio3: gpio@30220000 {
> @@ -311,6 +313,7 @@
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
>  				#interrupt-cells =3D <2>;
> +				gpio-ranges =3D <&iomuxc 0 61 26>;
>  			};
> =20
>  			gpio4: gpio@30230000 {
> @@ -323,6 +326,7 @@
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
>  				#interrupt-cells =3D <2>;
> +				gpio-ranges =3D <&iomuxc 0 87 32>;
>  			};
> =20
>  			gpio5: gpio@30240000 {
> @@ -335,6 +339,7 @@
>  				#gpio-cells =3D <2>;
>  				interrupt-controller;
>  				#interrupt-cells =3D <2>;
> +				gpio-ranges =3D <&iomuxc 0 119 30>;
>  			};
> =20
>  			tmu: tmu@30260000 {
> --=20
> 2.7.4
> =
