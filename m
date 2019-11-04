Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0317CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A321A21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 12:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572871491;
	bh=oZNDN41JbDQoGUIdu2NFut0arDvRMNXgBKl9waADRqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ToMQ6YfH27TEvi07ee0fRUP0RDFypSEKWOJTn87FqZnZ4TkzLX9YLHXXX3StKARCn
	 2HTWrYs31tAzSeG1Pc5f++ReZNHyJMB79QE3iNOdnf1gv6/f9f0MEVarwdlpOjsOYV
	 /cE9nvU+3BgRx/uqweaZ0+D+YWA1cAuv5JHAydiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729068AbfKDMou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 07:44:50 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42566 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727891AbfKDMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 07:44:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GCF2W9GoIMji6P38lZAtJnQ1QMJqaRDISSiKFCZJSos=; b=aHYYCN5FMrrDV3IW2Wm1dOk7Y
        qHXnr8PE3zYbFMQzzk57EgX0MVsQyY+5rdu8OnJvm308QAMb/jTTmkq0hrGqaFscVpC1EchB3As00
        TcbaP+kotvQewwUk0lrV7gUeBU4hz8j8lYglMoMP2qzmWNg7PqbH8aV8fe7bFKLvZqU7Q=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iRbiv-0002YG-OD; Mon, 04 Nov 2019 12:44:45 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id AB2D3274301E; Mon,  4 Nov 2019 12:44:44 +0000 (GMT)
Date:   Mon, 4 Nov 2019 12:44:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: spi-mem and gpio chipselects
Message-ID: <20191104124444.GB5238@sirena.co.uk>
References: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline
In-Reply-To: <cbe69f5457c4dd1c2cc96a247c6c6fca61c0d43c.camel@alliedtelesis.co.nz>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 04, 2019 at 12:35:24AM +0000, Chris Packham wrote:

> I'm working on a platform that has a slightly complicated scheme for
> SPI chip-selects using gpios[1]. The spi controller driver in this case
> supports the spi-mem operations which appear to bypass the generic
> spi_set_cs().

> Would there be any harm in adding calls to spi_set_cs() to spi-mem.c?
> Naively spi_mem_access_start() and spi_mem_access_end() seem like
> convenient places to start.

That's only going to work in cases where the controller translates
things into a single SPI operation on the flash which I'm not sure is
always going to be the case.  We'd need a way to guarantee that the
controller is going to do that in order to avoid data corruption issues.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3AHTsACgkQJNaLcl1U
h9CKcgf/a3Rsv/nEWYK652244fSFdDjB0Ae/GjNHxD+cHFj3PApNAkCG1mA1XAux
nu2t/yNhOlkeXysq1o7zHbsttZpVI9MPh9seGhrvyk1vMVnRv3DghWjgVNAZKv1h
pmWU3zN6MAU0K05C46j5B6QgF4euavsIS61ynsokTvdOdGfRLZQe2eBuRokPut5B
2scTuUx7HB6ybEWU+vjeXN53v3UYDfCoKYI0A3XiX9F4n3m7WTW+5xPu2etP8a1C
C0OFvD/mkVWCoQDeFWCIOTQ7thQc9HiAK2xgtTPeSggqQi7cj/bb14bE0FtGnCrM
5m6A7jwYbpby8OEZPG9MJphRUVclhw==
=E4bF
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--
