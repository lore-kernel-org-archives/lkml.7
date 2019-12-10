Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A71AC2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72759205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 18:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576004377;
	bh=30nTRPWcWNZXdJXjfm6kVShgPUOYSA9w8Z775GWHsk4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nY74pLoU2yuQ1YQLQsNqDl96rwObt95iy2ZpMdAOusuBcijyiMhNhSnictwryKMyb
	 byD9U71/Yk4Es0j428u9Jj95/bfecaviH+0cgkrxOaWWAq844iwgeCCJpvFnbK1WS7
	 7/BPdsEADeaD2SxtF15CWG/U1O3GXGwdN+BrQQAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfLJS7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:59:36 -0500
Received: from foss.arm.com ([217.140.110.172]:53924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727625AbfLJS7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 13:59:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66C4C328;
        Tue, 10 Dec 2019 10:59:35 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A9D3F6CF;
        Tue, 10 Dec 2019 10:59:34 -0800 (PST)
Date:   Tue, 10 Dec 2019 18:59:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, tglx@linutronix.de, allison@lohutok.net,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        mturquette@baylibre.com, horms+renesas@verge.net.au,
        Jisheng.Zhang@synaptics.com, krzk@kernel.org, arnd@arndb.de,
        spujar@nvidia.com, josephl@nvidia.com, vidyas@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        markz@nvidia.com, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alexios.zavras@intel.com,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 09/15] ASoC: tegra: Add fallback for audio mclk
Message-ID: <20191210185933.GJ6110@sirena.org.uk>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
 <20191209164027.GG5483@sirena.org.uk>
 <7fe879fd-dae3-1e64-1031-cd9f00e31552@gmail.com>
 <20191209204735.GK5483@sirena.org.uk>
 <560185d9-32fd-a85e-5feb-105f79b953c6@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XigHxYirkHk2Kxsx"
Content-Disposition: inline
In-Reply-To: <560185d9-32fd-a85e-5feb-105f79b953c6@gmail.com>
X-Cookie: We have ears, earther...FOUR OF THEM!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XigHxYirkHk2Kxsx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 10, 2019 at 09:24:43PM +0300, Dmitry Osipenko wrote:

> In some cases it could be painful to maintain device-tree compatibility
> for platforms like NVIDIA Tegra SoCs because hardware wasn't modeled
> correctly from the start.

> I agree that people should use relevant device-trees. It's quite a lot
> of hassle to care about compatibility for platforms that are permanently
> in a development state. It could be more reasonable to go through the
> pain if kernel required a full-featured device tree for every SoC from
> the start.

We absolutely should support the newer kernel with older device tree
case, what's less clear to me is the new device tree with old kernel
which is applying LTS updates case.  That does seem incredibly
specialist - I'd honestly never heard of people doing that before this
thread.

--XigHxYirkHk2Kxsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3v6xQACgkQJNaLcl1U
h9DaRQf/a3YemFgucFyV5HfTaJz5xFhKVR+h6YPRh1yMll+FZbh9bfsgwoQ0yWWe
pu3FNb2UWObN6Yd0c6nIxiIJAqyvPridz15jnQ8mfGSTehSRsbHf6YkTUsDeSpik
LZTQ4pCWNtrA5vJuFJ3i9DMNfOFTQjBOTwnFM0JcecBddROFtPhAG5CseblR7BlT
hBvipkmnrquc66L0hFpbqBoBN4RvHAaYBa+t8GZntPUqrQyN1XxtjJW4Ye+IRS7u
CsSsnVe5WUhZp70+Fa2UxTXhtAnmpTl5cFixH6fq6ynxgwgueKOHDfmLNB/wSR4I
Cg0W+t7FHmBN2Wrd/7z/avBc1teFeA==
=c8lH
-----END PGP SIGNATURE-----

--XigHxYirkHk2Kxsx--
