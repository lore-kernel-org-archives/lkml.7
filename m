Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26CCC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9939206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbfDQRS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:18:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:14147 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732321AbfDQRS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:18:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Apr 2019 10:18:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,362,1549958400"; 
   d="scan'208";a="224378485"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 17 Apr 2019 10:18:25 -0700
Received: from mhphan-mobl2.amr.corp.intel.com (unknown [10.255.84.70])
        by linux.intel.com (Postfix) with ESMTP id 79F5C580297;
        Wed, 17 Apr 2019 10:18:23 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
To:     Johan Hovold <johan@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com,
        jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
 <20190417093354.GL775@localhost>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <200c8e66-4245-967b-b80e-b6f6a63f80c5@linux.intel.com>
Date:   Wed, 17 Apr 2019 12:18:22 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417093354.GL775@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>>>> index 19c8efb9a5ee..84876a74874f 100644
>>>> --- a/drivers/soundwire/Kconfig
>>>> +++ b/drivers/soundwire/Kconfig
>>>> @@ -4,7 +4,7 @@
>>>>    
>>>>    menuconfig SOUNDWIRE
>>>>    	bool "SoundWire support"
>>>> -	---help---
>>>> +	help
>>>
>>> Not sure if this is a style issue, kernel seems to have 2990 instances
>>> of this!
>>
>> this is reported by checkpatch.pl --strict.
> 
> Please don't run checkpatch on code that's already in the kernel, and
> especially not with the --strict (a.k.a. --subjective) option enabled.
> 
> Don't try to fix what isn't broken.

I would agree in general, but this case is different: the SoundWire code 
in the upstream kernel is missing parts left and right and isn't fully 
functional as is. I will soon be posting what's missing, so this cleanup 
is an opportunity to bring SoundWire to the latest coding standards 
before adding the missing pieces which will be compliant with --strict. 
For the record using --strict already exposed 3 major issues in the 
yet-to-be-released code, so it's not as subjective as you describe it.
