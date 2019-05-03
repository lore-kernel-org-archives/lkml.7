Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A448C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5887E206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556863143;
	bh=sf6IrwOLTEPSoXVYE+SjxyOepZfuNo78cjXl6QzlDEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nuurA30s3mZfD2sFaF3nivPmGEUvKG8pqPwhZguW9nfKrWnDPplRCpSy0ptYr+EGU
	 qrECdJFOTfLafdNepjbXNTximTZxM+JKGxxcTC9A8X/nVrcM485Xs7zc+0MuBOQujH
	 7waKs+yuiQthZ86qlYDX+VqqF+Sy80m5oRSldV+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbfECF7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:59:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47472 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfECF7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4ib6EGiqGZs0cx0BP5zTIwv4T+gNe/EmI7hgleO5jVI=; b=GmdTJXgmhkiSwrhI+2N0wdBW3
        lmN0w63R8X5+GF0Pux4dkFSH32I1em1FTXPK3FSta2RRt6nsLtmOcSpU5Wh0dCWpG+3SAdq0MEVMB
        +9ow8z2J5AEg6xGyXOQNSeyaPcWmYrkyktmYr8NxvkRxgfsejJc0NXTf8JG1IahkzMSpM=;
Received: from [42.29.24.106] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hMRDA-0000R4-I5; Fri, 03 May 2019 05:58:21 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 204C2441D3C; Fri,  3 May 2019 06:58:09 +0100 (BST)
Date:   Fri, 3 May 2019 14:58:09 +0900
From:   Mark Brown <broonie@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.com,
        kaichieh.chuang@mediatek.com, shunli.wang@mediatek.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] ASoC: mediatek: Add MT8516 PCM driver
Message-ID: <20190503055809.GC14916@sirena.org.uk>
References: <20190502121041.8045-1-fparent@baylibre.com>
 <20190502121041.8045-4-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e7WmlSfQJTtHfSol"
Content-Disposition: inline
In-Reply-To: <20190502121041.8045-4-fparent@baylibre.com>
X-Cookie: -- I have seen the FUN --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e7WmlSfQJTtHfSol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2019 at 02:10:39PM +0200, Fabien Parent wrote:

> +static irqreturn_t mt8516_afe_irq_handler(int irq, void *dev_id)
> +{
> +	struct mtk_base_afe *afe = dev_id;
> +	unsigned int reg_value;
> +	unsigned int memif_status;
> +	int i, ret;
> +
> +	ret = regmap_read(afe->regmap, AFE_IRQ_STATUS, &reg_value);
> +	if (ret) {
> +		reg_value = AFE_IRQ_STATUS_BITS;
> +		goto exit_irq;
> +	}

...

> +exit_irq:
> +	regmap_write(afe->regmap, AFE_IRQ_CLR, reg_value & AFE_IRQ_STATUS_BITS);
> +
> +	return IRQ_HANDLED;
> +}

This unconditionally says it handled an interrupt regardless of what
happened.  This means that the interrupt line can't be shared and that
the error handling code in the generic interrupt subsystem can't tell if
something goes wrong and the interrupt gets stuck.

> +	ret = devm_request_irq(afe->dev, irq_id, mt8516_afe_irq_handler,
> +			       0, "Afe_ISR_Handle", (void *)afe);
> +	if (ret) {
> +		dev_err(afe->dev, "could not request_irq\n");
> +		return ret;
> +	}

Are you sure the interrupt handler can safely use managed resources,
especially given...

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(afe->base_addr))
> +		return PTR_ERR(afe->base_addr);
> +
> +	afe->regmap = devm_regmap_init_mmio(&pdev->dev, afe->base_addr,
> +		&mt8516_afe_regmap_config);
> +	if (IS_ERR(afe->regmap))
> +		return PTR_ERR(afe->regmap);

...that things like the register map and the I/O resources for the chip
are allocated after and therefore freed before before the interrupt is
freed.  Normally the interrupt should be one of the last things to be
allocated.

> +static int mt8516_afe_pcm_dev_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

In general if functions can legitimately be empty they should just be
omitted, if they are required that usually means they have to do
something.

--e7WmlSfQJTtHfSol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzL2HAACgkQJNaLcl1U
h9CyAwf9G6RLyjC0l1jZ7PuvlyUWgPa0meffYGQwZm5IRVLUCEfYjhxodTO5hKh2
fFN64GvyEDq68fgDpF1ILhSFWZFRBLkdFwJ2/e2tknzzQ3QWpWA3mvzrzEzyZlOB
Z0ocR20bgbYxO+OAas//SnwCaY+Hm14Dho0oQooGlWHWGfQtxF7OcKKVTYnf1uij
GHYwqmasG50ldZZ+Lwu8tgueOohnt53QpM5L8wx33IBSYmmAdpCw6C6raql8bQAe
9dyCLUtxkI+dUhvn9cemnDD6VTPhPvj7AGL+L8Xp2/3T8GQQkYTyskjPWt/3nCan
5wADxvamyeOpeEhFqke6O33PxGD2jA==
=0nPV
-----END PGP SIGNATURE-----

--e7WmlSfQJTtHfSol--
