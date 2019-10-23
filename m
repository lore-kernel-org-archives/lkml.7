Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65388CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 392B521872
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571848646;
	bh=u1nK+otPEe3G560oBE1oCtldypj4KPY82cjK27fxBuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T+CIVKa7vlqYXaj/YZh/+rHX+o2EmyqJPsRjHOh+AITrZmIAoXWIaeyUasVAlNAbi
	 pszLetyFmmtNn9tD6ytlp+6i91If/aEw8r/oMBpmoSaMKg/CPtOhkzg1EA3Ys0LUTT
	 qmGjebhXQKLYC2iujbaxEapmhNLFL3Fezy0VQZpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392522AbfJWQhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:37:25 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:51844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbfJWQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=u1nK+otPEe3G560oBE1oCtldypj4KPY82cjK27fxBuc=; b=GHTHs7e4tnbeVA9/04kQM9TeH
        +1rDG/ty8SraGi0CQrltsOx1j+aTrlLmvaUOcQz/laCC/deD5K/8zx7LAnrIiR6DsjWippUraR2Bw
        NYuxzeOyxcZ0yPGOCXZ9lJRIAuv2s6dLOvOzM/oIwDmREOMc4t5EjPoABt/DeCpklqfwE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iNJdN-0000wn-HX; Wed, 23 Oct 2019 16:37:17 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 0CBD32743021; Wed, 23 Oct 2019 17:37:17 +0100 (BST)
Date:   Wed, 23 Oct 2019 17:37:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 1/2] Revert "ASoC: hdmi-codec: re-introduce mutex locking"
Message-ID: <20191023163716.GI5723@sirena.co.uk>
References: <20191023161203.28955-1-jbrunet@baylibre.com>
 <20191023161203.28955-2-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <20191023161203.28955-2-jbrunet@baylibre.com>
X-Cookie: MMM-MM!!  So THIS is BIO-NEBULATION!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2019 at 06:12:02PM +0200, Jerome Brunet wrote:
> This reverts commit eb1ecadb7f67dde94ef0efd3ddaed5cb6c9a65ed.
>=20
> This fixes the following warning reported by lockdep and a potential
> issue with hibernation

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2wgbwACgkQJNaLcl1U
h9Dh8Af/US8PJypFTsEoI+hUXoaIwo9Pkf8kQ/nRECBygZ9Du+Xgizqb2Q+bRKy8
vVDRT2Qqgp7vN/oFjVr84iCHECVcAfFVFPJZ+n8NuFf9XYDS7zcmmPejSFczhmMq
Z4rmmAd2250VHzXCnjGLpyw7zloVUGiYaxZICMLlnGGbfPxzED55Iuzj4+Q7G7/h
QjPgzkCmo2hNuM2QHVKqsgWHXbH+uChPAF5K3KYs0CwTUpf8U+McKRrU4NWxX5Im
KTfjd62qXybkErrXt5vchfsynx0eBUmcbz9jDAG09jGTPW1lLTm/4v+/vPiCzA4X
f2fsV5jif9Ad5oHC+2rs+VoUVnC7Aw==
=6sCE
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
