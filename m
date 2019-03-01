Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53253C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CB02083E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:49:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="mziFkhcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfCALt4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:49:56 -0500
Received: from mail-eopbgr1400134.outbound.protection.outlook.com ([40.107.140.134]:32201
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbfCALt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:49:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WpMtV5UhVHNQbDJUFyklkZLL70zEDgCQj9N17zkoRY=;
 b=mziFkhcPjDEsNNSN/yqWAFOm2RnmetZ3QVpvExqHDr1bF5Oo46FZDbF2h8rTqsHDYXzp9OILs/UZECjh4zpKfWC/F5AW/ayOaVsseE+D7fCFBoZmbsJITVaK0ztyoMA7jlFhQFtiHv+PDlzHcwFXXGKM6qJMXfhbewTQvAUD55A=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1504.jpnprd01.prod.outlook.com (52.133.166.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.20; Fri, 1 Mar 2019 11:49:49 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 11:49:49 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Marc Zyngier <marc.zyngier@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Rob Herring <robh+dt@kernel.org>
Subject: RE: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0
 support
Thread-Topic: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0
 support
Thread-Index: AQHUkyD6AD0W0/GlCEuZuz1ywyu8ZqX3I0OQ
Date:   Fri, 1 Mar 2019 11:49:49 +0000
Message-ID: <TYXPR01MB1775847A1B243C0B30C69CFBC0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732284-5951-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732284-5951-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e695b9d-67f7-4029-d24a-08d69e3c0282
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1504;
x-ms-traffictypediagnostic: TYXPR01MB1504:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1504;20:PP4bemFPh2lrblySJGGCvxeacoFqJF7OSxXBBEUFqJwbCGpfeW1aYRAUDPVyuqZjyzC5zveFQ0L5QQw+0KpD9XIux3/FpArwGnisXGauF1FJLKX1gZLLX1tqPi0aCdqMCwFROyoXOSNJCGV57aYVmOx1CaGz2/azRTTC9DdE+CU=
x-microsoft-antispam-prvs: <TYXPR01MB15041FF0C3988D9218567F23C0760@TYXPR01MB1504.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(396003)(136003)(346002)(199004)(189003)(33656002)(71190400001)(7696005)(71200400001)(66066001)(105586002)(54906003)(7416002)(99286004)(97736004)(3846002)(106356001)(6116002)(76176011)(316002)(7736002)(6916009)(55016002)(81166006)(5660300002)(256004)(44832011)(9686003)(53936002)(305945005)(6246003)(25786009)(81156014)(446003)(6506007)(11346002)(26005)(86362001)(53546011)(186003)(486006)(52536013)(4326008)(476003)(229853002)(478600001)(2906002)(6436002)(8676002)(68736007)(8936002)(14454004)(74316002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1504;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: sxQnnfielzfWRSL1ggH7q89dxhPKQ5f1AarjGgH7BR5pKOgrBNxx9n1yccbEayOzg+lplqXWygDMfy8x2YHgGB14jtRmvM+AiJSqIfnore+OMXjtaQcg209jVfvSii9ObMQmPpusqQECeppng8DOCmdbRYnjd82hhXakuQPGWw8MIFFVR95TdhyjlnvQJM/UeS5hqtARK6or7pW/ABCPxw0jqf/fdv32zmYVhnd+wogHYZ74WpEjW1MRc+F2HxKUZAliK3D0aP+o40U33c7GpGKJStKN6d0nOpEE9TGfIjYi4WpUNliF97z9aaXvADnLHOuZwEo8rb8FxEOK4emMy7V4SaqtXm0C44if3ePnpnGOBGsNUen/2qUdTC5kbku7zLcpaDiycJgfIbAGUvu9YoMB4B/yp9/JpYehM4awrqg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e695b9d-67f7-4029-d24a-08d69e3c0282
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:49:49.5247
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

> From: linux-renesas-soc-owner@vger.kernel.org <linux-renesas-soc-owner@vg=
er.kernel.org> On Behalf Of Fabrizio Castro
> Sent: 13 December 2018 20:18
> Subject: [PATCH] dt-bindings: irqchip: renesas-irqc: Document r8a774c0 su=
pport
>=20
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt =
| 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renes=
as,irqc.txt
> b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> index 8de96a4..f977ea7 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc=
.txt
> @@ -16,6 +16,7 @@ Required properties:
>      - "renesas,irqc-r8a7793" (R-Car M2-N)
>      - "renesas,irqc-r8a7794" (R-Car E2)
>      - "renesas,intc-ex-r8a774a1" (RZ/G2M)
> +    - "renesas,intc-ex-r8a774c0" (RZ/G2E)
>      - "renesas,intc-ex-r8a7795" (R-Car H3)
>      - "renesas,intc-ex-r8a7796" (R-Car M3-W)
>      - "renesas,intc-ex-r8a77965" (R-Car M3-N)
> --
> 2.7.4

