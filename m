Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF1FC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D42A20881
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 14:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557932208;
	bh=T7XrePeRGhR4m//teerk+Y27hpO5cnbjtJZspej/iTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qG44YMvh7pwl6pmrU+lSrXRP1aF3uVo4IvTF/u6xiqQaPn0P9bf4H+xBoLdtE1Pso
	 2G0T2WWU3uPUzYi5IfdFFjw6I4mnPh2AiiFDpp+7aZRtTHMVDTYQiAj8jOl0obTjp+
	 mktKdIL9mXEGZfc4gYZWgFFSBpxMnjwmr3kpLWqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfEOO4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 10:56:47 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53584 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfEOO4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 10:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tMMwCkIhSKNuN46CCLZ+HPK8zIH9a55x1v9yGOdHZN8=; b=efKuWkAuR7gdoaxyK76NDlPln
        vhr7wVoYqnmnbgDquleYq3fgOgItX9pA8kx1K/zIpDnOtaCA28t1OgHlynPTuLsFRFbU9F4fplE2N
        6zwORjNSWupiM4cL6LTo0O5utbV5shoeG/Ln4O5kWTG+524osX7J2KZzTYEEuxwqny4ac=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQvKk-000421-MJ; Wed, 15 May 2019 14:56:42 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id DED161121C02; Wed, 15 May 2019 15:56:35 +0100 (BST)
Date:   Wed, 15 May 2019 15:56:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
Message-ID: <20190515145635.GG5613@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
 <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
 <20190513174000.GH5168@sirena.org.uk>
 <9e13bbd1-ff28-1570-b1a6-0cc6337b8f6c@gmail.com>
 <20190515090557.GB5613@sirena.org.uk>
 <3be50306-d3e0-f931-9d6b-0ae0ad5c78ce@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <3be50306-d3e0-f931-9d6b-0ae0ad5c78ce@gmail.com>
X-Cookie: You will lose an important tape file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2019 at 02:44:33PM +0300, Dmitry Osipenko wrote:
> 15.05.2019 12:05, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, May 14, 2019 at 09:30:05PM +0300, Dmitry Osipenko wrote:

> >> I'm afraid this is just a way of abusing the OPP's. I actually already

> > There's nothing wrong with handling regulators in an OPP, that's a
> > totally normal thing.

> Only if those regulators are directly related to the hardware unit,
> which is not the case here. Regulators coupling is the right abstraction
> that glues things together, there is absolutely no need in trying to
> make workarounds using OPP.

The thing with OPPs is that they are often system level rather than
related to one specific parrt of the device - one of the reasons people
use them is that they eliminate the needs to think about dynamic
combinations of things and instead pick a suitable configuration off a
relatively short menu.  This makes both validation and runtime easier.

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzcKKMACgkQJNaLcl1U
h9B+NwgAgLI94SGFcIjf5e/zV+qGvk219uqkypT4TVitsRux+TDwXPBqqpipHToV
Y2NXTgG5QUiNeMvAYRKlJaOc4JKTm6kUiU1EKyhOfjom9CbyNUZt6hkzDssVP4L+
wg7iQ3Xs19lWCMOXLjrmJmfUhDvvXsT5SQl0xxyzLmlXeq6QQ/saeGi6QXorG6Uz
GDz6A+BItUayv1ZLakLeGoUcRKngFHpUjJzIy8yO/zJ9WzWkS252z2u8z4TnhTms
59I9K9q2ia/syGa//PM2mNT2cbCGsHQykgYSlWIRWlldgL/OnxtIdS5vUvUhnl9G
+Vv/NLM9ommlZnjuTVxUCVp4J81D/A==
=JHHM
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
