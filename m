Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F0C282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9032173C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 16:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555519138;
	bh=EIuSywdYAYEDRCChyUXLcwackDJL7gbIMgOf+S9xeTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z0JS2nnKZme5BkhoJyFd/xtioz4xv4hnF3IjG/Zb+MS2vcUA/NLNZUyKPLmtR+ubd
	 dEFCvYVgC4lwONXR7a68DAOWLzPr5/eU24A5WGHs+b+JdPOAAa3ItLg16WxNdaMuKH
	 P/wkngSDzynwVJ6wRYAGaMcIeLaaP+V02U5Np9NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732822AbfDQQi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 12:38:57 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59490 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQQi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 12:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=EIuSywdYAYEDRCChyUXLcwackDJL7gbIMgOf+S9xeTI=; b=eNdeR7T0CoieAHxftAbqQiGzB
        Usz90tDZYqkrI0+S8HTvQKB9/1slnFRoI8Kd/VnBmdn+Fcrs1F78NbtZ3FneyAWV/FpBPy3y7k5zW
        03bhTq4gvOAxlrB0Vv2A0gkH5HuFR0m/d6Pi69Pteb4TEdidkkAdpRUGwNktRDBIpIhsw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hGnaG-00012k-Qb; Wed, 17 Apr 2019 16:38:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 500551128FC7; Wed, 17 Apr 2019 17:38:52 +0100 (BST)
Date:   Wed, 17 Apr 2019 17:38:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: stm32-pwr: Staticize local symbols
Message-ID: <20190417163852.GB1675@sirena.org.uk>
References: <20190417075942.28321-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <20190417075942.28321-1-axel.lin@ingics.com>
X-Cookie: Drop in any mailbox.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 03:59:42PM +0800, Axel Lin wrote:
> These symbols are only used by this driver, make them static.

Someone already sent a patch for this.

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly3VpsACgkQJNaLcl1U
h9CFygf+OQ2Ta0qjCV3Lb0iIYLj4ToojgPxOWlXBG0vRSooiu3HSMOw5o9m5iX/m
tcF/kKOJu5pHYw/7BXGinqC/WRZl1PEeuSRz4VvVAxAzRQFwI57QQUUzvY7cgBrh
SPQPdLmnl06/obj9aTj94O1/NJSLyEtdKG8ThXMtD4Fj4VA9rk48O5OHg4rOu+Z4
4bk6Wo2m1hovqJhvSVKGPRGG/XnokWqMv087mOynUrZjFqDesXCV4f6/3KeazeTW
oONpIqah7Rq8l4tEtY6qgselxbQrSezlVPENQJOkC34LETTubfz5gZ6IYjqLINRq
GNZS22AyOnR1psaaOZFJumqmox87TQ==
=kMYf
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
