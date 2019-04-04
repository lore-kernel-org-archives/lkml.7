Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62308C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226B620882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 07:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554364158;
	bh=JgM86smBtcNiQqSzgRl5d6wdUSP6aK1Ih31ADToQXRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vM95vfwmYssfhOiqzthjcJaUwT9mHO6lVW93SG+BaQJhirvBst53Ll7R3qTkBYqDL
	 IVu+NiM6G5y257h/pAHtFh5lMShEfc3h8LdO4I0E4Ax0Qbgp/IhnpkVlVVPlv9uUZZ
	 b3Didrekz2y4RY2jPcEht/Eg6Y3QD2+vgIOJuK9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDDHtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 03:49:16 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60600 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfDDHtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 03:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=JgM86smBtcNiQqSzgRl5d6wdUSP6aK1Ih31ADToQXRE=; b=nOTUW9J48E4ndqWLT/3i5G/8q
        EAThVXXqMUmPgwvLuAPFdFE4iFX7J21WZYFW2iRgESYWBPXjtOdwF/iIJ3binjVMAQQH9x1DtIM0v
        FwCWApv5Aa8NFowSsBhwfQUtch2C392VMA+x/MQO21lvlZpxyMIoBhxzuZRD9jPsj5u1A=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBx7Z-0004lx-6x; Thu, 04 Apr 2019 07:49:13 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 12948441D3C; Thu,  4 Apr 2019 14:49:10 +0700 (+07)
Date:   Thu, 4 Apr 2019 14:49:09 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] drivers: regulator: qcom_spmi: enable linear
 range info
Message-ID: <20190404074909.GO5748@sirena.org.uk>
References: <20190404050931.9812-1-niklas.cassel@linaro.org>
 <20190404050931.9812-2-niklas.cassel@linaro.org>
 <20190404055502.GA5683@sirena.org.uk>
 <28e31d46-7df1-cb93-835a-f5eec603baec@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YC8Ek3FeOE8ywfXk"
Content-Disposition: inline
In-Reply-To: <28e31d46-7df1-cb93-835a-f5eec603baec@linaro.org>
X-Cookie: Replace with same type.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YC8Ek3FeOE8ywfXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 08:59:10AM +0200, Jorge Ramirez wrote:

> > This doesn't build:

> yeah, the SPMI regulator changes are still pending

If you're sending patches that have dependencies on other series that
are reviewed please call that out so people are aware.

--YC8Ek3FeOE8ywfXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyltvIACgkQJNaLcl1U
h9ByPQf/aAYSMQ4cVSTqNpaSLrWFAFoaErPA0BfKRJrkigE4JFkJ74rdLvgPPDvg
qE1DkQ0AYJ87986/nZav3ys/df41XP1+rdRYwOz/dtsqkLNFTeuP7cZfyi2RukkD
KrynRZ0gIsA+Q4Xr+eGuLF4vhFG1jl8bZZJ2Ds1rLwL2Mum+cqh5uU8eekFcqE43
SFxT5/ckbpnYjDQT/emxccK5LsJIjO7AKdwrOFYscMlYQ56ddQvunAJ7rlJQZMhP
4aCwATGDdTWeKt5BnHu1Vh9FCEbcmksMZ9cuDV2RMvPuWZVN7dwM+JZeUfX1TLrb
fhsGIwNzKcAeuXKGqJvFsDVe1GVZKg==
=YdHA
-----END PGP SIGNATURE-----

--YC8Ek3FeOE8ywfXk--
