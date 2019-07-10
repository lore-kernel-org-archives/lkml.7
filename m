Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29B6C606CF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42F120651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 12:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbfGJMz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 08:55:59 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:46237 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfGJMz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 08:55:58 -0400
X-Originating-IP: 86.250.200.211
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 05851C0004;
        Wed, 10 Jul 2019 12:55:52 +0000 (UTC)
Date:   Wed, 10 Jul 2019 14:55:52 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/modes: Skip invalid cmdline mode
Message-ID: <20190710125552.qvmnh6qs63ikiu2k@flea>
References: <20190709145151.23086-1-digetx@gmail.com>
 <20190710101229.54ufuhmh22dfxclr@flea>
 <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="67vkpimxupn2emik"
Content-Disposition: inline
In-Reply-To: <4ad69d15-07f8-9753-72d6-a51402c94c20@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67vkpimxupn2emik
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 03:42:28PM +0300, Dmitry Osipenko wrote:
> 10.07.2019 13:12, Maxime Ripard =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, Jul 09, 2019 at 05:51:51PM +0300, Dmitry Osipenko wrote:
> >> The named mode could be invalid and then cmdline parser misses to vali=
date
> >> mode's dimensions, happily adding 0x0 mode as a valid mode. One case w=
here
> >> this happens is NVIDIA Tegra devices that are using downstream bootloa=
der
> >> which adds "video=3Dtegrafb" to the kernel's cmdline and thus upstream=
 Tegra
> >> DRM driver fails to probe because of the invalid mode.
> >>
> >> Fixes: 3aeeb13d8996 ("drm/modes: Support modes names on the command li=
ne")
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >
> > Applied to drm-misc-next-fixes
> >
> > Thanks for figuring this out!
>
> Thank you very much! So the driver now doesn't fail to probe because
> of the cmdline, but what else I noticed is that the framebuffer
> console is now rotated by 90=C2=B0 on a 800x1280 panel, while display in
> Xorg is vertical as it was before. Seems something else is still
> missing, reverting "drm/modes: Rewrite the command line parser"
> returns the framebuffer's console orientation into the original
> state.

What is the whole command line passed by the bootloader ?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--67vkpimxupn2emik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXSXgWAAKCRDj7w1vZxhR
xbSNAP90FVLFwB5+zilKrKrHuq5DCTLYbu5hD446R9T6mYbDzwEAsVaCQHHR/dDs
5WjcFcl9xSdLXeMNaAFgIjCu90b7Uw0=
=Pmf4
-----END PGP SIGNATURE-----

--67vkpimxupn2emik--
