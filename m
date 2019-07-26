Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B632C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1134822ADA
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 11:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfGZLOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 07:14:11 -0400
Received: from mga14.intel.com ([192.55.52.115]:53769 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfGZLOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 07:14:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 04:14:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,310,1559545200"; 
   d="scan'208";a="175563818"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.251.89.116]) ([10.251.89.116])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2019 04:14:06 -0700
Subject: Re: [RFC PATCH 00/40] soundwire: updates for 5.4
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <6d268dd6-5f1a-e1f4-b0be-c3b978f89cb1@intel.com>
Date:   Fri, 26 Jul 2019 13:14:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-07-26 01:39, Pierre-Louis Bossart wrote:
> The existing upstream code allows for SoundWire devices to be
> enumerated and managed by the bus, but streaming is not currently
> supported.
> 
> Bard Liao, Rander Wang and I did quite a bit of integration/validation
> work to close this gap and we now have SoundWire streaming + basic
> power managemement on Intel CometLake and IceLake reference
> boards. These changes are still preliminary and should not be merged
> as is, but it's time to start reviews. While the number of patches is
> quite large, each of the changes is quite small.
> 
> SOF driver changes will be submitted shortly as well but are still
> being validated.
> 
> ClockStop modes and synchronized playback on
> multiple links are not supported for now and will likely be part of
> the next cycle (dependencies on codec drivers and multi-cpu DAI
> support).
> 
> Acknowledgements: This work would not have been possible without the
> support of Slawomir Blauciak and Tomasz Lauda on the SOF side,
> currently being reviewed, see
> https://github.com/thesofproject/sof/pull/1638
> 
> Comments and feedback welcome!

Hello Pierre,

This patchset is pretty large - I'd suggest dividing next RFC into 
segments: debugfs, info, power-management, basic flow corrections and 
frame shape calculator.
Some commits have no messages and others lack additional info - tried to 
provide feedback wherever I could, though, especially for the last one, 
it would be vital to post additional info so in-depth feedback can be 
provided.

Maybe nothing for calculator will come up, maybe something will. In 
general I remember it being an essential part of SDW and one where many 
bugs where found during the initial verification phase.

Thanks for your contribution and have a good day!
Czarek
