Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D84C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678CA20833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560785120;
	bh=AmfYV+pjj3qVlHielgPezv8awSw+bol8dvH1mYkefuw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Re3gaApIXbG7uzAvWitZg8mH2TYWqmkJfQl7Sn3047v+PR2y/gkU33k6FavW0jhe
	 VMbC3XyMVTqd7BKlMjMXL5GrJYUIKRHcacbcTJc8cz2UTM+F1twkqkLnDgMh5NB0Cy
	 pvbwBDs1bNIGh/VHpmA+StFlLrMq7bAseKuru6oQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbfFQPZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:25:19 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52926 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfFQPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=NOy4r3sK5TQvgB754Cn8hFMYDa45Xa5S5aXrE6AfDIA=; b=XZyUDCvAuuquskuKRO9LvHdrh
        d4N1PRm34V3AnEPhHk6fhVz0sLsIDvTS58+/Gu4oL4PzJyUzdSpOqdxKrE4oPSQ83I+LWbL8UbvSU
        44sLHhpsObViKjnuaRT5JqSqAHBY/50JFwj8dRVK0ON/tt15steMMGENWhTjQ3rrnbepI=;
Received: from [2001:470:1f1d:6b5:7e7a:91ff:fede:4a45] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctVT-00020M-1W; Mon, 17 Jun 2019 15:25:15 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 87DC8440046; Mon, 17 Jun 2019 16:25:14 +0100 (BST)
Date:   Mon, 17 Jun 2019 16:25:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/8] regulator: core: Parse max-spread value per
 regulator couple
Message-ID: <20190617152514.GY5316@sirena.org.uk>
References: <20190603235904.19097-1-digetx@gmail.com>
 <20190603235904.19097-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="csti59zOqP8qx56L"
Content-Disposition: inline
In-Reply-To: <20190603235904.19097-3-digetx@gmail.com>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--csti59zOqP8qx56L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 04, 2019 at 02:58:58AM +0300, Dmitry Osipenko wrote:

> +#include <linux/regulator/driver.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/suspend.h>
> =20
> @@ -156,7 +157,7 @@ struct regulation_constraints {
>  	int system_load;
> =20
>  	/* used for coupled regulators */
> -	int max_spread;
> +	int max_spread[MAX_COUPLED];

I'd rather move MAX_COUPLED into a separate header than include driver.h
so we've got a bit more compile time sepration.

--csti59zOqP8qx56L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HsNkACgkQJNaLcl1U
h9Ds0wf+Ow2WVLIAd7uSRuPgCkWfL5qPDrkNCdes2qVTogdzf+l0bEi2s7g36y4U
UocF82di0IgOVQjkw4DbBTJNaDaF86PrH4+M3E7uE7egH9TW69S5wSwF13eQDxWx
if3V5TMA7C5pW03WGvh59MRbaeTsthOaL5wnVX5gGV7osuWdUYkz/6RRpG4RASIs
sGP+anp7dO/3VmX1Aq/h38OYLomU+0m0wW959jgdepTVnsaw86/BCesCvwc9M86k
ki0BGR28baq+mLhvDsd17qWLwTgigeMBPmQuCEXNppizyGi3lmuUzuNiU12WtJ/n
+YVh9cmMrcndt259HzuYGB/QABYFTg==
=evmc
-----END PGP SIGNATURE-----

--csti59zOqP8qx56L--
