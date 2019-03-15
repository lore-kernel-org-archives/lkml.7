Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E906EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE72E218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 11:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGIPIy2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbfCOLGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 07:06:52 -0400
Received: from mail-eopbgr150043.outbound.protection.outlook.com ([40.107.15.43]:56812
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726213AbfCOLGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 07:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=APgW5//lhoTceyewWWYXlSzefdwXfZl+rXESDAfbnt4=;
 b=OGIPIy2+eYah9H8PU1CP7phWeIsXv+c83vI+8FUPFlOnzJB0Gc+3wEJmU6qUea8PLbOzgwffsuRq3XUX8dKZOzd348BrqdO6q6sx+0LB0IR6lqGldX6WHxLqNCQjK0fXTyhQO/Yg4nl54MucOSc2WZErH2qE0x9cyY+xMJAsyvI=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5475.eurprd04.prod.outlook.com (20.178.113.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Fri, 15 Mar 2019 11:06:47 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 11:06:47 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Anson Huang <anson.huang@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH V4 3/4] arm64: dts: freescale: imx8qxp: enable scu general
 irq channel
Thread-Topic: [PATCH V4 3/4] arm64: dts: freescale: imx8qxp: enable scu
 general irq channel
Thread-Index: AQHUycaPfOeIoVylOEa4TMjNpsfSQqYMqnMQ
Date:   Fri, 15 Mar 2019 11:06:47 +0000
Message-ID: <AM0PR04MB4211B9EE638042D10E0E7ED680440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1550740354-2701-1-git-send-email-Anson.Huang@nxp.com>
 <1550740354-2701-3-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1550740354-2701-3-git-send-email-Anson.Huang@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2bf56e8-80ef-46e1-5d46-08d6a9365104
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5475;
x-ms-traffictypediagnostic: AM0PR04MB5475:
x-microsoft-antispam-prvs: <AM0PR04MB547505ED3A35C6160ABE985B80440@AM0PR04MB5475.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(396003)(376002)(136003)(199004)(189003)(66066001)(256004)(2501003)(71200400001)(71190400001)(33656002)(478600001)(14454004)(186003)(76176011)(52536014)(5660300002)(99286004)(25786009)(6506007)(106356001)(110136005)(26005)(102836004)(7696005)(105586002)(4744005)(4326008)(229853002)(7736002)(81156014)(305945005)(3846002)(6116002)(81166006)(6246003)(9686003)(2906002)(55016002)(53936002)(97736004)(6436002)(74316002)(446003)(68736007)(486006)(476003)(8936002)(2201001)(86362001)(316002)(8676002)(11346002)(7416002)(44832011)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5475;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dC2mnWkMAfBHiYe4hftShEhc69EbU6Svqb1L8ifdkTKfsaW+nFZZ90UhMfd/xJunVtyiJKpxvfPzng979scMyBp91Bsx776XOGMv4hwK1404YPXCBLUXtPxzuX8UsuzycVo7xslq4yoeKirSgpmg6c63brmupgCMzyLcaRLwBRSGP+dbAgbGv0RGO/mpEL/jiQVuFvM07fZGgs58SH+vpvSZipkFAwEshC4Pe0dCq8ClpvrrrYv9edLz5hZaq6YO160sY5eeA5B1WaVbcd7BeJ3QuVHccoi03tYwrnAuM4gKcPCWi2k2Ar7kjVFbpxehxDgdRvgzBcN8Vrc4lz+fRo5oTC4wlnz7WQkDfp5irzmGOdgxJfOze5vwmUWd8zb80TjPH7awvwU/+wCFabFdXPdijaYzS0sRns+nXuGDthg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bf56e8-80ef-46e1-5d46-08d6a9365104
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 11:06:47.1762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5475
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Anson Huang
>=20
> On i.MX8QXP, SCU uses MU1 general interrupt channel #3 to notify user for
> IRQs of RTC alarm, thermal alarm and WDOG etc., mailbox RX doorbell mode =
is
> used for this function, this patch adds support for it.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V3:
> 	- rename "gi3" to "gip3";
> 	- add alias for getting mu id by driver.
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 4c3dd95..f0a9224 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -21,6 +21,7 @@
>  		mmc1 =3D &usdhc2;
>  		mmc2 =3D &usdhc3;
>  		serial0 =3D &adma_lpuart0;
> +		mu1 =3D &lsio_mu1;

Need add aliase in binding doc.

Otherwise:
Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng
