Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E14FC28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96F424009
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EftG0tcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfE2RyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:54:24 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2RyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4fmAXjgAlgrqWrjrvceWv+cvuht35jcWY2gjbzwdhQU=; b=EftG0tcQ+1MUBbc6HadzBAFfG
        I6KWn/XYspZ50XkoqimhzyI/Z8s7ZeP60qsN4s5AOsfriA97cf3snBVOoMMzQ43U+ImWqzdE2HZFr
        yaTs75jUMqY5paZBR0v7GqD7OdcjRIFAXieMd+Zfctp0aXRHAH6gxD8qiRWESP909JNUMPS5hZ7Un
        Vj0qjOaXb66RvcnHsh2FKh38/nO4Be0qw+IYvkUT8SsHGMY/rXhjaqWk2V7aQ9RhXCWTFvq6Nz+eG
        bEV4qedcOZ7XSweMaopEXGK6GzeT2fmXTg4GISq4eVMJlJKTBesCTz85e6oXajUGz4cftqKusthsm
        CRVRVFzmA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hW2mJ-0001X1-VK; Wed, 29 May 2019 17:54:20 +0000
Subject: Re: ERROR: "hdac_hdmi_jack_port_init"
 [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!
To:     kbuild test robot <lkp@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
References: <201905281758.K64LbM6G%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <30d084d6-207a-053d-6ab4-0096a1d8d216@infradead.org>
Date:   Wed, 29 May 2019 10:54:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <201905281758.K64LbM6G%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/28/19 2:54 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   cd6c84d8f0cdc911df435bb075ba22ce3c605b07
> commit: f70abd75b7c6c04d3219d0b3a0f3f15411b042fb ASoC: Intel: add sof-rt5682 machine driver
> date:   4 weeks ago
> config: x86_64-randconfig-b005272310-05281357 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> reproduce:
>         git checkout f70abd75b7c6c04d3219d0b3a0f3f15411b042fb
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "hdac_hdmi_jack_port_init" [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!
>>> ERROR: "hdac_hdmi_jack_init" [sound/soc/intel/boards/snd-soc-sof_rt5682.ko] undefined!

Confirmed on 5.2-rc2.

Needs CONFIG_SND_SOC_HDAC_HDMI to be set for those functions to be built.

CONFIG_SND_SOC_SOF_BAYTRAIL=m
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=m

CONFIG_SND_SOC_SOF_HDA_COMMON is not set; the "select ... if" in the middle
[<<<<<<<<<<] of this Kconfig entry is preventing SND_SOC_HDAC_HDMI from being set:

if SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL
config SND_SOC_INTEL_SOF_RT5682_MACH
	tristate "SOF with rt5682 codec in I2S Mode"
	depends on I2C && ACPI
	depends on (SND_SOC_SOF_HDA_COMMON && MFD_INTEL_LPSS) ||\
		   (SND_SOC_SOF_BAYTRAIL && X86_INTEL_LPSS)
	select SND_SOC_RT5682
	select SND_SOC_DMIC
	select SND_SOC_HDAC_HDMI if SND_SOC_SOF_HDA_COMMON <<<<<<<<<<
	help
	   This adds support for ASoC machine driver for SOF platforms
	   with rt5682 codec.
	   Say Y if you have such a device.
	   If unsure select "N".
endif ## SND_SOC_SOF_HDA_COMMON || SND_SOC_SOF_BAYTRAIL




-- 
~Randy
