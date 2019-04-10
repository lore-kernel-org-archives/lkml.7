Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C70C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B169D20830
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554892381;
	bh=K4t71tLJLyRcL7o82ZN01DgvT16e09CWkDCXMdTt0aY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d576Av5Sb2/+2zpVWTSji4+Bop699PJpx8pZZBNP+rs7MOSiKYDh76nsMePcGlmlM
	 y6q0+faYqZojzubs/o2lciU6m2oybzkXmgTH9HwvqXUJAmOW45VjEjYynaBTVsRLBK
	 RAtmUetCbA2eipyTec36TNtVOHWEVLHYoe3QF34w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbfDJKdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:33:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41366 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730501AbfDJKc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=B/42ywBOMia/5dF1Eah4Yt1UCjadZ+fAPqVG+f0hgEQ=; b=qk135HMFCQ50N4luTnzNeIOB7
        db0UM+uZUTtye1DofUWjdHVxLk+65U0NxG75jt4utmTc+MvSqmsKrGlbgokX9c4wNvPU3xqyPYwZl
        A/AEE7IAz0VRAATU6AtwGgaXEEvELJZjiHV/xr9JaM6Y7DRGEbU1Ae6vJGD2AszzqRQx4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEAXD-0007l1-6z; Wed, 10 Apr 2019 10:32:51 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 312411128ED3; Wed, 10 Apr 2019 11:32:50 +0100 (BST)
Date:   Wed, 10 Apr 2019 11:32:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Message-ID: <20190410103250.GF6106@sirena.org.uk>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FeAIMMcddNRN4P4/"
Content-Disposition: inline
In-Reply-To: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FeAIMMcddNRN4P4/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2019 at 05:22:44PM +0200, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of the transfer mode used (DMA or GPIO).
>=20
> This info is useful to individuate the timing when
> the module starts.

Adding this sort of message to every driver is going to make boot far
too noisy, it's one thing if we actually enumerate information about the
physical device but this isn't really that.  There are already prints in
the driver core for when things get probed which can be enabled if
ordering issues need to be debugged.

--FeAIMMcddNRN4P4/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytxlEACgkQJNaLcl1U
h9AZ7Af+OiGmnQX7HRlnqJrTrMzmIi+/NnGXg5Wo0T0IE1uEoQ1jTgHEgpBZX8A3
jandhhRDVzZiXSgnnLavco55WLdNuU9aoaX/vZrOuWyUv7SRgiZQ1NSM7HtMM7pE
3b0acqhQwGdThQ6RICWb7fkna6u6ylLTr6CUKQ7FHuu/pcUwA2FIaZBDSHYFQeBO
o5sHOgp07QOaQG09TSM9G/7YzTuKbUjAq4d7+iytKxxtgu5ZlLppMqGAYt9PZD0r
8fRKtGdWaxpdf/ww3P1Nj8d84hnicLoawTlGRFJsi6fX2y7u6M6tcS8gyx0TIweP
U+MoafBik8icmF32XQwsRNlE7yZC4g==
=xpxE
-----END PGP SIGNATURE-----

--FeAIMMcddNRN4P4/--
