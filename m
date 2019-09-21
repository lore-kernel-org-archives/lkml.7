Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA12C4740A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146B721907
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 18:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569089045;
	bh=lcwNAkt0bSGmxQUYfiV3LKK1DJcTTpWRR97v2btnNd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=P5HKlDTYqxwY1vr0ix1whP/dpn3fr/ZT6AXSvRz6JvnHN94P80F9PPazK0oCcsOIF
	 ZpeWQv7U+EgPHYQhgp2iEo5a0SNhJo6ulbat50BfmyGHdTJE7EH5n1TWPGaHuBmCKe
	 7zvwhMc8/Wqu22dWRDUCyt0DUPBpVofcZls1eML8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfIUSEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 14:04:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:58544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbfIUSEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 14:04:04 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3D712080F;
        Sat, 21 Sep 2019 18:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569089042;
        bh=lcwNAkt0bSGmxQUYfiV3LKK1DJcTTpWRR97v2btnNd0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qieHYtiyiwUf3OoA8NV3cFoZS2ffU0SOjTH3F+mfdQNpP59HjYjanyicgRydfmJPQ
         QSuq2zlniFlEbHAQNROm5uPoTvUNZv3qe6pit2fWQPPJA5ww1e/pql4M3m7msfK3hI
         z2pAopE8jcURhrQxTTff9aGvauqE9hS1Ho1Vf6tc=
Date:   Sat, 21 Sep 2019 19:03:57 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: adc: stm32-adc: fix kernel-doc warnings
Message-ID: <20190921190357.7dc08c2d@archlinux>
In-Reply-To: <1568980206-5428-1-git-send-email-fabrice.gasnier@st.com>
References: <1568980206-5428-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2019 13:50:06 +0200
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> Fix the following warnings when documentation is built:
> drivers/iio/adc/stm32-adc-core.c:62: warning: cannot understand function
>  prototype: 'struct stm32_adc_common_regs '
> drivers/iio/adc/stm32-adc-core.c:78: warning: cannot understand function
>  prototype: 'struct stm32_adc_priv_cfg '
> drivers/iio/adc/stm32-adc-core.c:123: warning: Function parameter or
>  member 'pdev' not described in 'stm32f4_adc_clk_sel'
> drivers/iio/adc/stm32-adc.c:219: warning: cannot understand function
>  prototype: 'struct stm32_adc_regs '
> drivers/iio/adc/stm32-adc.c:237: warning: cannot understand function
>  prototype: 'struct stm32_adc_regspec '
> drivers/iio/adc/stm32-adc.c:264: warning: cannot understand function
>  prototype: 'struct stm32_adc_cfg '
> drivers/iio/adc/stm32-adc.c:323: warning: Function parameter or member
>  'difsel' not described in 'N'
> drivers/iio/adc/stm32-adc.c:323: warning: Function parameter or member
>  'pcsel' not described in 'stm32_adc'
> drivers/iio/adc/stm32-adc.c:371: warning: cannot understand function
>  prototype: 'const struct stm32_adc_regs stm32f4_sq[STM32_ADC_MAX_SQ + 1]
> drivers/iio/adc/stm32-adc.c:417: warning: cannot understand function
>  prototype: 'const struct stm32_adc_regs stm32f4_smp_bits[] = '
> drivers/iio/adc/stm32-adc.c:508: warning: cannot understand function
>  prototype: 'const struct stm32_adc_regs stm32h7_smp_bits[] = '
> drivers/iio/adc/stm32-adc.c:1112: warning: Function parameter or member
>  'indio_dev' not described in 'stm32_adc_get_trig_extsel'
> drivers/iio/adc/stm32-adc.c:1420: warning: Function parameter or member
>  'indio_dev' not described in 'stm32_adc_debugfs_reg_access'
> drivers/iio/adc/stm32-adc.c:1420: warning: Function parameter or member
>  'reg' not described in 'stm32_adc_debugfs_reg_access'
> drivers/iio/adc/stm32-adc.c:1420: warning: Function parameter or member
>  'writeval' not described in 'stm32_adc_debugfs_reg_access'
> drivers/iio/adc/stm32-adc.c:1420: warning: Function parameter or member
>  'readval' not described in 'stm32_adc_debugfs_reg_access'
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>

As I don't think we build these particular docs by default, I'm not going
to take this as a fix.  Hence it'll have to wait for the below to be
upstream of my togreg branch.

Give me a poke if that's true and I seem to have missed it.

Thanks,

Jonathan

