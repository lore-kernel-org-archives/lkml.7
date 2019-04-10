Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A28C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5A82084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554894603;
	bh=FvNLakgbCiZ8oekuqT5Zxjw/g0TJ6Ap088ZdJlwFDLQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZtZ4vF5QV+3plqRT7tsXhwt8V8SbttccnUWneVO2y3M7nZ3O91MCfyZwp0uBM+TMN
	 5lQRFeW4NmaxnZg40FAiP7w7vkQcXiVxyHzbabekUa0n7Kwb4rc5QFzz0HxG9JhhFn
	 ZSFPhsiLdFLYhqJSlO6wAFtLvBNW+OUKx/nLLIEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731312AbfDJLKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:10:02 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47360 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbfDJLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZCkcsFgkicSc8I+V+be06+D4zuFAbXpt9S9+gFGOCGw=; b=ikouA52L5qJsqdbiGZ/79M7S2
        LozF8HYJBw0rYSQLK20pK5AsDUBVb2PoJ0wxlOZxGtBZPqGJ/mfaA+umI49Iyv379fa6i0NlwT9Yv
        PRq5czd1sSz7wY9Q6OrhfB1fT0fRIqWkaCA/Hv3VrVnkr/6QgPzsBtD08mRMn4Zoa9dDI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hEB6U-00080L-Vj; Wed, 10 Apr 2019 11:09:19 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 597571128ED3; Wed, 10 Apr 2019 12:09:18 +0100 (BST)
Date:   Wed, 10 Apr 2019 12:09:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pengcheng Li <lipengcheng8@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        john.stultz@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, suzhuangluan@hisilicon.com,
        kongfei@hisilicon.com, liyuequan@hisilicon.com,
        cash.qianli@hisilicon.com, huangli295@hisilicon.com,
        hantanglei@huawei.com, wangyoulin1@hisilicon.com,
        ninggaoyu@hisilicon.com, xuwei5@huawei.com
Subject: Re: [PATCH 1/3] sound: Add hikey960 i2s audio driver
Message-ID: <20190410110918.GI6106@sirena.org.uk>
References: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y96v7rNg6HAoELs5"
Content-Disposition: inline
In-Reply-To: <1551362220-99351-1-git-send-email-lipengcheng8@huawei.com>
X-Cookie: teamwork, n.:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y96v7rNg6HAoELs5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 28, 2019 at 09:57:00PM +0800, Pengcheng Li wrote:
> From: Youlin Wang <wangyoulin1@hisilicon.com>

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

>  config SND_I2S_HI6210_I2S
> -	tristate "Hisilicon I2S controller"
> +	tristate "Hisilicon Hi6210 I2S controller"
> +	select SND_SOC_GENERIC_DMAENGINE_PCM
> +	help
> +	  Hisilicon I2S
> +

This should really be a separate patch as it's an update to the
existing driver.

> --- /dev/null
> +++ b/sound/soc/hisilicon/hi3660-i2s.c
> @@ -0,0 +1,448 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * linux/sound/soc/hisilicon/hi3660-i2s.c
> + *

Please make the entire comment a C++ one so it looks intentional.

> + * I2S IP driver for hi3660.
> + *
> + * Copyright (c) 2001-2021, Huawei Tech. Co., Ltd.
> + */

Given that it's currently 2019 I'm not sure that the years copyright is
claimed for here are accurate...

> +static void update_bits(struct hi3660_i2s *i2s, u32 ofs, u32 reset, u32 set)
> +{
> +	u32 val = readl(i2s->base + ofs) & ~reset;
> +
> +	writel(val | set, i2s->base + ofs);
> +}

It'd be better to namespace the functions in the driver to avoid
collisons with anything that gets added to headers.  Look at how other
drivers name their functions for examples.

It's also a bit confusing to have an _update_bits() with the set/reset
pattern given that we've got _update_bits() functions with the
mask/values pattern at both the ASoC and regmap levels in Linux.

> +static void shutdown(struct snd_pcm_substream *substream,
> +		       struct snd_soc_dai *cpu_dai)
> +{
> +	struct hi3660_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
> +
> +	if (!IS_ERR_OR_NULL(i2s->asp_subsys_clk))
> +		clk_disable_unprepare(i2s->asp_subsys_clk);
> +}

Can the driver actually function usefully without this clock?

> +static int set_sysclk(struct snd_soc_dai *cpu_dai,
> +			     int clk_id, unsigned int freq, int dir)
> +{
> +	return 0;
> +}

Don't implement empty operations; if it's safe to not have an operation
(like this one) then the framework will handle it being missing.

> +static int set_format(struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +{
> +	struct hi3660_i2s *i2s = dev_get_drvdata(cpu_dai->dev);
> +
> +	i2s->format = fmt;
> +	i2s->master = (i2s->format & SND_SOC_DAIFMT_MASTER_MASK) ==
> +		      SND_SOC_DAIFMT_CBS_CFS;
> +
> +	return 0;
> +}

There should be some validation in this function to make sure that the
format is valid.

> +	case SNDRV_PCM_FORMAT_U24_LE:
> +	case SNDRV_PCM_FORMAT_S24_LE:
> +		i2s->bits = 32;
> +		dma_data->addr_width = 4;
> +		break;

Does the hardware not support 32 bit samples?

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +	i2s->base_syscon = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(i2s->base_syscon)) {
> +		dev_err(&pdev->dev, "ioremap failed\n");
> +		ret = PTR_ERR(i2s->base_syscon);
> +		return ret;
> +	}

If there's a system controller involved shouldn't we be using the
standard system controller support in drivers/mfd/syscon.c?  Other
HiSilicon devices seem to use it.

> +	i2s->pctrl = devm_pinctrl_get(dev);
> +	if (IS_ERR(i2s->pctrl)) {
> +		dev_err(dev, "could not get pinctrl\n");
> +		ret = -EIO;
> +		return ret;
> +	}

This is discarding the error code returned by the API which is going to
make debuggging harder and will break deferred probe - you should use
PTR_ERR() to get the error and both print it and return it as the error
code.

> +static int hi3660_i2s_remove(struct platform_device *pdev)
> +{
> +	struct hi3660_i2s *i2s = dev_get_drvdata(&pdev->dev);
> +
> +	snd_soc_unregister_component(&pdev->dev);
> +	dev_set_drvdata(&pdev->dev, NULL);
> +
> +	pinctrl_put(i2s->pctrl);

The driver used devm_ functions on probe so no need to explicitly undo
things, the devm_ code will handle that for you.

--y96v7rNg6HAoELs5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytzt0ACgkQJNaLcl1U
h9DQcAf/d31a6Xj9h5Rwq8yAViJrRKGMTgWl0G0idih76pNg4I2P5n2Zv8K8Hbsk
FHDPMWYk7OP5BEKe0m9H3rHvMcmriYk1jm7lf2ldV/tpQapEYPaJ9NhwaTHS97Ca
5a3lzoyCZ5ghAbxglMWQspiy3rIqJbKPBE1BXo4peijZxkulir3E3rNT6E9N1TWu
08cQpOAE3Fm5Yl070dH8PR6Lw1CM2N3UZgEUgawFJ4sV2+KANW65zheAPwEfPpXO
pGadgs2iuFDFWb3+jXBPf3Ssh1Iu61oN9rvbkaPTboHI3N+H49syW2cB03uP565w
10I6Rw9FhI7A9jHh5i52U4kGPSpeSA==
=0geS
-----END PGP SIGNATURE-----

--y96v7rNg6HAoELs5--
