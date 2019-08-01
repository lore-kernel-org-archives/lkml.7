Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79D5C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9256620838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 16:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733168AbfHAQq4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 12:46:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:25929 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbfHAQq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 12:46:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 09:46:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,334,1559545200"; 
   d="scan'208";a="184304633"
Received: from jcclaybu-mobl1.amr.corp.intel.com (HELO [10.252.137.82]) ([10.252.137.82])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2019 09:46:54 -0700
Subject: Re: linux-next: manual merge of the sound-asoc tree with the sound
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>
References: <20190801125008.4a533637@canb.auug.org.au>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3dfa9102-6fe4-dc9e-12d5-8fac565059da@linux.intel.com>
Date:   Thu, 1 Aug 2019 11:46:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801125008.4a533637@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/19 9:50 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the sound-asoc tree got conflicts in:
> 
>    sound/soc/intel/skylake/skl-nhlt.c
>    sound/soc/intel/skylake/skl.h
> 
> between commit:
> 
>    1169cbf6b98e ("ASoC: Intel: Skylake: use common NHLT module")
> 
> from the sound tree and commit:
> 
>    bcc2a2dc3ba8 ("ASoC: Intel: Skylake: Merge skl_sst and skl into skl_dev struct")
> 
> from the sound-asoc tree.
> 
> I fixed it up (I think, see below (I used the sound tree version of
> ound/soc/intel/skylake/skl-nhlt.c)) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non
> trivial conflicts should be mentioned to your upstream maintainer when
> your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Mark, this comes my NHLT fixes merged by Takashi and available on his 
topic/hda-dmic branch.

This can be fixed by merging this topic/hda-dmic into your for-next 
branch, with a minor set of merge conflicts already identified by Stephen.

If you don't like merge conflicts, we can also do this with 
revert-merge-reapply, I pushed a branch 
https://github.com/plbossart/sound/commits/fix/nhlt-conflicts to provide 
the sequence needed

Sorry about that, let me know if I can help further.
-Pierre

