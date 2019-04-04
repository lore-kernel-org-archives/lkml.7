Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76485C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB2B20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 05:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554356881;
	bh=0edM/x1veO9YkGG0MTWeLyypWU0/EBKr6udjJleruQU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vWEjJoIMGcdEUDp0awjd7x26PY3fzMb7HZ943dMZzehUUeKUetLZ3zBcrLmtgAUvO
	 Z5nklcc2zoy0C7uh2GTianOsGB38jtLtc1yRDMvOPdV1oQWBnpengNKhUXilYD6h3R
	 MnH38NFWx5CzfWY0CjWVaz/WVHrRpKJngXp9v65w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDDFr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 01:47:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfDDFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 01:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0edM/x1veO9YkGG0MTWeLyypWU0/EBKr6udjJleruQU=; b=EaAqlwFfJK0yXvxhfmMR1AUDS
        ZVufeTCC5/Ew2X2SA88dQ6m8nWT4xeaXXzL8kEd9h+WrQ1NprowUijHfaQaN+2PZFjvS2LY0y7r/p
        IBJvG+d2DMJtrLQqW3Zg8yjlZ3Vp8aJRVYsk8CmxNUNLUN8skedeveFduK05oGqpzROeM=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBvDQ-0004CU-Jq; Thu, 04 Apr 2019 05:47:09 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0472B441D3C; Thu,  4 Apr 2019 12:47:04 +0700 (+07)
Date:   Thu, 4 Apr 2019 12:47:04 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, apatard@mandriva.com
Subject: Re: [PATCH 5/7] ASoC: cs42l51: change mic bias DAPM
Message-ID: <20190404054704.GN5748@sirena.org.uk>
References: <1554297817-14154-1-git-send-email-olivier.moysan@st.com>
 <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wwtQuX191/I956S7"
Content-Disposition: inline
In-Reply-To: <1554297817-14154-6-git-send-email-olivier.moysan@st.com>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wwtQuX191/I956S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 03:23:35PM +0200, Olivier Moysan wrote:
> Use SND_SOC_DAPM_SUPPLY for mic bias DAPM
> instead of deprecated SND_SOC_DAPM_MICBIAS.

There are existing users in mainline, have they all been updated to be
compatible with this, or verified that they don't need updates?

--wwtQuX191/I956S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylmlgACgkQJNaLcl1U
h9BOnAf+PPQFLLTsRJ7K59cQlzHC/KzeoMMsp5NZ8ya8aE9dR0f0Qsmdd9C2TBbv
7DQectXbqeSTHvK+lKeRDOaqLseOulblX5eioaayMSXrXgaQbSISOEp/jkonZI9Y
pc5qLhabKNKYGcYBFRwIUyTI/S/vBmbvQdbl9cTHiUmbTWpDmQi7rDzsB+XcM1RS
mYU7U1klquugB3orcCCoKe19wnOA75kfwKZVPFPv0QhUUJFU1qk35C/wjYKF6z8b
xXT+4cYj2YtSZ7O7Uoh5h0p+qSTSMfFToG2ry6qJ2UTKIg8Lp2TgU4epGz22uA0v
zwBJPJ0xTEqrG/a55i1+QI7I71w+MQ==
=GYiY
-----END PGP SIGNATURE-----

--wwtQuX191/I956S7--
