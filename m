Return-Path: <SRS0=xpJL=2P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2412C2D0DC
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 17:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC2920722
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Dec 2019 17:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577296671;
	bh=9Xq4VcjOueDmHCx5x1MsWoS3HcZBZ8M/IUkjuiAPHRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u3PQKV+LdDtELjPoqDHtumvbF0HeqZ0/UrqQDlImwRiXzXH9sA6+YzuZVU8Gr9nFr
	 JWmR5GPPOrs1gHwP7J242MH5d3jXULTRam1USqqBuX/gr1+QuhPmsVY8YCIo5wXeMi
	 5yIjQptzx17rwGO5D/RuKV8uifKWCkLxzSOTek4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLYR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Dec 2019 12:57:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50258 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfLYR5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Dec 2019 12:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lwfuEESWR4zX92Iq386iPtYoiE2TFNKpmeIvlfpb3Os=; b=ApchFp7KIms6vjJID9dvLZ2r+
        PQTXOQ3OE960aPn9u/+AEYhG5LzJsAxA97mGha1rgYrqURa9QEAAH7eh+NOHB2MZv5A7/H4K/k4Ed
        5kADNv5RtiErBeCzhHvh83uuv3GbqAUlGdvzN1dYcQdVJ3imwsytSCMn80BheYSlj5qg0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ikAuf-0001kC-72; Wed, 25 Dec 2019 17:57:37 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 77952D01A24; Wed, 25 Dec 2019 17:57:36 +0000 (GMT)
Date:   Wed, 25 Dec 2019 17:57:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 12/19] ASoC: tegra: Add initial parent configuration
 for audio mclk
Message-ID: <20191225175736.GC27497@sirena.org.uk>
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-13-git-send-email-skomatineni@nvidia.com>
 <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <a6567ff1-7bc2-3ca5-1200-92a63eb44ddb@gmail.com>
X-Cookie: I have many CHARTS and DIAGRAMS..
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 12:14:34AM +0300, Dmitry Osipenko wrote:
> 21.12.2019 01:26, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
> > through Tegra210 and currently Tegra clock driver does initial parent
> > configuration for audio mclk "clk_out_1" and enables them by default.

Please delete unneeded context from mails when replying.  Doing this
makes it much easier to find your reply in the message, helping ensure
it won't be missed by people scrolling through the irrelevant quoted
material.

> > -	clk_disable_unprepare(data->clk_cdev1);
> > -	clk_disable_unprepare(data->clk_pll_a_out0);
> > -	clk_disable_unprepare(data->clk_pll_a);
> > +	if (__clk_is_enabled(data->clk_cdev1))
> > +		clk_disable_unprepare(data->clk_cdev1);

> The root of the problem is that you removed clocks enabling from
> tegra_asoc_utils_init().

> I'm not sure why clocks should be disabled during the rate-changing,
> probably this action is not really needed.

I know nothing about this particular device but this is not that
unusual a restriction for audio hardware, you often can't
robustly reconfigure the clocking for a device while it's active
due to issues in the hardware.  You often see issues with FIFOs
glitching or state machines getting stuck.  This may not be an
issue here but if it's something that's documented as a
requirement it's probably good to pay attention.

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4Dow8ACgkQJNaLcl1U
h9CI+gf+NTSVmEXknNylmrROVvkijHFJkHpvx7hDJFGvYsu/qNKP8FkbIRWeKkE1
h1R5yupSd5QDSNRwtOG2Z3ZO5Dv/HYo+FmOIz+XDFNyKI7MU3fr4CkEzwZXcUzKt
GcGGfzcxYPJ8H7f5tbVvNjRHu+DiDvHEFvShhKUbHk7HJYqCrG6eMCfEDHlEkHU5
PkAp309INr7VEQSuch/JBXbvvI0glE66kcLH9CrHVdmrqc7hR8DmCm+49lGBOfIM
Jv1ylQj/Kx52U/zErkRqc9nsAkgJtQVafmwwCFj5SEeJIpCIanlTUXbRFRMkaMBL
5zpR7FZej7V40gjlWEGR0RaT9x6r5Q==
=c7E7
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
