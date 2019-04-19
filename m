Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D4C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD25620652
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfDSS0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:26:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:9990 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbfDSS0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:26:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 10:14:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="152260890"
Received: from unknown (HELO [10.251.7.229]) ([10.251.7.229])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2019 10:14:33 -0700
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com, joe@perches.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
 <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Message-ID: <37c5af39-a1e4-adc3-e8a9-bcada8e3b35b@linux.intel.com>
Date:   Fri, 19 Apr 2019 12:14:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>   enum sdw_command_response
>>>   cdns_xfer_msg_defer(struct sdw_bus *bus,
>>> -        struct sdw_msg *msg, struct sdw_defer *defer)
>>> +            struct sdw_msg *msg, struct sdw_defer *defer)
>>
>> this one too..
>>
>>>   static int cdns_port_params(struct sdw_bus *bus,
>>> -        struct sdw_port_params *p_params, unsigned int bank)
>>> +                struct sdw_port_params *p_params, unsigned int bank)
>>
>> here as well.. (and giving up on rest)
> 
> Please check for yourself that this is a diff illusion w/ tab space.

Vinod, can you please double-check, the alignment issues you reported 
don't exist, see e.g. below what the code looks like after merge.


int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
                        struct sdw_defer *defer)

int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
                  u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)

