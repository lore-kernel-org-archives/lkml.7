Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4772AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B222339E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 13:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfH2NWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 09:22:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:35724 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfH2NWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 09:22:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 06:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="197804689"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.66]) ([10.237.72.66])
  by fmsmga001.fm.intel.com with ESMTP; 29 Aug 2019 06:22:16 -0700
Subject: Re: [PATCH V6 5/5] mmc: host: sdhci-pci: Add Genesys Logic GL975x
 support
To:     "Michael K. Johnson" <johnsonm@danlj.org>
Cc:     Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw
References: <20190827003335.2494-1-benchuanggli@gmail.com>
 <99735a03-c698-624d-f5cf-4feed7e6a9ca@intel.com>
 <20190828134714.GA30547@people.danlj.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <7fcd0fd5-97cb-1dab-7477-666838478541@intel.com>
Date:   Thu, 29 Aug 2019 16:21:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828134714.GA30547@people.danlj.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/19 4:47 PM, Michael K. Johnson wrote:
> On Wed, Aug 28, 2019 at 04:13:03PM +0300, Adrian Hunter wrote:
>> On 27/08/19 3:33 AM, Ben Chuang wrote:
>> Looks good, one minor comment
> ...
>>> +#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>
>> Arguably CONFIG_MMC_SDHCI_IO_ACCESSORS needs to be removed altogether. i.e.
>> making the accessors always available.  So for now, I'd prefer to select
>> MMC_SDHCI_IO_ACCESSORS:
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 14d89a108edd..c3bd967d8a1a 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -94,6 +94,7 @@ config MMC_SDHCI_PCI
>>  	depends on MMC_SDHCI && PCI
>>  	select MMC_CQHCI
>>  	select IOSF_MBI if X86
>> +	select MMC_SDHCI_IO_ACCESSORS
>>  	help
>>  	  This selects the PCI Secure Digital Host Controller Interface.
>>  	  Most controllers found today are PCI devices.
> 
> Unless I'm missing something, this seems like a separate patch;
> are you asking for it first, as a predecessor to the GLI patch?
> 

No, it is fine with this patch.
