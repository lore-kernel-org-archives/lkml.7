Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFE6C2D0DC
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDF120866
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577958593;
	bh=e2aX0MJhewGki2xBt4YdOc9opVq/Rid8prxQy6m/Ask=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eI2NBgGA/n4I1v4jbixrZg/YnRXjvcuEiv1Q7r4TSrh2ufDIeM/xfF5t4Gkc3fXCr
	 ZUSPhHOSzBXU2i3gzRRvmcxDWU/Kq3FRAPOLTAypQRQb+8AaAkx4HAFH6nZREg/kDs
	 4pa/A6IJW5Rhew96IAiBrpRk3X8eufhu5qSeYAo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgABJtw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 04:49:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgABJtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 04:49:52 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03B42085B;
        Thu,  2 Jan 2020 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577958591;
        bh=e2aX0MJhewGki2xBt4YdOc9opVq/Rid8prxQy6m/Ask=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uJewPHQYBFbKV0Yfqi2AR4j6BhCuhjlhYdZMDjjUE6+7iSWBWg6lBV4hQS7nYnUWU
         YqXJCeuwQfjnjsTt9fnunSdiA2+Bmr9xmhIs9X1uEWPd6aRNk6HmdG9x4pa1Z1yBw1
         bCOoXERIIbmROz7TTCinfFclzPOVwGeV1S8Fbd34=
Date:   Thu, 2 Jan 2020 10:49:48 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     Roman Stratiienko <roman.stratiienko@globallogic.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/4] drm/sun4i: Reimplement plane z position setting logic
Message-ID: <20200102094948.2u56oiv6b3e4ekmb@gilmour.lan>
References: <20191228202818.69908-1-roman.stratiienko@globallogic.com>
 <1775324.taCxCBeP46@jernej-laptop>
 <CAODwZ7srrrbDk=kKjg2-amVtGzNsqqZ72JopHijtNPD=-EzjgA@mail.gmail.com>
 <2015568.Icojqenx9y@jernej-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="de3mzsbuwly2nscs"
