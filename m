Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F15C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7733206CD
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 10:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570791012;
	bh=+GYaGvn6aQG4ujRHeTb1+lopvEhjRcfgUQWj4NEdRZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nVZzhxNMOSkuMdNt6pO+WBAV5TPXzdQFfVg1nwusySTJMroQcMQ89dWzfi5ZkXPS9
	 UCa/XuCRGzGVFF+qW9BCtZH7P9QUHtoK/8Dzy6jpTwjktT/3I0llihWsBQJr7D3a7x
	 6LTL5QdBa0QkoOoio7Onc4ppYTLX2kZJkNnWT3ws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfJKKuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 06:50:12 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46162 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbfJKKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 06:50:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+GYaGvn6aQG4ujRHeTb1+lopvEhjRcfgUQWj4NEdRZ0=; b=oFF+nMW8ULTocBKQP7Rg0G0OD
        ULnpmBNgzEV4j+EqDbOV/8Kdzb2mh5FWrQeFQm7wEwX6fdvC1FsK8ujWRciwYHXfBbq3oXwwe+HGq
        Baau7aDhUJjlC4PE6unDctPMCzjGx3HIrkGX42kkWsJ45W2xe8WLLJQIaNMl1O16Npsb0=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1iIsUk-0005Sr-Uf; Fri, 11 Oct 2019 10:50:03 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 3111DD0019E; Fri, 11 Oct 2019 11:50:01 +0100 (BST)
Date:   Fri, 11 Oct 2019 11:50:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linus.walleij@linaro.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/36] ASoC: samsung: s3c2412-i2s: avoid hardcoded
 S3C2410_PA_IIS
Message-ID: <20191011105001.GG4741@sirena.org.uk>
References: <20191010202802.1132272-1-arnd@arndb.de>
 <20191010203043.1241612-1-arnd@arndb.de>
 <20191010203043.1241612-20-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rV8arf8D5Dod9UkK"
Content-Disposition: inline
In-Reply-To: <20191010203043.1241612-20-arnd@arndb.de>
X-Cookie: Void where prohibited by law.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rV8arf8D5Dod9UkK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 10, 2019 at 10:30:04PM +0200, Arnd Bergmann wrote:
> The constant requires indirectly including a machine header file,
> but it's not actually used any more since commit 87b132bc0315 ("ASoC:
> samsung: s3c24{xx,12}-i2s: port to use generic dmaengine API"), so
> remove it completely.

Acked-by: Mark Brown <broonie@kernel.org>

--rV8arf8D5Dod9UkK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2gXlgACgkQJNaLcl1U
h9DRDwf/Z97B2zjL3Z9O+QU4Fp9jlers2KrllaRLXhvKAvYYwb8JNWOGuedCmQDi
C6Gj9aBSXHmzjjFCM08/QJMG8u6TcM5H2gCjEVFOiRCMqP5DPX5qCIiiQ0SnBrdi
G78NJlKJRTR9kLnVYFd8DRx4fOHelhaH0X7n5EPUliwMpydcV81iL9zttP39m5+h
bTSe5rNrUxE6oNaq/1Ud7YFogrTUUSHQugLgRHDwsGakNFIYpP7HYvd9lYfAlX0C
dz+DUqy/Yq8FJMN3SUlsUyNx3X1LVOkKbKCiKbcwoYIaXy+YyNCPAja8eRtrWVZU
tdnsAgWDN5OszUmItgS481uI9UwV6Q==
=6yUg
-----END PGP SIGNATURE-----

--rV8arf8D5Dod9UkK--
