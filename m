Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECDC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6492420674
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 05:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554181396;
	bh=NaBNsZS+6p2pBNWrVaQ5XuMVQSChDbj+ftBrjQqeTzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xu0LaDq/B39SHCbg2autmHU/bCA7L2HE31bSK6l/RqrRKqeGIoZt7EriWq9xSduvS
	 wE709ZLXHLy6DNdunA55fYzfeRqHLDqK8m2NwqdKn0PVIQz8UEZNwuVCnL+0UW3X3n
	 hG2vEq2BROQuM7lrtx7bsVt0Wq7xBl/r+YJX6CFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfDBFDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 01:03:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfDBFDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 01:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j7IHpX2GPG5fzUrXw3WYr+TuhDMj45BXnkN5xylkgek=; b=WkOl3so/abOlVoFrT9N+KsfSj
        9zjDH5ZIHEi2QBgNyCJKXkOcfsjFhnHjy36Two3GQz2EUZuCRF5a3/tdNh9XeUntt8h1MUhLFHUbI
        HIji0D3KYcbhkYf+Cnt+pV9rmmKAHc4adGfa9dTyTYAgoSpUN8LTkGe0bSs9/6SknwtEE=;
Received: from [147.50.13.10] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hBBZH-0005oA-Ub; Tue, 02 Apr 2019 05:02:40 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 33CCC440082; Tue,  2 Apr 2019 06:02:36 +0100 (BST)
Date:   Tue, 2 Apr 2019 12:02:36 +0700
From:   Mark Brown <broonie@kernel.org>
To:     Fletcher Woodruff <fletcherw@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>,
        Bard Liao <bardliao@realtek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/2] ASoC: rt5677: allow multiple interrupt sources
Message-ID: <20190402050236.GV2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mmR5Tf+WJGm+vTLg"
Content-Disposition: inline
In-Reply-To: <20190401205519.34023-1-fletcherw@chromium.org>
X-Cookie: Use extra care when cleaning on stairs.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mmR5Tf+WJGm+vTLg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 01, 2019 at 02:55:18PM -0600, Fletcher Woodruff wrote:
> From: Ben Zhang <benzh@chromium.org>
>=20
> This patch allows headphone plug detect and mic present
> detect to be enabled at the same time. This patch implements
> an irq_chip with irq_domain directly instead of using
> regmap_irq, so that interrupt source line polarities can
> be flipped to support irq sharing.

regmap-irq should support active high/low, and if it doesn't it can't be
a unique thing that only this device wants to implement so the common
code should be improved.

> +	mutex_lock(&rt5677->irq_lock);
> +	/*
> +	 * Loop to handle interrupts until the last i2c read shows no pending
> +	 * irqs. The interrupt line is shared by multiple interrupt sources.
> +	 * After the regmap_read() below, a new interrupt source line may
> +	 * become high before the regmap_write() finishes, so there isn't a
> +	 * rising edge on the shared interrupt line for the new interrupt. Thus,
> +	 * the loop is needed to avoid missing irqs.
> +	 *
> +	 * A safeguard of 20 loops is used to avoid hanging in the irq handler
> +	 * if there is something wrong with the interrupt status update. The
> +	 * interrupt sources here are audio jack plug/unplug events which
> +	 * shouldn't happen at a high frequency for a long period of time.
> +	 * Empirically, more than 3 loops have never been seen.
> +	 */
> +	for (loop =3D 0; loop < 20; loop++) {

This looks unrelated to the polarity of the interupt?

--mmR5Tf+WJGm+vTLg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi7OkACgkQJNaLcl1U
h9Afkwf9FdntMljkuxjoO7lunLTOducb+/sCgTez1Cy1B56H0fZt54s0CAaHFK+9
qmaurcnS5BN4G4nEsLsYuMcgsGnIzUB6cgsg74F1V9YiO61mAieDQyC7WyIFwnPp
SK90F7ZZbbgqepooqtQLtRikLnuPOANRpxH1V44OKuKbsleUCkleJAQ8z7wT9Hnb
bw+b0vYVi6Zu0ylneUhjekCh3ICYwfMW87/pWlKxGWcKGcPMz23jfDHpHz1g1iCp
c2r8Z45+N4vc8/gDsX6g0Pef9MrRPl1IZXS6FuFlXoY+LDt0x/ng5cggaaXYkHi3
v8MhUyHQu7OOI7LS1+AHZ78vKSeKCA==
=k5Nd
-----END PGP SIGNATURE-----

--mmR5Tf+WJGm+vTLg--