Content-Disposition: inline
In-Reply-To: <2015568.Icojqenx9y@jernej-laptop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--de3mzsbuwly2nscs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2019 at 02:02:33PM +0100, Jernej =C5=A0krabec wrote:
> Dne nedelja, 29. december 2019 ob 13:47:38 CET je Roman Stratiienko
> napisal(a):
> > On Sun, Dec 29, 2019 at 2:18 PM Jernej =C5=A0krabec <jernej.skrabec@sio=
l.net>
> wrote:
> > > Dne nedelja, 29. december 2019 ob 13:08:19 CET je Roman Stratiienko
> > >
> > > napisal(a):
> > > > Hello Jernej,
> > > >
> > > > Thank you for review.
> > > >
> > > > On Sun, Dec 29, 2019 at 11:40 AM Jernej =C5=A0krabec
> > > > <jernej.skrabec@siol.net>
> > >
> > > wrote:
> > > > > Hi!
> > > > >
> > > > > Dne sobota, 28. december 2019 ob 21:28:17 CET je
> > > > >
> > > > > roman.stratiienko@globallogic.com napisal(a):
> > > > > > From: Roman Stratiienko <roman.stratiienko@globallogic.com>
> > > > > >
> > > > > > To set blending channel order register software needs to know s=
tate
> > > > > > and
> > > > > > position of each channel, which impossible at plane commit stag=
e.
> > > > > >
> > > > > > Move this procedure to atomic_flush stage, where all necessary
> > > > > > information
> > > > > > is available.
> > > > > >
> > > > > > Signed-off-by: Roman Stratiienko <roman.stratiienko@globallogic=
=2Ecom>
> > > > > > ---
> > > > > >
> > > > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c    | 47
> > > > > >  +++++++++++++++++++++++++-
> > > > > >  drivers/gpu/drm/sun4i/sun8i_mixer.h    |  3 ++
> > > > > >  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 42 ++++--------------=
-----
> > > > > >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 39 +++---------------=
---
> > > > > >  4 files changed, 60 insertions(+), 71 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index
> > > > > > bb9a665fd053..da84fccf7784
> > > > > > 100644
> > > > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > > > @@ -307,8 +307,47 @@ static void sun8i_atomic_begin(struct
> > > > > > sunxi_engine
> > > > > > *engine,
> > > > > >
> > > > > >  static void sun8i_mixer_commit(struct sunxi_engine *engine)
> > > > > >  {
> > > > > >
> > > > > > -     DRM_DEBUG_DRIVER("Committing changes\n");
> > > > > > +     struct sun8i_mixer *mixer =3D engine_to_sun8i_mixer(engin=
e);
> > > > > > +     u32 base =3D sun8i_blender_base(mixer);
> > > > > > +     int i, j;
> > > > > > +     int channel_by_zpos[4] =3D {-1, -1, -1, -1};
> > > > > > +     u32 route =3D 0, pipe_ctl =3D 0;
> > > > > > +
> > > > > > +     DRM_DEBUG_DRIVER("Update blender routing\n");
> > > > >
> > > > > Use drm_dbg().
> > > > >
> > > > > > +     for (i =3D 0; i < 4; i++) {
> > > > > > +             int zpos =3D mixer->channel_zpos[i];
> > > > >
> > > > > channel_zpos can hold 5 elements which is also theoretical maximu=
m for
> > > > > current HW design. Why do you check only 4 elements?
> > > >
> > > > I'll use plane_cnt as it done in mixer_bind
> > > >
> > > > > It would be great to introduce a macro like SUN8I_MIXER_MAX_LAYER=
S so
> > > > > everyone would understand where this number comes from.
> > > >
> > > > Will do.
> > > >
> > > > > > +
> > > > > > +             if (zpos >=3D 0 && zpos < 4)
> > > > > > +                     channel_by_zpos[zpos] =3D i;
> > > > > > +     }
> > > > > > +
> > > > > > +     j =3D 0;
> > > > > > +     for (i =3D 0; i < 4; i++) {
> > > > > > +             int ch =3D channel_by_zpos[i];
> > > > > > +
> > > > > > +             if (ch >=3D 0) {
> > > > > > +                     pipe_ctl |=3D SUN8I_MIXER_BLEND_PIPE_CTL_=
EN(j);
> > > > > > +                     route |=3D ch <<
> > > > >
> > > > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > > > >
> > > > > > +                     j++;
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     for (i =3D 0; i < 4 && j < 4; i++) {
> > > > > > +             int zpos =3D mixer->channel_zpos[i];
> > > > > >
> > > > > > +             if (zpos < 0) {
> > > > > > +                     route |=3D i <<
> > > > >
> > > > > SUN8I_MIXER_BLEND_ROUTE_PIPE_SHIFT(j);
> > > > >
> > > > > > +                     j++;
> > > > > > +             }
> > > > > > +     }
> > > > > > +
> > > > > > +     regmap_update_bits(mixer->engine.regs,
> > > > >
> > > > > SUN8I_MIXER_BLEND_PIPE_CTL(base),
> > > > >
> > > > > > +                        SUN8I_MIXER_BLEND_PIPE_CTL_EN_MSK,
> > > > >
> > > > > pipe_ctl);
> > > > >
> > > > > > +
> > > > > > +     regmap_write(mixer->engine.regs,
> > > > > > +                  SUN8I_MIXER_BLEND_ROUTE(base), route);
> > > > > > +
> > > > > > +     DRM_DEBUG_DRIVER("Committing changes\n");
> > > > >
> > > > > Use drm_dbg().
> > > >
> > > > According to
> > > > https://github.com/torvalds/linux/commit/99a954874e7b9f0c8058476575=
593b3
> > > > beb
> > > > 5731a5#diff-b0cd2d683c6afbab7bd54173cfd3d3ecR289 ,
> > > > DRM_DEBUG_DRIVER uses drm_dbg.
> > > > Also, using drm_dbg with category macro would require larger indent,
> > > > making harder to fit in 80 chars limit.
> > >
> > > From what I can see, category is already defined by macro name. Check
> > > here:
> > > https://cgit.freedesktop.org/drm/drm-misc/tree/include/drm/drm_print.=
h#n46
> > > 5
> > >
> > > So it should be actually shorter.
> >
> > Ah, it something very recent.
> > drm_dbg also require drm_device struct
> > Do you know the best way to extract it from `struct engine`?
>
> I don't think there is a way. I guess we can solve this later. Maxime, any
> thoughts?

There's no way at the moment, but it would make sense to add a pointer
to it.

Maximey

--de3mzsbuwly2nscs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXg28vAAKCRDj7w1vZxhR
xU6hAQCE+KlOly8mijq6chKdZDCcSW8wUtYhuO+CaIIU7J53xQEAuD9An1CTC6G1
3+SsZAX+/ykUpdWbkwliqwhgmDmdKgU=
=2asc
-----END PGP SIGNATURE-----

--de3mzsbuwly2nscs--
