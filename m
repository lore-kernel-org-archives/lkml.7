Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A699C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FE720674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 03:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554263269;
	bh=koBcHTsZHTF8xWsVjgUtCvxZLEZ2zoTMs6788PnA/GE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=If5vmQkThShuWWaNp1n6TJWxcZcH6IhoXvqeMFMSjJ6tMkrlC2EnXF3HfdXs1dCm8
	 H4eK2PwnNoTZxIe2kC+bZ8NqldDcUnAHvvoLFVr5L/9g7CYaeXryCKys2WwP77B6/V
	 P2UXadyQ7IP6LgB9anz86CrsQUyK5j+/xYIX3qSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfDCDrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 23:47:48 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33364 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCDrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 23:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2+GggMVZRNCeVKNnur4ryt+GTGib0CNmMYbKmlUHpy8=; b=mBibVdnaMU8QH6XvybhhyGCb7
        iESPwUDxwGE51UMnc05+BJIdrtY/mKSKeeZdEdTAn+Pws5RGwNRfX8RqePUssGicUyZESPFb/KBA6
        HX0iTzBd3L/B949GjMniYAtuZirvDGHRAnPHgXzXPPdXkRxsuJ9c0x1Gcu3r1pdt0Csq8=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBWsC-0003jG-5Z; Wed, 03 Apr 2019 03:47:36 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id B1964440082; Wed,  3 Apr 2019 04:47:32 +0100 (BST)
Date:   Wed, 3 Apr 2019 10:47:32 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Curtis Malainey <cujomalainey@google.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core: Fix probe deferral following prelink
 failure
Message-ID: <20190403034732.GA5748@sirena.org.uk>
References: <1551706274-22571-1-git-send-email-jonathanh@nvidia.com>
 <4eb94b41-7e16-7b39-5c14-a7d180ce67df@nvidia.com>
 <20190402043509.GQ2059@sirena.org.uk>
 <2d8a0569-b821-c0c0-af39-d3863d17f47f@nvidia.com>
 <20190402091955.GE2059@sirena.org.uk>
 <10d454a4-e1e1-3a4b-8400-acd680d75a3d@nvidia.com>
 <20190402093159.GF2059@sirena.org.uk>
 <3053ef10-ba36-ee88-4ca0-d1e39c0ea25c@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <3053ef10-ba36-ee88-4ca0-d1e39c0ea25c@nvidia.com>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 10:44:34AM +0100, Jon Hunter wrote:

> Right I see it in -next. Sorry but what I am asking is if you are
> planning to send as a fix for v5.1? Maybe you have not sent out the
> fixes yet for v5.1 and so wanted to check.

It is in my for-5.1 branch so I am intending to send it for v5.1.  Like
many maintainers I have separate branches in my tree and in -next for
things that are intended for the next merge window and things that are
intended to be sent sooner, in my case I have both for-linus and
for-next branches, plus both topic and numberd for-x.y branches which
feed into those.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykLNMACgkQJNaLcl1U
h9BmVAf/ZcwA45Zda/LkY1pBNBCgd87JEXIVkqXKtQGiEnPfpPgVjzZGI2dUGdHy
k2vP6x3i2/4tVQnihVezBNfuGh1wWSPiQD2WDBZURzn0TVpn0ACqD5m0c293f123
nUTXSjC6W2En40vRwC9TJZw5TlDFm6Dz1p+Wrrcj9BU6g/8T0vCo9rjTFT2EBq0D
i1VG7PojtINPWgLE/r2B/rewpPDtaxCMHRoA9/dKbpIcadXhX8aIbHlr95d6KqpN
m2XStNxFVjNjQyF4V+K7oeS/dBeVjVccoP3cj5E8brUicgXfV6IEVgIVciQ/R6lT
0qwd/+GKsvLlgwuy9Im4iSriS8pTvQ==
=zXM5
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
