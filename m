Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED97C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AAC20840
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554180961;
	bh=J32IraCAWptgtGKlaZGVNtAnjJ+QGMmBlmKZqJhH4PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2wbtPTOBzvmd/y+aIq5EUIoxu+RrP0SLxDURqrc6aCb184phAMaEwkoOylqbKhVyv
	 UGujV17QNVfPcfQ8aA185xNqcQfUyGMw8Xmo8mYMEm8OB2GImiIFZy14zY3AKqVhGb
	 u7hBlVRHebL0nkX3bx5Fc9P6Cv19FSxfOz8psMQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfDBE4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:56:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45570 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDBE4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=naCwJ05RzQIUKhqewbne4ttpme8Mxrbti8Ipod9sLfI=; b=ByJEd5ZRT1Kfb2AYMte3+JLio
        stT5cjnTvyjqYMHei3aaANEZPBSEEzmOZD6yE3YbwXiGTamlYb2cC+h1T1UY3QIiOPRSCfJOkT5kP
        u3iccGoydizb9VOxSGq/aa5ThfCrWMYg+93+S9a6cAWVZN57/H/kZvxLuqKahg5tZv0+A=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBSZ-0005nk-WA; Tue, 02 Apr 2019 04:55:44 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 32660440082; Tue,  2 Apr 2019 05:55:40 +0100 (BST)
Date:   Tue, 2 Apr 2019 11:55:40 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: Applied "ASoC: es8316: Add support for inverted jack detect" to
 the asoc tree
Message-ID: <20190402045540.GU2059@sirena.org.uk>
References: <20190329215045.6254-1-paul@crapouillou.net>
 <20190401085258.20BE0440083@finisterre.ee.mobilebroadband>
 <1554141439.10471.2@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZjLa2K+dB9SFbrgo"
Content-Disposition: inline
In-Reply-To: <1554141439.10471.2@crapouillou.net>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZjLa2K+dB9SFbrgo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 07:57:19PM +0200, Paul Cercueil wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> What about the other two patches? Should I make a new patchset with these?

They're Intel board patches so the Intel people will hopefully review.

--ZjLa2K+dB9SFbrgo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi60sACgkQJNaLcl1U
h9CAtAf/WlQsJFP+bB2DBFWNRIVdHgOV6ZiB1HGy0T9l0rCS5WNvYdbYByLv7yKq
Bsj1Dvihr4EI/9bnQcycw18MPNf3szP5ipSYJbuY3NSor3/vFv6FZVRISp1hhqL9
vp+2t2AuRn/kphazTsX6CxfslOO6FXQH9gP3bxFAHPDxXL4xu+Zbp2RFMgLvySj9
RyK1MDoIyliuuUygyoPnK1mh044kvswBB60HWvb4xwvbzwb9/o9hUwNbBAxRu7pq
w1N5U8pb1640VrkskElE061SVYK+PV6+cEcPUggPC8+usuqX8K2sKwk2NMkRu9IJ
91q+HxA8VoORafrxNAk42Fzyithqmg==
=4ORZ
-----END PGP SIGNATURE-----

--ZjLa2K+dB9SFbrgo--
