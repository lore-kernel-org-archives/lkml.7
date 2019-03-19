Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65599C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E04320828
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbfCSK6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:58:33 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:52683 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCSK6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:58:32 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 3642D40011;
        Tue, 19 Mar 2019 10:58:29 +0000 (UTC)
Date:   Tue, 19 Mar 2019 11:58:28 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Chen-Yu Tsai <wens@csie.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v9 0/5] drm/sun4i: sun6i_mipi_dsi: Fixes/updates
Message-ID: <20190319105828.x23jnynvonovlepp@flea>
References: <20190303173527.31055-1-jagan@amarulasolutions.com>
 <CAMty3ZAGvCOuqcTUozBm-uR4z=jR18bfOSyN5=jfT85HGWR_1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xj2yju6wym2h5pv"
Content-Disposition: inline
In-Reply-To: <CAMty3ZAGvCOuqcTUozBm-uR4z=jR18bfOSyN5=jfT85HGWR_1A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3xj2yju6wym2h5pv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 11:58:39PM +0530, Jagan Teki wrote:
> Hi,
>
> On Sun, Mar 3, 2019 at 11:06 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
> >
> > Unfortunately due to various reasons[3] the previous fixes[1] and burst[2]
> > changes are failed to apply.
> >
> > So, this series is filtered version of previous [1] and [2] changes on top
> > of drm-misc.
> >
> > patch-1: Fix for burst mode instruction delay computation
> >
> > patch-2: Fix for TCOn DRQ set bits
> >
> > patch-3: Support vblk timing for 4-lane devices
> >
> > patch-4: GENERIC_SHORT_WRITE_2 dsi transfer support
> >
> > patch-5: Code simplification for dsi timings
> >
> > Changes for v9:
> > - rebase on drm-misc
> > - update commit messages
> > - add hsync_porch overflow patch
> > Changes for v8:
> > - rebase on master
> > - rework on commit messages
> > - rework video start delay
> > - include drq changes from previous version
> > Changes for v7:
> > - rebase on master
> > - collect Merlijn Wajer Tested-by credits.
> > Changes for v6:
> > - fixed all burst mode patches as per previous version comments
> > - rebase on master
> > - update proper commit message
> > - dropped unneeded comments
> > - order the patches that make review easy
> > Changes for v5, v4, v3, v2:
> > - use existing driver code construct for hblk computation
> > - create separate function for vblk computation
> > - cleanup commit messages
> > - update proper commit messages
> > - fixed checkpatch warnings/errors
> > - use proper return value for tcon0 probe
> > - add logic to get tcon0 divider values
> > - simplify timings code to support burst mode
> > - fix drq computation return values
> > - rebase on master
> >
> > [1] https://patchwork.kernel.org/cover/10813573/
> > [2] https://patchwork.kernel.org/cover/10813623/
> > [3] https://patchwork.kernel.org/cover/10805995/
> >
> > Any inputs?
> > Jagan.
>
> Any further comments on this series? Can I send next version with some changes?

Unless you address what we've asked for the very beginning and provide
some accurate description of your problem, and references to why you
think your changes are the right thing to do, it's not worth sending a
new version, the discussion cannot make further progress.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--3xj2yju6wym2h5pv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXJDLVAAKCRDj7w1vZxhR
xdDZAQDRuWu7Ot5mMoMdbPwcbiTF91eoCdshwJRKLPvNvgli4wEA/lOG8FXF3F0X
4KBLr/YlsATpS6SUTNuoaXMMjPBXpQI=
=+kyz
-----END PGP SIGNATURE-----

--3xj2yju6wym2h5pv--
