Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BB7C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 879BC20866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559758641;
	bh=oQSDbPM28eexxs4+IqmMDN5zUHY3oU/4zuE5cja3U8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y88dpmDjz0b25aN2h59phwQZqLFK82Gf+8nzgoHv2Z2z3XwEP+jgLxJsSPGVaIdcT
	 ET+EY8hAUmIgn/j2xYXCz1F2J7niF6c+VLcUcW546I+ViG2THvYLUBAP3a6wngsgo4
	 5cGBT+ouJKGW4aeS2p9cDkrXBnFYQPnFCQWY7w9g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbfFESRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:17:20 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:60672 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFESRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oQSDbPM28eexxs4+IqmMDN5zUHY3oU/4zuE5cja3U8I=; b=kpCHFfCHyPKs8Bdkxzte5DcVB
        CKuX9zqYkt2wTz2wLN7dnS3n81wGHNtrkQF+wLxv205sQeoHQFSqleTnUEF8h9XA91ASkP9gn4YSP
        pzB6x+RnsKE47xle3IjAVmiPLuzKTM419tIPtxgkDqo58SrfXJsgqaKUrcIr7iz/odrfY=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hYaTN-00019y-PJ; Wed, 05 Jun 2019 18:17:17 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id 00293440046; Wed,  5 Jun 2019 19:17:16 +0100 (BST)
Date:   Wed, 5 Jun 2019 19:17:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, lgirdwood@gmail.com,
        lee.jones@linaro.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/5] regulator: lm363x: Add support for LM36274
Message-ID: <20190605181716.GU2456@sirena.org.uk>
References: <20190605125634.7042-1-dmurphy@ti.com>
 <20190605125634.7042-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ufiXnXZuEWu9ktD"
Content-Disposition: inline
In-Reply-To: <20190605125634.7042-4-dmurphy@ti.com>
X-Cookie: The other line moves faster.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7ufiXnXZuEWu9ktD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2019 at 07:56:32AM -0500, Dan Murphy wrote:
> Adding regulator support for the LM36274 backlight driver.
> This device can leverage this existing code as the functionality
> and registers are common enough between the LM36274 and the LM363x
> series of devices.

Acked-by: Mark Brown <broonie@kernel.org>

--7ufiXnXZuEWu9ktD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4BysACgkQJNaLcl1U
h9DoDgf/V2YC33j5Ud0esBDnPNRS3+xH3Zlc2kDXFTiDgjx06hmzU/n0qd1r9683
6rsudqA2fn5Em4kP85w6xlwQFYJNYBq9D5C0wOm+OMTSy5Q2OuCjutVZNEPILUds
dOGi9PL6v9MtvgpOrB0HaUaABqwHZ2AQMIXCHIpPDQceulf3dohTO03dFjwHHd88
ZUUsnDr3zWlK7lbA86ud5tutOc5mxq/23W47hdu9C4nAXnQkU7iuHLCNTcbjOHhg
mB6ba7BCxUCXKLpN5ZpROEBkcclPpZHN3efh0OKGc8rlkJ9/yORL5rnI5rnDQr+C
Azr2Sw57XsTCbxqsbYSEIhzjQVcCNw==
=TvzC
-----END PGP SIGNATURE-----

--7ufiXnXZuEWu9ktD--
