Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB248C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D3221582
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576691435;
	bh=zdbUHt5x8PH/epSF7/R3TjGuK6ls0Cr8YzTB4vubwYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k0o71T3vt0VThsdqvoiI+ETwnzl372k17yuah06uH6M7nYiHOips2FBu3TPRfu8tk
	 H2+HepxeO0zLEOK7bCMUSWVl2dNhJJvTbZrCH8aM51p5NZ4t21koAUcRbxDYR1QB1k
	 n4zm4Eibg7gTHgJ0T9tSVXR70DPiwT5B65tNuYWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLRRuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:50:35 -0500
Received: from foss.arm.com ([217.140.110.172]:55570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbfLRRue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:50:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1309B1FB;
        Wed, 18 Dec 2019 09:50:34 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 856C13F67D;
        Wed, 18 Dec 2019 09:50:33 -0800 (PST)
Date:   Wed, 18 Dec 2019 17:50:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/4] ASoC: meson: axg-fifo: add fifo depth to the
 bindings documentation
Message-ID: <20191218175031.GM3219@sirena.org.uk>
References: <20191218172420.1199117-1-jbrunet@baylibre.com>
 <20191218172420.1199117-3-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KSyhVCl2eeZHT0Rn"
Content-Disposition: inline
In-Reply-To: <20191218172420.1199117-3-jbrunet@baylibre.com>
X-Cookie: Power is poison.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KSyhVCl2eeZHT0Rn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 18, 2019 at 06:24:18PM +0100, Jerome Brunet wrote:

> Add a new property with the depth of the fifo in bytes. This is useful
> since some instance of the fifo, even on the same SoC, may have different
> depth. The depth is useful is set some parameters of the fifo.

Can't we figure this out from the compatible strings?  They look SoC
specific (which is good).  That means we don't need to add new
properties for each quirk that separates the variants.

--KSyhVCl2eeZHT0Rn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl36ZucACgkQJNaLcl1U
h9DwRAf/XO9oHDzn1VThOJNKz5nrgTjAgtf51hmSYc2qC4bFBEPQmKXHTQJwgxhC
7Q+4EV0qC+zkHdnDBl9RM5HgwVFirK2Bq106WvVMJizoEWf0D5B2C8vp8vMhCOXA
yquL9sijTzs79Z2+/wM05/OaaQ+nrKBZpBv6IOGYYkgZ+z4x7Jp8HQ9EhPW25EsU
am8nea9rtuvWkEDskXQ541gQw38hPicim+pS37hD/BzhTstwLpU7LqnyyFq6O+OE
ZtatzXOFXvOohYrOK4yGFUnT74rg6wE6shFbq3E4NNwnRtwh9TCCpUjS43JrNOZT
DJ6vG/tnjzlofd9ok9LwVvNZ2d4xQg==
=9adF
-----END PGP SIGNATURE-----

--KSyhVCl2eeZHT0Rn--
