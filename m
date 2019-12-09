Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E869CC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2490207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575909631;
	bh=vbkK5CIGGgBE8zOV3p0UskGcCxJ2wOHra9eBgs5nW38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KaS/XmwaPd7Mn3qCuPjR3w+rA5ejq8QsJPZQof7D2S+eERb2omqQSAGtHBhjwwqfq
	 rTAe6R+q1+TZaqBEqO2hmqpq1kepPUkfhXDPxEA85V8nO9pYoucCUM6vJD2U4oyRLD
	 NJpTqHOdKAAhR3C/FXdTjzaW2wyJ2tm+Gng7knjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfLIQkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:40:31 -0500
Received: from foss.arm.com ([217.140.110.172]:37948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfLIQka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1C7B1045;
        Mon,  9 Dec 2019 08:40:29 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E38B23F718;
        Mon,  9 Dec 2019 08:40:28 -0800 (PST)
Date:   Mon, 9 Dec 2019 16:40:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
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
Message-ID: <20191209164027.GG5483@sirena.org.uk>
References: <1575600535-26877-1-git-send-email-skomatineni@nvidia.com>
 <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UKNXkkdQCYZ6W5l3"
Content-Disposition: inline
In-Reply-To: <1575600535-26877-10-git-send-email-skomatineni@nvidia.com>
X-Cookie: We read to say that we have read.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UKNXkkdQCYZ6W5l3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 05, 2019 at 06:48:49PM -0800, Sowjanya Komatineni wrote:
> mclk is from clk_out_1 which is part of Tegra PMC block and pmc clocks
> are moved to Tegra PMC driver with pmc as clock provider and using pmc
> clock ids.
>=20
> New device tree uses clk_out_1 from pmc clock provider.
>=20
> So, this patch adds fallback to extern1 in case of retrieving mclk fails
> to be backward compatible of new device tree with older kernels.
>=20
> Cc: stable@vger.kernel.org

Why would this need to be a stable fix?  Presumably people with stable
kernels are using the old device tree anyway?

--UKNXkkdQCYZ6W5l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3uePoACgkQJNaLcl1U
h9D66wf9EtL0BmittcbTOCbTdEmV+6j2kRHf90+8kREBk+po5Zgw/f04NXW1VR/o
kLtbsSNRWvW6HVGcWiKcNfqwBnq6P5mb2ufc9OsvjWAKJJNBnZxF2AacAn7/I2my
ck6qGzJj4X70Xdt+KkhdTorKJX8PdX3Az9abC77DTq8cH2kbWt/domujEXrR/36g
XCAXHpj+Id9dTLaqKz8z0ZhYsZlzaaW+QTJ12Ocuayna4rF/JB/P0n94rSjBVSVG
ozfOhg7YYn9Q0NaGtjX7tUNX6vSF48kHKfrhfMIEDtkidq3AogcQACno8rg4amIL
EhtifDhVUKFWuXliJGz3WveE8/2MrA==
=CHYQ
-----END PGP SIGNATURE-----

--UKNXkkdQCYZ6W5l3--
