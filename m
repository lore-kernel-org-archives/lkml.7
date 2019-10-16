Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1564FFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A1721925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 14:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571237629;
	bh=uc/PYalgTjzCCWhp6PA2rkYtBpjEkTRPLPZjqrQyptI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tZ8nFLabBendTY/2aTU2xvmU7HyQadrE4RVwKp/4H2TIixMbXqpm0FKiSGdDdCdIg
	 KmhRvJtkxXpQMWf5tHVUUZsCeip/1WFZv/0hGyOy/kzErOl4/eV/oAdfdM1Ma6EqyQ
	 QokHYQoOiyy623c4abI8Zko6FX89K25u2VJCMCPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394104AbfJPOxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 10:53:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728706AbfJPOxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 10:53:48 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4985F2168B;
        Wed, 16 Oct 2019 14:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571237627;
        bh=uc/PYalgTjzCCWhp6PA2rkYtBpjEkTRPLPZjqrQyptI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x7w7DZ/gRhixI5aXMMHU39O2Ro3sO/7sBmGkF+zzkpkPrptyR9+jc4MEcN7v509e9
         Zg5kAUqeRoB9qzys+P36C2PI+bAfPTelA9JfB1RJB/FGqDk57u3ph7ZaakwdFs7iRm
         2UxhvNWaIWWezJxjUZVD3w+9mEyjt/+qlNHsYyqY=
Date:   Wed, 16 Oct 2019 16:53:45 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Code Kipper <codekipper@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "Andrea Venturi (pers)" <be17068@iperbole.bo.it>
Subject: Re: [PATCH v6 2/7] ASoC: sun4i-i2s: Add functions for RX and TX
 channel offsets
Message-ID: <20191016145345.ll2igr2j5zttosjj@gilmour>
References: <20191016070740.121435-1-codekipper@gmail.com>
 <20191016070740.121435-3-codekipper@gmail.com>
 <20191016080653.3seixioa2xiaobd7@gilmour>
 <CAEKpxBmuYe-kHpa4cvo6iabTM_qNro2hXVAkjioBZFt9N4pHdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jby4uz6cwklukmi6"
Content-Disposition: inline
In-Reply-To: <CAEKpxBmuYe-kHpa4cvo6iabTM_qNro2hXVAkjioBZFt9N4pHdA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jby4uz6cwklukmi6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 16, 2019 at 10:25:29AM +0200, Code Kipper wrote:
> On Wed, 16 Oct 2019 at 10:06, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > On Wed, Oct 16, 2019 at 09:07:35AM +0200, codekipper@gmail.com wrote:
> > > From: Marcus Cooper <codekipper@gmail.com>
> > >
> > > Newer SoCs like the H6 have the channel offset bits in a different
> > > position to what is on the H3. As we will eventually add multi-
> > > channel support then create function calls as opposed to regmap
> > > fields to add support for different devices.
> > >
> > > Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > ---
> > >  sound/soc/sunxi/sun4i-i2s.c | 31 +++++++++++++++++++++++++------
> > >  1 file changed, 25 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > > index f1a80973c450..875567881f30 100644
> > > --- a/sound/soc/sunxi/sun4i-i2s.c
> > > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > > @@ -157,6 +157,8 @@ struct sun4i_i2s_quirks {
> > >       int     (*set_chan_cfg)(const struct sun4i_i2s *,
> > >                               const struct snd_pcm_hw_params *);
> > >       int     (*set_fmt)(struct sun4i_i2s *, unsigned int);
> > > +     void    (*set_txchanoffset)(const struct sun4i_i2s *, int);
> > > +     void    (*set_rxchanoffset)(const struct sun4i_i2s *);
> >
> > The point of removing the regmap_field was that because having a
> > one-size-fits-all function with regmap_field sort of making the
> > abstraction was becoming more and more of a burden to maintain.
> >
> > Having functions for each and every register access is exactly the
> > same as using regmap_field here, and the issue we adressed is not with
> > regmap_fields in itself.
> >
> > If the H6 has a different register layout, then so be it, create a new
> > set_chan_cfg or set_fmt function for the H6.
>
> The H3 and the H6 have a similar register layout but the issue here
> is that sooner rather than later we would want to be supporting
> multi-channel audio which requires the offset to be applied to each
> TX channel channel select register(8chan PCM for HDMI requires 4 Tx
> channels). Currently we're only using one.

So, as it turns out, they do not have the same register layout?

Maxime

--jby4uz6cwklukmi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXacu+QAKCRDj7w1vZxhR
xbpWAQD9d7cqPH+6+SLdgcA51ULmYTV+ruv2fADxYhKJiST9+AD/UEhef7PZqkGw
6nq7Em4kSoD7ip5xtYFAHDOWzTFGUgk=
=IAvd
-----END PGP SIGNATURE-----

--jby4uz6cwklukmi6--
