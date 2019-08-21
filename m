Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54983C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 345DB206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 14:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfHUODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 10:03:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:4548 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728985AbfHUOD2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 10:03:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 07:03:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,412,1559545200"; 
   d="scan'208";a="172786398"
Received: from jmillerk-mobl1.amr.corp.intel.com (HELO [10.251.18.166]) ([10.251.18.166])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2019 07:03:27 -0700
Subject: Re: [alsa-devel] [PATCH 00/17] soundwire: fixes for 5.4
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, Blauciak@gmail-pop.l.google.com,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        Slawomir <slawomir.blauciak@intel.com>
References: <20190806005522.22642-1-pierre-louis.bossart@linux.intel.com>
 <20190821090742.GI12733@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8ec1bed6-af4d-4be1-93b6-273ee27ce5e4@linux.intel.com>
Date:   Wed, 21 Aug 2019 09:03:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821090742.GI12733@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/21/19 4:07 AM, Vinod Koul wrote:
> On 05-08-19, 19:55, Pierre-Louis Bossart wrote:
>> This series provides an update on the initial RFC. Debugfs and Intel
>> updates will be provided in follow-up patches. The order of patches
>> was changed since the RFC so detailed change logs are provided below.
> 
> Applied all except 14, which didnt apply, thanks

yes, that's a miss, there was a debugfs line that created a dependency 
with the other patches that were not applied because of the lack of 
alignment between soundwire/fixes and soundwire/next.
Will resubmit.
