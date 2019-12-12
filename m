Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16022C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FF0227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729836AbfLLOh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:37:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:59461 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729758AbfLLOh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:37:57 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 06:37:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,306,1571727600"; 
   d="scan'208";a="220707571"
Received: from unknown (HELO pbossart-mac02.local) ([10.254.97.107])
  by fmsmga001.fm.intel.com with ESMTP; 12 Dec 2019 06:37:55 -0800
Subject: Re: [alsa-devel] [PATCH v5 00/11] soundwire: update ASoC interfaces
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
 <20191212034926.GK2536@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b60388fe-10a6-3a19-a575-243ed12bc611@linux.intel.com>
Date:   Thu, 12 Dec 2019 08:37:56 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191212034926.GK2536@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/19 9:49 PM, Vinod Koul wrote:
> On 11-12-19, 19:44, Pierre-Louis Bossart wrote:
>> We need new fields in existing structures to
>> a) deal with race conditions on codec probe/enumeration
>> b) allow for multi-step ACPI scan/probe/startup on Intel plaforms
>> c) deal with MSI issues using a single handler/threads for all audio
>> interrupts
>> d) deal with access to registers shared across multiple links on Intel
>> platforms
>>
>> These structures for a) will be used by the SOF driver as well as
>> codec drivers. The b) c) and d) cases are only for the Intel-specific
>> implementation.
>>
>> To avoid conflicts between ASoC and Soundwire trees, these 11 patches
>> are provided out-of-order, before the functionality enabled in these
>> header files is added in follow-up patch series which can be applied
>> separately in the ASoC and Soundwire trees. As discussed earlier,
>> Vinod would need to provide an immutable tag for Mark Brown, and the
>> integration on the ASoC side of SOF changes and new codecs drivers can
>> proceed in parallel with SoundWire core changes.
>>
>> I had multiple offline discussions with Vinod/Mark/Takashi on how to
>> proceed withe volume of SoundWire changes. Now that v5.5-rc1 is out we
>> should go ahead with these interface changes.
>>
>> The next patchset "[PATCH v3 00/15] soundwire: intel: implement new
>> ASoC interfaces​" can still be reviewed but will not apply as is due to
>> a one-line conflict. An update will be provided when Vinod applies
>> this series to avoid noise on mailing lists.
>>
>> An update for the series "[PATCH v3 00/22] soundwire: code hardening
>> and suspend-resume support" is ready but will be provided when both
>> the interfaces changes and the implementation changes are merged.
> 
> Applied, thanks
> 
> I will send the tag tomorrow after it is in next

Thanks Vinod, I will repost the following series tonight.

