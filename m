Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A063DC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720D820828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 14:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbfH0O6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 10:58:40 -0400
Received: from mga11.intel.com ([192.55.52.93]:64152 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0O6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 10:58:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 07:58:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="380944372"
Received: from rileyrox-mobl.amr.corp.intel.com (HELO [10.254.31.52]) ([10.254.31.52])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 07:58:38 -0700
Subject: Re: [alsa-devel] [PATCH 0/6] Small fixes
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>, alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d7dae124-eaef-4cc7-50a9-ea66521775b4@linux.intel.com>
Date:   Tue, 27 Aug 2019 09:58:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190827141712.21015-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/27/19 9:17 AM, Amadeusz Sławiński wrote:
> Series of small fixes:
> * fixes few issues found during checking code with static checkers
> * fix few prints
> * define function in header, like it should be
> * release topology when done with it
> 
> Amadeusz Sławiński (6):
>    ASoC: Intel: Skylake: Use correct function to access iomem space
>    ASoC: Intel: Fix use of potentially uninitialized variable
>    ASoC: dapm: Expose snd_soc_dapm_new_control_unlocked properly
>    ASoC: Intel: Skylake: Print module type instead of id
>    ASoC: Intel: Skylake: Release topology when we are done with it
>    ASoC: Intel: NHLT: Fix debug print format

LGTM

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
>   include/sound/soc-dapm.h               |  3 +++
>   sound/soc/intel/common/sst-ipc.c       |  2 ++
>   sound/soc/intel/skylake/skl-debug.c    |  2 +-
>   sound/soc/intel/skylake/skl-messages.c |  5 +++--
>   sound/soc/intel/skylake/skl-nhlt.c     |  2 +-
>   sound/soc/intel/skylake/skl-topology.c | 20 ++++++++++----------
>   sound/soc/intel/skylake/skl.h          |  1 -
>   sound/soc/soc-topology.c               |  6 ------
>   8 files changed, 20 insertions(+), 21 deletions(-)
> 
