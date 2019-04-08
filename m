Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C7DC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C342920833
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 06:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554705494;
	bh=Qu6mnxqqBtIme/zBAQvrAE1CcvSqBi7aYLihPI0Z2ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dw4IBOFoOzK676PLuJqYDAnP3Q4o1/dL6Us1hCF2/O4KM3Xi4TeY3V9BVpgayadVV
	 V0xv+3PBVR+ueW0z+2aDQoilXUXsO8xe6ie5wvXtOc2Z3bgXS2kau7j3DrT03LM9ou
	 0dGxgFGUzyuTadu1zcQyxco6n5zCoj/tkCtG16jA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726577AbfDHGiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 02:38:08 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37326 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfDHGiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 02:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=iA/NMGYDBzquW7qMdFvBWFDWZIUMk2wtm9yIs5TCGd0=; b=aCu4R9FKOv+i84QJhN+z2qrFz
        rqYQs+SoFPARS7UdPYoY46bQrFScYloim027RJlVf7tGpG4mQBTmU5fOLLzsKN77EuTAHojOi+vlc
        sp3g1BfEHReI8YaRXcvmAupwIRjfl9ltMzXXGkYwO4XN/5B8UznyrfjUcbTgXwzn7Xk0E=;
Received: from [8.46.76.46] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hDNuq-0003ee-9J; Mon, 08 Apr 2019 06:38:01 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 42F79441D58; Mon,  8 Apr 2019 13:30:22 +0700 (+07)
Date:   Mon, 8 Apr 2019 13:30:22 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V2 14/20] spi: tegra114: add support for gpio based cs
Message-ID: <20190408063022.GK2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-14-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Content-Disposition: inline
In-Reply-To: <1554423259-26056-14-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:13PM -0700, Sowjanya Komatineni wrote:

> +		if (cstate->cs_gpio_valid) {
> +			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
> +
> +			gpio_set_value(spi->cs_gpio, val);
> +		}

This is adding new usage of the numbered GPIO interface but we're in the
process of trying to transition to GPIO descriptors.  Please update this
patch to use descriptors instead.

Please also investigate if it's possible to use the core GPIO chip
select support more.

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6n0ACgkQJNaLcl1U
h9BcSAf+P79lHEqMrW7XuwAWcgHftZesiNc2uJiGMhLmSXW5FIZB0YnxdsMJq9Fk
9oml5tF0sZSunCU5fbZvsVmtvsdfLhf03Qpbi+wvG9Z+OR1IUHwrIRx60nhHBirr
aHqKNt3cJPQX/cNEvJ+v3LAuwe0Y5GB6wrjGbmWsoUFqFd65wzITOm1s6yzJAbN8
w+FQ0n3BnWLi5nk5tjsYUtd55Ha1Q5PFjN1u1G7tw1TJBqAmoWT5XfgSmcaEOQG+
loIcH0KURFQ3rKw6BYGofntwLzaFGGOkAw1HunyW6zJyoRGu4CBFI7R5FyZwXg1W
RU5GmuMxu0im7Vx+Axhh5E0tOu8ucg==
=NNIA
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
