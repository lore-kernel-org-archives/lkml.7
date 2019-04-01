Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7901BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC0A2086C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:38:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Xj9X4bcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbfDAIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:38:44 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.2]:43476 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731774AbfDAIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:38:43 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-a.eu-central-1.aws.symcld.net id 72/54-01822-A0EC1AC5; Mon, 01 Apr 2019 08:38:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1VTe0xTVxzm9N5bbpGaQ0H52YhZOiYRaG1ZMi7
  GRLPtj5slRI1LliwYuYU72tkW7IPBkin+4QtfhE3IrmKtA53IbFYmUB8ZqcE4xQdUUGGQMNCI
  4ATqK6DEe7n19c/Jd77vy3e+38k5NKEZV2ppvszNOx2cTaeMIy3L6Wx93HVfnrHh94+YGwMhg
  hnqWcM0HgySTGC4l2Iqp08STPjsYSUTOngBMQ/+SmaE/mpqtYoN93YRbFAYiGUDjbuVbHP9Vj
  bYFlGwf/7fpmAPvDKykcAStv9+C7lW9S1ldZiLy/Ipyxn/dqLkQFzZ7KkBZQX6l65EcTSJ/QS
  MddQQ0kaD9ymga7AKyZtBBLX3OkRFRSuxCY6MP0YSTsJfQ2ekds5E4IgCXrZMKSUhEedARWBM
  IZtWwIPxICXjLJj2bhc9tHheKkzvyJdoNd4ANZeHSQlr8GfQsLeBkCwqnA31vXaJRjgFnmw7N
  VeBwMnQN+KdSweMof78DULGC2B0eJaS/Rth59+PYmU+E67dHkEy1sHxOwIl4xTo9u6J8rkQqZ
  6IZvYhON2dION0aB8XorwWng9PRjNtUFtRR0o1AS+Grie50i0AfkyBf6oHyaMUwETdtah/CTT
  uGyJl000Cap5WxsrDZMLRc1PKKrRMeG824T1Jxhlw3DdGCHPXlQD//DpCHkVkI8oxO61FFred
  s9r0JqNRbzJ9qs8S12wD96OeM/AefQHvcDs5UTVwP7gMrnJ7ga3Q4ODdASS+vMLNCk8bqjlRF
  EKLaIVugfp+wJenmW8uLiy3cC7LRqfHxrtCaDFN60B9+6qoJTj5Ir7sO6tNfL5vZKDjdUnq0k
  5RVrtKOLvLWiRLV5Cebj82VEdoSEexg9cmq2ekDCyZLB7H24g3n6AbpWgT1SgmJkYTX8I77Vb
  3h/pDlEwjXaI6LKXEWx3utyc9FEsoxBKMxyuVcHPvJG0F+skbDDelh7bUfn/oKRi/pKp9zy5N
  fWy990Uu5O1aOGP4ef35S8uF/fnrhFcnwyc2vQifafjEvMUAI6rrwnq/P2lHRtbSZWzTzKx53
  ucX/1hZrmcPpd3yPbow2ZmaX7pnMmUVOfpN24ZfWkdbD08U25rw3atpOQM9//WMaaq++q051a
  AjXRbOlE44XdxrkX+kuf8DAAA=
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-24.tower-229.messagelabs.com!1554107914!3600228!1
X-Originating-IP: [104.47.8.55]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24133 invoked from network); 1 Apr 2019 08:38:34 -0000
Received: from mail-am5eur03lp2055.outbound.protection.outlook.com (HELO EUR03-AM5-obe.outbound.protection.outlook.com) (104.47.8.55)
  by server-24.tower-229.messagelabs.com with AES256-SHA256 encrypted SMTP; 1 Apr 2019 08:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzDg8buSFcx0QoZ/XPUNq430fqVLRDgqbMSSY2+uWwo=;
 b=Xj9X4bcVEU6XtfaWdtNDHZ5sLyBZqE9Dwgv5WEZtU+9MQEiOlfWwXUlzw4wQFDe5yhQZW4H3nS9Raj3O0ENmWRCqypVG+PorNP/qpI+cFy4h6b2gKo1MCBBPcA8i88eDV/J8thRO0yUf6cgfCnVzWbjFtpOvCsRL6kwwM7PNadw=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB2493.EURPRD10.PROD.OUTLOOK.COM (20.177.59.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 08:38:29 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1730.019; Mon, 1 Apr 2019
 08:38:29 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Fabio Estevam <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     PENGUTRONIX <kernel@pengutronix.de>, IMXNXP <linux-imx@nxp.com>,
        "smoch@web.de" <smoch@web.de>, ARMLINUX <linux@armlinux.org.uk>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        LINUX-ARM-KERNEL <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: RE: [RFC] ARM: dts: imx: Fix the AR803X phy-mode
Thread-Topic: [RFC] ARM: dts: imx: Fix the AR803X phy-mode
Thread-Index: AQHU5xBo9FEhKNvi8keBVb+5B6eIiqYm+GPQ
Date:   Mon, 1 Apr 2019 08:38:28 +0000
Message-ID: <VI1PR10MB2352F3C08CADD6029FF77FF3FE550@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190330155051.9855-1-festevam@gmail.com>
In-Reply-To: <20190330155051.9855-1-festevam@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bb8b62c-e57e-4d8a-a01e-08d6b67d6a4c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB2493;
x-ms-traffictypediagnostic: VI1PR10MB2493:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR10MB2493EFE9CB55D504210D78A5F5550@VI1PR10MB2493.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(366004)(39850400004)(136003)(189003)(199004)(11346002)(25786009)(66066001)(446003)(6116002)(107886003)(476003)(6246003)(486006)(3846002)(7696005)(76176011)(6306002)(4326008)(53546011)(55016002)(9686003)(186003)(110136005)(6506007)(53936002)(54906003)(316002)(8936002)(81156014)(105586002)(2906002)(8676002)(99286004)(26005)(33656002)(97736004)(102836004)(2501003)(106356001)(256004)(81166006)(86362001)(6436002)(478600001)(52536014)(14454004)(305945005)(966005)(229853002)(74316002)(71200400001)(7736002)(71190400001)(5660300002)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2493;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: y6bCkekUdxHrv12ufYZK0V9fpMrMzr7q3ZNvePEdXIrvfiroDpoJv/iJsuQ48L4Dvqd43YfkE73irFpfmS2AM/EWpCpfWMbQ6NP+mqaNMR5y4RNXualyNeh7FuH2KnSxSV6+E0GPCU6dq38+eFNFvkVFCiAefNMeQhfGAtiZujuqJuvNe1KhlqN+QpI7ecvKJ+3VwzySeco29ewpv8OvxARIdGfVegN9loK/F4G6bNJC/zk1oDdY1TaDbbto98s8u0IoLqUqfsQ6Y/1rXRb7OyFM7zGS3LIlE7qJejk/dBBQvC3NUETmU3hP3QXcz1wh+b70iJn4HBJolBEsjplKaSngwX0qz0tHr7GY4en0V+GDAZ/zNfxbg5cFrrsSJKZPhs72SNyuVHNXZ0xOI3UxFG9V9TrDKmwVD1DqxvJoBtk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb8b62c-e57e-4d8a-a01e-08d6b67d6a4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 08:38:28.8806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2493
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 30 March 2019 15:51 Fabio Estevam, wrote:

> Subject: [RFC] ARM: dts: imx: Fix the AR803X phy-mode
>=20
> Commit 6d4cd041f0af ("net: phy: at803x: disable delay only for RGMII mode=
")
> exposed an issue on imx DTS files using AR8031/AR8035 PHYs.
>=20
> The end result is that the boards can no longer obtain an IP address
> via UDHCP, for example.

[...]

>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi   | 2 +-

[...]

> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index a0705066ccba..185fb17a3500 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -202,7 +202,7 @@
>  &fec {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&pinctrl_enet>;
> -	phy-mode =3D "rgmii";
> +	phy-mode =3D "rgmii-id";
>  	phy-reset-gpios =3D <&gpio1 25 GPIO_ACTIVE_LOW>;
>  	status =3D "okay";
>  };

[...]

This patch looks surprisingly similar to this one ;)
https://lore.kernel.org/patchwork/patch/1052588/

Link: https://lkml.kernel.org/r/1397569821-5530-4-git-send-email-thomas.pet=
azzoni@free-electrons.com
Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
Tested-by: Adam Thomson <Adam.Thomson@diasemi.com>
Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve

