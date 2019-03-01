Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D893FC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27B20851
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="fDaxclOV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387619AbfCALcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:32:53 -0500
Received: from mail-eopbgr1410111.outbound.protection.outlook.com ([40.107.141.111]:33083
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728221AbfCALcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLLm3nppqndxXMG/g+9+cRBxiYyiIK8YkgXXDBSqjrw=;
 b=fDaxclOVzBdLVJVv3Ogy8rtKCs7flDTg/l/K5x4Gbp5lOg8z7xiS/sQIjTeiHHj5LpY4cg/zmrXCV8HQhm7iiQ9if9DfUJgOpRjd2gT/Td5GkRojw9uijj3wjqA+FBDAg1uKOVyx14UaQi6sNS0daaNH0kIMSCdDX4rCvDt88zc=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1725.jpnprd01.prod.outlook.com (52.133.168.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 11:32:46 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 11:32:45 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
CC:     "David S. Miller" <davem@davemloft.net>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
Thread-Index: AQHUkyEw+RtG5fpKRkOUPxY6ZOn5j6X3HnCw
Date:   Fri, 1 Mar 2019 11:32:45 +0000
Message-ID: <TYXPR01MB177531C9737F7001F03D7CC7C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786847da-9eb7-4b51-1227-08d69e39a04e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1725;
x-ms-traffictypediagnostic: TYXPR01MB1725:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1725;20:5u/7ZJTEcJgsW4nxQhkV5hVB+h31ZTkCALcMdBRPklVJnjk4Lv7zzpbYIbvRkaQ4SCy1PSeY2oUQnpQgR9/7987774fOIbCL4JalxLBcUnWpKEPA7M9Z6lrPHhMQa8kZBxq2MsoyTtjjmvczwpbKWOgNDX2ZkmfrUbYoRogkq2Y=
x-microsoft-antispam-prvs: <TYXPR01MB1725DEE416121DE011A15B05C0760@TYXPR01MB1725.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(366004)(396003)(39860400002)(376002)(189003)(199004)(53546011)(8676002)(446003)(97736004)(11346002)(68736007)(55016002)(305945005)(102836004)(14454004)(6506007)(476003)(9686003)(26005)(6916009)(486006)(256004)(8936002)(7696005)(81156014)(81166006)(74316002)(33656002)(99286004)(7736002)(186003)(76176011)(44832011)(5660300002)(229853002)(53936002)(6246003)(66066001)(54906003)(3846002)(6116002)(478600001)(52536013)(105586002)(106356001)(7416002)(6436002)(316002)(86362001)(71190400001)(71200400001)(2906002)(4326008)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1725;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /siZ3lXT1n9jMeyiqVISA6wyKrkmHbIHgXFkOgMpwKx8TC9QbKSDKWGxdyENPzT+TtU5oCNi6I3ezKgQ6GfQOXPtFoSOt0YmsFlD/nZtsM8mDbphNVcCMuiWF8OB4aeArwE9yTLj43Rx+Obpv5EShI/4ZZ2M6RkCHUB4kLFhwj8FSWQrE8CSTy6NHIJAAFlzAs6f5ROhrMlRhzsT0a2ThXx+aAEaTZVy22z9NlmCesK9w1iaWuJLKShTogQJTAfJfKRzEFMtVlABuKOWo5sITL40QZNB3mt1dHfwN53j8fNSiLMeiiAO2hhfJxGnXhG350G2BW3I21i3WoKdUUKEmmnzfIJPFdVFXst/UbyersfTeCqjoAab6i6CQ0+7mYhUUsAtbub3CjAaL28+RcTv6NdNmsEEkufYKm3P73FOXx0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786847da-9eb7-4b51-1227-08d69e39a04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:32:45.7828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

I am sorry to bother you.
Do you think you can take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 13 December 2018 20:20
> Subject: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
>=20
> Document RZ/G2E (r8a774c0) SoC specific bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/can/rcar_can.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/rcar_can.txt b/Doc=
umentation/devicetree/bindings/net/can/rcar_can.txt
> index 9936b9e..7fcf501 100644
> --- a/Documentation/devicetree/bindings/net/can/rcar_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/rcar_can.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	      "renesas,can-r8a7744" if CAN controller is a part of R8A7744 SoC.
>  	      "renesas,can-r8a7745" if CAN controller is a part of R8A7745 SoC.
>  	      "renesas,can-r8a774a1" if CAN controller is a part of R8A774A1 So=
C.
> +	      "renesas,can-r8a774c0" if CAN controller is a part of R8A774C0 So=
C.
>  	      "renesas,can-r8a7778" if CAN controller is a part of R8A7778 SoC.
>  	      "renesas,can-r8a7779" if CAN controller is a part of R8A7779 SoC.
>  	      "renesas,can-r8a7790" if CAN controller is a part of R8A7790 SoC.
> --
> 2.7.4

