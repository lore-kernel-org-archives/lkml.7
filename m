Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F83C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE45B233A0
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566389155;
	bh=2FRrclBMVAhxORSkvx15JbwCjv+rECZrE3tmzTI6fjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MH0hpiF6NAb5YiMSj0mFJi0RsY61almLrkUEYI5TCuf9J2FiJZT3QDtlqclvv0FU9
	 z8bfWB4Qa3WTJ6WhfACAL4BmepDWtmDH7Wzl2xRuDLgf/2Uqb0x9V5YytALHmIkTpJ
	 Va0dZJNc2/jSZ2tYGbtIkDhu58JinLKyKqU2qP6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfHUMFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfHUMFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:05:54 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6825C2089E;
        Wed, 21 Aug 2019 12:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566389153;
        bh=2FRrclBMVAhxORSkvx15JbwCjv+rECZrE3tmzTI6fjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IbIaUibt98RW+BrZlXwdHPhbsgLQ9iOj11mOxlw6Yjy1yayKkHC4aRDGmudrko7Kx
         noHVlKvbF69kchSJz2ghinFmicUmJh1uuf7G/o7kEBUZrBsJJqDiDMperYLvKafvYv
         b1eKr/vXsFluy6CmtTWTuLDHZlYoB+K02En2rqBs=
Date:   Wed, 21 Aug 2019 14:05:51 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sergey Suloev <ssuloev@orpaltech.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com,
        broonie@kernel.org, codekipper@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 20/21] ASoC: sun4i-i2s: Add support for TDM slots
Message-ID: <20190821120551.r4b3h4nnet357wem@flea>
References: <cover.e08aa7e33afe117e1fa8f017119d465d47c98016.1566242458.git-series.maxime.ripard@bootlin.com>
 <26392af30b3e7b31ee48d5b867d45be8675db046.1566242458.git-series.maxime.ripard@bootlin.com>
 <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hsc5ca3rnlaanrdu"
