Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29D0C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A95206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 03:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5955lWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfCEDAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 22:00:46 -0500
Received: from mail-eopbgr150050.outbound.protection.outlook.com ([40.107.15.50]:27107
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726522AbfCEDAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 22:00:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNivLwOA7KeFCKT5zONXNHf0tqb6tiC5oQfKKK6xSks=;
 b=W5955lWtkfKWmFZ4X7va8MiKOT0oUjYUVJOKoQ/zScKePDO1q2oQqbf1FTU3pqQ0vSiAer25lwDePnFbzdVeZkhVylfajorStRhawESg6W1Ll6jUFGD5OKO4+Fb1EzP1Uao7f7HZtm/Ar8/xNdHjY4NaazwyjlMc4fBJDKWg7Qw=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5842.eurprd04.prod.outlook.com (20.178.117.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.19; Tue, 5 Mar 2019 03:00:42 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1665.020; Tue, 5 Mar 2019
 03:00:42 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>
CC:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jacky Bai <ping.bai@nxp.com>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] pinctrl: freescale: fix link errors
Thread-Topic: [PATCH] pinctrl: freescale: fix link errors
Thread-Index: AQHU0siXMm/T+Al1I0+bP+tD9ymveqX8WLJQ
Date:   Tue, 5 Mar 2019 03:00:42 +0000
Message-ID: <AM0PR04MB42119B4C4FE9DE3A352A0FB480720@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190304202640.1765847-1-arnd@arndb.de>
In-Reply-To: <20190304202640.1765847-1-arnd@arndb.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7e362c6-e69f-4d52-8fde-08d6a116c16a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5842;
x-ms-traffictypediagnostic: AM0PR04MB5842:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;AM0PR04MB5842;23:qfnycLNB9M85ujoMjiUDuuzOJAEOeeSdPIi65zu?=
 =?iso-8859-1?Q?Lqhk/0cYTjiDTYThLHjjqjFdb/X/t+RzyRsuZGJI7/2tSg4r3CRBYgByQA?=
 =?iso-8859-1?Q?iWaXfUjIKYnVF3ZEHYjyocmaa00d2sp7qg5WVOrvpzUT/XJojWr6GmuZBv?=
 =?iso-8859-1?Q?c5ephynIRy42QMZUcfHAVBeFI7LbdsvYPLrv4tQuKzH3xus6GCVlrc9ifP?=
 =?iso-8859-1?Q?/5OSqUC5j2MS3YAAeivMclF493w6PUvkbQHUdsWVuSJ39VVC3KUnyCrvWN?=
 =?iso-8859-1?Q?B68iqlfBSBsALGXBMvRXA3UlWVPBc+0rPUskPRP16V7LfEGDm4G1k8oiok?=
 =?iso-8859-1?Q?5jwNTIlPhbmNN5PMxI6LW5KQgO4yEsQGa8mOXa8Btgb0GOD2vXsqeCg55U?=
 =?iso-8859-1?Q?cNp2i7LEsITM0qeXHAK7J7eJ7CL2uDuB0MFIG64tS7L+cRTI48K8JIf6Zr?=
 =?iso-8859-1?Q?Krsd9Y++Qk6Vc4uRtU7HIMWH/oUnwz6XFYGKVbqmh094PTQNId3uwgo5u/?=
 =?iso-8859-1?Q?zeQmavb9IEQTv7knn8UESRQspFAZBfR5r+MqsHfVdbgI3yTsCVwKbnqPLk?=
 =?iso-8859-1?Q?WK0aj0blU4a7VbD3uxsm+KMagCMKkdmbGsWSGYNHbJDUI6YHDC+6Vaf2ws?=
 =?iso-8859-1?Q?vHd7EWO2owt3tNyb0hgGRvHFl0SEu7mw2StyIinV2pN+N7sFdNRhgW+OfV?=
 =?iso-8859-1?Q?+QatUGxuLOG1p0z2n7LXzn5m0QuBol2JOTug/fEtI/HcDOgOpu5o27hZK1?=
 =?iso-8859-1?Q?R4H4oHabQkFik9v4HY3tsRcHeGydiuV32cAmCJVEujdofDrf/oC6C8KvK2?=
 =?iso-8859-1?Q?o7C5irWAp5Qqj7bHjUp9WKDt9jiA9t+Zurw3OhPxWC7CjxuTZeDf8o2vAt?=
 =?iso-8859-1?Q?YIB83CmM+9HTr/AnZXpqrhdQYERo0kTABPxN5XpRKro3szG0Ef+rg1roiH?=
 =?iso-8859-1?Q?sYYGDWVeO8oFacQTwI3kaosfMsDXqbT1EENCVPPkpqx5yvY9yBpFBwhqDP?=
 =?iso-8859-1?Q?5cQOf4XWWNOxuuonTTKsIUsQAHNPtpwjam+J0sqdzRJQVu0nWqDw/+ozFY?=
 =?iso-8859-1?Q?Pd83m5x7CnWJEtUGkhyLDr0o9HoTUOeGjaxMCX6HM4ec/yMx10RkeL7yiB?=
 =?iso-8859-1?Q?5lLrzeOaU78zn3F+F+BYLNMc3Z0vY+ofUv/urnk+wKUbXS4FeUUK4QTx9+?=
 =?iso-8859-1?Q?ifgZuGDrfOPBKJr31ioMlu5PvYDzEB0KmeMF3WV21foG33v58QjbFg5maK?=
 =?iso-8859-1?Q?wOT21PqnDH6Mt7gi00EbVjsI+NQtgXJfE8WmSwkYQp9gF3FWotW5uVDGZp?=
 =?iso-8859-1?Q?1Pv/qZ7Ldgus3wXi2ojRBZxzUbK8eghiTKkR/5uMGHgFmcEpH2qpGyeor9?=
 =?iso-8859-1?Q?W3kricok=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB58424EA03C0428ED1D874FB180720@AM0PR04MB5842.eurprd04.prod.outlook.com>
x-forefront-prvs: 0967749BC1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(53936002)(9686003)(66066001)(8676002)(25786009)(44832011)(54906003)(81156014)(81166006)(6116002)(3846002)(6246003)(74316002)(110136005)(105586002)(99286004)(7416002)(186003)(33656002)(478600001)(106356001)(52536013)(446003)(305945005)(6306002)(5660300002)(55016002)(7736002)(6436002)(2906002)(71200400001)(966005)(11346002)(71190400001)(14454004)(476003)(68736007)(97736004)(6346003)(4326008)(486006)(76176011)(8936002)(256004)(102836004)(316002)(229853002)(26005)(7696005)(6506007)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5842;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: uzSzSvW/fdgX0dYBynBCyj/R3HTtbjxLYbBr2IpOryVKjOLBP7qS10DHkz0CY+Nt7tDlPzvfusLhn/qyqdQ9Vo6shude1YNhzzL+K2Q2BqHFtMSgDWMRJVC9QqWVhHgKTdnZKy2vM9GfrpkIRDiYKSaTcKFFrDZUZG4qdEZPodgKstOIMBB2mVEljxVErW29fByHvmu9H6spuc9Mql5pjewX1bX3ROxlvJ2LUqUk4ppYrSLr0XzxHOjonrLgNvpauYNA2vzomYFkJbHHRGmXrYR6zW6BILrUlbNgBe7iGSZxJKZYWeVVqAgGAd4iw6zOiHpUhkJ7mOpJ8Du4HeBwC89+fACVsaZbzII3QbU6O4cmymsPNF8k7ls6VLBRI6RN6OL6mrJb5zFsPFIr6yltPLgYH+uZXX+uubs697ouQQQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e362c6-e69f-4d52-8fde-08d6a116c16a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2019 03:00:42.4751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5842
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Tuesday, March 5, 2019 4:26 AM
>=20
> Submitted by Anders Roxell already
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

How would suggest to handle this patch?

I've already given an Ack to Andres' v3 patch with a few additional comment=
s,
but seems did not see any follow ups.

https://lore.kernel.org/patchwork/patch/1034330/

Regards
Dong Aisheng

> ---
>  drivers/pinctrl/freescale/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pinctrl/freescale/Kconfig b/drivers/pinctrl/freescal=
e/Kconfig
> index e6dff3167a67..e447b996e79f 100644
> --- a/drivers/pinctrl/freescale/Kconfig
> +++ b/drivers/pinctrl/freescale/Kconfig
> @@ -138,14 +138,14 @@ config PINCTRL_IMX8MQ
>=20
>  config PINCTRL_IMX8QM
>  	bool "IMX8QM pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on ARCH_MXC && ARM64 && IMX_SCU
>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qm pinctrl driver
>=20
>  config PINCTRL_IMX8QXP
>  	bool "IMX8QXP pinctrl driver"
> -	depends on ARCH_MXC && ARM64
> +	depends on ARCH_MXC && ARM64 && IMX_SCU
>  	select PINCTRL_IMX_SCU
>  	help
>  	  Say Y here to enable the imx8qxp pinctrl driver
> --
> 2.20.0

