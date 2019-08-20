Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084ECC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE95822CF7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTIlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:41:03 -0400
Received: from mga18.intel.com ([134.134.136.126]:63414 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbfHTIlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:41:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 01:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="172385728"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2019 01:41:00 -0700
Subject: Re: [kbuild-all] [PATCH] fix odd_ptr_err.cocci warnings
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Julia Lawall <julia.lawall@lip6.fr>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org
References: <alpine.DEB.2.21.1908091229140.2946@hadrien>
 <20190809123112.GC3963@sirena.co.uk>
 <88ac4c79-5ce3-3f1a-5f6e-3928a30a1ef5@ti.com>
 <alpine.DEB.2.21.1908091519400.2946@hadrien>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <297e44a8-e08d-ddf2-e5e8-b532965b4a8d@intel.com>
Date:   Tue, 20 Aug 2019 16:41:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908091519400.2946@hadrien>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

We have updated to only send the reports to you, please see 
https://github.com/intel/lkp-tests/blob/master/repo/linux/omap-audio

Best Regards,
Rong Chen

On 8/9/19 9:21 PM, Julia Lawall wrote:
>
> On Fri, 9 Aug 2019, Peter Ujfalusi wrote:
>
>>
>> On 09/08/2019 15.31, Mark Brown wrote:
>>> On Fri, Aug 09, 2019 at 12:30:46PM +0200, Julia Lawall wrote:
>>>
>>>> tree:   https://github.com/omap-audio/linux-audio peter/ti-linux-4.19.y/wip
>>>> head:   62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a
>>>> commit: 62c9c1442c8f61ca93e62e1a9d8318be0abd9d9a [34/34] j721e new machine driver wip
>>>> :::::: branch date: 20 hours ago
>>>> :::::: commit date: 20 hours ago
>>>>
>>>>   j721e-evm.c |    4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> --- a/sound/soc/ti/j721e-evm.c
>>>> +++ b/sound/soc/ti/j721e-evm.c
>>>> @@ -283,7 +283,7 @@ static int j721e_get_clocks(struct platf
>>> This file isn't upstream, it's only in the TI BSP.
>> Yes, it is not upstream, but the fix is valid.
>>
>> Julia: is it possible to direct these notifications only to me from
>> https://github.com/omap-audio/linux-audio.git ?
>>
>> It mostly carries TI BSP stuff and my various for upstream branches nowdays.
> Please discuss it with the kbuild people.  They should be able to set it
> up as you want.
>
> You can try lkp@intel.com
>
> julia
> _______________________________________________
> kbuild-all mailing list
> kbuild-all@lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild-all

