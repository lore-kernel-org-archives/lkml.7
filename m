Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FFEC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56B1207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 20:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578343524;
	bh=YW8DsLZfYQk4jih3HnOgrbhYrDtiqJmzQL3r72NKDjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pf4M6/rpjMklBIGPccRMZTiz3vGo5p7z600evoAKdNJiWTjzECQhmfnq/0HGVTOD6
	 AR3PxX60/bHupP7NqwE+IEG0nECo/KrLRFdQHMwdhp5KgghLrFDtrLYqPJa7pafCHV
	 ehLtC1QpHKEUcmzj6dx8IocKQOi5sxILCOV8qHEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgAFUpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 15:45:23 -0500
Received: from foss.arm.com ([217.140.110.172]:48912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbgAFUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 15:45:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6394328;
        Mon,  6 Jan 2020 12:45:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C91A3F534;
        Mon,  6 Jan 2020 12:45:22 -0800 (PST)
Date:   Mon, 6 Jan 2020 20:45:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] regulator: mp8859: add driver
Message-ID: <20200106204520.GD6448@sirena.org.uk>
References: <20200104153321.6584-1-m.reichl@fivetechno.de>
 <20200104153321.6584-2-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Content-Disposition: inline
In-Reply-To: <20200104153321.6584-2-m.reichl@fivetechno.de>
X-Cookie: It's later than you think.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jan 04, 2020 at 04:32:45PM +0100, Markus Reichl wrote:
> The MP8859 from Monolithic Power Systems is a single output DC/DC
> converter. The voltage can be controlled via I2C.

I have patches 1, 2 and 4 with no cover letter or other information
about dependencies.  What's the story there?

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4TnGAACgkQJNaLcl1U
h9A46gf/bxiSXCC7UE5lAyiSv1Ty0tmILgIugHIDfpv1kiItsznOj8o8gd3t8Xak
RfV15p/RE5SEf5Mt9PmQ9HZLYrz57LYhPdIW8mdqPYEBBSLIK6yomYITST5+FrH7
pc36LC/KBi310B2EzWReP45Tmw+oEWw/CTYHYcto48soSNDBsoaqoqfM59GrLRP5
2YapCH/IaVzmrxAToY00vPDGeOvkeRIzXV4ewVTedOB/ZDU0tUtKZhDPLzjv6P2+
lEGdUmRK+TYlP9UIB0i9b4i+Rmvx9LjHpZ3e+HZ3WOIiv6ONfgt2j9AcpgZUraeF
ExDGyMhZQFn9v/qcJs5Txp0Tdrebzw==
=5TQL
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
