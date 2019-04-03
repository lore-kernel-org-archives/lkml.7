Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2491C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F9472084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HWMVdj/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDCWBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:01:19 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:22487
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726099AbfDCWBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unGrwzDQ8dWQ0PPSp/iX9Gx3xldNZrgYj+9ZfJYFFCs=;
 b=HWMVdj/3Y25gBs/pSlVDck6zL3/OGMH8o/FmTZPTNU4X5SFcAYR7+yW3QHxAi/LWo1U0SAVcHn2abu9EkqJo8KYYeWB0uys2bbt0TQwJ4gi4b4s6hqRGCWvRYC3eJPpLo/JvXXHvLNQFGqHfLsW09GmL+R4HUTNw4BDuC8n9mkA=
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com (20.179.1.11) by
 AM6PR04MB6647.eurprd04.prod.outlook.com (20.179.247.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Wed, 3 Apr 2019 22:01:14 +0000
Received: from AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::fc93:97ef:f27e:a9]) by AM6PR04MB5863.eurprd04.prod.outlook.com
 ([fe80::fc93:97ef:f27e:a9%4]) with mapi id 15.20.1771.011; Wed, 3 Apr 2019
 22:01:13 +0000
From:   Leo Li <leoyang.li@nxp.com>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Andy Tang <andy.tang@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Topic: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
Thread-Index: AQHUzbuNhYaqfl3gv0C5n9/zHWak0aYqUroAgADigKA=
Date:   Wed, 3 Apr 2019 22:01:13 +0000
Message-ID: <AM6PR04MB5863C5DC8063C2B8F5BF9F088F570@AM6PR04MB5863.eurprd04.prod.outlook.com>
References: <1551132245-6089-1-git-send-email-vabhav.sharma@nxp.com>
 <1551132245-6089-2-git-send-email-vabhav.sharma@nxp.com>
 <VI1PR04MB480070B517B9D9961C9E8187F3570@VI1PR04MB4800.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR04MB480070B517B9D9961C9E8187F3570@VI1PR04MB4800.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=leoyang.li@nxp.com; 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b3fae01-1586-465f-2151-08d6b87fe3af
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM6PR04MB6647;
x-ms-traffictypediagnostic: AM6PR04MB6647:
x-microsoft-antispam-prvs: <AM6PR04MB6647301375569FA2789EC43F8F570@AM6PR04MB6647.eurprd04.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(396003)(136003)(199004)(189003)(13464003)(4326008)(53936002)(6436002)(86362001)(55016002)(99286004)(71200400001)(316002)(7696005)(110136005)(2906002)(97736004)(76176011)(54906003)(478600001)(14454004)(9686003)(71190400001)(6246003)(102836004)(25786009)(8936002)(81166006)(81156014)(53546011)(6506007)(68736007)(486006)(229853002)(26005)(446003)(186003)(33656002)(11346002)(5660300002)(106356001)(105586002)(52536014)(2501003)(74316002)(6116002)(14444005)(8676002)(256004)(66066001)(3846002)(7736002)(305945005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB6647;H:AM6PR04MB5863.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qcgRGD3bRg6+lHeSHNZcPaf/eDUpWNexZe+UxnFzDRQdINIzvnUa76sbzMgJUd0zRt+wJFCR3oJIKq/Cr1UD7QTMGIMsKQDCXkGvW6Fck54DuAwuF+VqDILF2qLE7VhFERoE0oXXrDsu6fa2511/Pvem95DGL1x6d51WfVDAXi+QxMLAiI8NDgUEcUmIBfxv64zbu5POYKS9p438kDoRUZTMa9zoCYJxrqRXAFrTIv00/285Wz48dGnpXHJF9gQ9swry5vf0vih0/PiNXocHI53FsoTyvWF9RF51Ek1BwqsPNlYTAP2NIyyqhzgETLosQEmXtfgv1qkBlsm0wteiQcZMhvTXiwW21bb5KKDnPPcDb6JRq1jiIsRhj2oB3A4fsVBxtaI5my3yUKEFtiyxm/lcCJH1s/I8M8C3ny0FV74=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3fae01-1586-465f-2151-08d6b87fe3af
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 22:01:13.8345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6647
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Vabhav Sharma
> Sent: Wednesday, April 3, 2019 3:28 AM
> To: robh+dt@kernel.org; mark.rutland@arm.com
> Cc: Leo Li <leoyang.li@nxp.com>; Meenakshi Aggarwal
> <meenakshi.aggarwal@nxp.com>; Andy Tang <andy.tang@nxp.com>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160=
A
>=20
> Hello Maintainers,
> Please merge below patch.
>=20
> Regards,
> Vabhav
>=20
> > -----Original Message-----
> > From: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Sent: Tuesday, February 26, 2019 3:41 PM
> > To: sudeep.holla@arm.com; oss@buserror.net;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > robh+dt@kernel.org; mark.rutland@arm.com;
> > linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> > viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-
> > pm@vger.kernel.org; linux-kernel-owner@vger.kernel.org;
> > catalin.marinas@arm.com; will.deacon@arm.com;
> > gregkh@linuxfoundation.org; arnd@arndb.de;
> > kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> > <leoyang.li@nxp.com>; shawnguo@kernel.org
> > Cc: linux@armlinux.org.uk; adrian.hunter@intel.com;
> > ulf.hansson@linaro.org; Vabhav Sharma <vabhav.sharma@nxp.com>
> > Subject: [PATCH v1 1/4] dt-bindings: arm64: add compatible for LX2160A
> >
> > Add compatible for LX2160A SoC,QDS and RDB board Add lx2160a
> > compatible for clockgen and dcfg
> >
> > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/arm/freescale/fsl,layerscape-dcfg.txt           |  2 +-
> >  Documentation/devicetree/bindings/arm/fsl.txt                | 12
> ++++++++++++
> >  Documentation/devicetree/bindings/clock/qoriq-clock.txt      |  1 +
> >  3 files changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-
> > dcfg.txt
> > b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-
> > dcfg.txt
> > index b5cb374..dc76046 100644
> > --- a/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-
> > dcfg.txt
> > +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,layerscape-d
> > +++ cf
> > +++ g.txt
> > @@ -8,7 +8,7 @@ Required properties:
> >    - compatible: Should contain a chip-specific compatible string,
> >  	Chip-specific strings are of the form "fsl,<chip>-dcfg",
> >  	The following <chip>s are known to be supported:
> > -	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a.
> > +	ls1012a, ls1021a, ls1043a, ls1046a, ls2080a, lx2160a.
> >
> >    - reg : should contain base address and length of DCFG
> > memory-mapped registers
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.txt
> > b/Documentation/devicetree/bindings/arm/fsl.txt
> > index 7fbc424..baef162 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.txt
> > +++ b/Documentation/devicetree/bindings/arm/fsl.txt

This file has been converted to yaml format in mainline kernel.  Please res=
pin the patch in order to apply.

> > @@ -235,3 +235,15 @@ Required root node properties:
> >  LS2088A ARMv8 based RDB Board
> >  Required root node properties:
> >      - compatible =3D "fsl,ls2088a-rdb", "fsl,ls2088a";
> > +
> > +LX2160A SoC
> > +Required root node properties:
> > +    - compatible =3D "fsl,lx2160a";
> > +
> > +LX2160A ARMv8 based QDS Board
> > +Required root node properties:
> > +    - compatible =3D "fsl,lx2160a-qds", "fsl,lx2160a";
> > +
> > +LX2160A ARMv8 based RDB Board
> > +Required root node properties:
> > +    - compatible =3D "fsl,lx2160a-rdb", "fsl,lx2160a";
> > diff --git a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > index c655f28..f322989 100644
> > --- a/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > +++ b/Documentation/devicetree/bindings/clock/qoriq-clock.txt
> > @@ -43,6 +43,7 @@ Required properties:
> >  	* "fsl,ls1046a-clockgen"
> >  	* "fsl,ls1088a-clockgen"
> >  	* "fsl,ls2080a-clockgen"
> > +	* "fsl,lx2160a-clockgen"
> >  	Chassis-version clock strings include:
> >  	* "fsl,qoriq-clockgen-1.0": for chassis 1.0 clocks
> >  	* "fsl,qoriq-clockgen-2.0": for chassis 2.0 clocks
> > --
> > 2.7.4

