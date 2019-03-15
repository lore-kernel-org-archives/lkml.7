Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41047C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0192D218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 10:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OdIxqO85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbfCOKYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 06:24:16 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:42902
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727428AbfCOKYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 06:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TEaOFRISQ0Nt5KrzjplqfP8WSlO8vByEvfL8tMIEriE=;
 b=OdIxqO853uIdeu0IggG8UPguu7wzD8jV/Hqnaa9op6M7nxUvSeJxD6TQdUw/h6Nz4Qdd3H5566Y2kDSIwJ6XU6ib2ChT+qKObbkGmTvrzh6QkCmoDKXmIFxPbMndcmE5atdRNKaWEYsXKNTaCjbRJzQR41MDc3MScqx1WS93UGU=
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com (52.134.92.158) by
 AM0PR04MB5396.eurprd04.prod.outlook.com (20.178.113.213) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.21; Fri, 15 Mar 2019 10:24:11 +0000
Received: from AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79]) by AM0PR04MB4211.eurprd04.prod.outlook.com
 ([fe80::50ed:d1b5:c043:3b79%2]) with mapi id 15.20.1709.011; Fri, 15 Mar 2019
 10:24:11 +0000
From:   Aisheng Dong <aisheng.dong@nxp.com>
To:     Peng Fan <peng.fan@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "van.freenix@gmail.com" <van.freenix@gmail.com>
Subject: RE: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Topic: [PATCH] arm64: dts: imx8qxp: add lsio_mu2 node
Thread-Index: AQHU2X6XfkrN9ckA80iUx9YseK0a4qYMf0+w
Date:   Fri, 15 Mar 2019 10:24:11 +0000
Message-ID: <AM0PR04MB4211FEB4C272759B84BCB6A180440@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <20190313093650.18693-1-peng.fan@nxp.com>
In-Reply-To: <20190313093650.18693-1-peng.fan@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aisheng.dong@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24cb4593-d32f-4772-0e2f-08d6a9305de6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5396;
x-ms-traffictypediagnostic: AM0PR04MB5396:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM0PR04MB5396;23:NcVzh7Uw493swYsJnfbsJu2f5dIb3w4/7cjhJDASr?=
 =?us-ascii?Q?E5lKUBfA4AMNTj3nkUknXT90nP79Bg7rCwNVeCwmgPQwQMdK4aI2ifJuf5z/?=
 =?us-ascii?Q?BV0FmUcg/KynXJb8UTRD3uOecMFH5AOjMjIfBYdiXjPulaW7Y6N13UHY//3C?=
 =?us-ascii?Q?P7eA5ZouviK69b65sKXDelo47aS89l9kvXyj1pthN9BNKkiGhPxtPrWTvKWi?=
 =?us-ascii?Q?GZOYx8W9UoP/Ei+RS+lT1SAgiKkRdR9k02I4yA9B3lcUEOBj5Abl4ouDpMNG?=
 =?us-ascii?Q?8QxIKOlfQk9cQAq7pzWK4GxGoD/fxbEALpj5VGiMI8MlYCRVpDwK8L9Kb1hQ?=
 =?us-ascii?Q?BF/Ktyv4/yXMI6rrh84J13MXKX9WYB6K+stcbh8QWSZXfp/R8kKy+SB0LKTI?=
 =?us-ascii?Q?nYAsBv+gqMRo2VbykMpOf5NxfauJ2d+AECuKIXEQ2OG7VzRCvXEuUkEoNIlM?=
 =?us-ascii?Q?a7WlVEv6fNEcgXqgMKr4Wdh7StxP5TvtlccuqSiSqmgjPUWSSyr3+/Q9gT4w?=
 =?us-ascii?Q?DBjgK4Xqv0Iksl+7RD7zm5qXqmSt8za9aUszbYV4tJfRdgHTUJa579/sHVK7?=
 =?us-ascii?Q?pyNDo4Ch4aw0UVHnYLd/fEg0Cik92u4f2fH8tQuYyu+HRNBffEY0pKk/rGKW?=
 =?us-ascii?Q?Ql3dWn3W/JeXAZhcf88moO043EWyjrzE8Kt5LtvQiqQ8jkQrTdPQYd3zvrHw?=
 =?us-ascii?Q?RKFMUDnBG5YyADN0Omc2kXsmeyouipBlAq906itW+RT6Q3+bu2X6J/1Zheng?=
 =?us-ascii?Q?bWIrevpyaq4olcR2O7YEoRMqInDZB1sh9JAkycCrjqkcDlFuH7u2Mrk29Jai?=
 =?us-ascii?Q?fsUp+Lix7eEiwTLuSiq8QcUkKu/7yjpeXbJFwwg72+J5hVTHhEkainPodqPh?=
 =?us-ascii?Q?boV3uJWxfCY+CRWJuxAIVg5soUDNskgDFySfIHZpvdiO2OZLXzkpowbp1zKp?=
 =?us-ascii?Q?CcWtvSuY+UTA8xu4+OfXnnntFZ4VG4HUeClmUGz/o66bsaGSxnbzqOnyjPqh?=
 =?us-ascii?Q?GPnZ0rNDDcJp3Bg4H8ag9QW9hn3qunfEGbmMO7jq6TjmYfWp9i4hRCdtIHel?=
 =?us-ascii?Q?mFwN3lbQeA7pSmIgukqgoU0A0sTnulBEzfWd+Y7avnuLy9DrkQVVcdIusGb6?=
 =?us-ascii?Q?cs5oJkKlK5UGHQY9M/ZYyH35ivBYBB22LdRJY6Fl/Tkv7eAPYcR1+TL75VH7?=
 =?us-ascii?Q?l6KHVIv1Gy9QPy7/5umOMEDoQJ+OuxDJtzTgkuTJCyX3J63eLpae74Jc0uyf?=
 =?us-ascii?Q?Uc3f3LXIbCZAjqymeYxiMj6awG5+F1UMD4mZ4vTP82GpJxvp16hsBZzyEoWM?=
 =?us-ascii?Q?6+wQsnw1GLRFGt6ylSqB9jy5BesoRiXYx2CqLpKAZqAoeIn5RylmgcWtEph8?=
 =?us-ascii?Q?wrEgw=3D=3D?=
