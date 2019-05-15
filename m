Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B626BC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87F8220862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 09:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557911165;
	bh=2m8SrTRV/x1QGk297rz2AW7VmvJVYnyP18FsnHYZkM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLYeBIA5uumVs+oC0jwDo38Ohw9AuVKpqAC6zMDOgMFTdcpm4TOVZOhTO0+uDRFvG
	 jPe8vH29pSH2ZC92sOSgMMa05T1UQD04zBBI2GIpC433O6Gp1wMGVgK8RBoxXkJORT
	 jM0spg612B2UZ3uvRz+n6CRgxrqsMihmWtJq9gSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfEOJGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 05:06:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57980 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfEOJGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 05:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2m8SrTRV/x1QGk297rz2AW7VmvJVYnyP18FsnHYZkM8=; b=U5x0UwHRRftnMtkU875/Vs7Q4
        f2PAe4M8Vv5EuVXuJA8yXuK660K7XvgMbfilt49EkO6BDzAosrfhCD/IVWZFeRWOy/lhn+iyD6Y7f
        nmgE2cpLHShoThLutqkDlpUTGf1ClbSUiosOxkvpppiwQ0qXWhGyEn/IZm0Pvsx+d0VzY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQprN-00039P-AX; Wed, 15 May 2019 09:06:01 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9A30F1126D5D; Wed, 15 May 2019 10:05:57 +0100 (BST)
Date:   Wed, 15 May 2019 10:05:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 6/6] soc/tegra: regulators: Add regulators coupler
 for Tegra30
Message-ID: <20190515090557.GB5613@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-7-digetx@gmail.com>
 <20190508075848.GX14916@sirena.org.uk>
 <af6de446-ab45-1745-30e5-426c6b34421f@gmail.com>
 <20190512090446.GN21483@sirena.org.uk>
 <3988cfb6-55fe-48c4-5365-ac79871f7fd2@gmail.com>
 <20190513174000.GH5168@sirena.org.uk>
 <9e13bbd1-ff28-1570-b1a6-0cc6337b8f6c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <9e13bbd1-ff28-1570-b1a6-0cc6337b8f6c@gmail.com>
X-Cookie: You will lose an important tape file.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2019 at 09:30:05PM +0300, Dmitry Osipenko wrote:
> 13.05.2019 20:40, Mark Brown =D0=BF=D0=B8=D1=88=D0=B5=D1=82:

> > The thing with OPPs is that they specify a whole table of values that
> > work together including regulator settings, the result being that you
> > have many fewer options but don't need to think about constraints.

> I'm afraid this is just a way of abusing the OPP's. I actually already

There's nothing wrong with handling regulators in an OPP, that's a
totally normal thing.

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzb1nQACgkQJNaLcl1U
h9B+uAf+ICo1YFwIDtc0IRXVChQYg8IxHaOtl3E0HssgAOIT+MbeRs+M+SSk6EbC
Kr1Psm76LVW/stVAjPoOmyapJczTaKrlNHDwDHwrQE7gEXgQ31AsOFzEMjQrVKzU
P2FBDNi1dIOvNJ27+0+FqDcBQOMIDZHUy/Z/bJhdQGtdg0YXp+SyTHxSnUIuNLTI
4DCFaCyP76gLH3Q8wkQjE5MmUeFQ8E0v4RlrImFH4NaJndqwKGoVMKGsCqPo6DTr
1bQdnF0AgJoRLEvsD/tPhff5AlaGjnuSfVeENJ4A2YQPLWcTDbs+uqh8T88D5Y59
0RP2BxB9PjODwkZuyRaWsFUDGNkkqQ==
=k+RW
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
