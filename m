Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CEBC3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16022064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfHPLNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:13:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:53004 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfHPLNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:13:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2019 04:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,393,1559545200"; 
   d="scan'208";a="188785382"
Received: from mprabhug-mobl1.amr.corp.intel.com (HELO [10.252.132.82]) ([10.252.132.82])
  by orsmga002.jf.intel.com with ESMTP; 16 Aug 2019 04:13:47 -0700
Subject: Re: [alsa-devel] [PATCH v2 0/3] soundwire: debugfs support for 5.4
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com
References: <20190812235942.7120-1-pierre-louis.bossart@linux.intel.com>
 <20190816094308.GA12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9f4789b2-66bd-4b17-2b13-934348a18691@linux.intel.com>
Date:   Fri, 16 Aug 2019 06:13:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816094308.GA12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/16/19 4:43 AM, Vinod Koul wrote:
> On 12-08-19, 18:59, Pierre-Louis Bossart wrote:
>> This patchset enables debugfs support and corrects all the feedback
>> provided on an earlier RFC ('soundwire: updates for 5.4')
>>
>> There is one remaining hard-coded value in intel.c that will need to
>> be fixed in a follow-up patchset not specific to debugfs: we need to
>> remove hard-coded Intel-specific configurations from cadence_master.c
>> (PDI offsets, etc).
>>
>> Changes since v1 (Feedback from GKH)
>> Handle debugfs in a more self-contained way (no dentry as return or parameter)
>> Used CONFIG_DEBUG_FS in structures and code to make it easier to
>> remove if need be.
>> No functional change for register dumps.
>>
>> Changes since RFC (Feedback from GKH, Vinod, Guennadi, Cezary, Sanyog):
>> removed error checks
>> used DEFINE_SHOW_ATTRIBUTE and seq_file
>> fixed copyright dates
>> fixed SPDX license info to use GPL2.0 only
>> fixed Makefile to include debugfs only if CONFIG_DEBUG_FS is selected
>> used static inlines for fallback compilation
>> removed intermediate variables
>> removed hard-coded constants in loops (used registers offsets and
>> hardware capabilities)
>> squashed patch 3
> 
> These looks good but failed to apply. Please rebase on soundwire-next
> and resend

Could you do us a favor and make sure your soundwire/fixes branch is 
actually merged in soundwire/next? in this case the Makefile is changed 
in soundwire/fixes and not in next.
If you use git am --3way things work fine and the conflict is resolved.

Applying: soundwire: add debugfs support
Using index info to reconstruct a base tree...
M	drivers/soundwire/Makefile
M	include/linux/soundwire/sdw.h
Falling back to patching base and 3-way merge...
Auto-merging include/linux/soundwire/sdw.h
Auto-merging drivers/soundwire/Makefile
Applying: soundwire: cadence_master: add debugfs register dump
Applying: soundwire: intel: add debugfs register dump
