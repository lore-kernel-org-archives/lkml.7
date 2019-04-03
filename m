Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B84EAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FDD520830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554262359;
	bh=rEjQ9L/7fpfsO4wFoyXbSNmriisEXNYcLi4MSrs9s0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U+a+zMtXA+i449uvwXEKtIx5VuxoXjqV0bMUQpXWwm8V6MdOuQJSskaO/CTM/LaOp
	 t8pah5Fvkli7RiPk00E45b0zYxl/4dNOk65zX7R1yD7zwdob/PJ4o0cOUCtcT0Ro8D
	 JeThf1eC3xCwds18chG2MfkoPUe3IyNqXaWx1i94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfDCDci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:32:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:36132 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfDCDch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lRsdsi75KJ1aJG3kl3MA0mdKJCqKBlk6tqPPgiI6BOw=; b=SZsovRx579TDgxAcr8D2Ltb4X
        BFYJWhDYVf/DdUbQtookNeXrzIev7IoV8ziB8YjXcrkdNQQOro0DuGOKLGt3FUPYPJJfaxLYJalua
        PvBsareLLZ35WjOwl5bD+G5IVu70ID5iU9YLSeYvJTj8uPQu/nVCW5qw4ynMcoNGQ3OJY=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBWde-0003Yu-UJ; Wed, 03 Apr 2019 03:32:35 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 0C29D440082; Wed,  3 Apr 2019 04:32:28 +0100 (BST)
Date:   Wed, 3 Apr 2019 10:32:27 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] drivers: base: regmap: add proper SPDX identifiers
 on files that did not have them.
Message-ID: <20190403033227.GG2059@sirena.org.uk>
References: <20190402133203.5463-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gAUgrzRZ7tRi/Yr6"
Content-Disposition: inline
In-Reply-To: <20190402133203.5463-1-gregkh@linuxfoundation.org>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gAUgrzRZ7tRi/Yr6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 03:32:00PM +0200, Greg Kroah-Hartman wrote:

> --- a/drivers/base/regmap/regcache-flat.c
> +++ b/drivers/base/regmap/regcache-flat.c
> @@ -1,13 +1,10 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*

Please make the whole header a C++ header so that things look more
consistent and intentional.

--gAUgrzRZ7tRi/Yr6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykKUkACgkQJNaLcl1U
h9DGnAf/Rkpqgpx8ZNrtZBTvBbLxGcIT1AGHNeQP+0gAHDDmdrzrxrCS0f2Ks6LU
133iodlYB+muLn2Utd56EINaDK8j8f92T9/D22tZ/giMkusjzzfwF4cfNUzl3DEL
dBM+zAtPuuqfev0fzAgPcyrj0vJziqvU1tmexvORCsrxBrGmUINUHwX8Lytfwag2
l2ZYaj3Ao/Jli7pXSq+4NVi87FX5ncDvyl7U2fVptqccnImSo0Q2iytHSyQZs+1a
1NJksQIKCKJF3TlQTiHokwmpRaQxC5hnUaSZLyLyvhbUd66HYkKFppukvXTRk6HH
0CVxulhyHNg6s15Mh88m/XyqmRRH+w==
=V+PI
-----END PGP SIGNATURE-----

--gAUgrzRZ7tRi/Yr6--
