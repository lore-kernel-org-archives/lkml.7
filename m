Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1255C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBD820868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfDPHe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:34:56 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60515 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfDPHez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:34:55 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 4611720007;
        Tue, 16 Apr 2019 07:34:50 +0000 (UTC)
Date:   Tue, 16 Apr 2019 09:34:49 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: sun4i-spdif: Add Allwinner H6
 compatible
Message-ID: <20190416073449.qzl3uyjgvjgd3tai@flea>
References: <20190411214422.2267-1-peron.clem@gmail.com>
 <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea>
 <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea>
 <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
 <20190415145135.fjbcaldwy7w3eqcs@flea>
 <CAJiuCcdrQ64jC8UH1eDKKhFdcOtk=bkWTAzoYOQ1ut3He+j2GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dreprrpoxkojozhw"
Content-Disposition: inline
In-Reply-To: <CAJiuCcdrQ64jC8UH1eDKKhFdcOtk=bkWTAzoYOQ1ut3He+j2GQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dreprrpoxkojozhw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 06:30:10PM +0200, Cl=E9ment P=E9ron wrote:
> > > I didn't change the driver and the SPDIF is working what's irrelevant
> > > in declaring the driver as compatible ?
> >
> > It's working by accident.
> >
> > This won't work for example:
> > https://elixir.bootlin.com/linux/latest/source/sound/soc/sunxi/sun4i-sp=
dif.c#L181
> >
> > > If some feature are missing they can be introduce later as there is a
> > > special binding for H6 no ?
> >
> > Again, that's irrelevant. The only question you need to ask yourself
> > is whether, if you take an imaginary source code that would support
> > all the H3 SPDIF features and run it on an H6, it works just as well.
> >
> > The examples above that it's not the case, so you can't claim that the
> > device is compatible.
>
> Is it ok if I fix the TX Fifo flush bit and remove the compatible with H3=
 ?
> (Looking at the driver this is the only bit used that is incompatible wit=
h H6)

Sure

> Or should I send a new driver with the correct mapping ?

No, we definitely don't want to duplicate a driver just for a single
bit offset that changes.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--dreprrpoxkojozhw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLWFmQAKCRDj7w1vZxhR
xbwSAP4yo3KgkfxUrGPdnBM72F56+bA+1mMwG98vKpWTUgVHwQEAuTweyDqrCXY6
OG3tkkix1uS2CpWCLw52E3RgcOp+1wk=
=4IzS
-----END PGP SIGNATURE-----

--dreprrpoxkojozhw--
