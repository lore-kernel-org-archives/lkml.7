Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E27C10F06
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02C01206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ZTF3tau3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbfDCKff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:35:35 -0400
Received: from mail-eopbgr1400114.outbound.protection.outlook.com ([40.107.140.114]:17134
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726495AbfDCKfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-bp-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNwnirBb8vREuMs+PZG3YGaCVcH8Qwm22jf5bwenzvQ=;
 b=ZTF3tau36b59krznIQBGXuXq+KJE2XBr1UXO3SoL7Dci2E115/8qdKyLDqTaGLOo3a7VHWHghbri3l1iVBwXDENr9X8Jsv0+SdbuNatRaIqcp8guKhZAAJg2OtEy8QgEuHByjeGNRThpW0y/AJttAhHH+B0lbKOu2KJraggLZfo=
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com (52.133.163.147) by
 TY1PR01MB1593.jpnprd01.prod.outlook.com (52.133.163.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.22; Wed, 3 Apr 2019 10:35:29 +0000
Received: from TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273]) by TY1PR01MB1770.jpnprd01.prod.outlook.com
 ([fe80::b593:2e3c:aa50:2273%4]) with mapi id 15.20.1750.017; Wed, 3 Apr 2019
 10:35:29 +0000
From:   Fabrizio Castro <fabrizio.castro@bp.renesas.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: RE: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Topic: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Index: AQHU6IM6dYjYvEya/U+5B0yf8PjleaYqP1HQ
Date:   Wed, 3 Apr 2019 10:35:29 +0000
Message-ID: <TY1PR01MB17708AF072E039D362FDE659C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fabrizio.castro@bp.renesas.com; 
x-originating-ip: [193.141.220.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 121b2268-70c6-40d9-1111-08d6b82017da
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:TY1PR01MB1593;
x-ms-traffictypediagnostic: TY1PR01MB1593:
x-microsoft-antispam-prvs: <TY1PR01MB159392AF45873C4DA417F657C0570@TY1PR01MB1593.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0996D1900D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(136003)(39860400002)(346002)(366004)(189003)(199004)(97736004)(54906003)(476003)(106356001)(99286004)(74316002)(53936002)(44832011)(7696005)(25786009)(52536014)(2501003)(107886003)(5660300002)(55016002)(9686003)(66066001)(486006)(86362001)(4326008)(68736007)(446003)(3846002)(6116002)(186003)(6246003)(6436002)(26005)(105586002)(11346002)(110136005)(305945005)(316002)(7736002)(14444005)(81166006)(256004)(8676002)(102836004)(8936002)(478600001)(6506007)(71200400001)(71190400001)(14454004)(2906002)(76176011)(33656002)(229853002)(53546011)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:TY1PR01MB1593;H:TY1PR01MB1770.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: bp.renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UbcxQ9uRF2gIPA6wvcDWXfanJKYZUPL6VibmYiySP2nFXBrPleyI43+yr83AnBzp28GrzYmMIqHEBBL8SVk+5ILyoB5L+aJFzQCOo6GoCplX31HQgcCZSwv8IUY3MlbDqMqsMFAJmZltmeMPwTz8xcttJJUOwCMk3teQE4yWZnf6OlHxfeuRkkVPj83NhT72koFdFc7Pq+7HvjYoR/7JK6V9OS/RKjndR/iS/xN4UC2YuP30c+fYdMp2hRu62RTb8JpRREt+x+dfpLtzP7pr26NK+Oz/thbQCORmzkeQR6HloIhDadEShTKLCQ9bvvtZFckAYPxw/X3oH2jFUW3CXloZYkM8oX/UNg4qvfY9oS3hPNedxDpA/BfdrTerZJfSNB41zJe/mUTL+SQdh7GumGzoBgJCwZcWVXREFZ6KS0Q=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 121b2268-70c6-40d9-1111-08d6b82017da
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2019 10:35:29.6374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1593
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yoshihiro-san,

Thank you for your patch!

> From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.=
org> On Behalf Of Yoshihiro Shimoda
> Sent: 01 April 2019 13:01
> Subject: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-ce=
lls property
>=20
> To have the detailed property on each PHY specifier, this patch revices

s/revices/revises/g

> the #phy-cells property.
>=20
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt=
 b/Documentation/devicetree/bindings/phy/rcar-gen3-
> phy-usb2.txt
> index ad9c290..7f0d4bf 100644
> --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> @@ -27,7 +27,12 @@ Required properties:
>=20
>  - reg: offset and length of the partial USB 2.0 Host register block.
>  - clocks: clock phandle and specifier pair(s).
> -- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
> +- #phy-cells: see phy-bindings.txt in the same directory, must be <1>.
> +
> +The phandle's argument in the PHY specifier is the INT_STATUS bit of con=
troller:

From the driver we are also looking for value 0, as in rcar_gen3_get_dr_mod=
e we
have a for loop that starts from 0, and we call of_usb_get_dr_mode_by_phy w=
ith
arg0 =3D=3D 0, why are we leaving this out from this list?

Thanks,
Fab

> +- 1 =3D USBH_INTA (OHCI)
> +- 2 =3D USBH_INTB (EHCI)
> +- 3 =3D UCOM_INT (OTG and BC)
>=20
>  Optional properties:
>  To use a USB channel where USB 2.0 Host and HSUSB (USB 2.0 Peripheral) a=
re
> --
> 2.7.4

