Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD87C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DCE2186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 08:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555057768;
	bh=m95wPZoMShtbT0j117e4kcWLfFrCNmJj879lVNXhBh0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJ8AybZ8k6fRwiYqaLBMWaeQqyHvn9O2ZRzrRrbmY5BRThcmgodK8oKHSUShzHTdR
	 YlaUFnFj2pEds1Jgmq48Znr8oqP7i1J9LsP7xryGVNsAi8Eq8kL70In7drNGGw1j1Y
	 +hoKvRfnHT31d8HZxTtXj2SBjrniiaPBwYFBltSc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfDLI31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 04:29:27 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56412 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbfDLI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 04:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YQl2xlGDNjmPg52cOvHRm7U2++/LqJE8cGLpMQpXjJU=; b=rJEHdL5EpUVRauJ+cJ7odccO3
        LBVT2MeeupjSFlcPiipWM5K3UDqnPCoaawqbrcfh0QaHK0KNTwxcCwAKUA6tthfm+a5WXeqlmxtss
        AGxIbNrmt26cKU7OcAfhlcNH/86NC5L+jOU//EThZUAqi/cH+VJ32iJQazG84OjZYfdf0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hErYl-00065n-T7; Fri, 12 Apr 2019 08:29:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id CF5491127945; Fri, 12 Apr 2019 09:29:13 +0100 (BST)
Date:   Fri, 12 Apr 2019 09:29:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] spi: SPI bus multiplexer
Message-ID: <20190412082913.GA6909@sirena.org.uk>
References: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20190412050213.17698-1-chris.packham@alliedtelesis.co.nz>
X-Cookie: Your present plans will be successful.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2019 at 05:02:10PM +1200, Chris Packham wrote:

> Unfortunately recent changes have stopped my hacks from working. I've
> tried adapting cs-gpios to work with my particular hardware but I came
> to the realisation that the current cs-gpios support assumes a 1:1
> mapping of gpio to SPI device whereas my hardware used the state of the
> gpio selecting the device i.e. a 1:2 mapping.

> This is my attempt to implement a driver to deal with this. One nice
> property is that it is pretty much self contained. The only change to
> the core SPI infrastructure is exposing a function I needed to lookup
> the spi_controller instance.

Why not implement the device that demuxes the GPIOs you're using for
chip select as a GPIO controller?  Presumably it might get used for
things other than chip selects.

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlywTFYACgkQJNaLcl1U
h9BDOgf+IcHAaeWBs4Mx2UtTah7O0uKNJnMfEXCcEao8tcgoRcqci45sx2Nr76JE
1qsM5/xGOsIBAnrP6saJ4hsY+oVuebCI/WOyy9VGgwSTYEtZCkObtVGxphM9aesN
3/gIVxrga7JjARBZB71csTJ9CuzdBDMCQA44qfjbbrMv40WIX/OSvMMrG7+IGCqp
cvYZ5Wh6gUjdoW1Bz795QnAxsmjJFrctcDYu7tSNBk92M5r+972l/27eDwjRnjKG
xRj05HYDartmd4aSaiYIm/hjFYwb7Uc7oR2SFYa+5vZF6N/yjRuSL2AqSueEvp6y
epJnfXiXFUSaDvAJRu/O22f97jHwbA==
=1YqJ
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
