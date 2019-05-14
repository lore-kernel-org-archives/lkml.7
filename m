Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70289C04AB7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450992084A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557853864;
	bh=sQ2v9BWL2TF+yUu5MdDu2lBLdFrOBaMcfG/xJ/BdtC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EXminC1i0kkRyq77pNDedngIpuJhxF3OGFLXNIONFFuUVavHzRLlMWUdutc9An+Z9
	 ekHwT4zf4M81pCPBWWB5kSERdcuPrghwrkSogHcY9g+9rRA+UZ/aT3+E24THv66pXF
	 tguIePvI0Cmvp4o5mmHmvpyuFZqvp9P/OajmEiZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfENRLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 13:11:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:35866 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfENRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 13:11:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sQ2v9BWL2TF+yUu5MdDu2lBLdFrOBaMcfG/xJ/BdtC4=; b=B5A0vFSRlNpytQh/GOoWvYlaZ
        TxO+q/vS8LUUggDpXA9TPUoM5Tm9MzRJzaGm18MdWW1waIF9TNtnr9vFRtdNJE2vD+d7STMOs8DSs
        u/4ktlzVrewoYvRQj2WhaExlZabOZAH3Xkf4tlDf+MR7nNA0RnV1e3aKTpoyhtwc0aB8M=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hQax2-0001KI-DD; Tue, 14 May 2019 17:10:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 7E1451121EE8; Tue, 14 May 2019 18:10:48 +0100 (BST)
Date:   Tue, 14 May 2019 18:10:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Tero Kristo <t-kristo@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        John Crispin <john@phrozen.org>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] clk: Remove io.h from clk-provider.h
Message-ID: <20190514171048.GB1917@sirena.org.uk>
References: <20190514170931.56312-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline
In-Reply-To: <20190514170931.56312-1-sboyd@kernel.org>
X-Cookie: There is a fly on your nose.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 14, 2019 at 10:09:31AM -0700, Stephen Boyd wrote:
> Now that we've gotten rid of clk_readl() we can remove io.h from the
> clk-provider header and push out the io.h include to any code that isn't
> already including the io.h header but using things like readl/writel,
> etc.

Acked-by: Mark Brown <broonie@kernel.org>

--3lcZGd9BuhuYXNfi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlza9pcACgkQJNaLcl1U
h9DaRwf+K/Mfxb8gWGuzc1Th+U9YfqsFJrEyFQUxjLaiqbF6rZ8isFQGvrxN4+V0
2xNugryG8w0M4OMurwyx+l4DvB9TjSbzQP6E9Yg1jjyUMrCePyFU6I7K9dS6uG9n
zgNWqL4Jrg+0tzMvsy0a7NyodjJj4QUlx3+IZh0iSkDoGtOC88GTFtwux1i3nFBP
uebyLjf5T9Fi1K0wODXYCTTCE/Ylbb/vjo577+PWz2qG5Cg5aANTGzDw5CUx8Y2L
KNWZ6Brdcn8kNsT8xd18dK9cRBV/nvYilSitEarMYR3FvtOBylS7yl0NljUYxo+Z
d2lujlL/XfSEbF8DIbQ7E3uRQoL10Q==
=yApY
-----END PGP SIGNATURE-----

--3lcZGd9BuhuYXNfi--
