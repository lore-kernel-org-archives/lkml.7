Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1465C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF54D20665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfHMTIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:08:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:19500 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbfHMTIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:08:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 12:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,382,1559545200"; 
   d="scan'208";a="176293507"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 13 Aug 2019 12:08:17 -0700
Received: from dalyrusx-mobl.amr.corp.intel.com (unknown [10.251.3.205])
        by linux.intel.com (Postfix) with ESMTP id 410AE5800FE;
        Tue, 13 Aug 2019 12:08:16 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] soundwire: Add compute_params callback
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org,
        spapothi@codeaurora.org
References: <20190813083550.5877-1-srinivas.kandagatla@linaro.org>
 <20190813083550.5877-2-srinivas.kandagatla@linaro.org>
 <7e462330-a357-698a-b259-5ff136963a57@linux.intel.com>
 <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3fd3c98c-eb25-7040-3089-f5e5bc9d24ee@linux.intel.com>
Date:   Tue, 13 Aug 2019 14:08:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1a02f190-0aab-d512-ceb0-4a21014705e8@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/19 1:17 PM, Srinivas Kandagatla wrote:
> 
> 
> On 13/08/2019 15:34, Pierre-Louis Bossart wrote:
>> On 8/13/19 3:35 AM, Srinivas Kandagatla wrote:
>>> From: Vinod Koul <vkoul@kernel.org>
>>>
>>> This callback allows masters to compute the bus parameters required.
>>
>> This looks like a partial use of the patch ('soundwire: Add Intel 
>> resource management algorithm')? see comments below
>>
> 
> Yes it duplicate indeed!
> 
> I will use that patch!

Actually please don't...
we found issues with the Intel allocation so I'd rather have the big 
Intel patch split into two parts, with callbacks+prepare/deprepare 
changes going in first. It'll be much faster/nicer for everyone.

