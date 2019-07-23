Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364BCC7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABB42184E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563881212;
	bh=yOXMGjU8R02usJeRrCSEH5GjIu9VADCOGFNXyp1tq8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CG84NaO2wDNkHwl0xA3S+yZl+HfeQxD/HeR9TgfKpsKUxtXpF5mEsE7tWVCb7Q8Hv
	 652GWkXqjD7ByJaTVPM53kQ5TlK4xfauYrSMk+aS5NJlauRceggcDWwUQ5lktw3qv5
	 jSPzfwf8eiJwYJVjjI7CFRfOrNr64pjL4iGNJtso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389336AbfGWL0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:26:51 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41818 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbfGWL0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yOXMGjU8R02usJeRrCSEH5GjIu9VADCOGFNXyp1tq8E=; b=FJh9DDi+t8cfKRwBBt3F3veQO
        bPPJACg8GMFBkLuUjsxxYvhFtASh+vhPSJ+dLHEMgIas8jc/ad/L3XvAJvK+ju03XgzVxKwYSodye
        HWicgGW2YytmjFnwKYjp2NCxpxwYiQjvCXWLYvd5CIcAaK2eCjjHxKMKzmU2bjlQEftSw=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hpswT-0003IB-2m; Tue, 23 Jul 2019 11:26:49 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id E12ED2742B59; Tue, 23 Jul 2019 12:26:47 +0100 (BST)
Date:   Tue, 23 Jul 2019 12:26:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Keerthy <j-keerthy@ti.com>, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFT] regulator: lp87565: Fix probe failure for
 "ti,lp87565"
Message-ID: <20190723112647.GE5365@sirena.org.uk>
References: <20190711113517.26077-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
Content-Disposition: inline
In-Reply-To: <20190711113517.26077-1-axel.lin@ingics.com>
X-Cookie: Avoid contact with eyes.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 11, 2019 at 07:35:17PM +0800, Axel Lin wrote:
> The "ti,lp87565" compatible string is still in of_lp87565_match_table,
> but current code will return -EINVAL because lp87565->dev_type is unknown.
> This was working in earlier kernel versions, so fix it.

This doesn't seem to apply against current code, please check and
resend.

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl027vcACgkQJNaLcl1U
h9BF/Af/biVlvgCp+T640qvVuGZuazoEbeDtbfysHcXmFp3yNNVpvbfcEjtP1yHu
aVHQ6O8mpwkZ9wh+thr0MLJXuOpuvC8Z9KXGN2lvf+upLZkdhNLteiXHoywOK33X
Qge7PRNd/Ov3b981W4jQb7a8OvntZR5G81LAauK9vvbDPbCxOSthbCUPZZ/Ltlgs
WpLwkkbgx//bGxpfrSqsW7hPXp93e8s3jsdUNkzadRYcDtnbcAM2iyR8pUzFWmku
S9TIoOHgimd5o8V3xCxc/wRwxL1YVBr6eMHsb9pHkwenDyS/ykCdJFUzsf0RcCVF
H1tyUBzfSw4d6XD36sfv3t07oqOXoQ==
=ilLO
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
