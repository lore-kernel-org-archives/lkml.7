Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96EBC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C3020880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="dmozvc4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726471AbfDHGWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:22:19 -0400
Received: from mail-eopbgr1400135.outbound.protection.outlook.com ([40.107.140.135]:31376
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfDHGWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39GXyv373cZ7Dh20VRWFqDlaORseL3MOJmQsM72by3w=;
 b=dmozvc4tuipxyTpYUR+GH+YSDCeUUEqAMOQlp1XOKPcfG2AOVDFG/t8FsOUhKW03zCpKu6u1B2Q5wbetUZ8C4/r2zelisJrZJdahmI26XA6c3zAnw7db0nZRxGI6jq5FFuTjUXbs6xH30WjbKkknw81HYeGmFhGUiJ7deioYzK4=
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com (20.178.139.148) by
 TYAPR01MB2205.jpnprd01.prod.outlook.com (52.133.178.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Mon, 8 Apr 2019 06:22:14 +0000
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70]) by TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70%4]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 06:22:14 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Topic: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Index: AQHU6IMsyywmg/TypEeOnT1pl/tOhqYqQOOAgAeS6/A=
Date:   Mon, 8 Apr 2019 06:22:14 +0000
Message-ID: <TYAPR01MB4271FBDF12890817243F3FABD82C0@TYAPR01MB4271.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <TY1PR01MB17708AF072E039D362FDE659C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17708AF072E039D362FDE659C0570@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 505e980b-5200-48e9-e944-08d6bbea8ac8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2205;
x-ms-traffictypediagnostic: TYAPR01MB2205:
x-microsoft-antispam-prvs: <TYAPR01MB2205F8ED40880348BD8FCC41D82C0@TYAPR01MB2205.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(376002)(39860400002)(189003)(199004)(55016002)(2906002)(53936002)(5660300002)(6436002)(446003)(476003)(486006)(52536014)(11346002)(9686003)(6246003)(229853002)(25786009)(2501003)(106356001)(14454004)(105586002)(33656002)(3846002)(97736004)(71190400001)(6116002)(66066001)(71200400001)(316002)(110136005)(7736002)(7696005)(53546011)(26005)(6506007)(4326008)(54906003)(305945005)(68736007)(256004)(14444005)(8936002)(86362001)(99286004)(478600001)(102836004)(8676002)(81156014)(81166006)(186003)(76176011)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2205;H:TYAPR01MB4271.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UJqsQzDfCDwdnKLjHsOr111e/mVYZA+mEpBnrJ4CGMtWGD0Yt9wOifxsOrN2PYPCx0Rjzc5u+hKmYW1pwQV48Q0ev7qv3NreFkD28duTRtA1NpOUCMKsWTRiqybJ2uj3+9XXX6KnqqqbVdcjJMgGRE8IgFk88HxTjPby6n1UqO9IPMUH7xDyAdy6IwDcSzwYsoY6og1hksx1ypegahpNZnorwXcjoB9aazutBOafKQYz6fjoX8UvvnTNpVoMYPT7OEVrPSvKLBxs0D9STgzhTAJ4+TkuQP1Ujj/fvNgG0sMJ3AxGPxE4DLV3a4l89jP5yc/anaDJlYEv5DG1PgInFbN+rJNqbuoEHUf8g2f87xdzf9WJwXZSKFuYF1+aZQvJbajD4lI8+3U1lZrZ6MhfRL/81nC7hF3DGFR12dS/46Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505e980b-5200-48e9-e944-08d6bbea8ac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 06:22:14.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrizio-san,

Thank you for your review!

> From: Fabrizio Castro, Sent: Wednesday, April 3, 2019 7:35 PM
>=20
> Hello Yoshihiro-san,
>=20
> Thank you for your patch!
>=20
> > From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kerne=
l.org> On Behalf Of Yoshihiro Shimoda
> > Sent: 01 April 2019 13:01
> > Subject: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-=
cells property
> >
> > To have the detailed property on each PHY specifier, this patch revices
>=20
> s/revices/revises/g

Oops! I'll fix it in v2.

> > the #phy-cells property.
> >
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt | 7 +++++=
+-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.t=
xt
> b/Documentation/devicetree/bindings/phy/rcar-gen3-
> > phy-usb2.txt
> > index ad9c290..7f0d4bf 100644
> > --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > @@ -27,7 +27,12 @@ Required properties:
> >
> >  - reg: offset and length of the partial USB 2.0 Host register block.
> >  - clocks: clock phandle and specifier pair(s).
> > -- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
> > +- #phy-cells: see phy-bindings.txt in the same directory, must be <1>.
> > +
> > +The phandle's argument in the PHY specifier is the INT_STATUS bit of c=
ontroller:
>=20
> From the driver we are also looking for value 0, as in rcar_gen3_get_dr_m=
ode we
> have a for loop that starts from 0, and we call of_usb_get_dr_mode_by_phy=
 with
> arg0 =3D=3D 0

This is backward compatibility for old DTS file (phy-cells =3D 0).

> why are we leaving this out from this list?

This is because I don't assume any device nodes doesn't have such a propert=
y
(the bit 0 of INT_STATUS).

Best regards,
Yoshihiro Shimoda

> Thanks,
> Fab
>=20
> > +- 1 =3D USBH_INTA (OHCI)
> > +- 2 =3D USBH_INTB (EHCI)
> > +- 3 =3D UCOM_INT (OTG and BC)
> >
> >  Optional properties:
> >  To use a USB channel where USB 2.0 Host and HSUSB (USB 2.0 Peripheral)=
 are
> > --
> > 2.7.4

