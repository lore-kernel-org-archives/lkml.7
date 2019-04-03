Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94074C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C26421473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 08:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fMUWvIKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbfDCI2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 04:28:23 -0400
Received: from mail-eopbgr20069.outbound.protection.outlook.com ([40.107.2.69]:58394
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726004AbfDCI2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 04:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJnKVJQCxk5V2rMJyDNV96gvZVJ2XqQpqQ+iDoNAiyg=;
 b=fMUWvIKjyrCPQjVCDkruHDoQLWWtsJSaEFAGIy1gFD5RDZYU9TD1dU6FZW6tqzQeu0pOY41ncEbok6QnRQidVyTDeo4HAItHJ8WbY915voFsWiJRBGdGTpxxif3NSGkEQ1xifqybUyXx0Ue+YzIUD5Htbx/cmK86NWZe/guOcFY=
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com (20.177.48.221) by
 VI1PR04MB6317.eurprd04.prod.outlook.com (20.179.24.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.15; Wed, 3 Apr 2019 08:27:39 +0000
Received: from VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2980:9bad:dad5:b9a0]) by VI1PR04MB4800.eurprd04.prod.outlook.com
 ([fe80::2980:9bad:dad5:b9a0%2]) with mapi id 15.20.1750.021; Wed, 3 Apr 2019
 08:27:39 +0000
From:   Vabhav Sharma <vabhav.sharma@nxp.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Leo Li <leoyang.li@nxp.com>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUzbuN4akhuqbX10Ke5fel48DmPqYqUetA
Date:   Wed, 3 Apr 2019 08:27:38 +0000
Message-ID: <VI1PR04MB480070B517B9D9961C9E8187F3570@VI1PR04MB4800.eurprd04.prod.outlook.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
 <1551132245-6089-2-git-send-email-vabhav.sharma@nxp.com>
In-Reply-To: <1551132245-6089-2-git-send-email-vabhav.sharma@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vabhav.sharma@nxp.com; 
x-originating-ip: [92.121.36.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dc9b5c7-0760-487a-aed4-08d6b80e3bb4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:VI1PR04MB6317;
x-ms-traffictypediagnostic: VI1PR04MB6317:
x-microsoft-antispam-prvs: <VI1PR04MB63178EDD84E1444AC7487EC7F3570@VI1PR04MB6317.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(39860400002)(376002)(199004)(13464003)(189003)(74316002)(102836004)(7696005)(81166006)(25786009)(9686003)(3846002)(478600001)(33656002)(6246003)(71190400001)(4326008)(316002)(26005)(71200400001)(6436002)(97736004)(55016002)(53936002)(446003)(5660300002)(99286004)(44832011)(186003)(106356001)(110136005)(76176011)(8936002)(54906003)(305945005)(11346002)(6116002)(66066001)(2906002)(2501003)(81156014)(476003)(53546011)(52536014)(68736007)(14454004)(14444005)(105586002)(6506007)(7736002)(256004)(229853002)(486006)(8676002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6317;H:VI1PR04MB4800.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Vsl0qMeWjZAi0RD41P40NeDIAxV90LyzvnEsL3EwBCGI4B2xb8sXR03entC9Px9iBMweYT/x60xLnpda9S0cA2qi6dsQUBPlpF+41y3YL9zOiiFe1j4VqgwQqDGLa7L6/RFPXD0c98Gtt76y7EXK/by4L0x88DcIXrMay9CTBTOLV1mexm7XzTDinXyM0L7DbEk/cdPi3Fp5tnk+45HfZX63+AE0DmEn7gsQq+uBE0gefuD9QBi+OCyWTYUD3Yk0QWyM6TB6spLGjHK9xyHxAeF0jyxu1Kbpvv5FUN/OhApFYehaOvnWgTITMiz2DMlMIb4qPpdmtiPPnu+dkgdgaNltGLeaUZY9wTdAYyAwI5dTXc52iX+JHjN2ItJ8hXKGLx4CY7y7G5L3k4FJRDqSi058URdVOm9xelLEOcyhpcE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dc9b5c7-0760-487a-aed4-08d6b80e3bb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 08:27:38.9133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6317
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maintainers,
Please merge below patch.

Regards,
Vabhav

> -----Original Message-----
> From: Vabhav Sharma <vabhav.sharma@nxp.com>
> Sent: Tuesday, February 26, 2019 3:41 PM
> To: sudeep.holla@arm.com; oss@buserror.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-
> pm@vger.kernel.org; linux-kernel-owner@vger.kernel.org;
> catalin.marinas@arm.com; will.deacon@arm.com;
> gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; shawnguo@kernel.org
> Cc: linux@armlinux.org.uk; adrian.hunter@intel.com;
> ulf.hansson@linaro.org; Vabhav Sharma <vabhav.sharma@nxp.com>
> Subject: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
>=20
> Add compatible for LX2160A SoC,QDS and RDB board Add lx2160a
> compatible for clockgen and dcfg
>=20
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/arm/freescale/fsl,layerscape-dcfg.txt           |  2 +-
>  Documentation/devicetree/bindings/arm/fsl.txt                | 12 ++++++=
++++++
>  Documentation/devicetree/bindings/clock/qoriq-clock.txt      |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,layersca=
pe-
> dcfg.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape=
-
> dcfg.txt
> index b5cb374..dc76046 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-
> dcfg.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-dcf
> +++ g.txt
> @@ -8,7 +8,7 @@ Required properties:
>    - compatible: Should contain a chip-specific compatible string,
>  	Chip-specific strings are of the form "fsl,<chip>-dcfg",
>  	The following <chip>s are known to be supported:
> -	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
> +	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
>=20
>    - reg : should contain base address and length of DCFG memory-mapped
> registers
>=20
> diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> b/Documentation/devicetree/bindings/arm/fsl.txt
> index 7fbc424..baef162 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.txt
> +++ b/Documentation/devicetree/bindings/arm/fsl.txt
> @@ -235,3 +235,15 @@ Required root node properties:
>  LS2088A ARMv8 based RDB Board
>  Required root node properties:
>      - compatible =3D "fsl,ls2088a-rdb", "fsl,ls2088a";
> +
> +LX2160A SoC
> +Required root node properties:
> +    - compatible =3D "fsl,lx2160a";
> +
> +LX2160A ARMv8 based QDS Board
> +Required root node properties:
> +    - compatible =3D "fsl,lx2160a-qds", "fsl,lx2160a";
> +
> +LX2160A ARMv8 based RDB Board
> +Required root node properties:
> +    - compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
> diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> index c655f28..f322989 100644
> --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> @@ -43,6 +43,7 @@ Required properties:
>  	* "fsl,ls1046a-clockgen"
>  	* "fsl,ls1088a-clockgen"
>  	* "fsl,ls2080a-clockgen"
> +	* "fsl,lx2160a-clockgen"
>  	Chassis-version clock strings include:
>  	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
>  	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> --
> 2.7.4