Content-Disposition: inline
In-Reply-To: <c311e88a-fdd2-8a01-275e-675d98dc90ba@orpaltech.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hsc5ca3rnlaanrdu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Aug 20, 2019 at 08:46:30AM +0300, Sergey Suloev wrote:
> Hi, Maxime,
>
> On 8/19/19 10:25 PM, Maxime Ripard wrote:
> > From: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > The i2s controller supports TDM, for up to 8 slots. Let's support the TDM
> > API.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > ---
> >   sound/soc/sunxi/sun4i-i2s.c | 40 ++++++++++++++++++++++++++++++++------
> >   1 file changed, 34 insertions(+), 6 deletions(-)
> >
> > diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> > index 0dac09814b65..4f76daeaaed7 100644
> > --- a/sound/soc/sunxi/sun4i-i2s.c
> > +++ b/sound/soc/sunxi/sun4i-i2s.c
> > @@ -168,6 +168,8 @@ struct sun4i_i2s {
> >   	struct reset_control *rst;
> >   	unsigned int	mclk_freq;
> > +	unsigned int	slots;
> > +	unsigned int	slot_width;
> >   	struct snd_dmaengine_dai_dma_data	capture_dma_data;
> >   	struct snd_dmaengine_dai_dma_data	playback_dma_data;
> > @@ -287,7 +289,7 @@ static bool sun4i_i2s_oversample_is_valid(unsigned int oversample)
> >   static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >   				  unsigned int rate,
> > -				  unsigned int channels,
> > +				  unsigned int slots,
> >   				  unsigned int word_size)
> >   {
> >   	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > @@ -335,7 +337,7 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
> >   	bclk_parent_rate = i2s->variant->get_bclk_parent_rate(i2s);
> >   	bclk_div = sun4i_i2s_get_bclk_div(i2s, bclk_parent_rate,
> > -					  rate, channels, word_size);
> > +					  rate, slots, word_size);
> >   	if (bclk_div < 0) {
> >   		dev_err(dai->dev, "Unsupported BCLK divider: %d\n", bclk_div);
> >   		return -EINVAL;
> > @@ -419,6 +421,10 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> >   				  const struct snd_pcm_hw_params *params)
> >   {
> >   	unsigned int channels = params_channels(params);
> > +	unsigned int slots = channels;
> > +
> > +	if (i2s->slots)
> > +		slots = i2s->slots;
> >   	/* Map the channels for playback and capture */
> >   	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
> > @@ -428,7 +434,6 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
> >   	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
> >   			   SUN4I_I2S_CHAN_SEL_MASK,
> >   			   SUN4I_I2S_CHAN_SEL(channels));
> > -
> >   	regmap_update_bits(i2s->regmap, SUN8I_I2S_RX_CHAN_SEL_REG,
> >   			   SUN4I_I2S_CHAN_SEL_MASK,
> >   			   SUN4I_I2S_CHAN_SEL(channels));
> > @@ -452,10 +457,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >   			       struct snd_soc_dai *dai)
> >   {
> >   	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > +	unsigned int word_size = params_width(params);
> >   	unsigned int channels = params_channels(params);
> > +	unsigned int slots = channels;
> >   	int ret, sr, wss;
> >   	u32 width;
> > +	if (i2s->slots)
> > +		slots = i2s->slots;
> > +
> > +	if (i2s->slot_width)
> > +		word_size = i2s->slot_width;
> > +
> >   	ret = i2s->variant->set_chan_cfg(i2s, params);
> >   	if (ret < 0) {
> >   		dev_err(dai->dev, "Invalid channel configuration\n");
> > @@ -477,15 +490,14 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
> >   	if (sr < 0)
> >   		return -EINVAL;
> > -	wss = i2s->variant->get_wss(i2s, params_width(params));
> > +	wss = i2s->variant->get_wss(i2s, word_size);
> >   	if (wss < 0)
> >   		return -EINVAL;
> >   	regmap_field_write(i2s->field_fmt_wss, wss);
> >   	regmap_field_write(i2s->field_fmt_sr, sr);
> > -	return sun4i_i2s_set_clk_rate(dai, params_rate(params),
> > -				      channels, params_width(params));
> > +	return sun4i_i2s_set_clk_rate(dai, params_rate(params), slots, word_size);
> >   }
> >   static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
> > @@ -785,10 +797,26 @@ static int sun4i_i2s_set_sysclk(struct snd_soc_dai *dai, int clk_id,
> >   	return 0;
> >   }
> > +static int sun4i_i2s_set_tdm_slot(struct snd_soc_dai *dai,
> > +				  unsigned int tx_mask, unsigned int rx_mask,
> > +				  int slots, int slot_width)
> > +{
> > +	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
> > +
> > +	if (slots > 8)
> > +		return -EINVAL;
> > +
> > +	i2s->slots = slots;
> > +	i2s->slot_width = slot_width;
> > +
> > +	return 0;
> > +}
> > +
> >   static const struct snd_soc_dai_ops sun4i_i2s_dai_ops = {
> >   	.hw_params	= sun4i_i2s_hw_params,
> >   	.set_fmt	= sun4i_i2s_set_fmt,
> >   	.set_sysclk	= sun4i_i2s_set_sysclk,
> > +	.set_tdm_slot	= sun4i_i2s_set_tdm_slot,
> >   	.trigger	= sun4i_i2s_trigger,
> >   };
>
> it seems like you forgot to implement sun4i_i2s_dai_ops.set_bclk_ratio
> because, as I far as I understand, it should alter tdm slots functionality
> indirectly.

As far as I can see, while this indeed changes a few things on the TDM
setup, it's optional, orthogonal and it has a single user in the tree
(some intel platform card).

So I'd say that if someone ever needs it, we can have it, but it's not
a blocker.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hsc5ca3rnlaanrdu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXV0znwAKCRDj7w1vZxhR
xRAgAP9EHPMB6Hx7FqcfcszC8f7EF/uLx9RlJGciIrJpOQnKcwEAuaxLthvSNVh/
RddPDN3sljHZtOQBGhyVmlCuwyQoUAk=
=iCnK
-----END PGP SIGNATURE-----

--hsc5ca3rnlaanrdu--