> ---
> Note: this applies on top of "iio: adc: stm32-adc: fix a race when using
> several adcs with dma and irq"
> ---
>  drivers/iio/adc/stm32-adc-core.c | 11 ++++++-----
>  drivers/iio/adc/stm32-adc.c      | 21 +++++++++++++--------
>  2 files changed, 19 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 93a096a..20c626c 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -38,12 +38,12 @@
>  #define HAS_ANASWVDD		BIT(1)
>  
>  /**
> - * stm32_adc_common_regs - stm32 common registers, compatible dependent data
> + * struct stm32_adc_common_regs - stm32 common registers
>   * @csr:	common status register offset
>   * @ccr:	common control register offset
> - * @eoc1:	adc1 end of conversion flag in @csr
> - * @eoc2:	adc2 end of conversion flag in @csr
> - * @eoc3:	adc3 end of conversion flag in @csr
> + * @eoc1_msk:	adc1 end of conversion flag in @csr
> + * @eoc2_msk:	adc2 end of conversion flag in @csr
> + * @eoc3_msk:	adc3 end of conversion flag in @csr
>   * @ier:	interrupt enable register offset for each adc
>   * @eocie_msk:	end of conversion interrupt enable mask in @ier
>   */
> @@ -60,7 +60,7 @@ struct stm32_adc_common_regs {
>  struct stm32_adc_priv;
>  
>  /**
> - * stm32_adc_priv_cfg - stm32 core compatible configuration data
> + * struct stm32_adc_priv_cfg - stm32 core compatible configuration data
>   * @regs:	common registers for all instances
>   * @clk_sel:	clock selection routine
>   * @max_clk_rate_hz: maximum analog clock rate (Hz, from datasheet)
> @@ -117,6 +117,7 @@ static int stm32f4_pclk_div[] = {2, 4, 6, 8};
>  
>  /**
>   * stm32f4_adc_clk_sel() - Select stm32f4 ADC common clock prescaler
> + * @pdev: platform device
>   * @priv: stm32 ADC core private data
>   * Select clock prescaler used for analog conversions, before using ADC.
>   */
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 663f8a5..76a247b 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -102,7 +102,7 @@ struct stm32_adc_calib {
>  };
>  
>  /**
> - * stm32_adc_regs - stm32 ADC misc registers & bitfield desc
> + * struct stm32_adc_regs - stm32 ADC misc registers & bitfield desc
>   * @reg:		register offset
>   * @mask:		bitfield mask
>   * @shift:		left shift
> @@ -114,7 +114,7 @@ struct stm32_adc_regs {
>  };
>  
>  /**
> - * stm32_adc_regspec - stm32 registers definition, compatible dependent data
> + * struct stm32_adc_regspec - stm32 registers definition
>   * @dr:			data register offset
>   * @ier_eoc:		interrupt enable register & eocie bitfield
>   * @isr_eoc:		interrupt status register & eoc bitfield
> @@ -140,7 +140,7 @@ struct stm32_adc_regspec {
>  struct stm32_adc;
>  
>  /**
> - * stm32_adc_cfg - stm32 compatible configuration data
> + * struct stm32_adc_cfg - stm32 compatible configuration data
>   * @regs:		registers descriptions
>   * @adc_info:		per instance input channels definitions
>   * @trigs:		external trigger sources
> @@ -183,8 +183,8 @@ struct stm32_adc_cfg {
>   * @rx_buf:		dma rx buffer cpu address
>   * @rx_dma_buf:		dma rx buffer bus address
>   * @rx_buf_sz:		dma rx buffer size
> - * @difsel		bitmask to set single-ended/differential channel
> - * @pcsel		bitmask to preselect channels on some devices
> + * @difsel:		bitmask to set single-ended/differential channel
> + * @pcsel:		bitmask to preselect channels on some devices
>   * @smpr_val:		sampling time settings (e.g. smpr1 / smpr2)
>   * @cal:		optional calibration data on some devices
>   * @chan_name:		channel name array
> @@ -254,7 +254,7 @@ static const struct stm32_adc_info stm32h7_adc_info = {
>  	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
>  };
>  
> -/**
> +/*
>   * stm32f4_sq - describe regular sequence registers
>   * - L: sequence len (register & bit field)
>   * - SQ1..SQ16: sequence entries (register & bit field)
> @@ -301,7 +301,7 @@ static struct stm32_adc_trig_info stm32f4_adc_trigs[] = {
>  	{}, /* sentinel */
>  };
>  
> -/**
> +/*
>   * stm32f4_smp_bits[] - describe sampling time register index & bit fields
>   * Sorted so it can be indexed by channel number.
>   */
> @@ -392,7 +392,7 @@ static struct stm32_adc_trig_info stm32h7_adc_trigs[] = {
>  	{},
>  };
>  
> -/**
> +/*
>   * stm32h7_smp_bits - describe sampling time register index & bit fields
>   * Sorted so it can be indexed by channel number.
>   */
> @@ -994,6 +994,7 @@ static int stm32_adc_conf_scan_seq(struct iio_dev *indio_dev,
>  
>  /**
>   * stm32_adc_get_trig_extsel() - Get external trigger selection
> + * @indio_dev: IIO device structure
>   * @trig: trigger
>   *
>   * Returns trigger extsel value, if trig matches, -EINVAL otherwise.
> @@ -1297,6 +1298,10 @@ static int stm32_adc_of_xlate(struct iio_dev *indio_dev,
>  
>  /**
>   * stm32_adc_debugfs_reg_access - read or write register value
> + * @indio_dev: IIO device structure
> + * @reg: register offset
> + * @writeval: value to write
> + * @readval: value to read
>   *
>   * To read a value from an ADC register:
>   *   echo [ADC reg offset] > direct_reg_access

