Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0EBC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AB32075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfDOOvl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:51:41 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45869 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfDOOvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:51:40 -0400
X-Originating-IP: 90.88.18.121
Received: from localhost (aaubervilliers-681-1-63-121.w90-88.abo.wanadoo.fr [90.88.18.121])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 03D1C60017;
        Mon, 15 Apr 2019 14:51:35 +0000 (UTC)
Date:   Mon, 15 Apr 2019 16:51:35 +0200
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
Message-ID: <20190415145135.fjbcaldwy7w3eqcs@flea>
References: <20190411214422.2267-1-peron.clem@gmail.com>
 <20190411214422.2267-2-peron.clem@gmail.com>
 <20190415080443.frubh4ln4agrdsfe@flea>
 <CAJiuCcc0Q8rh8u_30gKi8o07k0+e35UR99ZBHtCjx-DPkJEtdw@mail.gmail.com>
 <20190415081816.2pay4pioc5d4mojf@flea>
 <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxl5ukncdhkjkqsu"
Content-Disposition: inline
In-Reply-To: <CAJiuCcedNF0xYSa_+Zfwj-vqYsbjfEpRqisOhEvuitYALMsyjw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxl5ukncdhkjkqsu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2019 at 10:30:38AM +0200, Cl=E9ment P=E9ron wrote:
> On Mon, 15 Apr 2019 at 10:18, Maxime Ripard <maxime.ripard@bootlin.com> w=
rote:
> >
> > On Mon, Apr 15, 2019 at 10:09:11AM +0200, Cl=E9ment P=E9ron wrote:
> > > Hi,
> > >
> > > On Mon, 15 Apr 2019 at 10:04, Maxime Ripard <maxime.ripard@bootlin.co=
m> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, Apr 11, 2019 at 11:44:19PM +0200, Cl=E9ment P=E9ron wrote:
> > > > > Allwinner H6 has a SPDIF controller with an increase of the fifo
> > > > > size and the possibility to output the master clock.
> > > > > However it's still compatible with the already existing driver for
> > > > > Allwiner H3.
> > > > >
> > > > > Add this compatible in the device-tree bindings documentation.
> > > >
> > > > How was this tested?
> > >
> > > Using Alsa utils on a Beelink GS1 and I check correct output sound on
> > > my home cinema.
> > >
> > > > After looking at the datasheet, it looks like it's still significan=
tly
> > > > different. In particular:
> > > >
> > > >   - The MCLK divider isn't at the same offset
> > >
> > > We don't use the MCLK
> > >
> > > >   - The bits to flush the FIFO aren't at the same offset
> > > >   - The FIFO trigger levels aren't at the same offset
> > > >   - The FIFO status register layout is almost entirely different
> > >
> > > We use DMA not FIFO
> >
> > Well, DMA still uses the FIFOs. And even then, you're kind of missing
> > the point. The device tree's compatible is about whether a particular
> > device can be used as another one. How you are using it in the driver
> > is completely irrelevant.
>
> Sorry I meant " We use DMA not PIO".

I'm still not quite sure what you mean. Both DMA and PIO would be
using the FIFOs.

> I didn't change the driver and the SPDIF is working what's irrelevant
> in declaring the driver as compatible ?

It's working by accident.

This won't work for example:
https://elixir.bootlin.com/linux/latest/source/sound/soc/sunxi/sun4i-spdif.=
c#L181

> If some feature are missing they can be introduce later as there is a
> special binding for H6 no ?

Again, that's irrelevant. The only question you need to ask yourself
is whether, if you take an imaginary source code that would support
all the H3 SPDIF features and run it on an H6, it works just as well.

The examples above that it's not the case, so you can't claim that the
device is compatible.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sxl5ukncdhkjkqsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLSadwAKCRDj7w1vZxhR
xceAAP96JN2YhYM1zBkmyvK0GznWHP/qGjaXEu34Ymc9cr94WgEA5YRrzmmCqSra
G/5VRd32UJzMeF3TWQFNRHrueDOylwI=
=A0UO
-----END PGP SIGNATURE-----

--sxl5ukncdhkjkqsu--
