Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31019C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BDC206A1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 16:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="UdLgGU4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfJKQTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 12:19:55 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:46826 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfJKQTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 12:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0yjaPFk9im2nG9nyjw/NXqylRPkJs/ZYPxLfdG7PgrM=; b=UdLgGU4HTKZsYRF0lCf2KWQJB
        +EHYWH+lW6RgMlTzIHt6CgsxV2vP/Xa8SKlGr8wsU9sjWQ8x60HJYFW0BUqfQ/2ugQ68Ptuv94Hrb
        MQCDPMaFQobMG6lTIlKIFjuFAvNZKrFkrWoJ+8zDzJeNChl+TSZDNUtiGJ+egSfmG3f70=;
Received: from p5dcb30f2.dip0.t-ipconnect.de ([93.203.48.242] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIxdq-0006qF-Ct; Fri, 11 Oct 2019 18:19:47 +0200
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIxdp-00015g-AV; Fri, 11 Oct 2019 18:19:45 +0200
Date:   Fri, 11 Oct 2019 18:19:38 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Rob Herring <robh@kernel.org>, mark.rutland@arm.com, marex@denx.de,
        devicetree@vger.kernel.org, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011181938.185f2a00@kemnade.info>
In-Reply-To: <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
        <20191010192357.27884-3-andreas@kemnade.info>
        <20191011065609.6irap7elicatmsgg@pengutronix.de>
        <20191011094148.1376430e@aktux>
        <20191011142927.GA11490@bogus>
        <20191011170147.1b3c4b25@kemnade.info>
        <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xJOdSTuzcipgvT99VuhdzxO"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xJOdSTuzcipgvT99VuhdzxO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 17:22:14 +0200
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 19-10-11 17:05, Andreas Kemnade wrote:
> > On Fri, 11 Oct 2019 09:29:27 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >  =20
> > > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote: =20
> > > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > >    =20
> > > > > Hi Andreas,
> > > > >=20
> > > > > On 19-10-10 21:23, Andreas Kemnade wrote:   =20
> > > > > > The Netronix board E60K02 can be found some several Ebook-Reade=
rs,
> > > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > > is equipped with different SoCs requiring different pinmuxes.
> > > > > >=20
> > > > > > For now the following peripherals are included:
> > > > > > - LED
> > > > > > - Power Key
> > > > > > - Cover (gpio via hall sensor)
> > > > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > > > >   subdevices).
> > > > > > - Backlight via lm3630a
> > > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > >=20
> > > > > > It is based on vendor kernel but heavily reworked due to many
> > > > > > changed bindings.
> > > > > >=20
> > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > > - better led name
> > > > > > - correct memory size
> > > > > > - comments about missing devices
> > > > > >=20
> > > > > > Changes in v2:
> > > > > > - reordered, was 1/3
> > > > > > - moved pinmuxes to their actual users, not the parents
> > > > > >   of them
> > > > > > - removed some already-disabled stuff
> > > > > > - minor cleanups     =20
> > > > >=20
> > > > > You won't change the muxing, so a this dtsi can be self contained?
> > > > >    =20
> > > > So you want me to put a big=20
> > > > #if defined(MX6SLL)    =20
> > >=20
> > > Not sure what the comment meant, but no, don't do this. C defines in =
dts=20
> > > files are for symbolic names for numbers and assembling bitfields and=
=20
> > > that's it. =20
> >=20
> > yes, that is also my opinion. For now, there is only one user
> > of this .dtsi, but I have another one in preparation. That is the
> > reason for splitting things between .dts and .dtsi to avoid such ugly
> > ifdefs =20
>=20
> Then IMHO the pnictrl-* entries shouldn't appear in the dsti.
>=20
hmm, maybe now I understand your idea:
You do not want only to have

  pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
                        fsl,pins =3D <
                                MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10   0x1=
0059 /* HWEN */
                        >;
                };
in dts, but also  do not have these in .dtsi:

                pinctrl-names =3D "default";
                pinctrl-0 =3D <&pinctrl_lm3630a_bl_gpio>;

and instead have in dts:
&lm3630a {
 	pinctrl-names =3D "default";
        pinctrl-0 =3D <&pinctrl_lm3630a_bl_gpio>;
=09
};


just to make sure I get it right before doing the restructuring work. That =
way of structuring things did not come to my mind, but then the .dtsi is se=
lf-contained.

Regards,
Andreas

--Sig_/xJOdSTuzcipgvT99VuhdzxO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl2gq5oACgkQl4jFM1s/
ye/5WQ//SImeJwq5R6t0iZb9z5B55KLp97kuzkBviRqa/bWog9G1ceHcKolOMpSj
/KnN+y5Ila/ha3ncHAlp0dTUitcVSIVlho5boYhLlSzFRkxRnB0+xPsPOSdil1GG
TwhIWKuhokxRH+LrMXfPVfEY+eM+jT3RqXxUml7JDqaia5PUdWPP5nRf2jLK+dee
SXOv46TGfWVziN4bbZY05zAbcjUeE5IT4tGJpOqcm2Tfmeci6oRlvHzh+j6/y9LB
lAto7x+/EuzrLaaY9nmQgzaKGjKLMwjRANPIIFumx6c9U6yvl4ptglSdBZRGtCTE
rT+eGouNQOlG5uuDewl8tYCwDwdrg0wBj879xUr9DPogHeXFW7CMvEcMlTk33/56
FSQ8kzz1hxK84qphq6iJyQjReCqb0H2hDgOxB2yV2q8bWxL0S0MRn1iFJ9RODOqW
XCU9EILEsLjQbfjB6EHlvR7Gw6ETL1WJIP25drqpyy09pvCtixtLVfpaYWO18adP
nOv27Ah/5rT9NW5OH9kzm1Mt2HR1KxDSuyki3vR4rFFuWRrZlwt99nppAXDbzKqj
j6oBOqZkksVhsuw4S6J79ML2qRCbOZghcLyQnA50V9Pk7AQuIA+F85h/HF4p3xt/
WfiBoU3pHAnnyk+Yj1YiRzl/YaOWnm+xb2EQCtPxeyI9qyiDuwk=
=7ucO
-----END PGP SIGNATURE-----

--Sig_/xJOdSTuzcipgvT99VuhdzxO--
