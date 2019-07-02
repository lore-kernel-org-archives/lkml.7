Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43289C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC962064B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562075797;
	bh=UxFBcUgdQ2MnSSCxNKZ4FC7b6asPEDWx2T4Ad1T7Q9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MsmCRpDGh9fD6AXkLqjAN+RVsxRErQHHtGUZSkA2igiJi1TAocgo7nbsnB/SdBFKo
	 WUm+UagFf+DP2IBX3+Uq5RfJg4uKdr085KemFjnF3hvRGavYMcgirdEeDq2J7s9ecX
	 KzRw/OHzP1f5ZDrrbeGgi7FmP2Bh5XaEKjyjPaOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfGBN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 09:56:36 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:42484 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGBN4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 09:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=T1Q+VpjeyZlNwEne8y2hkSC/ONhFvAnTgrUVHUcvIzs=; b=G79xDe25sJCl45zOekFuPBjnt
        GqdZyzwaiLr85kK4dh8LqQTVB7e5AqFw2fVMWHzVZ8DZypcnZ5naOuiEI9FUHFbvjzpdCMtBeR3kl
        w8kgxFZ3IJ9qkZS48xWxqTIzbVoKPKTFfckvg4msXfxxdM4fGW5mSq3HqfEUwim6s87/o=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=finisterre.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hiJG6-0002Sq-BT; Tue, 02 Jul 2019 13:55:46 +0000
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
        id B7978440046; Tue,  2 Jul 2019 14:55:45 +0100 (BST)
Date:   Tue, 2 Jul 2019 14:55:45 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        dgreid@chromium.org, cychiang@chromium.org
Subject: Re: [PATCH v6] ASoC: max98090: remove 24-bit format support if RJ is
 0
Message-ID: <20190702135545.GN2793@sirena.org.uk>
References: <20190618022411.208156-1-yuhsuan@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4OpS+d6oOtUQaRm1"
Content-Disposition: inline
In-Reply-To: <20190618022411.208156-1-yuhsuan@chromium.org>
X-Cookie: This sentence no verb.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4OpS+d6oOtUQaRm1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 18, 2019 at 10:24:11AM +0800, Yu-Hsuan Hsu wrote:

> +	/*
> +	 * When TDM = 0, remove 24-bit format support if it is not in right
> +	 * justified mode.
> +	 */
> +	if ((fmt & SND_SOC_DAIFMT_FORMAT_MASK) != SND_SOC_DAIFMT_RIGHT_J &&
> +			!max98090->tdm_slots)
> +		substream->runtime->hw.formats &= ~SNDRV_PCM_FMTBIT_S24_LE;

Why do this and not add a constraint (which doesn't modify any
constant data structures)?

--4OpS+d6oOtUQaRm1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0bYmAACgkQJNaLcl1U
h9DMTgf+PYAum94WJNy/d7fNa5ky+hsLP7iR/oIMWfHTiiNRsNfXCy/3qjz3HleI
B+VON17KVufcU6Yi6GhITx/05AB2mbtk15C8fgFrOFv+GN/bP0jklpx05wo07q81
REn5TG8B3YDD14t1akxcZxdrc63/gIHMZTuZ56g1GRTNeTEd7F3/Vyz/G2p0Csgi
V4DAb54G1b17MrAre6LG9So1NWcUQT3i/rmSIy60AswQK2Za55P2j2UHNySFpby7
I4jL4ujieJ2L3Mb8AE/U49ioJ2YIGp481ABjMxJPB3cYE/BKVZ96WzKCnCDFa9jW
RxxZhCWx051gBV63t6mJ6/UzZESDgw==
=1nES
-----END PGP SIGNATURE-----

--4OpS+d6oOtUQaRm1--
