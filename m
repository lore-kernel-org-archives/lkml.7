Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7266DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4429D2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8ovulrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfC2JKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:10:33 -0400
Received: from mail-eopbgr30076.outbound.protection.outlook.com ([40.107.3.76]:3394
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728775AbfC2JKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQyLy4X7U5wm2qP8Yj48d6RMJn7bzd8+mqzGhiiTO04=;
 b=m8ovulrbWZ2YAtZnIWeUp3epZsYwAHejssO6+HXGQfPNsHtNCrzjwWuByw4pHmE8DpN3LiMeHg78q5nw8pYg8IbJf3pMxiHEvJXfr8EyPosiNkheGbU7Bkm7Shl+uF8T3K3VJENK6fL4rkTUdXs5slJkaa9dIIS9KOej+snJnEk=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB4721.eurprd04.prod.outlook.com (20.176.214.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 09:10:27 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 09:10:27 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Carlo Caione <ccaione@baylibre.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        =?iso-8859-1?Q?Guido_G=FCnther?= <agx@sigxcpu.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Subject: RE: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Topic: [PATCH 1/4] arm64: dts: imx8mq: Fix the fsl,imx8mq-sdma
 compatible string
Thread-Index: AQHU5WuctWDkyXcHbE2Ey/RFHTIe5KYiOjaA
Date:   Fri, 29 Mar 2019 09:10:27 +0000
Message-ID: <AM0PR04MB421112C3EE79B279953A9252805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190328133828.20999-1-angus@akkea.ca>
 <20190328133828.20999-2-angus@akkea.ca>
In-Reply-To: <20190328133828.20999-2-angus@akkea.ca>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1b1b392-bb5b-4ba0-4e90-08d6b42662d7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4721;
x-ms-traffictypediagnostic: AM0PR04MB4721:
x-microsoft-antispam-prvs: <AM0PR04MB4721661F2F57A0C87E44E4C6805A0@AM0PR04MB4721.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(366004)(376002)(199004)(189003)(476003)(7736002)(74316002)(26005)(6506007)(8676002)(4744005)(53936002)(229853002)(6436002)(7696005)(71200400001)(71190400001)(186003)(81156014)(68736007)(4326008)(8936002)(76176011)(33656002)(102836004)(86362001)(6916009)(99286004)(316002)(81166006)(256004)(66066001)(14444005)(54906003)(6246003)(44832011)(5660300002)(7416002)(305945005)(105586002)(106356001)(11346002)(9686003)(52536014)(446003)(2906002)(55016002)(25786009)(14454004)(478600001)(6116002)(3846002)(486006)(97736004)(142933001)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4721;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KUpsWV8YLQGG8K+OE6+LZe5jBNUQ+xUuNkFbQluyngcv2e+HwBlMatZjkN/XoR76r9qW0524ENm1PfJn/1QFam3jvw4KSxBA2ZhlCIIKgOieii2cVfwvs5nECpPsah3VuiYZMJPaVQXWj+CHQ0TzKBe/XYIX6XIeB+L8mLXk8lt6K6O4lJr/+bSlKHYLuU4nXvkQC7OXQwNtkqUHgpQONjjBOBnJC8082QDDAxs0x67X8KxIs9Rm6yDeCv3WOCBwm8QYZgweK/n4119i+jDC46x4VvMlAag8pStkOwatUJc5yXRPp8gSjR8ftbDkqiE24JWlFljH/7l77SRvGqq+ChIKoba96RfyeLo7AEShbtZXk38i3yknOH2WmgRsViI7zAW9NctgILXAv0+Ql6nKun1RkSBoq81e3fwbciYyAik=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b1b392-bb5b-4ba0-4e90-08d6b42662d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 09:10:27.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4721
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Angus Ainslie (Purism) [mailto:angus@akkea.ca]
> Sent: Thursday, March 28, 2019 9:38 PM
>=20
> Fix a typo in the compatible string
>=20
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> index 81d5ce1b1ec1..07099f82965e 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> @@ -720,7 +720,7 @@
>  			};
>=20
>  			sdma1: sdma@30bd0000 {
> -				compatible =3D "fsl, imx8mq-sdma","fsl,imx7d-sdma";
> +				compatible =3D "fsl,mx8mq-sdma","fsl,imx7d-sdma";

This is a bit strange.
If binding doc says like that, probably we'd better fix the typo in binding=
 doc
to use the same style.

Regards
Dong Aisheng

>  				reg =3D <0x30bd0000 0x10000>;
>  				interrupts =3D <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks =3D <&clk IMX8MQ_CLK_SDMA1_ROOT>,
> --
> 2.17.1

