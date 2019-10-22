Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245BCCA9EB7
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E663F205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571762254;
	bh=XYt01QDASLshwcD8BBPmTNrzoEd6n2RKiXKjRc1xWes=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YRf97z9eTB2XDrcLlnLg7+/S4K48c3V3MS47qqw1iTWbLIfOY0zL1RUaUkrMtpp1s
	 D6cDZFqwmWPJxZ8UaPfE29cUBSVXnHmCtvAa8uQWbJYxkKLwQknjFv+pGMi9lJqet7
	 wW6KIk+WpEVR3aupFzdgyWXqJ3hTChQEyhNXBc6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbfJVQhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 12:37:33 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60674 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731727AbfJVQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 12:37:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XYt01QDASLshwcD8BBPmTNrzoEd6n2RKiXKjRc1xWes=; b=H9dCVn5kIoroBfx4/ITB1seZy
        d4GIPI7LIHFIBX/ucd8uhgvPIR85r3jG0a4vQSWd+kLm8IunlcioGHFqgDNz68Su7N/Z9lLWbQQSH
        MsLukhbB2LFCrLxgIvGoCaAyEW1gGTMDHAa7mv1UAzabfa+OhDZNiH1G68xUFd9RBURFg=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iMxA0-00073H-Go; Tue, 22 Oct 2019 16:37:28 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E9FE32743259; Tue, 22 Oct 2019 17:37:27 +0100 (BST)
Date:   Tue, 22 Oct 2019 17:37:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH 18/46] ARM: pxa: corgi: use gpio descriptors for audio
Message-ID: <20191022163727.GP5554@sirena.co.uk>
References: <20191018154052.1276506-1-arnd@arndb.de>
 <20191018154201.1276638-18-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K8zN2sh9fO5jmbe4"
Content-Disposition: inline
In-Reply-To: <20191018154201.1276638-18-arnd@arndb.de>
X-Cookie: Whip it, whip it good!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K8zN2sh9fO5jmbe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 18, 2019 at 05:41:33PM +0200, Arnd Bergmann wrote:
> The audio driver should not use a hardwired gpio number
> from the header. Change it to use a lookup table.

Acked-by: Mark Brown <broonie@kernel.org>

--K8zN2sh9fO5jmbe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2vMEcACgkQJNaLcl1U
h9BniAf+KxW3zK8aAq/5sBBVj52dQLINMW2dy7ThgwVMqgnrNu7aNXa+NJSIiOe5
WZREVSA3+M+rZ8BYonxgB8EZVVtYTSFR+gyMjAHQe1UsQMgWlkKYHdvB87nh1LNu
jn+zAuwNuQK6XfMfGFEFbQ07eyytgl9VRO5OaRmO6d6U+37vn6CSqz7NJ/SCfMSS
fT2cyd1E83ep6e7qlaKOXC4iRfkzq0q4GhZ6+30RRzUcFViguzVbAW1oz3YvVr2c
4dwRH4yZJmPkGPn9jAOARCd62eFUdpoU55MIyoVYo0gd4NWDOG8VspiKawN/6Rz6
PPyqtPs0cIO8zRSX6y9WQg1dZRS7hg==
=noRN
-----END PGP SIGNATURE-----

--K8zN2sh9fO5jmbe4--
