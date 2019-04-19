Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9A0C282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48734204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbfDSScY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:36066 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727804AbfDSScU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:32:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 10:07:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="152259854"
Received: from unknown (HELO [10.251.7.229]) ([10.251.7.229])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2019 10:07:39 -0700
Subject: Re: [alsa-devel] [PATCH v3 0/5] soundwire: code cleanup
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190414100417.GH28103@vkoul-mobl>
 <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
Message-ID: <bb335979-61de-e2d7-d1b4-8e29e2beda49@linux.intel.com>
Date:   Fri, 19 Apr 2019 12:07:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <df6040ba-ab69-ae64-a27f-236e8ac95c14@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/15/19 7:57 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 4/14/19 5:04 AM, Vinod Koul wrote:
>> On 10-04-19, 22:16, Pierre-Louis Bossart wrote:
>>> SoundWire support will be provided in Linux with the Sound Open
>>> Firmware (SOF) on Intel platforms. Before we start adding the missing
>>> pieces, there are a number of warnings and style issues reported by
>>> checkpatch, cppcheck and Coccinelle that need to be cleaned-up.
>>
>> Applied, 1, 3 and 4 (5 looked good but didnt apply)
> 
> this applies on top of Mark Brown's for-next tree. This should be the 
> reference really for SoundWire work, if we start having another tree 
> with deltas it's really counter productive. I already have dependencies 
> on acpi...

Vinod, can you please double-check why patch 5 didn't work for you. I 
tried on Mark and Linus' trees and no issues, see below.

$ git reset --hard v5.1-rc5
HEAD is now at dc4060a5dc25 Linux 5.1-rc5

$ git am ~/Downloads/alsa/39/\[PATCH\ v3\ *.eml
Applying: soundwire: intel: fix inversion in devm_kcalloc parameters
Applying: soundwire: fix style issues
Applying: soundwire: bus: remove useless initializations
Applying: soundwire: stream: remove useless initialization of local variable
Applying: soundwire: add missing newlines in dynamic debug logs

$ git reset --hard broonie/for-next
HEAD is now at 84fdefca04a7 Merge branch 'asoc-5.2' into asoc-next

$ git am ~/Downloads/alsa/39/\[PATCH\ v3\ *.eml
Applying: soundwire: intel: fix inversion in devm_kcalloc parameters
Applying: soundwire: fix style issues
Applying: soundwire: bus: remove useless initializations
Applying: soundwire: stream: remove useless initialization of local variable
Applying: soundwire: add missing newlines in dynamic debug logs

