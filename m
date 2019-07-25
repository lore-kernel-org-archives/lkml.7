Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DFBC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A8E21951
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564059623;
	bh=g4RGUwZmu18nz57PaiTCIDlcJO5x7TAwfRHhxeooAXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=N7plhoL9uPZjRWfL12bvSCki6POFqwStX8L7JeKCHpolP7EvLmOaAJuANPgc06C88
	 ogKpKLY2dv/E8yfglVtvtkHY8cDtnhqyCwHVL00UIZNsQqu3LQtya4lhFYImnBAzyI
	 ehUuL57c1GKHMPy5wfhjim/3d+33heH+WIspBx7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbfGYNAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:00:22 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40332 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfGYNAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cwFiHQ+8lVnRhkC8EwJXQy9RvFDx6GKVTnbtr172hKw=; b=ntrHtbgTrK5RrFAcAKNPtbEk3
        hmGXUqTzSj2WgIAxbRXdUcV+DuGJBu9t7rYLai2X11kbG5uggytpi7YflTWu8UsY3LqosdntXd3Wu
        1u8GqHV3tp6ykZ/SPq7OJ41vTJZnTEClmjCK8dyUsirsOJOYox59O+WG+UEWLn9xVTTzs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hqdM1-0002p8-II; Thu, 25 Jul 2019 13:00:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 06E062742B52; Thu, 25 Jul 2019 14:00:16 +0100 (BST)
Date:   Thu, 25 Jul 2019 14:00:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 1/6] ASoC: codec2codec: run callbacks in order
Message-ID: <20190725130016.GC4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com>
 <20190724162405.6574-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20190724162405.6574-2-jbrunet@baylibre.com>
X-Cookie: Jenkinson's Law:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2019 at 06:24:00PM +0200, Jerome Brunet wrote:
> When handling dai_link events on codec to codec links, run all .startup()
> callbacks on sinks and sources before running any .hw_params(). Same goes
> for hw_free() and shutdown(). This is closer to the behavior of regular
> dai links

This looks good but needs rebasing against -next due to Morimoto-san's
recent DAI changes:

  CC      sound/soc/soc-dapm.o
sound/soc/soc-dapm.c: In function =E2=80=98snd_soc_dai_link_event=E2=80=99:
sound/soc/soc-dapm.c:3857:10: error: implicit declaration of function =E2=
=80=98soc_dai_hw_params=E2=80=99; did you mean =E2=80=98snd_soc_dai_hw_para=
ms=E2=80=99? [-Werror=3Dimplicit-function-declaration]
    ret =3D soc_dai_hw_params(&substream, params, source);
          ^~~~~~~~~~~~~~~~~
          snd_soc_dai_hw_params

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl05p+AACgkQJNaLcl1U
h9AP+gf+KYWXJgB5nW6jPKjIT4VghTppSU3QuuCdZrhY/sNBJSzzMz6wo1IPyz97
fyMJDcDemoa6wbn2EdzxffFQKt7DlKNs8fNe1TSu6SaQaITcI5iGYaeeQ0U+t1ps
bydYObp41RlNN66PWCqoObTjwrtmbT4KjZt6VVD/rpUA+TYVaT4lAlC43lYdGOwS
s1U3cqK0UhnJ2tl7ijvp1GbohlH7hG+STTgSwMVHjnqTvDAnLJrQ7aXO4U39m4mc
GKQ2VtknUOXH4SmQ/HCyLdKOHXSv2fWdEMSeD65MBUxRnfW9ivMoQabStIA39rk9
m1xUbylnxDjw8hciPEbmbsQapqiavg==
=HgG8
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