x-microsoft-antispam-prvs: <AM0PR04MB53968D068A7E5F1525753BEB80440@AM0PR04MB5396.eurprd04.prod.outlook.com>
x-forefront-prvs: 09778E995A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(346002)(366004)(376002)(199004)(189003)(14444005)(33656002)(76176011)(256004)(53936002)(11346002)(446003)(25786009)(71190400001)(229853002)(71200400001)(6246003)(66066001)(2906002)(52536014)(476003)(486006)(68736007)(8936002)(7416002)(6436002)(14454004)(4326008)(9686003)(6116002)(3846002)(55016002)(7736002)(186003)(4744005)(26005)(102836004)(86362001)(99286004)(110136005)(316002)(97736004)(44832011)(305945005)(6506007)(7696005)(105586002)(2201001)(2501003)(106356001)(8676002)(81156014)(81166006)(5660300002)(478600001)(74316002)(32563001)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5396;H:AM0PR04MB4211.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UsUQOrywzvOG2D52CL4DnijO49emRCIxQJ6yDA058FgfosYj9C0d/0PSe9ADzmcRKThOBpTEJaxEDYOY4bSbhDlM7XTUAww+bItQSRFspJcJSPGjwVR65YcYI6yuXopWPfehjFEnY8t08r4ond4tSJeB1+baPbwmjtNXfd21dQPmEfOrsn0ywiTbhEhIr85LREZ3UsVmhZlmJ8umB5Kpg6+PQhk9dtvHMLs42Qh6Fi0rQ0tKvhemqyjAnuaXHoYjBucmKywBTVO8TD4z+89rkQ++y2Z7+yTEOj73lp+MfcpvfGC6mvZ44CiCSbfx6sfSV0t1JlL9DPR2DyvpoapNgp8jlcavDLpeGp/Ve/8zwpbiVobVMcJtWvNrwI/C71hDNUIVg9vb9cM+znr/GjIM6gVX9hHFQ4J6kB6rRpuHc8k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24cb4593-d32f-4772-0e2f-08d6a9305de6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2019 10:24:11.7205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5396
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Peng Fan
>=20
> Add lsio_mu2 node which could be used communicate with SCU.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> index 16766838ac77..64eecd6cb1e9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -339,6 +339,14 @@
>  			#mbox-cells =3D <2>;
>  		};
>=20
> +		lsio_mu2: mailbox@5d1d0000 {
> +			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
> +			reg =3D <0x5d1d0000 0x10000>;
> +			interrupts =3D <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> +			#mbox-cells =3D <2>;
> +			status =3D "disabled";
> +		};
> +
>  		lsio_mu3: mailbox@5d1e0000 {
>  			compatible =3D "fsl,imx8qxp-mu", "fsl,imx6sx-mu";
>  			reg =3D <0x5d1e0000 0x10000>;
> --
> 2.16.4

