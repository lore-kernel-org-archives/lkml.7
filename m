Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53838C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D2820830
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 10:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554286059;
	bh=i0H7I8bcHrmBKEYgoza2NR/UBW8l7aN6DhJ7gT4b0KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NNlbS3b7/B/bBmuRKXibHyrOw5l81xzzsCWI/ztIe2aGF9uGV7FqHPJw2Qs1Zjn91
	 EQyrgyRrXK4iNzKRtSanB6lwPyDYwRITapipy1qbo1AKN1JAL/7PzRBKGm0BRnK+CW
	 M9jcpLd+K2uJVo8T4BSXzU5CGk5+niyQodG3J1eE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbfDCKHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 06:07:38 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50052 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbfDCKHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 06:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wmdve85oy7icbPkAJTntjOdtzoNsEbMD1QCBMEflElo=; b=rhLwDzQ0UF6qgAoHHLJRfaKTl
        Z7P0lCzEVUKbQLpMx7rR/ysVKL48D15T7NZI1rdMdRET4NttWe6B5IOGfW9bN4hv+qMK04gAjzoZp
        8TnUZx2iFP01g2yxkXLto8mMOouXbHPJR2IEoYr6yMAwIVa7wTeQs+RjXH3X+2+nRZKcU=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBcnt-0005qQ-7u; Wed, 03 Apr 2019 10:07:33 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 19B2B441D3C; Wed,  3 Apr 2019 17:07:30 +0700 (+07)
Date:   Wed, 3 Apr 2019 17:07:29 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 4/6] regulator: da9063: move definitions out of a header
 into the driver
Message-ID: <20190403100729.GJ5748@sirena.org.uk>
References: <20190318154759.21978-1-wsa+renesas@sang-engineering.com>
 <20190318154759.21978-5-wsa+renesas@sang-engineering.com>
 <20190319130134.GD5514@sirena.org.uk>
 <20190403092230.dsgce4jscuqg72ls@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NqSa+Xr3J/G6Hhls"
Content-Disposition: inline
In-Reply-To: <20190403092230.dsgce4jscuqg72ls@ninjato>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NqSa+Xr3J/G6Hhls
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 11:22:30AM +0200, Wolfram Sang wrote:

> Mark, if you are OK with all the patches going in via MFD, could you ack
> the other regulator patches, too? Steve is fine with the patches and
> tested them, too.

I don't recall any more patches, sorry.  Probably they're fine because
the whole series looked straightforward enough so I guess.

Acked-by: Mark Brown <broonie@kernel.org>

--NqSa+Xr3J/G6Hhls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlykhd8ACgkQJNaLcl1U
h9CoqQgAhj5mNqVXo1Cqhq49RehC2r3/MucopRJYgbNc2OyHygvtDPioXlcxQcS+
ew7KWdMeoZv32dBy/8ZRaoo7une1VCXAKeEnRL4kFhNDwmVowvvMvzTdX+A/bg8R
SjI6R/CJDhZSFFFNAhbRONfAQ4mtPPQf2LHpfhUZXUEelI/ffKT+iVvNu5zgD2Z8
kExnXvteLLJ8Ejp7pOQnQdNaPX6JAnogkYPyU0eLb+Q1pUjT10C/86XyS9XAd0wz
NRUeO+D7RSBGwt6C4XeAKgg5egCeeskORzCpnDWh9MrNM3gUOc4v6IhAhBi7C7je
32a6wy46zM7G05q6qvSHELjE1jIjWg==
=odHo
-----END PGP SIGNATURE-----

--NqSa+Xr3J/G6Hhls--
