Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBDDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C6E214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566912888;
	bh=JUTyWwX2ET5pcAqmDZd9yiuKVN2SmCNm8sEP12RzMMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5QAJvdat2dIxMhAaeCWFmGFtjYcch7XqnHm3viSzNXwxGhNHsDxljNc6X2O/9TXG
	 NBSahPs+v6kKDg7rB+Mo+d/OmlWsy6ekavIXiWvDDKMf+3tbb/j+9R6xli1pWJCSIr
	 1BiZ5LF9Z9D5c1D5u5GY3x0UvncbSc7OgExQ1tFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfH0Ner (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0Ner (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:34:47 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96FD420828;
        Tue, 27 Aug 2019 13:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566912886;
        bh=JUTyWwX2ET5pcAqmDZd9yiuKVN2SmCNm8sEP12RzMMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W8ZvR5DOjP38DXOaIx0j7myXAl5RgAQIqWTAFcW9XrI6yxAULG4QtZbJ00ES1PtER
         0IuAUFyISZy/h9ClfTor1novhWyk4vkJPnoMSOET1v3C+MutUZDXG8jrEcjoUM4EX5
         QdPdAZBYQ45xuf4Ibd0L1LDj/JdnCbt+yZMwUXI4=
Date:   Tue, 27 Aug 2019 15:34:43 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Ondrej Jirman <megous@megous.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: pine64-plus: Add PHY
 regulator delay
Message-ID: <20190827133443.fdxl5wjmgkerc3uh@flea>
References: <20190825130336.14154-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hjrahydg6q3alewh"
Content-Disposition: inline
In-Reply-To: <20190825130336.14154-1-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hjrahydg6q3alewh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 25, 2019 at 03:03:36PM +0200, Jernej Skrabec wrote:
> Depending on kernel and bootloader configuration, it's possible that
> Realtek ethernet PHY isn't powered on properly. It needs some time
> before it can be used.
>
> Fix that by adding 100ms ramp delay to regulator responsible for
> powering PHY.
>
> Fixes: 94dcfdc77fc5 ("arm64: allwinner: pine64-plus: Enable dwmac-sun8i")
> Suggested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

How was that delay found?

It should at least have a comment explaining why it's there.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hjrahydg6q3alewh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXWUxcwAKCRDj7w1vZxhR
xQcDAP9PcjmKcemio5RyGsvXfmaqZINOqCwOKsTiONK54RVLbQEAgaFOmHxFyHfJ
oQcsq82EY17PkSDieqvgY9JWjjbwrgo=
=kJyJ
-----END PGP SIGNATURE-----

--hjrahydg6q3alewh--
