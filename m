Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0EDCC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82B220651
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbfGZOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:43:36 -0400
Received: from mga02.intel.com ([134.134.136.20]:38937 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbfGZOng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:43:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 07:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="322055734"
Received: from msmall-mobl.amr.corp.intel.com (HELO [10.251.154.62]) ([10.251.154.62])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2019 07:43:34 -0700
Subject: Re: [alsa-devel] [RFC PATCH 29/40] soundwire: intel_init: add kernel
 module parameter to filter out links
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-30-pierre-louis.bossart@linux.intel.com>
 <c1d859dc-3fd6-0be7-2240-c3b1f3240c0a@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <a8ac6b27-ce30-2a76-aeab-d01acbac4265@linux.intel.com>
Date:   Fri, 26 Jul 2019 09:43:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c1d859dc-3fd6-0be7-2240-c3b1f3240c0a@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/19 5:30 AM, Cezary Rojewski wrote:
> On 2019-07-26 01:40, Pierre-Louis Bossart wrote:
>> @@ -83,6 +87,9 @@ static struct sdw_intel_ctx
>>       caps = ioread32(res->mmio_base + SDW_SHIM_BASE + SDW_SHIM_LCAP);
>>       caps &= GENMASK(2, 0);
>> +    dev_dbg(&adev->dev, "SoundWire links: BIOS count %d hardware caps 
>> %d\n",
>> +        count, caps);
>> +
>>       /* Check HW supported vs property value and use min of two */
>>       count = min_t(u8, caps, count);
> 
> This message does not look like it belongs to current patch - no 
> link_mask dependency whatsoever. There have been couple "informative" 
> patches in your series, maybe schedule it with them instead (as a 
> separate series)?

You're right, this log should be in a different patch. it was added when 
I was debugging the DisCo properties a couple of months back and should 
be moved. thanks for noting this.
