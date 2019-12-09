Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56DEC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F1D20637
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575924459;
	bh=xjQtbBTSqhoMGJwn3RUeOi50GwFWIhX8xMZTaQKQu9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zG2kjaHraAkh2YEaH3FSVF9ZqFTrJ6qaVrsbUlNnwiD7V7XVpd2XIY+S8J3/no29X
	 cyTgeqe66KdweiPD12GKyuNuHPderVqGZq9Q6YPwvKEdM7tm/W+dsWSNlyHBEV6Rvh
	 r8A5hBDgNHNJ55LvvCbCHpFi8DHuSRfb3SLaW/Ts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfLIUrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 15:47:39 -0500
Received: from foss.arm.com ([217.140.110.172]:45592 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfLIUri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 15:47:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E147A328;
        Mon,  9 Dec 2019 12:47:37 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E6833F718;
        Mon,  9 Dec 2019 12:47:37 -0800 (PST)
Date:   Mon, 9 Dec 2019 20:47:35 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, allison@lohutok.net, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, mturquette@baylibre.com,
        horms+renesas@verge.net.au, Jisheng.Zhang@synaptics.com,
        krzk@kernel.org, arnd@arndb.de, spujar@nvidia.com,
        josephl@nvidia.com, vidyas@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alexios.zavras@intel.com, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
Message-ID: <20191209204735.GK5483@sirena.org.uk>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <20191209164027.GG5483@sirena.org.uk>
 <7fe879fd-dae3-1e64-1031-cd9f00e31552@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LQ77YLfPrO/qF/pM"
Content-Disposition: inline
In-Reply-To: <7fe879fd-dae3-1e64-1031-cd9f00e31552@gmail.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQ77YLfPrO/qF/pM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 11:31:59PM +0300, Dmitry Osipenko wrote:
> 09.12.2019 19:40, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > Why would this need to be a stable fix?  Presumably people with stable
> > kernels are using the old device tree anyway?

> At least Rob Herring is asking to maintain backwards compatibility
> because some ditros are using newer device-trees with stable kernels.

You're talking about forwards compatibility not backwards here.  Are
those distros actually using LTS kernels?

> I'm personally also tending to use the newer DTB with older kernel
> version whenever there is a need to check something using stable kernel.
> Perhaps losing sound is not very important, but will be nicer if that
> doesn't happen.

That really does sound like a "you broke it, you get all the pieces"
situation TBH...  I'd be a lot more comfortable if the stable kernels
were sticking to bugfix only though I do appreciate that they're not
really that any more.

--LQ77YLfPrO/qF/pM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3usucACgkQJNaLcl1U
h9DLZgf/bl+y6tN1f9+6Q5i4PkGjVAppOzDxi0mDZ6TrvcSLsNfAhK9+1IH7w0+x
F90tauu6Flsm9/TnoDK5Csuotm+nKlkXidXNL5qfSzW4azrXes5gdOrwpicKOnEG
7T92jLjHOCPaANNqKrtX+29qAamyxmKOCW/8AKH8SNjerkCDZfZks3yjqilm4i4A
6jwUUAi9ij8TvZlSGteUlqfmib7FdxodH0Gud2q3lYFUKWrKpGnPh823iHtTpiKK
EGDYhbcuS1BeEP6dB/7baejQjkrEjpz7YslmD2KjGlUWIRVEpKPqU/SY63e7mChB
UDCefmC858Tzlkyi7AFFmjnFrTfrMQ==
=IA00
-----END PGP SIGNATURE-----

--LQ77YLfPrO/qF/pM--
