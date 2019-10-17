Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE633FA3730
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F821848
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 09:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571304485;
	bh=71Gn97Vrnruwg/w4kqqAAh7f+VgYiYJZubzV77QaMxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NMbbncSoG1wLa80aEBLcZCjg3+2tMox60NEi3lEwRvL3uZTdljigs1fPCON7iK76q
	 0QwACBuHnxyJAJ/gZzSZvqSXIQEdl80IOWgSi2kIfD5MbegHMCgTwFP3tWJ7ZR8oLE
	 XAC50XM9PX/WuYpHzkbPIHeNSC5jV6LQ+oRnO434=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408511AbfJQJ2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 05:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbfJQJ2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 05:28:04 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2D3720869;
        Thu, 17 Oct 2019 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571304483;
        bh=71Gn97Vrnruwg/w4kqqAAh7f+VgYiYJZubzV77QaMxQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQhpwzDFsBquCNw5d+S8kTpjuEPeg71p5ObVgjp4ZxTk+OSLm0rVlLn/Zo0I4scSc
         rQauaiEk11f7VlIB0wkdhwDP/qmceaXDUnpUyh9eGx+HkzJ5geqZt3VNhxAb9/6piK
         tXkh5UN3NfoSm4NL/vX5E6uW36F5cY7AegKTljxM=
Date:   Thu, 17 Oct 2019 11:28:00 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab@kernel.org, hverkuil@xs4all.nl, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 5/6] media: sun4i: Add H3 deinterlace driver
Message-ID: <20191017092800.old6jcyeoq3ruawv@gilmour>
References: <20191016192807.1278987-1-jernej.skrabec@siol.net>
 <20191016192807.1278987-6-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="amvhyb5qqkqgtzi2"
Content-Disposition: inline
In-Reply-To: <20191016192807.1278987-6-jernej.skrabec@siol.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--amvhyb5qqkqgtzi2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I have a small comment that can definitely be addressed in a subsequent patch

On Wed, Oct 16, 2019 at 09:28:06PM +0200, Jernej Skrabec wrote:
> +	dev->bus_clk = devm_clk_get(dev->dev, "bus");
> +	if (IS_ERR(dev->bus_clk)) {
> +		dev_err(dev->dev, "Failed to get bus clock\n");
> +
> +		return PTR_ERR(dev->bus_clk);
> +	}
> +
> +	dev->mod_clk = devm_clk_get(dev->dev, "mod");
> +	if (IS_ERR(dev->mod_clk)) {
> +		dev_err(dev->dev, "Failed to get mod clock\n");
> +
> +		return PTR_ERR(dev->mod_clk);
> +	}
> +
> +	dev->ram_clk = devm_clk_get(dev->dev, "ram");
> +	if (IS_ERR(dev->ram_clk)) {
> +		dev_err(dev->dev, "Failed to get ram clock\n");
> +
> +		return PTR_ERR(dev->ram_clk);
> +	}
> +
> +	dev->rstc = devm_reset_control_get(dev->dev, NULL);
> +	if (IS_ERR(dev->rstc)) {
> +		dev_err(dev->dev, "Failed to get reset control\n");
> +
> +		return PTR_ERR(dev->rstc);
> +	}
> +
> +	clk_set_rate_exclusive(dev->mod_clk, 300000000);

clk_set_rate_exclusive puts a pretty big constraint on the clock tree,
and we shouldn't really enforce it if the device is unused.

I guess we should move it to the runtime_pm resume hook (with the
put_exclusive call in suspend).

Otherwise, that patch is
Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--amvhyb5qqkqgtzi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXag0IAAKCRDj7w1vZxhR
xaZsAP4ktQAK6tje3Cb2Qjis6/lKTHrygep8ppy1RAYh+5gmFgD/cmwwWzyQ42I7
oxbLIVKna9bDTyghs0A+0vE3KpGYPgA=
=4k1j
-----END PGP SIGNATURE-----

--amvhyb5qqkqgtzi2--
