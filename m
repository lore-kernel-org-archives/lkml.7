Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6ECC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D73F208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566986941;
	bh=MbS3oc7NrCKE60Ei5jYAwXPyH10LVao3N2dl3+rESSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y8e4m//IAcYejBWpNAaw4q57R/qY6NuF+XCG0dKqhX0qXSmxsJasK1DcLYiQgV5oZ
	 kcl7QytJwHAiT5UMIjL3teao8/6I33GnZwaivO8wh1w1was1SfqGP4nYCnrVfTwUBj
	 z8PIrH6jntdgYoIG67MwSE/lV/Foh1PtgeDGOMfw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfH1KJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:09:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37622 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfH1KI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PxI8huNfC6VFO+8riZb4FVf90k7meZB53ciogdQeoxw=; b=EWanL1V5Q1ysiJUkGXj2AZpLA
        AkKvPbie/CUTWWQtcEDvQ4ZEe9KNvHIA4Ww2o9G1oWRdSQapHeQuYXmaV9oyW1qB2fZNrOlYyC/xO
        ABBSFHObTB6l64IZ8JM0viW114aCvD8+hum4x5JcpS9SveY9HFFGVN7i0XRZX0qG4odg8=;
Received: from ypsilon.sirena.org.uk ([2001:470:1f1d:6b5::7])
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.co.uk>)
        id 1i2uso-0003Yo-Lg; Wed, 28 Aug 2019 10:08:54 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
        id 432E82742B9F; Wed, 28 Aug 2019 11:08:52 +0100 (BST)
Date:   Wed, 28 Aug 2019 11:08:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] regulator: support Silergy SY8824C/SY8824E etc.
Message-ID: <20190828100852.GA4298@sirena.co.uk>
References: <20190828135646.52457ac3@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <20190828135646.52457ac3@xhacker.debian>
X-Cookie: Oatmeal raisin.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2019 at 06:08:09AM +0000, Jisheng Zhang wrote:
> Add support for Silergy SY8824C/SY8824E/SY20276/SY20278 regulator.
>=20
> Changes since v1:
>   - use c++ comment style for SPDX header
>   - add prefix for BUCK_EN and MODE

I already applied v1, please just send incremental updates fixing these
rather than entirely new versions.  As the message sent when applying
patches says:

| If any updates are required or you are submitting further changes they
| should be sent as incremental updates against current git, existing
| patches will not be replaced.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1mUrMACgkQJNaLcl1U
h9DfAQf/Z/uVU2+OG/dRjjnb9aJg2tEZUnbuMpSBOEc39IJjERea1NqcPGugs1/r
GoDl/aa1erdGnnA7Thw4iMN9fmyqxvL71eTblz0gQ4KcNFYtOAR7EHWUYqM7rXsX
STu+D4ytH5fUspWIqeGROG5kVS6+1x3OO3JDRAobTAO23F4u0Hecq85g2vxGHiHn
ifrjH8uYFs7zExUlvidN4qkF6Lz3vz88XGffPScsoi6ZySBFPQBcmEiWk8namQ+a
z3yDJoVrW84Api/AQ4Oz+0YvHUk2IPwLW9x9rAAhsZJwdYxURhClQgUQOsV+/XA1
hiEzWBdNw8Y1TQMUjjISRBJuh3+eTg==
=kSzK
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
