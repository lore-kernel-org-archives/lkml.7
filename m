Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B404C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02ADC20693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbfDOMlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:41:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:13667 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfDOMlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:41:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 05:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="149549485"
Received: from ddimarco-mobl1.amr.corp.intel.com (HELO [10.252.206.7]) ([10.252.206.7])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 05:41:34 -0700
Subject: Re: [alsa-devel] [PATCH] soundwire: cdns: Fix compilation error on
 arm64
To:     Vinod Koul <vkoul@kernel.org>, Jan Kotas <jank@cadence.com>
Cc:     sanyog.r.kale@intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20190404081221.341-1-jank@cadence.com>
 <20190414094408.GF28103@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8ba31402-b507-5060-76be-89a7ddaf7dca@linux.intel.com>
Date:   Mon, 15 Apr 2019 07:41:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414094408.GF28103@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
>> index cb6a331f4..0b5bcc209 100644
>> --- a/drivers/soundwire/cadence_master.c
>> +++ b/drivers/soundwire/cadence_master.c
>> @@ -9,6 +9,7 @@
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>>   #include <linux/interrupt.h>
>> +#include <linux/io.h>
> 
> Why not add asm/io.h which is the header that actually defines
> readl/writel?

The vast majority of kernel code uses linux/io.h.
We use linux/io.h for SOF as well.

> 
>>   #include <linux/module.h>
>>   #include <linux/mod_devicetable.h>
>>   #include <linux/soundwire/sdw_registers.h>
>> -- 
>> 2.15.0
> 
