Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC147C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EDC3205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U+0MHtp2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgAHFPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:15:49 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12338 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:15:49 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e15656d0001>; Tue, 07 Jan 2020 21:15:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jan 2020 21:15:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jan 2020 21:15:43 -0800
Received: from [10.24.44.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jan
 2020 05:15:36 +0000
Subject: Re: [PATCH v7 14/21] ASoC: tegra: Add audio mclk configuration
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <broonie@kernel.org>, <lgirdwood@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <gregkh@linuxfoundation.org>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <pdeschrijver@nvidia.com>, <pgaikwad@nvidia.com>,
        <josephl@nvidia.com>, <daniel.lezcano@linaro.org>,
        <mmaddireddy@nvidia.com>, <markz@nvidia.com>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1578457515-3477-1-git-send-email-skomatineni@nvidia.com>
 <1578457515-3477-15-git-send-email-skomatineni@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <6110236f-9bab-b166-1a31-05e71f95e8eb@nvidia.com>
Date:   Wed, 8 Jan 2020 10:45:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578457515-3477-15-git-send-email-skomatineni@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578460526; bh=eTstNcjqbretY4ixX92EWt07UW4gr9VTT4StBhf4Kn0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=U+0MHtp2aOWp2dGOaeV8w/dEXRbKI1PoesQ/fx0IxxtC2O9fC80VK4nse8584i4d5
         U9T9ppXqd0fexh+hR4+zTBhLCvb73LlS815G4jaImv/9ACdH0G8CJJOeqCR8xbD4cz
         NEWf6QmjXsautNLByq2bhwty6f/UNRH4OJ6AABAcg236HkGxcXCQSuJXwUJh6M9Cra
         ehbYuN0uAHsOLBOhvfUq5lM5bb+tgZFKIjhLv5A9mDD7SQ+1bSqw/7xIOX5XNpSuNq
         6E3jiYch9cm9IcXXdk1FUDO8fu19+yEEKy5ct3UmGJY6UOxRl2zqAy6o6pkAu1DmcF
         zv8PPscJweVAw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/8/2020 9:55 AM, Sowjanya Komatineni wrote:
> Tegra PMC clock clk_out_1 is dedicated for audio mclk from Tegra30
> through Tegra210 and currently Tegra clock driver does the initial parent
> configuration for audio mclk and keeps it enabled by default.
>
> With the move of PMC clocks from clock driver into pmc driver,
> audio clocks parent configuration can be specified through the device tree
> using assigned-clock-parents property and audio mclk control should be
> taken care by the audio driver.
>
> This patch has implementation for parent configuration when default parent
> configuration is not specified in the device tree and controls audio mclk
> enable and disable during machine startup and shutdown.
>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Reviewed-by: Sameer Pujar <spujar@nvidia.com>

> ---
>   sound/soc/tegra/tegra_alc5632.c    | 18 ++++++++
>   sound/soc/tegra/tegra_asoc_utils.c | 88 +++++++++++++++++++++++++-------------
>   sound/soc/tegra/tegra_asoc_utils.h |  2 +
>   sound/soc/tegra/tegra_max98090.c   | 18 ++++++++
>   sound/soc/tegra/tegra_rt5640.c     | 18 ++++++++
>   sound/soc/tegra/tegra_rt5677.c     | 18 ++++++++
>   sound/soc/tegra/tegra_sgtl5000.c   | 18 ++++++++
>   sound/soc/tegra/tegra_wm8753.c     | 18 ++++++++
>   sound/soc/tegra/tegra_wm8903.c     | 18 ++++++++
>   sound/soc/tegra/trimslice.c        | 18 ++++++++
>   10 files changed, 204 insertions(+), 30 deletions(-)
>
> diff --git a/sound/soc/tegra/tegra_alc5632.c b/sound/soc/tegra/tegra_alc5632.c
> index 50a6d2ff4442..5da7933f6a99 100644
> --- a/sound/soc/tegra/tegra_alc5632.c
> +++ b/sound/soc/tegra/tegra_alc5632.c
> @@ -62,8 +62,26 @@ static int tegra_alc5632_asoc_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_alc5632_asoc_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_alc5632_asoc_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_alc5632 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_alc5632_asoc_ops = {
> +	.startup = tegra_alc5632_asoc_startup,
>   	.hw_params = tegra_alc5632_asoc_hw_params,
> +	.shutdown = tegra_alc5632_asoc_shutdown,
>   };
>   
>   static struct snd_soc_jack tegra_alc5632_hs_jack;
> diff --git a/sound/soc/tegra/tegra_asoc_utils.c b/sound/soc/tegra/tegra_asoc_utils.c
> index 0d2271952555..9cfebef74870 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.c
> +++ b/sound/soc/tegra/tegra_asoc_utils.c
> @@ -60,8 +60,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>   	data->set_mclk = 0;
>   
>   	clk_disable_unprepare(data->clk_cdev1);
> -	clk_disable_unprepare(data->clk_pll_a_out0);
> -	clk_disable_unprepare(data->clk_pll_a);
>   
>   	err = clk_set_rate(data->clk_pll_a, new_baseclock);
>   	if (err) {
> @@ -77,18 +75,6 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>   
>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>   
> -	err = clk_prepare_enable(data->clk_pll_a);
> -	if (err) {
> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(data->clk_pll_a_out0);
> -	if (err) {
> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
> -		return err;
> -	}
> -
>   	err = clk_prepare_enable(data->clk_cdev1);
>   	if (err) {
>   		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
> @@ -109,8 +95,6 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>   	int err;
>   
>   	clk_disable_unprepare(data->clk_cdev1);
> -	clk_disable_unprepare(data->clk_pll_a_out0);
> -	clk_disable_unprepare(data->clk_pll_a);
>   
>   	/*
>   	 * AC97 rate is fixed at 24.576MHz and is used for both the host
> @@ -130,17 +114,28 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>   
>   	/* Don't set cdev1/extern1 rate; it's locked to pll_a_out0 */
>   
> -	err = clk_prepare_enable(data->clk_pll_a);
> +	err = clk_prepare_enable(data->clk_cdev1);
>   	if (err) {
> -		dev_err(data->dev, "Can't enable pll_a: %d\n", err);
> +		dev_err(data->dev, "Can't enable cdev1: %d\n", err);
>   		return err;
>   	}
>   
> -	err = clk_prepare_enable(data->clk_pll_a_out0);
> -	if (err) {
> -		dev_err(data->dev, "Can't enable pll_a_out0: %d\n", err);
> -		return err;
> -	}
> +	data->set_baseclock = pll_rate;
> +	data->set_mclk = ac97_rate;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
> +
> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data)
> +{
> +	clk_disable_unprepare(data->clk_cdev1);
> +}
> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_clk_disable);
> +
> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data)
> +{
> +	int err;
>   
>   	err = clk_prepare_enable(data->clk_cdev1);
>   	if (err) {
> @@ -148,16 +143,14 @@ int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data)
>   		return err;
>   	}
>   
> -	data->set_baseclock = pll_rate;
> -	data->set_mclk = ac97_rate;
> -
>   	return 0;
>   }
> -EXPORT_SYMBOL_GPL(tegra_asoc_utils_set_ac97_rate);
> +EXPORT_SYMBOL_GPL(tegra_asoc_utils_clk_enable);
>   
>   int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>   			  struct device *dev)
>   {
> +	struct clk *clk_out_1, *clk_extern1;
>   	int ret;
>   
>   	data->dev = dev;
> @@ -193,9 +186,44 @@ int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>   		return PTR_ERR(data->clk_cdev1);
>   	}
>   
> -	ret = tegra_asoc_utils_set_rate(data, 44100, 256 * 44100);
> -	if (ret)
> -		return ret;
> +	/*
> +	 * If clock parents are not set in DT, configure here to use clk_out_1
> +	 * as mclk and extern1 as parent for Tegra30 and higher.
> +	 */
> +	if (!of_find_property(dev->of_node, "assigned-clock-parents", NULL) &&
> +	    data->soc > TEGRA_ASOC_UTILS_SOC_TEGRA20) {
> +		dev_warn(data->dev,
> +			 "Configuring clocks for a legacy device-tree\n");
> +		dev_warn(data->dev,
> +			 "Please update DT to use assigned-clock-parents\n");
> +		clk_extern1 = devm_clk_get(dev, "extern1");
> +		if (IS_ERR(clk_extern1)) {
> +			dev_err(data->dev, "Can't retrieve clk extern1\n");
> +			return PTR_ERR(clk_extern1);
> +		}
> +
> +		ret = clk_set_parent(clk_extern1, data->clk_pll_a_out0);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"Set parent failed for clk extern1\n");
> +			return ret;
> +		}
> +
> +		clk_out_1 = devm_clk_get(dev, "clk_out_1");
> +		if (IS_ERR(clk_out_1)) {
> +			dev_err(data->dev, "Can't retrieve clk clk_out_1\n");
> +			return PTR_ERR(clk_out_1);
> +		}
> +
> +		ret = clk_set_parent(clk_out_1, clk_extern1);
> +		if (ret < 0) {
> +			dev_err(data->dev,
> +				"Set parent failed for clk_out_1\n");
> +			return ret;
> +		}
> +
> +		data->clk_cdev1 = clk_out_1;
> +	}
>   
>   	return 0;
>   }
> diff --git a/sound/soc/tegra/tegra_asoc_utils.h b/sound/soc/tegra/tegra_asoc_utils.h
> index a34439587d59..6db93009a317 100644
> --- a/sound/soc/tegra/tegra_asoc_utils.h
> +++ b/sound/soc/tegra/tegra_asoc_utils.h
> @@ -34,5 +34,7 @@ int tegra_asoc_utils_set_rate(struct tegra_asoc_utils_data *data, int srate,
>   int tegra_asoc_utils_set_ac97_rate(struct tegra_asoc_utils_data *data);
>   int tegra_asoc_utils_init(struct tegra_asoc_utils_data *data,
>   			  struct device *dev);
> +int tegra_asoc_utils_clk_enable(struct tegra_asoc_utils_data *data);
> +void tegra_asoc_utils_clk_disable(struct tegra_asoc_utils_data *data);
>   
>   #endif
> diff --git a/sound/soc/tegra/tegra_max98090.c b/sound/soc/tegra/tegra_max98090.c
> index f554a3d4571f..ec43b27ca3f7 100644
> --- a/sound/soc/tegra/tegra_max98090.c
> +++ b/sound/soc/tegra/tegra_max98090.c
> @@ -82,8 +82,26 @@ static int tegra_max98090_asoc_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_max98090_asoc_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_max98090_asoc_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_max98090 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_max98090_ops = {
> +	.startup = tegra_max98090_asoc_startup,
>   	.hw_params = tegra_max98090_asoc_hw_params,
> +	.shutdown = tegra_max98090_asoc_shutdown,
>   };
>   
>   static struct snd_soc_jack tegra_max98090_hp_jack;
> diff --git a/sound/soc/tegra/tegra_rt5640.c b/sound/soc/tegra/tegra_rt5640.c
> index 5c695dfea009..2d63ab0987ea 100644
> --- a/sound/soc/tegra/tegra_rt5640.c
> +++ b/sound/soc/tegra/tegra_rt5640.c
> @@ -65,8 +65,26 @@ static int tegra_rt5640_asoc_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_rt5640_asoc_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_rt5640_asoc_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_rt5640 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_rt5640_ops = {
> +	.startup = tegra_rt5640_asoc_startup,
>   	.hw_params = tegra_rt5640_asoc_hw_params,
> +	.shutdown = tegra_rt5640_asoc_shutdown,
>   };
>   
>   static struct snd_soc_jack tegra_rt5640_hp_jack;
> diff --git a/sound/soc/tegra/tegra_rt5677.c b/sound/soc/tegra/tegra_rt5677.c
> index fb86f76728b3..81485dbe4ec6 100644
> --- a/sound/soc/tegra/tegra_rt5677.c
> +++ b/sound/soc/tegra/tegra_rt5677.c
> @@ -82,8 +82,26 @@ static int tegra_rt5677_event_hp(struct snd_soc_dapm_widget *w,
>   	return 0;
>   }
>   
> +static int tegra_rt5677_asoc_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_rt5677_asoc_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_rt5677 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_rt5677_ops = {
> +	.startup = tegra_rt5677_asoc_startup,
>   	.hw_params = tegra_rt5677_asoc_hw_params,
> +	.shutdown = tegra_rt5677_asoc_shutdown,
>   };
>   
>   static struct snd_soc_jack tegra_rt5677_hp_jack;
> diff --git a/sound/soc/tegra/tegra_sgtl5000.c b/sound/soc/tegra/tegra_sgtl5000.c
> index 586f56f435f4..8852a4bcafe7 100644
> --- a/sound/soc/tegra/tegra_sgtl5000.c
> +++ b/sound/soc/tegra/tegra_sgtl5000.c
> @@ -71,8 +71,26 @@ static int tegra_sgtl5000_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_sgtl5000_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_sgtl5000 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_sgtl5000_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_sgtl5000 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_sgtl5000_ops = {
> +	.startup = tegra_sgtl5000_startup,
>   	.hw_params = tegra_sgtl5000_hw_params,
> +	.shutdown = tegra_sgtl5000_shutdown,
>   };
>   
>   static const struct snd_soc_dapm_widget tegra_sgtl5000_dapm_widgets[] = {
> diff --git a/sound/soc/tegra/tegra_wm8753.c b/sound/soc/tegra/tegra_wm8753.c
> index f76cfdc963ed..a4595d73df53 100644
> --- a/sound/soc/tegra/tegra_wm8753.c
> +++ b/sound/soc/tegra/tegra_wm8753.c
> @@ -75,8 +75,26 @@ static int tegra_wm8753_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_wm8753_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_wm8753_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_wm8753 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_wm8753_ops = {
> +	.startup = tegra_wm8753_startup,
>   	.hw_params = tegra_wm8753_hw_params,
> +	.shutdown = tegra_wm8753_shutdown,
>   };
>   
>   static const struct snd_soc_dapm_widget tegra_wm8753_dapm_widgets[] = {
> diff --git a/sound/soc/tegra/tegra_wm8903.c b/sound/soc/tegra/tegra_wm8903.c
> index f5f78c3512cd..9cd637385685 100644
> --- a/sound/soc/tegra/tegra_wm8903.c
> +++ b/sound/soc/tegra/tegra_wm8903.c
> @@ -82,8 +82,26 @@ static int tegra_wm8903_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int tegra_wm8903_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void tegra_wm8903_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_wm8903 *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops tegra_wm8903_ops = {
> +	.startup = tegra_wm8903_startup,
>   	.hw_params = tegra_wm8903_hw_params,
> +	.shutdown = tegra_wm8903_shutdown,
>   };
>   
>   static struct snd_soc_jack tegra_wm8903_hp_jack;
> diff --git a/sound/soc/tegra/trimslice.c b/sound/soc/tegra/trimslice.c
> index e51c67092c8f..a78c2bc633bc 100644
> --- a/sound/soc/tegra/trimslice.c
> +++ b/sound/soc/tegra/trimslice.c
> @@ -60,8 +60,26 @@ static int trimslice_asoc_hw_params(struct snd_pcm_substream *substream,
>   	return 0;
>   }
>   
> +static int trimslice_asoc_startup(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_trimslice *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	return tegra_asoc_utils_clk_enable(&machine->util_data);
> +}
> +
> +static void trimslice_asoc_shutdown(struct snd_pcm_substream *substream)
> +{
> +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +	struct tegra_trimslice *machine = snd_soc_card_get_drvdata(rtd->card);
> +
> +	tegra_asoc_utils_clk_disable(&machine->util_data);
> +}
> +
>   static const struct snd_soc_ops trimslice_asoc_ops = {
> +	.startup = trimslice_asoc_startup,
>   	.hw_params = trimslice_asoc_hw_params,
> +	.shutdown = trimslice_asoc_shutdown,
>   };
>   
>   static const struct snd_soc_dapm_widget trimslice_dapm_widgets[] = {
