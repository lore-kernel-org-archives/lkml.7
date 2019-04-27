Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79542C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 414ED204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 18:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556388037;
	bh=/zRjMbzBiv2s9JYXZwe5cYYSiAICagPWPRWCg0nrcts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufGpW7cTe+yIU/yxiCeMYmd4PB9BuaZ4frjYrvIV9xcxiNsemjKjYZ4fRUsXgLl91
	 RLw5AudSaj9AXGY68aT98KicAijczyw5yF+gf9bcRsk9flnwYo0blL22bXY2w5wt6R
	 SGKbl7fnjl/aLjdeB5TJ3o0YCcu0FMW5JRzu1tsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfD0SAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 14:00:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:55684 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbfD0SAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 14:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/zRjMbzBiv2s9JYXZwe5cYYSiAICagPWPRWCg0nrcts=; b=qV5Obo3xI2dLbptH9kR7cfgfi
        mJvknFCSHRfTRU78dZgZPoF3yiBinssokTAXOhGX2qTBEBwvCgd+1/jUs+HdjoXKoN8bYdTo7xCYV
        octP9b4UqV935KZCD+fAkKicUF9X2+FTDzb8k+vMhzXfF6WWFI2kRClQ3NjZ1a+WWsBHU=;
Received: from [211.55.52.15] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hKRcm-00051m-Fb; Sat, 27 Apr 2019 18:00:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 3BAB2441D3B; Sat, 27 Apr 2019 19:00:29 +0100 (BST)
Date:   Sun, 28 Apr 2019 03:00:29 +0900
From:   Mark Brown <broonie@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.0 03/79] ASoC: ab8500: Mark expected switch
 fall-through
Message-ID: <20190427180029.GK14916@sirena.org.uk>
References: <20190427013838.6596-1-sashal@kernel.org>
 <20190427013838.6596-3-sashal@kernel.org>
 <20190427171410.GE14916@sirena.org.uk>
 <90e92595-1609-6c3b-b1d7-ca6a20a81f79@embeddedor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gBYU9MM4gf8jKg2V"
Content-Disposition: inline
In-Reply-To: <90e92595-1609-6c3b-b1d7-ca6a20a81f79@embeddedor.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gBYU9MM4gf8jKg2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 27, 2019 at 12:31:22PM -0500, Gustavo A. R. Silva wrote:
> On 4/27/19 12:14 PM, Mark Brown wrote:

> > Are we *realy* going to enable -Wimplicit-fallthrough in stable kernels
> > and both backport all the fixes and add new fixes for the issues which
> > don't have backportable fixes?

> I don't think so.

> There are hundreds of these patches in mainline, and I think this is
> the first time I see one of them being backported.

Right, this looked like a super weird thing to backport.

--gBYU9MM4gf8jKg2V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzEmLwACgkQJNaLcl1U
h9AMewf+NcfgSMZeeFeumPEiOrm65mvlAlECmRvdyrB82psUkR1C3y7rM8Nx6DRM
2SRWhnRHKcFhiXPZ2/jzZWMKMiWr5PWkVpjKq5uZO8dGQSexDm5TnvnKKxBa6M6O
yPMRvgP0k6FegOttGRfnWT9zALo+Yp9P2jWTEkWMfdI7sd1UaHEqmMv80uCCMk1u
s5DVQOlA/Pem3/t2IPxrr0Th4B3Q1vDQ0FuSL1q3qh2OCGeQD1bVq9L+6FZMCWpN
8/hnr2RFmofRmdm5+JX2RkA4fue5tN1OhGumMLubVwE+Ep1LBeWW8GMdTXQAbPMi
638BcHuoM9/Mm+bYUSZZe+pLyv5/QQ==
=4fxy
-----END PGP SIGNATURE-----

--gBYU9MM4gf8jKg2V--
