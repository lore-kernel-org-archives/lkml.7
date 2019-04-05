Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBF0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2074217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 08:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730353AbfDEInm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 04:43:42 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:35963 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfDEInm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 04:43:42 -0400
X-Originating-IP: 90.88.30.125
Received: from localhost (aaubervilliers-681-1-89-125.w90-88.abo.wanadoo.fr [90.88.30.125])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E64861BF215;
        Fri,  5 Apr 2019 08:43:37 +0000 (UTC)
Date:   Fri, 5 Apr 2019 10:43:37 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Sean Paul <sean@poorly.run>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "Documentation/gpu/meson: Remove link to
 meson_canvas.c"
Message-ID: <20190405084337.7v7v7h2g7qqxoo4n@flea>
References: <20190404144342.15238-1-narmstrong@baylibre.com>
 <20190404145202.GC17077@art_vandelay>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sbnzg6yrejf7zfmw"
Content-Disposition: inline
In-Reply-To: <20190404145202.GC17077@art_vandelay>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sbnzg6yrejf7zfmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 10:52:02AM -0400, Sean Paul wrote:
> On Thu, Apr 04, 2019 at 04:43:42PM +0200, Neil Armstrong wrote:
> > This reverts commit a3f98bb22cbfaaf67717e156f79e2bfeb42d4cac.
> >
> > Patch "Documentation/gpu/meson: Remove link to meson_canvas.c" was
> > incorrectly applied on the wrong branch not containing the fixed
> > commit 2bf6b5b0e374 ("drm/meson: exclusively use the canvas provider module")
> >
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>
> Acked-by: Sean Paul <sean@poorly.run>
>
> and I'll leave this for Maxime to apply if he so chooses.

Applied, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--sbnzg6yrejf7zfmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXKcVOQAKCRDj7w1vZxhR
xfViAP0VV+50SZFxz5zGnyNmQRNY/RXj+w0HUU7HRcadcuJJIAEAoH4KjpVDoL5L
1eWdCzGH6R9XkPIOfeWmVp2us70LygE=
=Jo6u
-----END PGP SIGNATURE-----

--sbnzg6yrejf7zfmw--
