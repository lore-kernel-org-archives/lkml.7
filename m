Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FCAC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EAA208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 15:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567611028;
	bh=sAFg6CdO9IgQr2JfCCgKK6YJrHe6h3VwnAnrJdPrq0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1E0b4vBLh7YH78unBXScVt3Pw5Q7IEMevNa1f8XqOL8W/iNtgK1LkGf2cHi5I2r8c
	 0O0InAga5QBzwyJsBaM+vCaz0U+ZIh2VIjMUNhbKENnmUf81cc3R67djv4JXVyZWcT
	 LjMscyZWYQTrya5ukFT7+kGp8GXh0x+7Hc1wM3e4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfIDPa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 11:30:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34716 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfIDPa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 11:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=c7U5Te26OOkpWZh++wRipeOwfTU9MW2rO16f03qANlE=; b=TtnIL2Lvf76PRgjjGcjO5m6CT
        f9WndgysisoyfcXDGr8r7su7K21pY4RLBjQ2+AdhVLc0xJvh/Qo9olW1hKGj5gx5NPvEYQBPdcYUL
        6/PFPA+2dCs9UR5RTMY5S4XsBi5V+gygEqJmxvsKerAKIB0llRn11ACJgLET5EFHJctAQ=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i5XEf-0006KI-Me; Wed, 04 Sep 2019 15:30:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id D94FC2742B45; Wed,  4 Sep 2019 16:30:16 +0100 (BST)
Date:   Wed, 4 Sep 2019 16:30:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     David Yang <yangxiaohua@everest-semi.com>,
        Daniel Drake <drake@endlessm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ASoC: es8316: judge PCM rate at later timing
Message-ID: <20190904153016.GD4348@sirena.co.uk>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
 <20190903174801.GD7916@sirena.co.uk>
 <85c717bf-d875-016c-a303-867bdca9a645@katsuster.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <85c717bf-d875-016c-a303-867bdca9a645@katsuster.net>
X-Cookie: Help fight continental drift.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 12:06:23AM +0900, Katsuhiro Suzuki wrote:

> Would you tell me one more thing. I don't understand who sets MCLK to 0.
> Is it needed original machine driver instead of audio-graph-card?

> On my test environment (audio-graph-card + Rockchip I2S + ES8316), it
> seems audio-graph-card has never called set_sysclk() with freq = 0 after
> stop play/capture sound. So my env will go to bad scenario as I described in
> this patch.

You shouldn't need a custom machine driver - you'll just be the first
person who ran into this with audio-graph-card.  I'd just add this
support to the audio-graph-card, either with custom startup and shutdown
callbacks or using a set_bias_level() callback (both get used, I'd guess
the set_bias_level() is easier since you don't need to reference count
anything).

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1v2IgACgkQJNaLcl1U
h9CzYQgAgkCVkBPAUDivm6m1Ys+xPGbqYO85zw38TRTqnQ8UMpCzpJd0DV1P8jAb
xx3AaPskCUVjVjY8Nf9ejibjh3Bv0EF75kTr+qcuSCSm1gHjzNOsYym05tMtVOEJ
wO6Kf95ga1nFkJdUzMlnPYY7Ifsybx29HfT0qdaWny4G6c1JnciMRAqRQx457ZAU
a2beSvFPAoNAxB2l2N/mUxWM5OkhnYQ+hoy02agR9LoMsYGO3YxVfBRictMw1e8W
fw3Hq9jULyMR4rY0tIObdsog2kHlwsCQrFzbQ1e4j25r1UntY9whHlctZKJX0onX
jxre3OCp7c1jZLxxjsU9vsacKvYRxQ==
=YJma
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
