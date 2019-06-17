Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E7C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA2208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560784421;
	bh=NhHHk1mLM+RLKPSl3YcG+kDxY5HrCsZSU06OQOpeXI4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fMKzPKI4YJmgojExk4st311F/Qf/cKctKfOgeyYfuj+ssoY/zQPLjRH+zGNsk6vIW
	 3aM0qUfYVvrzjHu9kXvXBQnVYHcoyP8bUiKcZJks8toimH6xUwLRaTjLEOdlGrhRJy
	 AQR4pKdeOrTTi4FtIW0Ku8WQ+TVCMiZfDpzQnnmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfFQPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:13:40 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33136 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728170AbfFQPNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZhD88dZhIwAEFMHCQHv+WMw+ImhJWgcbe2rvZ4ePTmI=; b=D9Zlq71E+PS5ixfuK6IQ2ycb8
        qh6kZtw2+dp3SKUPqRbx7aNNre1mQPZlD3d21tS46XVKuNFHVcIFY1wOw2OAKfJLS4OO1e761Xnly
        cCsFzECWSjNt3/90AD313x3Mhv+3pvL8/b4wGQxkp2906MgiwA/2/FoKyyIsu/8FruToc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hctKC-0001vG-0m; Mon, 17 Jun 2019 15:13:36 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 8E4BB440046; Mon, 17 Jun 2019 16:13:35 +0100 (BST)
Date:   Mon, 17 Jun 2019 16:13:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: Add missing newline at end of file
Message-ID: <20190617151335.GW5316@sirena.org.uk>
References: <20190617144048.5450-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jr/gb2Ce1GM9KKZD"
Content-Disposition: inline
In-Reply-To: <20190617144048.5450-1-geert+renesas@glider.be>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jr/gb2Ce1GM9KKZD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 04:40:48PM +0200, Geert Uytterhoeven wrote:

>  sound/usb/bcd2000/Makefile         | 2 +-

This isn't ASoC but I'm just going to go ahead and apply it on the basis
that it's trivial and more trouble than it's worth to split or anything
like that.

--jr/gb2Ce1GM9KKZD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0Hrh4ACgkQJNaLcl1U
h9BlLAf/XkqJNB8j8P2Zh31fJzq0kGKURYcvPZFZnRkSysg+6PhbGDmOa2Yr5cQa
MOumNRRlLtWxS4fi11CwnRS+XKO2b2hB2N0HpEKnm0JYcHt2TZzcLGhmf8wS00cQ
AaKaOoPKf8wBq1jYc+8HWXe9NwakA5zYqfvhld1VZ1MbMi9da1KePzIb8JMapGMI
PC+Xr2ZVgMkgWRrPVuHcy+719VBcJr7pvR6mKxTu4niPl5AFE773e2C9wTKW6PGZ
Ht8YDB8p/MwbLDHVLE6hnKUwCLyaRUvagHhMNwNRl9kfbhKGQ5wLqzcfnIb6WKTC
UvrcNo1YNmcLlssETzEuTPpGVkKv3A==
=CRUr
-----END PGP SIGNATURE-----

--jr/gb2Ce1GM9KKZD--
