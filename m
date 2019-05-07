Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3101C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2C520578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 13:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEGNhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 09:37:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:31717 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726428AbfEGNhZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 09:37:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 06:37:24 -0700
X-ExtLoop1: 1
Received: from asakoono-mobl.gar.corp.intel.com (HELO [10.251.159.132]) ([10.251.159.132])
  by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 06:37:23 -0700
Subject: Re: [alsa-devel] [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
To:     "M R, Sathya Prakash" <sathya.prakash.m.r@intel.com>,
        Evan Green <evgreen@chromium.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rajat Jain <rajatja@chromium.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ben Zhang <benzh@chromium.org>,
        "M, Naveen" <naveen.m@intel.com>
References: <20190506225321.74100-1-evgreen@chromium.org>
 <20190506225321.74100-2-evgreen@chromium.org>
 <74e8cfcd-b99f-7f66-48ce-44d60eb2bbca@linux.intel.com>
 <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ff778a2b-ee22-6223-199c-856da069f755@linux.intel.com>
Date:   Tue, 7 May 2019 08:37:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <64FD1F8348A3A14CA3CB4D4C9EB1D15F30A7C756@BGSMSX107.gar.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/6/19 10:34 PM, M R, Sathya Prakash wrote:
> 
> 
> -----Original Message-----
> From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
> Sent: Tuesday, May 7, 2019 7:11 AM
> To: Evan Green <evgreen@chromium.org>; Liam Girdwood <liam.r.girdwood@linux.intel.com>; Mark Brown <broonie@kernel.org>
> Cc: M, Naveen <naveen.m@intel.com>; M R, Sathya Prakash <sathya.prakash.m.r@intel.com>; Ben Zhang <benzh@chromium.org>; Rajat Jain <rajatja@chromium.org>; Jaroslav Kysela <perex@perex.cz>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org; Takashi Iwai <tiwai@suse.com>; Liam Girdwood <lgirdwood@gmail.com>
> Subject: Re: [PATCH v1 1/2] ASoC: SOF: Add Comet Lake PCI ID
> 
> 
> 
> On 5/6/19 5:53 PM, Evan Green wrote:
>>> Add support for Intel Comet Lake platforms by adding a new Kconfig for
>>> CometLake and the appropriate PCI ID.
> 
>> This is odd. I checked internally a few weeks back and the CML PCI ID was 9dc8, same as WHL and CNL, so we did not add a PCI ID on purpose. To the best of my knowledge SOF probes fine on CML and the known issues can be found on the SOF github [1].
> 
> The PCI ID change is seen on later production Si versions. The PCI ID is 02c8.

we must be talking about a different skew. I'll check, give me a couple 
of days.

> 
>> Care to send the log of sudo lspci -s 0:1f.3 -vn ?
> 
> Here you go:
> localhost ~ # sudo lspci -s 0:1f.3 -vn
> 00:1f.3 0401: 8086:02c8
>          Subsystem: 8086:7270
>          Flags: fast devsel, IRQ 11
>          Memory at d1114000 (64-bit, non-prefetchable) [size=16K]
>          Memory at d1000000 (64-bit, non-prefetchable) [size=1M]
>          Capabilities: [50] Power Management version 3
>          Capabilities: [80] Vendor Specific Information: Len=14 <?>
>          Capabilities: [60] MSI: Enable- Count=1/1 Maskable- 64bit+
> 
> 
> [1]
> https://github.com/thesofproject/sof/issues?q=is%3Aopen+is%3Aissue+label%3ACML
>>
>> Signed-off-by: Evan Green <evgreen@chromium.org>
>> ---
>>
>>    sound/soc/sof/intel/Kconfig | 16 ++++++++++++++++
>>    sound/soc/sof/sof-pci-dev.c |  4 ++++
>>    2 files changed, 20 insertions(+)
>>
>> diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
>> index 32ee0fabab92..0b616d025f05 100644
>> --- a/sound/soc/sof/intel/Kconfig
>> +++ b/sound/soc/sof/intel/Kconfig
>> @@ -24,6 +24,7 @@ config SND_SOC_SOF_INTEL_PCI
>>    	select SND_SOC_SOF_CANNONLAKE  if SND_SOC_SOF_CANNONLAKE_SUPPORT
>>    	select SND_SOC_SOF_COFFEELAKE  if SND_SOC_SOF_COFFEELAKE_SUPPORT
>>    	select SND_SOC_SOF_ICELAKE     if SND_SOC_SOF_ICELAKE_SUPPORT
>> +	select SND_SOC_SOF_COMETLAKE   if SND_SOC_SOF_COMETLAKE_SUPPORT
>>    	help
>>    	  This option is not user-selectable but automagically handled by
>>    	  'select' statements at a higher level @@ -179,6 +180,21 @@ config
>> SND_SOC_SOF_ICELAKE
>>    	  This option is not user-selectable but automagically handled by
>>    	  'select' statements at a higher level
>>    
>> +config SND_SOC_SOF_COMETLAKE
>> +	tristate
>> +	select SND_SOC_SOF_CANNONLAKE
>> +	help
>> +	  This option is not user-selectable but automagically handled by
>> +	  'select' statements at a higher level
>> +
>> +config SND_SOC_SOF_COMETLAKE_SUPPORT
>> +	bool "SOF support for CometLake"
>> +	help
>> +	  This adds support for Sound Open Firmware for Intel(R) platforms
>> +	  using the Cometlake processors.
>> +	  Say Y if you have such a device.
>> +	  If unsure select "N".
>> +
>>    config SND_SOC_SOF_HDA_COMMON
>>    	tristate
>>    	select SND_SOC_SOF_INTEL_COMMON
>> diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
>> index b778dffb2d25..5f0128337e40 100644
>> --- a/sound/soc/sof/sof-pci-dev.c
>> +++ b/sound/soc/sof/sof-pci-dev.c
>> @@ -353,6 +353,10 @@ static const struct pci_device_id sof_pci_ids[] = {
>>    #if IS_ENABLED(CONFIG_SND_SOC_SOF_ICELAKE)
>>    	{ PCI_DEVICE(0x8086, 0x34C8),
>>    		.driver_data = (unsigned long)&icl_desc},
>> +#endif
>> +#if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE)
>> +	{ PCI_DEVICE(0x8086, 0x02c8),
>> +		.driver_data = (unsigned long)&cnl_desc},
>>    #endif
>>    	{ 0, }
>>    };
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
