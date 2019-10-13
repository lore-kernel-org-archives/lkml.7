Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FF0C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D695D20854
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 06:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="IAme3oDR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbfJNGAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 02:00:22 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:45442 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbfJNGAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 02:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZJpXfsdzZRwG1qeodiK+1Q6zBO7em5LRGWg3z+JO8hw=; b=IAme3oDRZ70HpbxSF0dfULA/3
        ZfZFO6x1BN9p4EQWSkoQRBy2sUmQ/SvfedMDmLabO1RF431lo7cpEwl8XcjIHsSeOQteK/glLD0hW
        ByynikA75rcysXMNK/0R+Kj3xD4weaICTjZ458eiRVNyJ6Xb25GPVZp6I7h6UEKVd0ohU=;
Received: from hsvpn29.hotsplots.net ([185.46.137.7] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iJtOq-0002Id-V2; Mon, 14 Oct 2019 08:00:09 +0200
Received: from [::1] (helo=localhost)
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iJgGr-0005NO-SD; Sun, 13 Oct 2019 17:59:04 +0200
Date:   Sun, 13 Oct 2019 17:56:44 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Marco Felsch <m.felsch@pengutronix.de>, festevam@gmail.com
Cc:     Rob Herring <robh@kernel.org>, mark.rutland@arm.com, marex@denx.de,
        devicetree@vger.kernel.org, andrew.smirnov@gmail.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, angus@akkea.ca,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, manivannan.sadhasivam@linaro.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191013175644.4fc264d0@kemnade.info>
In-Reply-To: <20191011165633.5ty3yux4ljrcycux@pengutronix.de>
References: <20191010192357.27884-1-andreas@kemnade.info>
        <20191010192357.27884-3-andreas@kemnade.info>
        <20191011065609.6irap7elicatmsgg@pengutronix.de>
        <20191011094148.1376430e@aktux>
        <20191011142927.GA11490@bogus>
        <20191011170147.1b3c4b25@kemnade.info>
        <20191011152214.v6lq6itwf5lp6j7q@pengutronix.de>
        <20191011181938.185f2a00@kemnade.info>
        <20191011165633.5ty3yux4ljrcycux@pengutronix.de>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/K6CGQhzU3FFoLuhqnsD_8gF"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/K6CGQhzU3FFoLuhqnsD_8gF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 18:56:33 +0200
Marco Felsch <m.felsch@pengutronix.de> wrote:

> On 19-10-11 18:19, Andreas Kemnade wrote:
> > On Fri, 11 Oct 2019 17:22:14 +0200
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >  =20
> > > On 19-10-11 17:05, Andreas Kemnade wrote: =20
> > > > On Fri, 11 Oct 2019 09:29:27 -0500
> > > > Rob Herring <robh@kernel.org> wrote:
> > > >    =20
> > > > > On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote: =
  =20
> > > > > > On Fri, 11 Oct 2019 08:56:09 +0200
> > > > > > Marco Felsch <m.felsch@pengutronix.de> wrote:
> > > > > >      =20
> > > > > > > Hi Andreas,
> > > > > > >=20
> > > > > > > On 19-10-10 21:23, Andreas Kemnade wrote:     =20
> > > > > > > > The Netronix board E60K02 can be found some several Ebook-R=
eaders,
> > > > > > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > > > > > is equipped with different SoCs requiring different pinmuxe=
s.
> > > > > > > >=20
> > > > > > > > For now the following peripherals are included:
> > > > > > > > - LED
> > > > > > > > - Power Key
> > > > > > > > - Cover (gpio via hall sensor)
> > > > > > > > - RC5T619 PMIC (the kernel misses support for rtc and charg=
er
> > > > > > > >   subdevices).
> > > > > > > > - Backlight via lm3630a
> > > > > > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > > > > > >=20
> > > > > > > > It is based on vendor kernel but heavily reworked due to ma=
ny
> > > > > > > > changed bindings.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > > > > > ---
> > > > > > > > Changes in v3:
> > > > > > > > - better led name
> > > > > > > > - correct memory size
> > > > > > > > - comments about missing devices
> > > > > > > >=20
> > > > > > > > Changes in v2:
> > > > > > > > - reordered, was 1/3
> > > > > > > > - moved pinmuxes to their actual users, not the parents
> > > > > > > >   of them
> > > > > > > > - removed some already-disabled stuff
> > > > > > > > - minor cleanups       =20
> > > > > > >=20
> > > > > > > You won't change the muxing, so a this dtsi can be self conta=
ined?
> > > > > > >      =20
> > > > > > So you want me to put a big=20
> > > > > > #if defined(MX6SLL)      =20
> > > > >=20
> > > > > Not sure what the comment meant, but no, don't do this. C defines=
 in dts=20
> > > > > files are for symbolic names for numbers and assembling bitfields=
 and=20
> > > > > that's it.   =20
> > > >=20
> > > > yes, that is also my opinion. For now, there is only one user
> > > > of this .dtsi, but I have another one in preparation. That is the
> > > > reason for splitting things between .dts and .dtsi to avoid such ug=
ly
> > > > ifdefs   =20
> > >=20
> > > Then IMHO the pnictrl-* entries shouldn't appear in the dsti.
> > >  =20
> > hmm, maybe now I understand your idea:
> > You do not want only to have
> >=20
> >   pinctrl_lm3630a_bl_gpio: lm3630a_bl_gpio_grp {
> >                         fsl,pins =3D <
> >                                 MX6SLL_PAD_EPDC_PWR_CTRL3__GPIO2_IO10  =
 0x10059 /* HWEN */ =20
> >                         >; =20
> >                 };
> > in dts, but also  do not have these in .dtsi:
> >=20
> >                 pinctrl-names =3D "default";
> >                 pinctrl-0 =3D <&pinctrl_lm3630a_bl_gpio>;
> >=20
> > and instead have in dts:
> > &lm3630a {
> >  	pinctrl-names =3D "default";
> >         pinctrl-0 =3D <&pinctrl_lm3630a_bl_gpio>;
> > =09
> > };
> >=20
> >=20
> > just to make sure I get it right before doing the restructuring work. T=
hat way of structuring things did not come to my mind, but then the .dtsi i=
s self-contained. =20
>=20
> That is what I mean but wait for Shawn's comments. It's just my opinion
> that .dtsi and .dts files should be self-contained.

for files like the imx6sll.dtsi, I would clearly agree, here it might
hide errors like missing pinmuxes in the dts, so it is not so clear.
But if there is is consensus about .dtsi being self-contained I will not
refuse to restructurize my work.

Regards,
Andreas

--Sig_/K6CGQhzU3FFoLuhqnsD_8gF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl2jSUAACgkQl4jFM1s/
ye92lxAAsdTP3+mhOGTNy8BO0DcQGyukpQ4pJxYxIqrzLRnVO8ylnBEmW6tua5fh
OICjnZ3NaxwbfkQPKSCJEtggUJI2w+6BkLpF3+eUvuU1RjQpTcHjiBR+znmxulhJ
n7hyvtCx6O32GzyamSOAx8nW2qBJ1hGbUKyREJkpY4NZ615dL7jnWR5gSDJqQ/A6
aZ7Cx6Xna2Mu8lXa3a8doDQKQMcPdluCZgNr76IsRTPmoMg7KEk2nrWOy2gls9N3
Z+SVji02h3HtyjKFj4L0MPIZhiaAPsI9SFjfJyXQ570FBK5wnjtHv5VuxGBsVZlo
TWdE1i6HGXnw5pSROb1jXLgmCG8G07UDF876UaNtjUpg8uGNLPhrlh3+SP5+zvbP
n0m+vpm3GFkHFcKw5RxkdSz/E8+/rF2D/eFt6E4w8Gi2SzBq1nwTndvIN7ZYx4e4
F95Sa4vQbYxtN1e6JYEJGcP0xKQC0LMRGLLIAAYGn11GBG8/o/8ociGdcmJnFBtk
QsYoE8wCExvkYc2L/L/4YsFiLDfXCs+pYePVlAZsqffIInh1k0TGdmSINk8f+u5U
etBUvs2x9zKs6K/OqNVcaRTP2pbozKfOGPmbcgUQ03k5Q/7eo7+IiJrPu+LgnkI6
rQ42+/WhAfXgo5aBHI+Gzgtqsd/5fYTrRQab7IejHhNbYAPh6P8=
=xmgK
-----END PGP SIGNATURE-----

--Sig_/K6CGQhzU3FFoLuhqnsD_8gF--
