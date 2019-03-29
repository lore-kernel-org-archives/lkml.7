Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D163CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD662082F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 09:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VYQywVbl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbfC2J2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 05:28:06 -0400
Received: from mail-eopbgr150049.outbound.protection.outlook.com ([40.107.15.49]:27990
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfC2J2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 05:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4nYfXiIQzcQvlJjBA6z8HQZBxYWRzIOQFFo80VxsIg=;
 b=VYQywVblT6L7DyUBW9lcw+iVWP9+jA0h4UfU+iOhfK87ZWoRjEn+wVCySQRd5LCfCkdH1CItO3uWUtkuOQ+RcjQnUd6wy5BkPaqh+EyDgWr2+EZs8gryBmj8c7Uuc1vaIN87ovz8GZicXQBRqPjTgNjtOkJl1hxfbFSsLFbJ0Jc=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB6004.eurprd04.prod.outlook.com (20.178.114.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Fri, 29 Mar 2019 09:28:01 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::4514:91e2:16b7:ee2b%4]) with mapi id 15.20.1750.014; Fri, 29 Mar 2019
 09:28:01 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Christina Quast <cquast@hanoverdisplays.com>
CC:     "festevam@gmail.com" <festevam@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
Thread-Topic: [PATCH v2] dt-bindings: pinctrl: imx7d: Fix PAD_CTL_DSE_X*
Thread-Index: AQHU2af7cbSmi8TJKEC1UrPKPbJyuaYib8jg
Date:   Fri, 29 Mar 2019 09:28:01 +0000
Message-ID: <AM0PR04MB4211EBAB9D3DB1772FB51673805A0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313142040.26694-1-cquast@hanoverdisplays.com>
In-Reply-To: <20190313142040.26694-1-cquast@hanoverdisplays.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08023027-1180-45e4-e010-08d6b428d6c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB6004;
x-ms-traffictypediagnostic: AM0PR04MB6004:
x-microsoft-antispam-prvs: <AM0PR04MB60040F4EC0BB61B2384F2D40805A0@AM0PR04MB6004.eurprd04.prod.outlook.com>
x-forefront-prvs: 0991CAB7B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(136003)(366004)(376002)(346002)(396003)(39860400002)(199004)(189003)(105586002)(3846002)(6436002)(76176011)(256004)(52536014)(44832011)(7416002)(6916009)(86362001)(106356001)(7736002)(446003)(2906002)(486006)(33656002)(6246003)(26005)(4326008)(54906003)(68736007)(186003)(97736004)(102836004)(66066001)(8676002)(71200400001)(9686003)(74316002)(229853002)(478600001)(305945005)(99286004)(25786009)(6506007)(6116002)(7696005)(316002)(476003)(55016002)(8936002)(71190400001)(5660300002)(14454004)(81166006)(53936002)(11346002)(81156014)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6004;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: x/hkow76/dBsjCjONBR2stUq/Qg/NlMqz+hPs5zXQNT2dsrNg0xZ5HDOnkDe/FUmIqvvEmlVPdMiKVPMEqx9OgJ20aDqF/VBCuwPWsDPEtUqVT9Mmc5zVmg3PGdFZKBpS6nnPVhOUTMC0auh0UL22jvnH2LlOtUG5J+yeLake5PxvI0foCNEbTMEc0c4a7bDr4hYjEtULHoYz1Xtaf7C4QyQ/zBNkUqXx/Zc4dJ7cPxj6/lhlhlTOVp1+Tbbj2TYVzKhDhGeOJ7S7zquJaC5Q2LmA81cqNIUVUzcazBz+mQKtmLNwkdSg2pfPDl+qqN2Ij27gGUSsOm+0ZNOdcrG/5tDHilrhJ6jHe+m0MrzEcOVJDU0+7Bcai2N7+Iwsuw0n0AmUGU7nPR+d5c4Hx7GBZqdbwWOxJ4A3I2BDnKos4I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08023027-1180-45e4-e010-08d6b428d6c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2019 09:28:01.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6004
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Christina Quast [mailto:cquast@hanoverdisplays.com]
> Sent: Wednesday, March 13, 2019 10:21 PM
>=20
> In the iMX7d datasheet, the PAD_CTL_DSE_X* values are different from the
> documentation.
>=20
> Changes since v2:
> * Changed patch title to 'dt-bindings: pinctrl: imx7d:'
>=20
> Signed-off-by: Christina Quast <cquast@hanoverdisplays.com>

Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  .../devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt       | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.=
txt
> b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> index 6666277c3acb..8ac1d0851a0f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.txt
> @@ -48,9 +48,9 @@ PAD_CTL_HYS                     (1 << 3)
>  PAD_CTL_SRE_SLOW                (1 << 2)
>  PAD_CTL_SRE_FAST                (0 << 2)
>  PAD_CTL_DSE_X1                  (0 << 0)
> -PAD_CTL_DSE_X2                  (1 << 0)
> -PAD_CTL_DSE_X3                  (2 << 0)
> -PAD_CTL_DSE_X4                  (3 << 0)
> +PAD_CTL_DSE_X4                  (1 << 0)
> +PAD_CTL_DSE_X2                  (2 << 0)
> +PAD_CTL_DSE_X6                  (3 << 0)
>=20
>  Examples:
>  While iomuxc-lpsr is intended to be used by dedicated peripherals to tak=
e
> --
> 2.20.1

