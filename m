Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F5C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1D120652
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 14:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbfEBOzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 10:55:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:64431 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfEBOzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 10:55:45 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 07:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="320858498"
Received: from sfloyd-t480s.amr.corp.intel.com (HELO [10.251.147.239]) ([10.251.147.239])
  by orsmga005.jf.intel.com with ESMTP; 02 May 2019 07:55:43 -0700
Subject: Re: [alsa-devel] [PATCH v4 22/22] soundwire: add missing newlines in
 dynamic debug logs
To:     Greg KH <gregkh@linuxfoundation.org>, Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190501155745.21806-1-pierre-louis.bossart@linux.intel.com>
 <20190501155745.21806-23-pierre-louis.bossart@linux.intel.com>
 <20190502053746.GE3845@vkoul-mobl.Dlink> <20190502063219.GB14347@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5e81b8ff-b5e0-47a0-8bb9-d63e7532bf14@linux.intel.com>
Date:   Thu, 2 May 2019 09:55:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502063219.GB14347@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/19 1:32 AM, Greg KH wrote:
> On Thu, May 02, 2019 at 11:07:46AM +0530, Vinod Koul wrote:
>> On 01-05-19, 10:57, Pierre-Louis Bossart wrote:
>>> For some reason the newlines are not used everywhere. Fix as needed.
>>>
>>> Reported-by: Joe Perches <joe@perches.com>
>>> Reviewed-by: Takashi Iwai <tiwai@suse.de>
>>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>> ---
>>>   drivers/soundwire/bus.c            |  74 +++++++++----------
>>>   drivers/soundwire/cadence_master.c |  12 ++--
>>>   drivers/soundwire/intel.c          |  12 ++--
>>>   drivers/soundwire/stream.c         | 110 ++++++++++++++---------------
>>
>> Sorry this needs to be split up. I think bus.c and stream.c should go
>> in patch with cadence_master.c and intel.c in different ones
> 
> Again, _way_ too picky.  You can't look a gift horse _too_ closely in
> the mouth...
> 
> greg k-h

Vinod, your distinction between subsystem and driver is quite arbitrary 
and borderline unreasonable. I would counter that the Intel parts have 
actually nothing to do in this drivers/soundwire directory and should be 
moved to the SOF tree if you push your own logic one step. There already 
known variations on capabilities and number of links which would be 
better handled in sound/soc/sof/intel, just like SoundWire slaves are 
expected to be in sound/soc/codecs.

Besides this fixes *newlines*...

I will send an update but I am not happy about the directions here.
