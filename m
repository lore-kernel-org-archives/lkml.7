Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E7BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA63820880
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 12:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfDOM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 08:57:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:49492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727326AbfDOM5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 08:57:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 05:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="149552679"
Received: from ddimarco-mobl1.amr.corp.intel.com (HELO [10.252.206.7]) ([10.252.206.7])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 05:57:04 -0700
Subject: Re: [alsa-devel] [PATCH v3 0/5] soundwire: code cleanup
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190414100417.GH28103@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
Date:   Mon, 15 Apr 2019 07:57:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414100417.GH28103@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/19 5:04 AM, Vinod Koul wrote:
> On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
>> SoundWire support will be provided in Linux with the Sound Open
>> Firmware (SOF) on Intel platforms. Before we start adding the missing
>> pieces, there are a number of warnings and style issues reported by
>> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
> 
> Applied, 1, 3 and 4 (5 looked good but didnt apply)

this applies on top of Mark Brown's for-next tree. This should be the 
reference really for SoundWire work, if we start having another tree 
with deltas it's really counter productive. I already have dependencies 
on acpi...
