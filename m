Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE53C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508052173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 08:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbfGPIne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 04:43:34 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:48877 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfGPInd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 04:43:33 -0400
Received: from localhost (91-163-65-175.subs.proxad.net [91.163.65.175])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 5A1CF100017;
        Tue, 16 Jul 2019 08:42:25 +0000 (UTC)
Date:   Tue, 16 Jul 2019 10:42:25 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/modes: Don't apply cmdline's rotation if it
 wasn't specified
Message-ID: <20190716084225.6wf5lsdzukyb6cz5@flea>
References: <20190711021313.29445-1-digetx@gmail.com>
 <20190712195429.dlz5ofwoafciedcq@flea>
 <11723cfd-12d2-5810-70df-0e053352d648@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="octe5474vzs7zgnm"
Content-Disposition: inline
In-Reply-To: <11723cfd-12d2-5810-70df-0e053352d648@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--octe5474vzs7zgnm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 13, 2019 at 09:57:32PM +0300, Dmitry Osipenko wrote:
> 12.07.2019 22:54, Maxime Ripard =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Thu, Jul 11, 2019 at 05:13:13AM +0300, Dmitry Osipenko wrote:
> >> The rotation mode from cmdline shouldn't be taken into account if it
> >> wasn't specified in the cmdline. This fixes ignored default display
> >> orientation when display mode is given using cmdline without the
> >> rotation being specified.
> >>
> >> Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflect=
ion on the commandline")
> >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > Thanks!
> > Maxime
>
> Thank you. Please note that I'm not a DRM maintainer, hence either you
> should pick up and apply the patch by yourself or somebody else who has
> the commit rights will have do that. I guess Thierry could also pick up
> the patch into the Tegra's tree, but this patch is more DRM-generic.

Right, I've applied it now

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--octe5474vzs7zgnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXS2N8QAKCRDj7w1vZxhR
xZU/APwMSaCF6bmFUXlM1KJUOeNWQxXyRsoece/0gjVsiShCfAD+INMwbkotiFNg
3y6stSLHSrLJF4aCkziA0WYN6xwACQ4=
=/jaE
-----END PGP SIGNATURE-----

--octe5474vzs7zgnm--
