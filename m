Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395A2C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9D52083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 12:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554899108;
	bh=T4HGe+J95iNKzKRzJ7yvC01WJlgqfDGSiYAPUkv21aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KbDyngh0lIWgYMD5l/XuHJnfQpJ5MkyRXUbTbkqZcDzofpVePhT7P1fUZOw8Rx7y6
	 PzvmQ4gAcCEid4U4IqWULogEHbITouGAoxx1zxbKM6T2gXz9tiNVKMX21o4FeOFd/S
	 9GXm4dEsPesbuGB+JGio5WKyNrXwooVK00bUhED8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbfDJMZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 08:25:06 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60592 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731843AbfDJMZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 08:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=UScRJCdVvI9Ty5zncdrGlVcZvM7admZXPK/o32Srltc=; b=QhjloOy0f/ZsODipwZJjxoptD
        g4X3XeOAnRcfya4NZqllqta1QgD8zhuf8BfOGm6gYfgE/3ycsYVuaPaJGg0OQwr45WEiG+qKxtUJm
        v3fJq+nBM2zVZ+zuPqyFyaBaOWWFp4owhNh1lq+2QZXLED0BSt75b+Rii0wyjhscjBiME=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hECHi-0008VP-MQ; Wed, 10 Apr 2019 12:24:58 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id BDACB1128ED2; Wed, 10 Apr 2019 13:24:57 +0100 (BST)
Date:   Wed, 10 Apr 2019 13:24:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, michal.simek@xilinx.com,
        nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v3] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Message-ID: <20190410122457.GP6106@sirena.org.uk>
References: <1554897429-5959-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Content-Disposition: inline
In-Reply-To: <2d9cee19-a776-ad18-b8ac-6d0d1b096ad6@huawei.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 08:22:29PM +0800, YueHaibing wrote:
> On 2019/4/10 19:57, Naga Sureshkumar Relli wrote:

> > +static inline bool spi_mem_default_supports_op(struct spi_mem *mem,
> > +				 const struct spi_mem_op *op);

> Here miss a Function body, right?

Yeah, I'm surprised that builds...

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyt4JgACgkQJNaLcl1U
h9AGvAf/XvkuIdQl1Bjc7+gX1oHtpDMd0YFPPdANYn+UGWHXzXOP3QmvT3oacxsl
bBAr/e5cZ0mJi04HGMcPm+SOFXw1uNkvVtZ9c/HCs/pCVxX3p4S4eDiKbWoxoVA8
WBNee0/MIPhDqXGy/3X8JIgj11WSKMAFzpy/D1AplqgkTswcncFwED7bsFGw+knk
5V3ccPAmcGTX+0cR5Yutgofz2E4nvQsdNM9u7HwsNTZuB5XSVxhOKnK4ya4bw8/6
AyIKtBeV801HJ7TLGZpuYFC6OgO2v/s9nhahFGrwMEPu5xUNtDvqHajYhCbGoVDr
KJhz+3dpLvTbGk7UjN9lcbkbV6EBbQ==
=eX1p
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--
