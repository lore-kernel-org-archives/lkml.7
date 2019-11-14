Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3297420718
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 19:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573758530;
	bh=qoJvmm3HUBhrO4GtlbT8E1muqZuJdtDDlNo4ymu6dRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NyEKmgL5xZJBj72ulAEqRMVaKp4jcK5KJNhjMVPRhbaxFDWWgq3p5oKgyxfZjtJnc
	 goOGU6a7wfQtGOhrIKPLp7kP7/NZNdmi8+mHnB8G8R9fGclsq0a1RNYzkC7DqGJj2G
	 pMp5yShX/oSbzweJS1FffKrSlRdg+W1/3SqQpKe0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfKNTIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 14:08:49 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41988 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNTIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 14:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=kexbIRGdgnOvNpDCJNRhDSzcKw+JRewZujyNvN5WeHE=; b=vkE2lkRgfNiR5JBodUL9yjrTh
        xUawzxKzxyWEg1tP0OB4VmcSGeX4UPteei3IrJrGluGdM6cpGEjbasV7pmaunhFnO7qfYBkZSeJ6t
        ElCcgYSeNn1ERx3dfJ+aCdlTZ3tuolw2zDiTwh09a3+o2slFVcDsgO7ZBc4LxQlUrpfrY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=ypsilon.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1iVKU0-0007PQ-Lc; Thu, 14 Nov 2019 19:08:44 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id B96AF274328B; Thu, 14 Nov 2019 19:08:43 +0000 (GMT)
Date:   Thu, 14 Nov 2019 19:08:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org, phh@phh.me,
        b.galvani@gmail.com, stefan@agner.ch
Subject: Re: [PATCH] regulator: rn5t618: fix rc5t619 ldo10 enable
Message-ID: <20191114190843.GB4664@sirena.co.uk>
References: <20191113182643.23885-1-andreas@kemnade.info>
 <20191113183211.GB4402@sirena.co.uk>
 <20191113202633.66a91d96@aktux>
 <20191114115430.GA4664@sirena.co.uk>
 <20191114152451.1756b0c8@kemnade.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Pd0ReVV5GZGQvF3a"
Content-Disposition: inline
In-Reply-To: <20191114152451.1756b0c8@kemnade.info>
X-Cookie: Santa Claus is watching!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pd0ReVV5GZGQvF3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2019 at 03:24:51PM +0100, Andreas Kemnade wrote:
> Mark Brown <broonie@kernel.org> wrote:
> > On Wed, Nov 13, 2019 at 08:26:33PM +0100, Andreas Kemnade wrote:

> > > Well, it is not just guessing, it is there in the url I referenced. B=
ut
> > > I would of course prefer a better source. At first I wanted to spread
> > > my findings. =20

> > The URL you provided looked to be for a different part though?

> No, they just skip the rc5t in the name. Same situation in the vendor
> kernel for my device, but there is only a tarball online, so it is bad
> to reference. Everything is named there ricoh619 (or 61x). And on the chi=
p is
> printed rc5t619.

Ah, OK - that's probably good enough then.  Let's leave it a bit and see
if we can get some more definite review though.

--Pd0ReVV5GZGQvF3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3NpjoACgkQJNaLcl1U
h9Dlxwf7BXGuuBwTLLz94MrZ1bDq60w+rMhV89xgvzQsVWZO8iGtBOE8LQkzWVfi
xrR5ELowY3l1YXlimjIDTOqCxIzBB2Z3Gi4tffBk9TbVS0vL9FNu+WyYZcS21IEL
Ubk8YVLbdnHGRVehtN77tktwwXccO+oN5Tt5Mb2h492aG+pAKeRR7exaJzXMvuRn
wWb7n6d5PCkcY6Dv6Xs5HbPDt4/KJfidshrnKsMGxSHeck4RencXKM5L5dNdtD2X
jt+u1q1BoECOqmeG0YfHL8s1T27lePZrbh0ojEO4jbW41XfSXLyL319QjGBDBclA
1DkH82nbWe9fDS0B83y5SVYikDszvA==
=J4fs
-----END PGP SIGNATURE-----

--Pd0ReVV5GZGQvF3a--
