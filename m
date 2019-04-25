Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CB8C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66B9920717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556216276;
	bh=TfUmuNaJuYstbYjt2cXXyzlWso/wZbKBoh9mLr+1OgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RM6ru9rLiZ5JeDWrpcrNxaS135UbSF10dwYqBfAStB1DmPEUe17/ZslgkYrEocRyR
	 zGYjYHcaw1qR4NZsi+JrmhNc0JLVN/1Hxb6J4O7nT09bHgIy9QSLS+nvsSCXD741BM
	 TV3Fs/S5qk2M+CHSi2wylnoI2zUn5WkWFQiONCx0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfDYSRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:17:54 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49698 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfDYSRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:17:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MdJ1sN/LBuMiDfptCYjNzhlbJmjNI/eJu8NWCJerpuo=; b=LVJeP6NvCWPq5LXTCrh9hr8UY
        4uNzLxuVfH7LYh+qQCal7/0eY5Z3exBdDA1QL/WncjKD084ZW1Xy/egBe07jb+ROHEWQ6tnB2ShXq
        TavH0G0VbI2lqTtORiKZXHo5cc/OqAB9PwpCG32BQ12+DzGYGDszol0TNDPsEIsJhTf18=;
Received: from 94.197.120.252.threembb.co.uk ([94.197.120.252] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hJiwJ-00045I-5f; Thu, 25 Apr 2019 18:17:48 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1EFEA441D3B; Thu, 25 Apr 2019 19:17:36 +0100 (BST)
Date:   Thu, 25 Apr 2019 19:17:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        enric.balletbo@collabora.com, khilman@baylibre.com,
        matthew.hart@linaro.org, mgalka@collabora.com,
        tomeu.vizoso@collabora.com,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: clk/clk-next boot bisection: v5.1-rc1-142-ga55b079c961b on panda
Message-ID: <20190425181736.GD23183@sirena.org.uk>
References: <5cbe596c.1c69fb81.e252.b9d0@mx.google.com>
 <155598159898.15276.8408514960097680895@swboyd.mtv.corp.google.com>
 <20190423144028.GA8007@atomide.com>
 <20190425172807.GW2803@sirena.org.uk>
 <9d076ce7-ce9b-07d9-21c7-e3e2eddf2fdb@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Content-Disposition: inline
In-Reply-To: <9d076ce7-ce9b-07d9-21c7-e3e2eddf2fdb@collabora.com>
X-Cookie: But they went to MARS around 1953!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 25, 2019 at 06:44:16PM +0100, Guillaume Tucker wrote:

> Also there aren't that many bisections, maybe a couple per month.
> I think we could cc the KernelCI reports mailing list, or maybe
> have a new list, for people who want to receive all the bisection
> reports.  There should be more as we keep adding trees and
> especially when we start bisecting test suite results, not just
> boots.

This is the sort of thing that tends to go in phases as subsystems get
worked on IME - if something is getting disruptive work done on it you
can get a lot of issues for a while.  You'd also see a lot more reports
if all boards got reported.

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzB+b0ACgkQJNaLcl1U
h9AAiwf8C1JIM8NxRZSN+SFwEgEAMU6EST1TKEwGRQIh+m8CJKne13iND/8ieE7b
c6mbRJK472H2q/2uiDlyZEPifypfBovRxEiW/v3kafnM6kqQiGSwzD8/rJXpl7d2
xqZBlt6jQktc5Gkgru7BOclLzkNmpKvMSduH4mfCC9slH/dBd0G7ima8LFSUw6sv
SvqUJF9lmcPCeuy2hVJJe0jvOeC2Oj55dh9yBc2WjoC+b/r5qSvdzT2hOKzfD6GL
2ryawlKkkkQgzs5C20wl/2DsC8wCLs70AtIaPcBv0oAMej34WOAW8qOU7OKAc5J+
pQjY347mXGQW0tKc03UGLelRNl1f9w==
=FLJ0
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
