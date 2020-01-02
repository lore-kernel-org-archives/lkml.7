Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE22C3276E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F06217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577980028;
	bh=T8OrAG+EbDBgprNjNPQUw5artBgkO7vYeVQWzwTXJoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RkfYE19OJsar83OYFadLx09MrJBXtWIBF3uenp6Zcu3KNT95LagHERWQ+NqfvyfU5
	 RTa0TuqJ/AscohjWKoq+T6kJz8B+bbSEOMGLImjb2+zLQgWnvCJInCN6X/BfYgdArv
	 JePHWlVLAFiyNrcKiCQODJcwixv0gsN2f7POESI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728745AbgABPrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 10:47:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728692AbgABPrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 10:47:07 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35EAD2084D;
        Thu,  2 Jan 2020 15:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577980026;
        bh=T8OrAG+EbDBgprNjNPQUw5artBgkO7vYeVQWzwTXJoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHJuZfunqyFIUSm59iEc056NpuILkoQ6oFP5/CcZbxEABe9Tdw4bbJCYvITmXyHsw
         bJX8BeH0sfhUJJwGDpFLnr+tY+l5ystDQV6TB3pT2zp9BLkgh8POz+fsfDNMEfa4QM
         uSBNPxcMQXEIcuBWHU0bY5f7VafWFZrL+q5RUiaA=
Date:   Thu, 2 Jan 2020 16:47:03 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v3 2/9] drm/sun4i: tcon: Add TCON LCD support for R40
Message-ID: <20200102154703.3prgwcjyo36g5g5u@gilmour.lan>
References: <20191231130528.20669-1-jagan@amarulasolutions.com>
 <20191231130528.20669-3-jagan@amarulasolutions.com>
 <20200102105424.kmte7aooh2gkrcnu@gilmour.lan>
 <CAMty3ZA0e8eJZWvAh0x=KGAZVL3apdao3COvR6j3-ckv0cdvcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p6isxbjx5q73zube"
Content-Disposition: inline
In-Reply-To: <CAMty3ZA0e8eJZWvAh0x=KGAZVL3apdao3COvR6j3-ckv0cdvcg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6isxbjx5q73zube
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 02, 2020 at 09:10:31PM +0530, Jagan Teki wrote:
> On Thu, Jan 2, 2020 at 4:24 PM Maxime Ripard <mripard@kernel.org> wrote:
> >
> > On Tue, Dec 31, 2019 at 06:35:21PM +0530, Jagan Teki wrote:
> > > TCON LCD0, LCD1 in allwinner R40, are used for managing
> > > LCD interfaces like RGB, LVDS and DSI.
> > >
> > > Like TCON TV0, TV1 these LCD0, LCD1 are also managed via
> > > tcon top.
> > >
> > > Add support for it, in tcon driver.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > ---
> > > Changes for v3:
> > > - none
> > >
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > index fad72799b8df..69611d38c844 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > @@ -1470,6 +1470,13 @@ static const struct sun4i_tcon_quirks sun8i_a83t_tv_quirks = {
> > >       .has_channel_1          = true,
> > >  };
> > >
> > > +static const struct sun4i_tcon_quirks sun8i_r40_lcd_quirks = {
> > > +     .supports_lvds          = true,
> > > +     .has_channel_0          = true,
> > > +     /* TODO Need to support TCON output muxing via GPIO pins */
> > > +     .set_mux                = sun8i_r40_tcon_tv_set_mux,
> >
> > What is this muking about? And why is it a TODO?
>
> Muxing similar like how TCON TOP handle TV0, TV1 I have reused the
> same so-that it would configure de port selection via
> sun8i_tcon_top_de_config
>
> TCON output muxing have gpio with GPIOD and GPIOH bits, which select
> which of LCD or TV TCON outputs to the LCD function pins. I have
> marked these has TODO for further support as mentioned by Chen-Yu in
> v1[1].

It should be in the commit log.

What's the plan to support that when needed? And that means that the
LCD and TV outputs are mutually exclusive? We should at the very least
check that both aren't enabled at the same time.

Maxime

--p6isxbjx5q73zube
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg4QdwAKCRDj7w1vZxhR
xV8pAQDW62BjjYRqQWaS/MCrLYV0sOBGYFlSj2Kk1hrJLyStbAEAugmjPCknAQNc
AuBKfBeWbLwThyU6B5QE39I7erhWOwQ=
=omNK
-----END PGP SIGNATURE-----

--p6isxbjx5q73zube--
