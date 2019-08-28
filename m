Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6530C3A5A3
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 844C6214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 01:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbfH1BeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:34:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:7077 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfH1BeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 21:34:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 18:34:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,439,1559545200"; 
   d="scan'208";a="209956217"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 27 Aug 2019 18:34:19 -0700
Received: from [10.226.38.21] (vramuthx-mobl1.gar.corp.intel.com [10.226.38.21])
        by linux.intel.com (Postfix) with ESMTP id 90C1E580375;
        Tue, 27 Aug 2019 18:34:16 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mmc: sdhci-of-arasan: Add Support for Intel LGM
 eMMC
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
References: <20190826072800.38413-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190826072800.38413-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CAPDyKFrPoPqnh3_23P=wGO+QrUE9ogJzC6xgzy+0QeyuyeO=HQ@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <373e55ab-c76b-7657-bd47-1a5efc75a062@linux.intel.com>
Date:   Wed, 28 Aug 2019 09:34:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrPoPqnh3_23P=wGO+QrUE9ogJzC6xgzy+0QeyuyeO=HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On 27/8/2019 9:49 PM, Ulf Hansson wrote:
> On Mon, 26 Aug 2019 at 09:28, Ramuthevar,Vadivel MuruganX
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>> From: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> The current arasan sdhci PHY configuration isn't compatible
>> with the PHY on Intel's LGM(Lightning Mountain) SoC devices.
>>
>> Therefore, add a new compatible, to adapt the Intel's LGM
>> eMMC PHY with arasan-sdhc controller to configure the PHY.
>>
>> Signed-off-by: Ramuthevar Vadivel Muruganx <vadivel.muruganx.ramuthevar@linux.intel.com>
>
> Applied for next, thanks!
>
> Kind regards
> Uffe
>
Thank you so much for review and applied for next.

Best Regards
Vadivel
>> ---
>>   drivers/mmc/host/sdhci-of-arasan.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index b12abf9b15f2..7023cbec4017 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -114,6 +114,12 @@ static const struct sdhci_arasan_soc_ctl_map rk3399_soc_ctl_map = {
>>          .hiword_update = true,
>>   };
>>
>> +static const struct sdhci_arasan_soc_ctl_map intel_lgm_emmc_soc_ctl_map = {
>> +       .baseclkfreq = { .reg = 0xa0, .width = 8, .shift = 2 },
>> +       .clockmultiplier = { .reg = 0, .width = -1, .shift = -1 },
>> +       .hiword_update = false,
>> +};
>> +
>>   /**
>>    * sdhci_arasan_syscon_write - Write to a field in soc_ctl registers
>>    *
>> @@ -373,6 +379,11 @@ static struct sdhci_arasan_of_data sdhci_arasan_rk3399_data = {
>>          .pdata = &sdhci_arasan_cqe_pdata,
>>   };
>>
>> +static struct sdhci_arasan_of_data intel_lgm_emmc_data = {
>> +       .soc_ctl_map = &intel_lgm_emmc_soc_ctl_map,
>> +       .pdata = &sdhci_arasan_cqe_pdata,
>> +};
>> +
>>   #ifdef CONFIG_PM_SLEEP
>>   /**
>>    * sdhci_arasan_suspend - Suspend method for the driver
>> @@ -474,6 +485,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
>>                  .compatible = "rockchip,rk3399-sdhci-5.1",
>>                  .data = &sdhci_arasan_rk3399_data,
>>          },
>> +       {
>> +               .compatible = "intel,lgm-sdhci-5.1-emmc",
>> +               .data = &intel_lgm_emmc_data,
>> +       },
>>          /* Generic compatible below here */
>>          {
>>                  .compatible = "arasan,sdhci-8.9a",
>> --
>> 2.11.0
>>
