Return-Path: <SRS0=w+Kb=XL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5974C4CEC4
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8237F214D9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Sep 2019 01:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568597857;
	bh=BMfk88ico29ySmgOGny1z5/EkCwjKyHZo9oZsys7Pu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yyL6xz3MatoQdguEmbVPg6p65Osn/G+W8XC5l2Kbk5uwgQR00xl1u0cP60nTCr/2H
	 +GcZFAKemJtPVyEesT4naob89GrM/lcZwGqpxH5HQbYK7EeU9avdyjyaFvwU3JfPFp
	 O53wpfH+8Yut1+8kF6omAGoYSgWzlVCa8jJ01fhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfIPBhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Sep 2019 21:37:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49120 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfIPBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 21:37:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BMfk88ico29ySmgOGny1z5/EkCwjKyHZo9oZsys7Pu8=; b=SjixzUGcST2fpzETcSni45n2n
        eB6G/YEV/CfuWKigy9XdPCSmiqoDYZHmPvkrwPhj2fmCGiEke4kBkw9gYsuHel9qYXEZ2Uhi9K+/R
        QvmIN6j5PsvY8JJIy1AfLKXYIBe454nIyQY42hRX/AraEjr07eLFZUXamrFvrf7awTCA0=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i9fxI-00029H-Vs; Mon, 16 Sep 2019 01:37:29 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 04F9E2741587; Mon, 16 Sep 2019 02:37:27 +0100 (BST)
Date:   Mon, 16 Sep 2019 02:37:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: no release today
Message-ID: <20190916013727.GT4352@sirena.co.uk>
References: <20190905160237.2e972a89@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xPLL5cPndR2UZ7Mw"
Content-Disposition: inline
In-Reply-To: <20190905160237.2e972a89@canb.auug.org.au>
X-Cookie: Man and wife make one fool.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xPLL5cPndR2UZ7Mw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 05, 2019 at 04:02:37PM +1000, Stephen Rothwell wrote:

> As I said yesterday, there will be no release today, or any day until
> September 30.

I'm going to try to provide some builds for this week (16th-20th).
There may also be a build for the 15th depending on how much rebuilding
the rest of the trees is needed for the build I've got ongoing.

--xPLL5cPndR2UZ7Mw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1+51cACgkQJNaLcl1U
h9CaIQf/X+bWHuxJxTJi47cSPu575HrnQuH0o3HuDF3CxxqBR1QyOZUgSbtsnfjR
d7NK1G4a901K3i9phvaoOlx/7fch6oUs5HMbmzC2PDfkRzwRRqv39OFBMYtVSM8G
IV8XIoolLxP9VWY4nt9jOlvRCs8vayFAFMYO2+x9M50zPrd0yqk3Lxfaev0+sUJu
bGb4qXFyH9G5od03OEd32Wng39qZ+puguum7+pK8LpmBlE782rKAKgHyZ4bafVEc
Zm1EXDYEUuRd9mNTNJL/6zUUl69bZr/UQSJCtdajQbcI8Rk5yI1B51bq3hULho14
SqxPNymeWbiMzVxRuxvri5yTNT9eHg==
=ifm5
-----END PGP SIGNATURE-----

--xPLL5cPndR2UZ7Mw--
