Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B21C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 387DA2084B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 04:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554180783;
	bh=uhFhU7e7eLrsDLP745Vh64U2pEvje6X/UG/b6jmjiO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hNN97QFC8vox5ayAxrO6xqhDNVp1RDMK1Tz9kfLpVpX4mw+F4Epvn17xC2N4LYonu
	 VGXjLNRUP0xT3TyMBk58vLWgaj8queWRFj8IFfbk2rgsmUezm6ujCWV9OT8z9yPPFh
	 oL/Tc3+SD80JUIP7rwgyeKSF1zk0WOmE00zFIGcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfDBExB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 00:53:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:40544 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 00:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uhFhU7e7eLrsDLP745Vh64U2pEvje6X/UG/b6jmjiO0=; b=CWkXE7IF6XjYb8jOtyJC/DIgf
        igmg1UyNU2dvTiYd4WsM/tcGLF9RGU5urmc7dRya/VSnU1NxosPd4EElk1I+2aHZgdALPfvhypo63
        zY8ytuqXj18LM/xYcOnn/NxtfSKjEO27W70bSytq8jT8XuaFHsjhuQXyLf1gbpI1WsNDM=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBPs-0005nP-Eb; Tue, 02 Apr 2019 04:52:56 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 1F3BF440082; Tue,  2 Apr 2019 05:52:53 +0100 (BST)
Date:   Tue, 2 Apr 2019 11:52:52 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Message-ID: <20190402045252.GT2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
 <20190401074940.GL2059@sirena.org.uk>
 <BYAPR12MB33984E9D0FA76FCC77FD72BFC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33984E9D0FA76FCC77FD72BFC2550@BYAPR12MB3398.namprd12.prod.outlook.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 06:07:45PM +0000, Sowjanya Komatineni wrote:

> I see you have applied some patches in V1 series so should I re-send
> again those as well along with feedback changes in next version or
> just only the patches that are not applied.

Please don't resend already applied patches.

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi6qQACgkQJNaLcl1U
h9BCGAf+NYRxMnW6ONYZmV4FftAloNGPGnqTBpiG/qRhwbHgasyY1onIMglKaEK/
qM9LLV2fropNwrQmgaHMVYEcDctSL0c/e4qAsCYAil7MQE1GcZPhlWAMmhb53QhC
HhYm4GU7V7pEUaC2qcWA8XaZu4vFXHmdnn9igjs9+EI+cS7E4ZczdXI93DgmOHYJ
5lbvGAOaSYMjtcmiLgZs2TF7PNb3XedhyLvSZsnGHbNuHQzujFiaMlj/Za00bGuu
M//ZznUdHmZb+aajej+dHPUdlw7GL1C4vDIjKi33mLGB2B9Q78JNWtXCDTEasrur
VzbJiZ2onLGxcdvoLAxmGhcHsajbNA==
=K83W
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--
