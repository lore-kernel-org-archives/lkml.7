Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067E5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06812083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="osFfafmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388051AbfCAL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:56:41 -0500
Received: from mail-eopbgr1400101.outbound.protection.outlook.com ([40.107.140.101]:44114
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388004AbfCAL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CL+70fpOUAjO58+ExBT1OwleGho/BCk8CteQURkBghM=;
 b=osFfafmFR0BH0Xj+MpWpUuSN210Y13IouEGfzx73OEjQp6P0ty8Dttg1dJmEE58sF80X8QjrUTS7/FulYdA+Lr3GCART/JVk0/KrL80vt/rqPzWu6sildwSJ3UL9p/GKfXngzBi8LhJ5mVwwjIRukWGb30KXmvKYe8qOQmHdXqU=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1504.jpnprd01.prod.outlook.com (52.133.166.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 11:56:33 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 11:56:33 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        =?iso-8859-2?Q?Andreas_F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        =?iso-8859-2?Q?Michal_Vok=E1=E8?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiharaml@si-linux.co.jp" <ebiharaml@si-linux.co.jp>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: RE: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Thread-Topic: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0
 support
Thread-Index: AQHUrcrQP6ilvIZSJkSXC+A0LiwxK6X275xg
Date:   Fri, 1 Mar 2019 11:56:32 +0000
Message-ID: <TYXPR01MB1775D48B2053F31EC501C154C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1547663874-29411-12-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8611384-31ac-4dcb-b39e-08d69e3cf2f9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1504;
x-ms-traffictypediagnostic: TYXPR01MB1504:
x-ms-exchange-purlcount: 2
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1504;20:6HyUu0y+khpyrnkbgjiDM0clDy0aPrtAAUo69+4+lciCML8sAVbCtiiTClrLcrvU5VSMaEuFnb4kvU3d2hZbWljjypzeHLFlX1aVi+vVdFVeZw9B2xNjPrq1Jk3bCjmoTpVdJux/7imjARQ3dCLTKhF8ESLIl0NH9yFXbXNK+Uw=
x-microsoft-antispam-prvs: <TYXPR01MB150486DA4F44AAA91D5CFF86C0760@TYXPR01MB1504.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(33656002)(71190400001)(7696005)(71200400001)(66066001)(105586002)(54906003)(7416002)(99286004)(97736004)(3846002)(106356001)(6116002)(76176011)(316002)(7736002)(6916009)(55016002)(81166006)(5660300002)(256004)(44832011)(9686003)(53936002)(305945005)(6246003)(25786009)(81156014)(446003)(6506007)(11346002)(966005)(26005)(86362001)(53546011)(186003)(486006)(52536013)(4326008)(476003)(229853002)(478600001)(2906002)(6436002)(6306002)(8676002)(68736007)(8936002)(14454004)(74316002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1504;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9I0HoJFq8H8g4MDHI1YgeqAyvZkHXcGrMKL/qRiFdeqAaiBqJ/UOG/iykD8qaHV9czOYb25bvFIPfvP/QQ036283PAEfHfCoTfmJHDBGeKpZbR9RAKtH595VAC3NssTiP5NwX+bmNX2EMpNVt+CbJaE0nL1d76PVqm/+szLwFGz1guN4AJS/AsZBJklKJYz3DVT/vZIh/8gLP6MonfnpuKMFAon9QRVEXASSQT5oLPYPtBJ59dxID8HeQrKC192L65hxkCt6qQ+RCOjF85kE2By41claR6QRiu4hV/xsHlVvQ3IAaUJiSgZaS0owvc0l3xY0BFRRTkUUqcrNb2qRPefdSDDbepPzdCcbA9YXS/sVN90BnOcrypQYw7cKqxeyo6zUrD04E34qCF9FvK3281vtrFlo3KqUSj4HcK3ljCs=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8611384-31ac-4dcb-b39e-08d69e3cf2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:56:32.8459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1504
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marc,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 16 January 2019 18:38
> Subject: [PATCH 11/11] dt-bindings: can: rcar_canfd: document r8a774c0 su=
pport
>=20
> Document the support for rcar_canfd on R8A774C0 SoC devices.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
> This patch depends on:
> https://patchwork.kernel.org/patch/10687999/
> https://patchwork.kernel.org/patch/10688001/
>=20
>  Documentation/devicetree/bindings/net/can/rcar_canfd.txt | 16 +++++++++-=
------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> index 41049fe..32f051f 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_canfd.txt
> @@ -3,7 +3,8 @@ Renesas R-Car CAN FD controller Device Tree Bindings
>=20
>  Required properties:
>  - compatible: Must contain one or more of the following:
> -  - "renesas,rcar-gen3-canfd" for R-Car Gen3 compatible controller.
> +  - "renesas,rcar-gen3-canfd" for R-Car Gen3 and RZ/G2 compatible contro=
llers.
> +  - "renesas,r8a774c0-canfd" for R8A774C0 (RZ/G2E) compatible controller=
.
>    - "renesas,r8a7795-canfd" for R8A7795 (R-Car H3) compatible controller=
.
>    - "renesas,r8a7796-canfd" for R8A7796 (R-Car M3-W) compatible controll=
er.
>    - "renesas,r8a77965-canfd" for R8A77965 (R-Car M3-N) compatible contro=
ller.
> @@ -28,12 +29,13 @@ The name of the child nodes are "channel0" and "chann=
el1" respectively. Each
>  child node supports the "status" property only, which is used to
>  enable/disable the respective channel.
>=20
> -Required properties for "renesas,r8a7795-canfd", "renesas,r8a7796-canfd"=
,
> -"renesas,r8a77965-canfd" and "renesas,r8a77990-canfd" compatible:
> -In R8A7795, R8A7796, R8A77965 and R8A77990 SoCs, canfd clock is a div6 c=
lock
> -and can be used by both CAN and CAN FD controller at the same time. It n=
eeds
> -to be scaled to maximum frequency if any of these controllers use it. Th=
is is
> -done using the below properties:
> +Required properties for "renesas,r8a774c0-canfd", "renesas,r8a7795-canfd=
",
> +"renesas,r8a7796-canfd", "renesas,r8a77965-canfd", and "renesas,r8a77990=
-canfd"
> +compatible:
> +In R8A774C0, R8A7795, R8A7796, R8A77965, and R8A77990 SoCs, canfd clock =
is a
> +div6 clock and can be used by both CAN and CAN FD controller at the same=
 time.
> +It needs to be scaled to maximum frequency if any of these controllers u=
se it.
> +This is done using the below properties:
>=20
>  - assigned-clocks: phandle of canfd clock.
>  - assigned-clock-rates: maximum frequency of this clock.
> --
> 2.7.4

