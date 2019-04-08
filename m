Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3F1C282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7980720663
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="nyJXf8gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbfDHGOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:14:02 -0400
Received: from mail-eopbgr1400128.outbound.protection.outlook.com ([40.107.140.128]:6223
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725925AbfDHGOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:14:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector1-renesas-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hfn5uqeOgYzqBNVXSxGQMiQinm2lt+f3okC+Q1hJPXI=;
 b=nyJXf8glgzUleuXXJ50jhR+aHmW8IihelgoTL76DLiz/AiI/0bjza3fhG5YF5itJmY1FJpojVs0v2+Oq8l0tXECYlAp1EBhbS2D6J0XYArAA+MtPpamef/0n600VU1ZGqgWIRpWONeSNPFgmruKW2zZQ4zZH7w0kpcPZYiAJQ4U=
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com (20.178.139.148) by
 TYAPR01MB2431.jpnprd01.prod.outlook.com (20.177.103.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Mon, 8 Apr 2019 06:13:58 +0000
Received: from TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70]) by TYAPR01MB4271.jpnprd01.prod.outlook.com
 ([fe80::cda2:4f20:84e4:de70%4]) with mapi id 15.20.1771.016; Mon, 8 Apr 2019
 06:13:58 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Simon Horman <horms@verge.net.au>
CC:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Topic: [PATCH 1/3] dt-bindings: phy: rcar-gen3-phy-usb2: Revise
 #phy-cells property
Thread-Index: AQHU6IMsyywmg/TypEeOnT1pl/tOhqYqLA6AgAenOcA=
Date:   Mon, 8 Apr 2019 06:13:57 +0000
Message-ID: <TYAPR01MB42711FBCAD17ED19A55C5DFDD82C0@TYAPR01MB4271.jpnprd01.prod.outlook.com>
References: <1554120083-29990-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1554120083-29990-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <20190403092054.d26pmbngconkn3hx@verge.net.au>
In-Reply-To: <20190403092054.d26pmbngconkn3hx@verge.net.au>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb8b2d16-d7c9-4e54-99a7-08d6bbe96319
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:TYAPR01MB2431;
x-ms-traffictypediagnostic: TYAPR01MB2431:
x-microsoft-antispam-prvs: <TYAPR01MB2431048D2B5713DB7D904010D82C0@TYAPR01MB2431.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(136003)(396003)(39860400002)(376002)(199004)(189003)(6506007)(6916009)(105586002)(81166006)(316002)(8676002)(81156014)(25786009)(11346002)(256004)(6116002)(97736004)(99286004)(54906003)(26005)(3846002)(486006)(478600001)(446003)(76176011)(102836004)(7696005)(14454004)(186003)(14444005)(476003)(71200400001)(86362001)(53936002)(8936002)(106356001)(33656002)(5660300002)(68736007)(74316002)(52536014)(305945005)(66066001)(2906002)(6246003)(7736002)(229853002)(55016002)(71190400001)(4326008)(6436002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:TYAPR01MB2431;H:TYAPR01MB4271.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 9luYEZZMI9LLW9audOiAabpyYzW6gVTdzUKvcHITHiKnX/IxVTSBE1vxHKREVBiQy/vKZlaK+rsqsG7nBhF8nyAIk+MtqRfhFlXOvS9rXUrLrdOoaZwdiYW4mLM8UF3GgFeMRHT49sjMZZVXGHrqJi17TADA051MQLQ0El/f+6y0ZgxCpiGn6LhvhijCIYlpx5bMsp38+JoP7t6IoMftCfoZGKuHeMa5PoxVlmBXsBnyB1wIC3hTV54qraF7pMn3eLz0JEm+pnnM6UMylbufvu9yx7o5KlDNQUbeQCaTLsKB67u5o82AMPaOzaT25cBU6rq0TU8CdVsIoW0EU+KopXTxLfgLxycCX18R1A6AGmhLG5IunltmCqEmGjI6VQ/9mMwFD3SR4g7CaYhCf25KB0I2a5cZbp6IbYnXDpZjBKE=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8b2d16-d7c9-4e54-99a7-08d6bbe96319
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 06:13:58.2028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2431
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon-san,

Thank you for your review!

> From: Simon Horman, Sent: Wednesday, April 3, 2019 6:21 PM
>=20
> Hi Shimoda-san,
>=20
> On Mon, Apr 01, 2019 at 09:01:21PM +0900, Yoshihiro Shimoda wrote:
> > To have the detailed property on each PHY specifier, this patch revices
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
> b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > index ad9c290..7f0d4bf 100644
> > --- a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> > @@ -27,7 +27,12 @@ Required properties:
> >
> >  - reg: offset and length of the partial USB 2.0 Host register block.
> >  - clocks: clock phandle and specifier pair(s).
> > -- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
>=20
> The driver currently supports <0> and with this changeset continues to do
> so. I also assume there are existing DTs that use <0>. Would it be
> better to describe this as deprecated?

I got it. I'll fix this in v2.

Best regards,
Yoshihiro Shimoda


> > +- #phy-cells: see phy-bindings.txt in the same directory, must be <1>.
> > +
> > +The phandle's argument in the PHY specifier is the INT_STATUS bit of c=
ontroller:
> > +- 1 =3D USBH_INTA (OHCI)
> > +- 2 =3D USBH_INTB (EHCI)
> > +- 3 =3D UCOM_INT (OTG and BC)
> >
> >  Optional properties:
> >  To use a USB channel where USB 2.0 Host and HSUSB (USB 2.0 Peripheral)=
 are
> > --
> > 2.7.4
> >
