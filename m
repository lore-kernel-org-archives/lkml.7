Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9381C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 858912183F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554107222;
	bh=qPh2ZaG2h67L4XBGeKMZeUs1Vfbf7HU3dPV6VbtRk30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hbAGabrMvjTasMgZ0FzAqCA4IyvLBroIki28Hrw5etmMjIKTYoyQoJl1shk6a7GpC
	 4h5obMQTFhkFvcNBEl7HXnYwDpqkwTFSSXDcSHlKmqYPzJ7JKr2VUR7YbwIGeY6dBf
	 Q/BT1uUYBnmv/7dYvgtJmVhuI2oqWlaw/Ea6Nmjc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732115AbfDAI1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:27:01 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43408 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDAI1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qPh2ZaG2h67L4XBGeKMZeUs1Vfbf7HU3dPV6VbtRk30=; b=BmlgbtmerOaBX1rJgqUeQpuRM
        qAecf/uj+aE/I4Mqce8cPE1SsmtpQt8JKuc1lauJczFJXItxBajounoSYp1vweDNEVAv04JjR4luE
        7rtDGH+3JzFKkZvbKn21D863fgbXEHJjRcB6auLAMrtWRISBzYzJClJZed7UA7PlOdtCE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hAsHP-0008IB-KY; Mon, 01 Apr 2019 08:26:55 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 27FBC440082; Mon,  1 Apr 2019 09:26:52 +0100 (BST)
Date:   Mon, 1 Apr 2019 15:26:52 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V1 05/26] spi: tegra114: use unpacked mode for below 4
 byte transfers
Message-ID: <20190401082652.GO2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Content-Disposition: inline
In-Reply-To: <1553666207-11414-5-git-send-email-skomatineni@nvidia.com>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 10:56:26PM -0700, Sowjanya Komatineni wrote:
> Fixes: use unpacked mode when transfer length is less than 4 bytes.
>=20
> Packed mode expects minimum transfer length of 4 bytes.

This doesn't apply against current code, please check and resend.

Applying: spi: tegra114: use unpacked mode for below 4 byte transfers
error: sha1 information is lacking or useless (drivers/spi/spi-tegra114.c).
error: could not build fake ancestor

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhy0sACgkQJNaLcl1U
h9BhDAf/YzC68CrCyTEHb0zYa6sYLWL4GsIiNvJeg+VaT2fxEqki1YlIGVaWux99
unPjxHCA29RjgY/n9HSV7LUquaEa9ewtfF6j8XFNHeseSJHqNpjP6mX0ULNHa6mJ
OqMDD0ylTHEDFsd2thdgLTd2+sz+/bAIY+46otC/OqsM3r1CI1iiPHKAuD7l0eOF
WDfPcAemcwTPOjZObqUBIblIThEZ8yF0r4PKFsIktFdXDWJxJJastthlsCLJiLg7
x8R1wAYUqpLUNwtjlO9pmYfupGw2y1TOtU/Ke5lR44dtwijcfrRbr86nL95PYV54
3pTsoGn6AL1iLQfbsxsvFUgQAeSHaA==
=yHR5
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--
