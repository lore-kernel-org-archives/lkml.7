Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7831CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B299212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559906009;
	bh=Hs7qTSXru+9dvrpFOzJ+XU1trpXEyPCPUYwQxgDQ0cI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jKL0UHMQQlGMCrZ9ms4U9ZWnwZWMSxmNyXsR3GUVFYO/5ADH0ddB2w72xZA5C2eSN
	 eBpjUS8NUnhFpMj1vhF5Lu2HcQeZJAUllMkuFGwLMmJXSys07tRIouOyKDQz8tssd5
	 N14Yb+sk4WLQE2PjwfkUu4MZWqATc8vHgrbArpqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfFGLN2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:13:28 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:34238 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727765AbfFGLN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AspmKVjY7mJ8HlX6+G0jU6RWDgqTyzyWO77BW5lTioo=; b=AWxRGyzYu+UByYRVNF7xUoTci
        K9YJ7T+ee4KHFo/QooSYiSQYK+GMd9yWh6ldoSQK+1uBDAtTov4FoBIII1Z6AwYjhDhX7/7bJV4uK
        +OI9NFxvCnZIOTyDT+ITbW5MQ2wOj5DEQV7XTUtGeasr5KyirCok5/hC6m8n9KyfKSJFM=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hZCnd-0001iM-BW; Fri, 07 Jun 2019 11:12:45 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 4F0CA440046; Fri,  7 Jun 2019 12:12:44 +0100 (BST)
Date:   Fri, 7 Jun 2019 12:12:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     shengjiu.wang@nxp.com, timur@kernel.org, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/RFT PATCH] Revert "ASoC: fsl_esai: ETDR and TX0~5 registers
 are non volatile"
Message-ID: <20190607111244.GE2456@sirena.org.uk>
References: <20190606230105.4385-1-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cnnC1+vf4lqgEF19"
Content-Disposition: inline
In-Reply-To: <20190606230105.4385-1-nicoleotsuka@gmail.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cnnC1+vf4lqgEF19
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2019 at 04:01:05PM -0700, Nicolin Chen wrote:
> This reverts commit 8973112aa41b8ad956a5b47f2fe17bc2a5cf2645.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

> 1) Though ETDR and TX0~5 are not volatile but write-only registers,
>    they should not be cached either. According to the definition of
>    "volatile_reg", one should be put in the volatile list if it can
>    not be cached.

There's no problem with caching write only registers, having a cache
allows one to do read/modify/write cycles on them and can help with
debugging.  The original reason we had cache code in ASoC was for write
only devices.

--cnnC1+vf4lqgEF19
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz6RqkACgkQJNaLcl1U
h9Co7Qf7Bkg3ndyaPGB0nY7y53/txpehf1drjHOKGiWoZ0+zJMVKS1VxMRflVs5s
/jl1lph0ebC8gfz/UipI3j7ZrLPd1tRsasfmuIpa4aDTAd5h3ekJe2uMHyxDiATf
+riYjRV5ZiBQ5EFVZQN2j9VMvtJGfaLsDD6Wkc4laIvAevPThDKrs5YLyiH/ncrn
q1RktO/C3gfdAuUd0x0oGbHOlpXuMw8AaT0I6NNonOM5GlLqDq0jUw9Or/WdOepk
UMskpFmlTMYNm9AcJGvZ2JemvZ+fYCZUs+1nU2h6+MgEBIs1DqvdYagwnFXb4K1J
ZkaAUBJ2IdDf+r2aYfr+BVFEUIjuPA==
=AgxG
-----END PGP SIGNATURE-----

--cnnC1+vf4lqgEF19--
