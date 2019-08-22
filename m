Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE80C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDD5233FD
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 14:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566483511;
	bh=gmxMQJV4pqxZQO3wcgdhCDUc992RIMAHvgrcXbGDS7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mpO2fjxuSQg6ZyjAgGciK7CCWXi0oq4tNP3vvZH5f4/3PLvGKsIogNPxJt7TUQiqi
	 E77vcaG1IOUkjYKDQ8k48UCg/9fY+ShWo1pVZYIHHVva57tOYtrZc97njY4ouKEE6I
	 jpnlP0I0GWUcAQ4wvrUhNSsAOTN6Rmos2/Zyo8to=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbfHVOSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 10:18:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732213AbfHVOS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 10:18:29 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3513421743;
        Thu, 22 Aug 2019 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566483508;
        bh=gmxMQJV4pqxZQO3wcgdhCDUc992RIMAHvgrcXbGDS7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPBQBdB5hA6kDZZpQjWgtb5+2+cbcqWt3sKnBOG+g5UPJbkk+JN7aswR0V0k/sMAJ
         1AhgX5ZA7VkTf7URGjG6bqR5uz4tjLsWWiWLhBF3VeH8UvPYRIHqtmtKNcSkMj8S0t
         qrnCyIk3UgRRSD/5njrMoABJZqyw5QNTAno6Vlow=
Date:   Thu, 22 Aug 2019 16:18:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Marcus Cooper <codekipper@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in
 sun4i_i2s_init_regmap_fields()
Message-ID: <20190822141826.is6nizjpdgvhd7ra@flea>
References: <20190822065252.74028-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="63ssjdwokv3xdxzu"
Content-Disposition: inline
In-Reply-To: <20190822065252.74028-1-yuehaibing@huawei.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--63ssjdwokv3xdxzu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Aug 22, 2019 at 06:52:52AM +0000, YueHaibing wrote:
> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 9e691baee1e8..2071c54265f3 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1095,10 +1095,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>  	i2s->field_fmt_sr =
>  			devm_regmap_field_alloc(dev, i2s->regmap,
>  						i2s->variant->field_fmt_sr);
> -	if (IS_ERR(i2s->field_fmt_sr))
> -		return PTR_ERR(i2s->field_fmt_sr);
> -
> -	return 0;
> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);

I'm not really convinced that this more readable or more maintainable
though. Is there a reason for this other than we can do it?

Maxie

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--63ssjdwokv3xdxzu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV6kMgAKCRDj7w1vZxhR
xYfCAQCzZc0NwL/KfHnmN5cCqmspt4rw9g7yY9ueTUdm/d4SMAD/U5pvKe6kNk6f
0GRxtaBnisn3CWTssq3fqkAzCBywhgk=
=VH9U
-----END PGP SIGNATURE-----

--63ssjdwokv3xdxzu--
