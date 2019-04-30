Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15A8C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EAE21670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 13:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfD3NiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 09:38:06 -0400
Received: from mga04.intel.com ([192.55.52.120]:29308 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfD3NiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 09:38:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 06:38:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,413,1549958400"; 
   d="scan'208";a="140102964"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 30 Apr 2019 06:38:04 -0700
Received: from brettjgr-mobl1.ger.corp.intel.com (unknown [10.254.180.216])
        by linux.intel.com (Postfix) with ESMTP id 1804A580372;
        Tue, 30 Apr 2019 06:38:03 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190430085153.GS3845@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9866ac8c-103d-22cd-a639-a71c39a685c2@linux.intel.com>
Date:   Tue, 30 Apr 2019 08:38:01 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430085153.GS3845@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/30/19 3:51 AM, Vinod Koul wrote:
> On 15-04-19, 08:09, Pierre-Louis Bossart wrote:
>>
>>>>
>>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>>> ---
>>>>    drivers/soundwire/Kconfig          |   2 +-
>>>>    drivers/soundwire/bus.c            |  87 ++++++++--------
>>>>    drivers/soundwire/bus.h            |  16 +--
>>>>    drivers/soundwire/bus_type.c       |   4 +-
>>>>    drivers/soundwire/cadence_master.c |  87 ++++++++--------
>>>>    drivers/soundwire/cadence_master.h |  22 ++--
>>>>    drivers/soundwire/intel.c          |  87 ++++++++--------
>>>>    drivers/soundwire/intel.h          |   4 +-
>>>>    drivers/soundwire/intel_init.c     |  12 +--
>>>>    drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
>>>>    drivers/soundwire/slave.c          |  10 +-
>>>>    drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
>>>
>>> I would prefer this to be a patch per module. It doesnt help to have a
>>> single patch for all the files!
>>>
>>> It would be great to have cleanup done per logical group, for example
>>> typos in a patch, aligns in another etc...
>>
>> You've got to be kidding. I've never seen people ask for this sort of
>> detail.
> 
> Nope this is the way it should be. A patch is patch and which
> should do one thing! Even if it is a cleanup one.
> 
> I dislike a patch which touches everything, core, modules, so please
> split up. As a said in review it takes guesswork to find why a change
> was done, was it whitespace fix, indentation or not, so please split up
> based on type of fixes.

With all due respect, you are not helping here but rather slowing things 
down. I've done dozens of cleanups in the ALSA tree and I didn't go in 
this sort of details. The fact that the series was tagged as Reviewed by 
Takashi on April 11 and we are still discussing trivial changes tells me 
the integration model is broken. It's not just me, the patches related 
to runtime-pm from your own Linaro colleagues posted on March 28 went 
nowhere either.

Moving forward, I suggest we merge SoundWire-related patches through the 
sound tree. There will be dependencies in the coming weeks between SOF 
and SoundWire and it makes no sense to have separate maintainers and 
make the life of early adopters more complicated than it needs to be. If 
we have 3-week delays for trivial stuff, I can't imagine what the pace 
will be when I publish the next 20-odd patches I am still working on, 
and the code needed for the SoundWire audio device class being 
standardized as we speak. Things were fine up to now since no one was 
actually using the code, we are in a different model now.
