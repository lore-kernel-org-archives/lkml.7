Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C61C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C58D221530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 08:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557303246;
	bh=fRKiyFebGzfQ/OXZXnDZabcN2Du8hX+UbvT5OhOU7g0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XyqdpyL4lmeo8dATBIMuQls1pDxCfhyKWIrdyerCTm2vJKKQ7bMaQI1eSnqA/t8ux
	 4FnSTi+3r5MbXfwOruDhh5mjXHqOsj9hhgBh/RHyoIRD7eumMjbFvcNZdDbJ+GwG+h
	 TfmIl3VWFGv56rMIrr4BT/cAUjO29tRBmO9yHXX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfEHIOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 04:14:05 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49486 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfEHIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 04:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fRKiyFebGzfQ/OXZXnDZabcN2Du8hX+UbvT5OhOU7g0=; b=FMLuyCucBR/G6C0wsxjsJJ83s
        dwTxUjz7/UE1a175DopdeINPjBv0ld/WJD6qzVGR0L/k2mmBKSIvh3gbGm/GluAlms+FipbBP7zqa
        jTvlpiDO3nydFnr8H0lYUsKvxWKD4PP1Oi+DtcrVN4PUXZQrrpmCJUnz4aRHkBkB3l5kM=;
Received: from [61.199.190.11] (helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hOHiD-0007RX-PC; Wed, 08 May 2019 08:14:02 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 5B682440017; Wed,  8 May 2019 08:57:06 +0100 (BST)
Date:   Wed, 8 May 2019 16:57:06 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/6] soc/tegra: regulators: Add regulators coupler
 for Tegra20
Message-ID: <20190508075706.GW14916@sirena.org.uk>
References: <20190414175939.12368-1-digetx@gmail.com>
 <20190414175939.12368-6-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="C5xVAVv//s0yeCuO"
Content-Disposition: inline
In-Reply-To: <20190414175939.12368-6-digetx@gmail.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C5xVAVv//s0yeCuO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 14, 2019 at 08:59:38PM +0300, Dmitry Osipenko wrote:
> Add regulators coupler for Tegra20 SoC's that performs voltage balancing
> of a coupled regulators and thus provides voltage scaling functionality.

Can you say what the rules that this is trying to follow are?

--C5xVAVv//s0yeCuO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSi9EACgkQJNaLcl1U
h9C3tAf/QEVkD4x9OPyNW8VAmP3XAF31JINw2pe4GGSAcKlq0ebDjdirVhY2OFQS
YQvYFLQUajlYkWxFhmGAKzbR3PxZsAegrSGE6kNqPmKdCsHoj4g2qmDfRZ5kR2nf
tD3xT81kBZaATyOm0DLVm5z7B3t6V3udOLSGDgn9KFV+JUG3ZN0DyV902fh2jA8I
+rMYdwGUHCQGPTyy8voDKWlyKQ7eNOUsUT7hsJevbUwW2lEa71R5mw2c/gld9boR
MCdXQxB6nGoGY8VZUx46dbTvUFo0X6aw6S7bu/hv+SM21KeFnLZV958JBcuAvSlF
y1hDjuZzE52CeJEhfAtgnX3I0VvuAg==
=E32Z
-----END PGP SIGNATURE-----

--C5xVAVv//s0yeCuO--
