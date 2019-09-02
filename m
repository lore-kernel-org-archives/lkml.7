Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DF7C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6FAA217D7
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 12:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567425780;
	bh=JrpVNUHzyLxt9hof9snwPpUV4HyTX0cAhfkhm1bpzUk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mMWQAeHj5YehQc/MD3t2N1HuWnyaCED30PXmSXjNQsFT+JDm5u2pLa5/r47uOzwIV
	 bmGmM4rKdxguP9Okf/7dEAAMqRcFw53fJbeBsUlgBPtNxwgABOoXkpL7Fs3RrHFZfd
	 Pi16bBVnqgb3dMJjDnDZrVsyWyBbGLBuw/kf6mdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731193AbfIBMC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 08:02:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730314AbfIBMC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RHTgkM0dM8xda/qXMLAftdtWVTMspSpd+zBxKdxmYLg=; b=q2WL50s09cQ8HSMxrwkyp2lQE
        KEWJsv8fwGb6HNa2DyeWECv+x39Wlm1WjFANRf2dfFkQxsSMQ+WXGSmtqywvNn49tNV+wqNX0L6DE
        +NRIZFLBN9Spw5oVoLWH4G5G4UABZdNu79sH/XvNtxpTmeb4+Mz+3iDlNReEpC6ou5FXw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i4l2o-00039e-0O; Mon, 02 Sep 2019 12:02:50 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 1714E2742CCB; Mon,  2 Sep 2019 13:02:49 +0100 (BST)
Date:   Mon, 2 Sep 2019 13:02:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ASoC: es8316: judge PCM rate at later timing
Message-ID: <20190902120248.GA5819@sirena.co.uk>
References: <20190831162650.19822-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20190831162650.19822-1-katsuhiro@katsuster.net>
X-Cookie: Lost ticket pays maximum rate.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 01, 2019 at 01:26:48AM +0900, Katsuhiro Suzuki wrote:
> This patch change the judge timing about playing/capturing PCM rate.
>=20
> Original code set constraints list of PCM rate limits at set_sysclk.
> This strategy works well if system is using fixed rate clock.
>=20
> But some boards and SoC (such as RockPro64 and RockChip I2S) has
> connected SoC MCLK out to ES8316 MCLK in. In this case, SoC side I2S
> will choose suitable frequency of MCLK such as fs * mclk-fs when
> user starts playing or capturing.

The best way to handle this is to try to support both fixed and variable
clock rates, some other drivers do this by setting constraints based on
MCLK only if the MCLK has been set to a non-zero value.  They have the
machine drivers reset the clock rate to 0 when it goes idle so that no
constraints are applied then.  This means that if the machine has a
fixed clock there will be constraints, and that constraints get applied
if one direction has started and fixed the clock, but still allows the
clock to be varied where possible.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1tBOgACgkQJNaLcl1U
h9Cqsgf/QH87sADyO5H2sSFpF1Q+z94gj4FdObMAowT+MfdNXULU7KlUsVfMcZ1i
uqbIgpKzNezmZ0HSIckM81LJhPki96kWttW1LV4C/0XSse0qRvmlodK8eCg5P8ah
DUUrvBEd65MRMpTNKdF/QZ8QSG8CSHgDntHA1iej9N6k04LeGLVEB9N25h0Kv02R
+z+mHUCQvxmh5+ql8hg2a9XvKEyOW/fslKAV57xgEHbP8ElCdwkBqVvVn1LkyldJ
b+cwBXQ/4HbjHQMJB7effDFbSpRJ8GrHO/SBT78pt05pu2+8gVqy+TV7CrM2bw7m
Qhv3yQbq2xzikv0Vjj3WX+Gtnsjm7g==
=AnX7
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
