Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBCCECE58C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79138206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="d+8mNidN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfJKPGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 11:06:18 -0400
Received: from mail.andi.de1.cc ([85.214.55.253]:53308 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbfJKPGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 11:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oFnh+7aofaF0FzctP338voKSyncR9/qqjW/7qmv+uiI=; b=d+8mNidNz2g3CT4o7emVa8Iv9
        j4mlf6bjNdTPBL6ebgONqPnBkPA4X2BnpvGPs8RpZLkZDOHEzE1xl4SKtDn/FV3olLmSNsafpsl3m
        oxBlYV4T3I+iCYIBwhsjqlT08Qg/jpeTmwflO6zo1G6uYgW9Xa7QtwUQ9v7LvM9v7gijg=;
Received: from p5dcb30f2.dip0.t-ipconnect.de ([93.203.48.242] helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIwUX-0004ul-2F; Fri, 11 Oct 2019 17:06:05 +0200
Received: from localhost ([::1])
        by localhost with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iIwUV-0008KW-R0; Fri, 11 Oct 2019 17:06:03 +0200
Date:   Fri, 11 Oct 2019 17:05:53 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Rob Herring <robh@kernel.org>
Cc:     Marco Felsch <m.felsch@pengutronix.de>, mark.rutland@arm.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        manivannan.sadhasivam@linaro.org, andrew.smirnov@gmail.com,
        marex@denx.de, angus@akkea.ca, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        j.neuschaefer@gmx.net,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v3 2/3] ARM: dts: add Netronix E60K02 board common file
Message-ID: <20191011170147.1b3c4b25@kemnade.info>
In-Reply-To: <20191011142927.GA11490@bogus>
References: <20191010192357.27884-1-andreas@kemnade.info>
        <20191010192357.27884-3-andreas@kemnade.info>
        <20191011065609.6irap7elicatmsgg@pengutronix.de>
        <20191011094148.1376430e@aktux>
        <20191011142927.GA11490@bogus>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/pKsq_nhga4Bcf+WxR+iqaqg"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pKsq_nhga4Bcf+WxR+iqaqg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 11 Oct 2019 09:29:27 -0500
Rob Herring <robh@kernel.org> wrote:

> On Fri, Oct 11, 2019 at 09:41:48AM +0200, Andreas Kemnade wrote:
> > On Fri, 11 Oct 2019 08:56:09 +0200
> > Marco Felsch <m.felsch@pengutronix.de> wrote:
> >  =20
> > > Hi Andreas,
> > >=20
> > > On 19-10-10 21:23, Andreas Kemnade wrote: =20
> > > > The Netronix board E60K02 can be found some several Ebook-Readers,
> > > > at least the Kobo Clara HD and the Tolino Shine 3. The board
> > > > is equipped with different SoCs requiring different pinmuxes.
> > > >=20
> > > > For now the following peripherals are included:
> > > > - LED
> > > > - Power Key
> > > > - Cover (gpio via hall sensor)
> > > > - RC5T619 PMIC (the kernel misses support for rtc and charger
> > > >   subdevices).
> > > > - Backlight via lm3630a
> > > > - Wifi sdio chip detection (mmc-powerseq and stuff)
> > > >=20
> > > > It is based on vendor kernel but heavily reworked due to many
> > > > changed bindings.
> > > >=20
> > > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > > ---
> > > > Changes in v3:
> > > > - better led name
> > > > - correct memory size
> > > > - comments about missing devices
> > > >=20
> > > > Changes in v2:
> > > > - reordered, was 1/3
> > > > - moved pinmuxes to their actual users, not the parents
> > > >   of them
> > > > - removed some already-disabled stuff
> > > > - minor cleanups   =20
> > >=20
> > > You won't change the muxing, so a this dtsi can be self contained?
> > >  =20
> > So you want me to put a big=20
> > #if defined(MX6SLL)  =20
>=20
> Not sure what the comment meant, but no, don't do this. C defines in dts=
=20
> files are for symbolic names for numbers and assembling bitfields and=20
> that's it.

yes, that is also my opinion. For now, there is only one user
of this .dtsi, but I have another one in preparation. That is the
reason for splitting things between .dts and .dtsi to avoid such ugly
ifdefs

Regards,
Andreas

--Sig_/pKsq_nhga4Bcf+WxR+iqaqg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl2gmlEACgkQl4jFM1s/
ye9vKhAAos4YjS29TrFqk0UVc9rEP9svrO1m9mcIy34GAw1S8lPgrTQHk6CxjNYF
o2gTG/mcofsy1ngPu7kk625wYMDVzwP8ZXtM7N4DxYLS80vEKq56nkhrBnqIUCvb
Rv+8Sbo0TU4VAES/Hl2yjzl5XBiT6gPajB0BJE4WDSA+lHoZwRDpLz+4QbYlufTG
wJmiDj03mNOGU+UoQ6oruSYW9TQCbiGyx+W/nQGmxEBsT700acHt9A6WPvLeQBYi
nqKVtfVpd6uxxe58mJWEePFF9vEJNe2+FkSg9mMvSZd1SwfNfENw3XqYFb0V8xQ3
ZK8ZWp0ohC5Pa/+fSUlkKFOrPL/PDmK9arKOpj1+IHUg/HIUKW/PN+lzYK8d8Pw/
XKwmUkf4d8rMUyebbrmZgZmAA1V0lArO63RnWLY1COMo3x8whIx7TEjR7lCwi6ht
/p0k4uUw6tzdTsNDLhNNZs8jSY1fFWVJYdX5syspQGy9txQHmZCeDI7+qdleskUA
n7gJj7BslbrK5tmcC6kL2T8ZR8KtrEQjeeHM4UpuNh++7C9tkW44OGN/RP7ytcCr
4T3r21EoF1vNcIV9baRHD7iu74tbuvV8LW/hhsi7CBl2kKHDA1Q4uRaPIfF30wwD
8MwIW7K6JPxJvHlMbHOelBk1vI24MbMyXA4KjFewQDmZPfZK5AQ=
=icrB
-----END PGP SIGNATURE-----

--Sig_/pKsq_nhga4Bcf+WxR+iqaqg--
