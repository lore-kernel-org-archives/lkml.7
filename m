Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E749C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0E20815
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732580AbfETMHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:07:41 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54041 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732564AbfETMHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:07:41 -0400
X-Originating-IP: 90.88.22.185
Received: from localhost (aaubervilliers-681-1-80-185.w90-88.abo.wanadoo.fr [90.88.22.185])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id B57911BF20E;
        Mon, 20 May 2019 12:07:37 +0000 (UTC)
Date:   Mon, 20 May 2019 14:07:36 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 7/7] drm: Remove users of drm_format_num_planes
Message-ID: <20190520120736.6ywe64l2oaigktbh@flea>
References: <27b0041c7977402df4a087c78d2849ffe51c9f1c.1558002671.git-series.maxime.ripard@bootlin.com>
 <c0a78c87cd0410a1819edad2794ad06543c85bb5.1558002671.git-series.maxime.ripard@bootlin.com>
 <20190520112045.GB6789@aptenodytes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="omouog2ag5tr5q2s"
Content-Disposition: inline
In-Reply-To: <20190520112045.GB6789@aptenodytes>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--omouog2ag5tr5q2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2019 at 01:20:45PM +0200, Paul Kocialkowski wrote:
> Hi,
>
> On Thu 16 May 19, 12:31, Maxime Ripard wrote:
> > drm_format_info_plane_cpp() basically just returns the cpp array content
> > found in the drm_format_info structure.
> >
> > Since it's pretty trivial, let's remove the function and have the users use
> > the array directly
>
> Reviewed-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Applied all 7 patches to drm-misc-next, thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--omouog2ag5tr5q2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXOKYiAAKCRDj7w1vZxhR
xQQ3AQCwmuWyICKzfQgOtEuXjQnERNJXKUlcT2+4I6UFvOzbpQEA1mQQ+PKTdFJ7
5c02i7jc4RH+Vxdlxw9S1jewokogoQE=
=Sv7i
-----END PGP SIGNATURE-----

--omouog2ag5tr5q2s--
