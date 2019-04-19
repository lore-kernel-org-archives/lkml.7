Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F5C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B45222AF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698106;
	bh=cnrGWA+ez/LVxbvxaSo+JN56JsmoxBmA38W/daBIKss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uw5fnpW1wIGuwfrdgCMlKDnw2dXsfeHRXsuqyGp7va6LSVql0bFW3m64p/gUyBsVS
	 O6czy3U3eAxFcQy78L7LlF7HCeN9eON8Z6/qzbwlnEs6z31MaUo8sVETVii+atvRC4
	 vr4nNy7Y6fjZGvkle6B9p/wpwaTQMv1I6MJyUNY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfDSSVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:21:44 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38528 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbfDSSVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XG8zAcN/Cdib2jKfVHm3MDgQxp0vn5cRdxCvErmhPxo=; b=lPcOCrrQG/9tpNtFqLHxtdrVN
        mb67sKYJQFy5ANW24x4Ccz4QR8e7AV9piCpIbcKgDYbOUoKIaUiSwVGXFISviJFTShYc6KftMznTM
        iWC1XCiOwvTlC3CoiqxVnL1FhRSfXtB2Sw34Njl8RSrfFyAoVMjh+FjnWqzo+P6UmQPhg=;
Received: from 188.29.164.213.threembb.co.uk ([188.29.164.213] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hHVHV-0008Fv-OF; Fri, 19 Apr 2019 15:18:25 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 575F0441D3B; Fri, 19 Apr 2019 16:18:23 +0100 (BST)
Date:   Fri, 19 Apr 2019 16:18:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 5/9] spi: export spi core function spi_set_cs
Message-ID: <20190419151823.GS2803@sirena.org.uk>
References: <1555363834-32155-1-git-send-email-skomatineni@nvidia.com>
 <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QHhm1I6mwQR20oIa"
Content-Disposition: inline
In-Reply-To: <1555363834-32155-6-git-send-email-skomatineni@nvidia.com>
X-Cookie: Shah, shah!  Ayatollah you so!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QHhm1I6mwQR20oIa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2019 at 02:30:30PM -0700, Sowjanya Komatineni wrote:
> This patch exports spi_set_cs of the spi core to allow SPI masters
> to use when gpio based chip select is needed.

This isn't really what I meant when I said it'd be good to use the core
GPIO code - this function doesn't do a huge amount really and the usage
of it in your subsequent patch for the driver isn't exactly joined up
with the little it does (which is mainly swapping in the GPIO chip
select instead of the hardware chip select) isn't used in your driver
usage of this as far as I can see.  The bulk of the chip select handling
code in the core is actually in transfer_one_message() which your driver
doesn't use as it's got it's own implementation of that; I've not looked
in enough detail to figure out if it could use it.

--QHhm1I6mwQR20oIa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAly55r4ACgkQJNaLcl1U
h9ABFQf/di4BhVkLLzj0LzAWfq+W3aQXLwjMllikpbSVi4yBAjMMBCiY/hJ694sK
t74oXpOBl1I+nU8XTCCo2UQgwEkIg5nVLHQJqoALeiqtM8W26w9xCeN4I3skqA1m
lftMW84AiOm3Rj8FXw62w8WvnugSHO5D+YMbL1DHlltQw2RBM0K6mVrENcuCu+eZ
3BVN3SzoKeuWgJV0HrZhFklXSPjbYUHKlWESz2gNukz9mmP7O+IPPAx6YJ5qbQac
Ek1vYs20B7Ldl3EmbRDIdoiiiPssmHNAqT7wiG+WDrehx2f4SF2LTEHQknLypBim
/NexZZx63UoROPuN2ifzuZSjJT2bZQ==
=bYUd
-----END PGP SIGNATURE-----

--QHhm1I6mwQR20oIa--
