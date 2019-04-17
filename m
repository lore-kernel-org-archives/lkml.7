Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A0AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47BEB20663
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555518999;
	bh=bW6xSBvDB/mBGgIPoG8GbmafCV4/BBW01qP4pUZg0uA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e5U1RYFFOyiAPtpxgaer92XpNFVlc8aYV+txHfrULhn1G1/Q5eInmDE998xValvTU
	 p8oBvy760NtwrLbZ28aQMx1EyAshyyHF2QW9K09rqu65hnWeqDXNA8hY2dwLcgEP6h
	 2EZWcJWigIfAX2pUlfy/X0mFJ2GQhqwsIzO7Rmzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbfDQQgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:36:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55634 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731472AbfDQQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:36:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bW6xSBvDB/mBGgIPoG8GbmafCV4/BBW01qP4pUZg0uA=; b=b23qw49RF4mdV1JEYxeEUH0Av
        3lkHNIvyj+Is77edUqO/CfolTJ+XvscvicqL5UpmbRSr0jLkyyBPQ+qaFPYC9RZsrCFO9nu6z/9ur
        YZ2zU9oooXJvpouSIwyiEeEg/c2APZF79+Za7Mw3BRp7ZmBKAKpqJcbjrtblijBwTOCUs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGnY0-000128-UK; Wed, 17 Apr 2019 16:36:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2CAD01128FC7; Wed, 17 Apr 2019 17:36:32 +0100 (BST)
Date:   Wed, 17 Apr 2019 17:36:32 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: stm32-pwr: Fix error checking for of_iomap
Message-ID: <20190417163632.GA23145@sirena.org.uk>
References: <20190417084335.15483-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
In-Reply-To: <20190417084335.15483-1-axel.lin@ingics.com>
X-Cookie: Colorless green ideas sleep furiously.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 04:43:35PM +0800, Axel Lin wrote:
> of_iomap returns NULL on error.

Someone already sent a patch for this.

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3Vg8ACgkQJNaLcl1U
h9BLtAf8DMa6gODEtdtmKMaYolmFVhVyPZBvFlA3c1pDCRQvw4RNd+og/2ev4fl1
kNTkMQMc+2WTabyzOHX9mVfciqhMQV0HF5AWGqmuBuABfw3iUIiF0D1poyqUXVoo
udsbIEJJQWKwvmBYW35EID9ZOEM0z6G8YN+iQ7fQINOuWqQeLf26w6VZnZTDZR4n
LxWGBruh6ACFCDH84yTdhYxZnjAeiuMlvXaFik/eJgsDyM2qws6PkmTDkX9fonDU
DOgSsezDoi44CKOs69Qtvcv5Hsx6wGBPtDgCC6bo1IH+WLWDtTVdY1eq0SHlb+LI
GOceKLE54/t3Uw30xjIbm/bQfNnivw==
=rXXn
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
