Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B40CCA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 281DE21783
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762273;
	bh=yEWjUh9HRZLx9XZTRlNwU0IyHfWYaOjUVBl6LKXoSGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DXL9Zln6Z1WhneR+Opc+tKwtoMjfS72874M/6tMkH4/B7rnPG+Ju2cFa39sT6VS42
	 NJSlktlIJ9IMYJzxuzRL2aM8GPGps77r6QRtoec+xH+O1c7mtdRFDvVkxRe+vn3WM8
	 Slf5wHp1lSWLQ/SmdDMJaVkGbPczgjGFpSSrK7nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfJVQhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:37:52 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32962 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfJVQhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:37:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yEWjUh9HRZLx9XZTRlNwU0IyHfWYaOjUVBl6LKXoSGg=; b=eujbdbr8i14aLx7d16qzSg84a
        Fy/kXsYQnk8/XUTrW2u/qw/hMLvFjm4w0Q7lg5KpxbaI0CCxIsw/f0PdaQNCOdA7TGUyxoYsIrW1R
        JoNZO8dYJgUf5Adtu5cTcRIOQ7VA6XlRBx1INaHuA17pBD98PhJGENc8UqV4BbNuFsTDo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxAK-00073S-Fl; Tue, 22 Oct 2019 16:37:48 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id ED5112743259; Tue, 22 Oct 2019 17:37:47 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:37:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 19/46] ARM: pxa: hx4700: use gpio descriptors for audio
Message-ID: <20191022163747.GQ5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-19-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lG9v85r552aFjg4G"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-19-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lG9v85r552aFjg4G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:34PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--lG9v85r552aFjg4G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMFsACgkQJNaLcl1U
h9AyrAf+PEou8xICUpA4tJXD4/V65hYlHwHijqpdDNIb8z17mM77HkKGZt59II8h
yPCGMI+KNeqAj3bhR7kC6pGAdJ0O2EPBV27wvfg7qdsZ4tTLkKDKRpU+Ub3BawaV
Y+hcM8ovqmbJV9E/1jiwUl29KVvbCbMSjupVbL8YpxA5uK4hLUfPi2W0fuC92wxB
riKv3rnc0+qfsjc2nZBAQ+A16BA6pQZYOi62Nk8aTosPva2zP6kIPXjwnRmKahZw
gfsjwsHCKgOA4qu1FQSNkw/p/D1SFXSl5Y9CVT4SZoJhJSBQ7sE7UsxiV/+2cd8g
dq6oYdPGaAueZLaZTJz0Xru8jPwafQ==
=hKIE
-----END PGP SIGNATURE-----

--lG9v85r552aFjg4G--
