Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8129DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C15C20818
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 11:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="lPN8/Tdm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387590AbfCALZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 06:25:40 -0500
Received: from mail-eopbgr1400114.outbound.protection.outlook.com ([40.107.140.114]:35860
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727951AbfCALZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 06:25:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es5nf3hvfsYJ+wOdsW4Dg5GAJp0khiSOZ0G+2dXz3aU=;
 b=lPN8/TdmWJn15qdMURychbZHoFJypJvsSMyYuF98pGrlIwSuRwRdtO1ZTES5Lkn59/Yz13UFbgi0i1cGUEIz7YNB4N+Q5NyVdXWfZLOylqJcaWRmLtWvdOkXQic8AMCbAS5Jj9AYbiq+d8rgfL7qGJT0rsOIMUV1u9hRH9vf9lk=
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com (52.133.168.140) by
 TYXPR01MB1725.jpnprd01.prod.outlook.com (52.133.168.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1665.16; Fri, 1 Mar 2019 11:25:34 +0000
Received: from TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf]) by TYXPR01MB1775.jpnprd01.prod.outlook.com
 ([fe80::88d2:545c:9212:c8cf%5]) with mapi id 15.20.1665.015; Fri, 1 Mar 2019
 11:25:34 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Topic: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
Thread-Index: AQHUkyFpi/45UrthxEeTw5QuFUj6AaX3HGug
Date:   Fri, 1 Mar 2019 11:25:33 +0000
Message-ID: <TYXPR01MB1775A4A3AF86097F284C4A08C0760@TYXPR01MB1775.jpnprd01.prod.outlook.com>
References: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732471-6730-1-git-send-email-fabrizio.castro@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab7d4e03-3437-40b2-eb0f-08d69e389eeb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:TYXPR01MB1725;
x-ms-traffictypediagnostic: TYXPR01MB1725:
x-microsoft-exchange-diagnostics: 1;TYXPR01MB1725;20:Alp9RMXj7K6fDbAES4TA9Jc9A49rqi1LRVc9zB0VQYMO1FpGowPBHUEaj+MAOPjmu+dzrcyVn/HJG0u8jgOdJz56dD9mTkaBeprFPo3gOLYbhayycDp27/4mF2PyTVQ7Ey6kei0mS9Bt8Sh0ov7+H9ZhuS0GaKs2mGfr1KU/ykk=
x-microsoft-antispam-prvs: <TYXPR01MB1725601E4EFE377FD01A8557C0760@TYXPR01MB1725.jpnprd01.prod.outlook.com>
x-forefront-prvs: 09634B1196
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(54906003)(52536013)(6116002)(3846002)(478600001)(5660300002)(6246003)(53936002)(66066001)(229853002)(4326008)(2906002)(25786009)(105586002)(106356001)(6436002)(71190400001)(71200400001)(86362001)(316002)(6506007)(102836004)(14454004)(26005)(9686003)(476003)(446003)(97736004)(8676002)(53546011)(305945005)(11346002)(68736007)(55016002)(186003)(76176011)(44832011)(256004)(8936002)(7696005)(486006)(6916009)(7736002)(81166006)(81156014)(74316002)(33656002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:TYXPR01MB1725;H:TYXPR01MB1775.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1xTK2hTD/4vk01shdLK4LX0rjhkA448a772KXo4y1+F+z3jznOl2RrI/nPfCvt1zQiO48JQy7aFGUBkL414eV+M+WgAKtCLgBE47TCGaHW/e1xyX0RiVM+BSuPJdq5XtWW/+/j5v9BD4DtDPbDFk1awkGuPr2RxCrh577G4bg0GmnlkQJoL6FNwlqbECYZ2GdnG+O2x5kS4WOEtSisn2VnEX9yLa+EdRIgMi+BgPOGFKh6T5XzkW3rsPdPYnEAv5FcUi2y2qbd629w91kpkfQo9zf3ewG8q1/LxGcqkbdZJdNsWtI8uigrNU7Gr9xL4Ib31WIqyvG+JuibpEjuor0/0/lpEbRhZ95qOrpuVV4+wc7ywfNsKjwHpCSsSQpTjnoiWDzhebPpaONCYbPHG6Hy/bQyje/gy3F94zwm+4BcU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab7d4e03-3437-40b2-eb0f-08d69e389eeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2019 11:25:33.9281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1725
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

I am sorry to bother you.
Do you think you take this patch?

Thanks,
Fab

> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Sent: 13 December 2018 20:21
> Subject: [PATCH] dt-bindings: usb-xhci: Add r8a774c0 support
>=20
> Document RZ/G2E (R8A774C0) SoC bindings.
>=20
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documen=
tation/devicetree/bindings/usb/usb-xhci.txt
> index fea8b15..97400e8 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -10,6 +10,7 @@ Required properties:
>      - "renesas,xhci-r8a7743" for r8a7743 SoC
>      - "renesas,xhci-r8a7744" for r8a7744 SoC
>      - "renesas,xhci-r8a774a1" for r8a774a1 SoC
> +    - "renesas,xhci-r8a774c0" for r8a774c0 SoC
>      - "renesas,xhci-r8a7790" for r8a7790 SoC
>      - "renesas,xhci-r8a7791" for r8a7791 SoC
>      - "renesas,xhci-r8a7793" for r8a7793 SoC
> --
> 2.7.4

