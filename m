Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C347DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880E32053B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578490572;
	bh=hRF/c6vSidz995Bdfrt73EUUwHf0cNPuoQjJDpBeQS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=apPEsaOxrnaPv2cV6CIAUq/Ud3D72ZQiEKOhJG1COmmBvUvuyJ584yBrq4ZFdXz+n
	 6xz0SfPukWpOdI0zXNQXuMJD8QqsFh/F/f3iSYZWwOOn910sHRRV4gjcOKdkD/qrYU
	 reyuJk78FC0DzHDt0Qpk3FE63yBe9CGfQtuI1NAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727693AbgAHNgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:36:11 -0500
Received: from foss.arm.com ([217.140.110.172]:44654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgAHNgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:36:11 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AF3831B;
        Wed,  8 Jan 2020 05:36:10 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 253813F703;
        Wed,  8 Jan 2020 05:36:10 -0800 (PST)
Date:   Wed, 8 Jan 2020 13:36:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     jonathanh@nvidia.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: Re: [PATCH] regmap: add iopoll-like atomic polling macro
Message-ID: <20200108133608.GB3817@sirena.org.uk>
References: <1578392889-16587-1-git-send-email-spujar@nvidia.com>
 <20200107120902.GC4877@sirena.org.uk>
 <ae119533-6966-157a-d14b-365306907554@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ftEhullJWpWg/VHq"
Content-Disposition: inline
In-Reply-To: <ae119533-6966-157a-d14b-365306907554@nvidia.com>
X-Cookie: Trouble always comes at the wrong time.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ftEhullJWpWg/VHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2020 at 10:20:37AM +0530, Sameer Pujar wrote:

> While checking the documentation on snd_soc_dai_ops, it appears trigger() is
> in atomic context.
> This means I cannot use regmap interface (with default configuration) in
> trigger().
> The above issue went away with usage of regmap_read_poll_timeout_atomic()
> and now I think I just got lucky.

It's fine if your regmap is set up to support atomic use (using a flat
or no cache and MMIO) but not for regmaps in general, I'm asking you to
document the fact that it's only usable with some regmaps.

--ftEhullJWpWg/VHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4V2scACgkQJNaLcl1U
h9DyyQf+LRcDvu8nJIgo56AfloLDZvisdiVJj7IrHeWoTCRS9c1x+UZUP70TNT6z
U8jW6z/jfA0AjReMQygFjd6K+3qAlfl3A/7EdFIb2oIv8xhW89KOhEIG2gp0ai57
bID5m+17D34TDlaCbzVgR5jAapB34UzAK6Okv1VjbeTgAXvEhUbbPYPgNbF2WVB7
Sz8KTR4CVfHPNN3UVh/9PBkrbEx5ndgBhAyjf00iffGfisbtUJ2WoHWd06VuUAmW
MlUxoi4kSwbgx+yd9L1gq+TOcCYqrCiW/8b2UubQ/xEe4hOM6i8SvMKbtuViORIa
W9nhfZ/Ki+3VjeiMnh+n2/XUVY4ndw==
=8PIN
-----END PGP SIGNATURE-----

--ftEhullJWpWg/VHq--
