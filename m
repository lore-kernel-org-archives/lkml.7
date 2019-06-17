Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905C8C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631432084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560789027;
	bh=m6RYecpngTHw4Rm0MCTvwaF39j5i9+FmddkjoWvFW7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UvTdgE0267LLK7orqbZqzjtavbeFVcSO7SoK0sWOZ63Y0H2VpkqrBj4ADFYYKN7kR
	 EMA13bszm+DRNyzujSO0n1/zCknLxSqVMvKkheyLr6+6JIz8qbHCvdOyGEwS6IUoB1
	 4JfH+Q9xKZtjNncoYPuD4BnLsL3vraAzoKQaEv54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbfFQQa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 12:30:26 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:49428 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbfFQQaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 12:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=m6RYecpngTHw4Rm0MCTvwaF39j5i9+FmddkjoWvFW7k=; b=sT9eOAtGOlZHSQkmkPu7dYtsM
        r9S43wR5IjDSz6lLdC6OnU3UMS92Gc6/q2uO3+jIps9CEdpX+F2N5kdNSZRGJPYoY4Bh5mD115MPV
        4O7NUbksBSx5rg0XmFXg1rRmCbkQapxcgJyl0bM7VpJmIkpJHXciSDZXaHujYD9ueTmfo=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hcuWO-0002AW-GS; Mon, 17 Jun 2019 16:30:16 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B8DC5440046; Mon, 17 Jun 2019 17:30:15 +0100 (BST)
Date:   Mon, 17 Jun 2019 17:30:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lee.jones@linaro.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        afaerber@suse.de, linux-actions@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.liau@actions-semi.com,
        devicetree@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 3/4] regulator: Add regulator driver for ATC260x PMICs
Message-ID: <20190617163015.GD5316@sirena.org.uk>
References: <20190617155011.15376-1-manivannan.sadhasivam@linaro.org>
 <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ROA1rv1+fHr2QGor"
Content-Disposition: inline
In-Reply-To: <20190617155011.15376-4-manivannan.sadhasivam@linaro.org>
X-Cookie: Editing is a rewording activity.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ROA1rv1+fHr2QGor
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 09:20:10PM +0530, Manivannan Sadhasivam wrote:

> +++ b/drivers/regulator/atc260x-regulator.c
> @@ -0,0 +1,389 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Regulator driver for ATC260x PMICs

Please make the entire comment a C++ one so this looks more intentional.

> + * Copyright (C) 2019 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

You definitely didn't assign copyright to your employer?

--ROA1rv1+fHr2QGor
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0HwBYACgkQJNaLcl1U
h9AlQgf/cOduPIgVfw037hso/F8J/DY12ynhZ3O7IPyWtiaUIazr9Y3zB2dch0EH
mMdmUFiGT9ijRDAj2tlkLGAKfsD+/4pfGnxaTLL/unOM7uvWHLcT4j1L0eo2FGEa
nARIZZng3pZnEp/Yo3E/DzMJGNKxQ+NCYEnkClzI4Je9Kg/SB0vKijbMEMkstH9v
RfEclPCayi30RQ/cbRv7YUbDBc7GMD2JRVBn4Xv+hVLszHqTbJa/RZ/cJADQS3uZ
KmWHEHurfwYJIX314fbjiBCcHNWfZQ0kiFZsHNJGYmxwKHZiPg9DyQSh5Zk9s41l
mKfXniiw5dpGYEgsDok3f/gEh10XgA==
=bXNF
-----END PGP SIGNATURE-----

--ROA1rv1+fHr2QGor--
