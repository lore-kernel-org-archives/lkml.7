Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F61C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D132173E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 12:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbfH1Mk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 08:40:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:53769 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfH1Mk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 08:40:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 05:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="210152703"
Received: from deyangko-mobl.ccr.corp.intel.com ([10.249.168.35])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2019 05:40:23 -0700
Message-ID: <63b8753a2a58688e75f6e03c46c84a064a123d85.camel@intel.com>
Subject: Re: [PATCH v5 03/18] thermal: fix indentation in makefile
From:   Zhang Rui <rui.zhang@intel.com>
To:     Yangtao Li <tiny.windzz@gmail.com>, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        nicolas.ferre@microchip.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 28 Aug 2019 20:40:33 +0800
In-Reply-To: <20190810052829.6032-4-tiny.windzz@gmail.com>
References: <20190810052829.6032-1-tiny.windzz@gmail.com>
         <20190810052829.6032-4-tiny.windzz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2019-08-10 at 05:28 +0000, Yangtao Li wrote:
> To unify code style.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

the later patches in this series does not change Makefile.
So this seems to be a cleanup patch independent of this patch set.
It's better to remove this patch from this patch series.

thanks,
rui
> ---
>  drivers/thermal/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
> index fa6f8b206281..d7eafb5ef8ef 100644
> --- a/drivers/thermal/Makefile
> +++ b/drivers/thermal/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_THERMAL)		+= thermal_sys.o
>  thermal_sys-y			+= thermal_core.o
> thermal_sysfs.o \
> -					thermal_helpers.o
> +				   thermal_helpers.o
>  
>  # interface to/from other layers providing sensors
>  thermal_sys-$(CONFIG_THERMAL_HWMON)		+= thermal_hwmon.o
> @@ -25,11 +25,11 @@ thermal_sys-$(CONFIG_CPU_THERMAL)	+=
> cpu_cooling.o
>  thermal_sys-$(CONFIG_CLOCK_THERMAL)	+= clock_cooling.o
>  
>  # devfreq cooling
> -thermal_sys-$(CONFIG_DEVFREQ_THERMAL) += devfreq_cooling.o
> +thermal_sys-$(CONFIG_DEVFREQ_THERMAL) 	+= devfreq_cooling.o
>  
>  # platform thermal drivers
>  obj-y				+= broadcom/
> -obj-$(CONFIG_THERMAL_MMIO)		+= thermal_mmio.o
> +obj-$(CONFIG_THERMAL_MMIO)	+= thermal_mmio.o
>  obj-$(CONFIG_SPEAR_THERMAL)	+= spear_thermal.o
>  obj-$(CONFIG_SUN8I_THERMAL)     += sun8i_thermal.o
>  obj-$(CONFIG_ROCKCHIP_THERMAL)	+= rockchip_thermal.o
> @@ -50,7 +50,7 @@ obj-$(CONFIG_TI_SOC_THERMAL)	+= ti-soc-
> thermal/
>  obj-y				+= st/
>  obj-$(CONFIG_QCOM_TSENS)	+= qcom/
>  obj-y				+= tegra/
> -obj-$(CONFIG_HISI_THERMAL)     += hisi_thermal.o
> +obj-$(CONFIG_HISI_THERMAL)     	+= hisi_thermal.o
>  obj-$(CONFIG_MTK_THERMAL)	+= mtk_thermal.o
>  obj-$(CONFIG_GENERIC_ADC_THERMAL)	+= thermal-generic-adc.o
>  obj-$(CONFIG_ZX2967_THERMAL)	+= zx2967_thermal.o

