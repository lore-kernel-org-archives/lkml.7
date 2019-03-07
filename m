Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A6EC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFFB20684
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551957805;
	bh=vOdi4/CBsio+8xIKEThXZ3Iu5znTrm8uDn1Lh8Jjf3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rU5rLrpsLmrW4g9K9+mB+LkooLYvZfdOcUnvC2aD56kswY4NcrtPRKXFb/wELyhrJ
	 iDZjmiHku4XmLOWQQXn9tu19GV0dgR9ccIvWS87SecWfu4MhNskr+Bq3IFl4MYnXjM
	 UvIG/c2F+FJ/Bfj3oX9wjN0755BM1ybWAdFUWY+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfCGLXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 06:23:24 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53880 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfCGLXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 06:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OTh72GeCa30m9/TRNI1fkMt+9s6nS8N+/Ws82U7Vw20=; b=PiWUBz9W/lCRjc85/IUWxuoxu
        Fxy/FqfGChP+azbdXZNAbpTVCk5rpAKn81icy4Uo//Q6cKq93A4BwCzSPWiM5Bs/pE6S1GEq2r0Vs
        CzJOPwLtGwlYecmppEhwQulypqDvLUD0alu3uTYtPJSGb36eo5d2ne5qwZhsLmYv7MQdM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1h1r7N-0005RP-LT; Thu, 07 Mar 2019 11:23:17 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id B33721128841; Thu,  7 Mar 2019 11:23:16 +0000 (GMT)
Date:   Thu, 7 Mar 2019 11:23:16 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Message-ID: <20190307112316.GD6529@sirena.org.uk>
References: <20190307105619.2780591-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Content-Disposition: inline
In-Reply-To: <20190307105619.2780591-1-arnd@arndb.de>
X-Cookie: All celebrity voices impersonated.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 11:56:07AM +0100, Arnd Bergmann wrote:

> Link: https://bugs.llvm.org/show_bug.cgi?id=38789

>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BIT_MASK(bits) ((BIT((bits) - 1) << 1) - 1)
> +#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - (BIT((min) - 1) - 1))

Can we have a comment that this is for the clang warning please so
nobody goes in and simplifies the code?

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyA/yMACgkQJNaLcl1U
h9DKhwf/SozTac0wQSMSrUHIwpvylWyr+FBIm0JsAJoURYCL+uTKN/vJJqlIOarw
v7Xl06lpLSYGjxgVs7grdlA+FmiJbcNpJDJV3V1fThKuqHyt5rZ75R4uMvVu7Tea
C+642mKN9GMqEsnB9nz4Po+n6krbez65AW6fKE30Oaa5yMebQ7vz6gf6Z1a22zM2
sJiNXkCu51A6jrb+H/l3gtd/iSTDCfvQvOvX2bE1ihQhJl5C9Y+Sev+wgxGvfTPq
wG+qNBTX43NSpV8LNg6p1pNBDUDxDR5HWYDlAuy8svmiDBo3pcHxXco1iq8rASRk
yxY1mB8uzXI6tehvTKLYM1ZbOTAFeQ==
=n2rH
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
