Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A335C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67FCC20651
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfDDThI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:37:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:32675 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbfDDThH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:37:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Apr 2019 12:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,309,1549958400"; 
   d="scan'208";a="288770635"
Received: from jespires-mobl2.amr.corp.intel.com (HELO [10.255.76.233]) ([10.255.76.233])
  by orsmga004.jf.intel.com with ESMTP; 04 Apr 2019 12:37:06 -0700
Subject: Re: [alsa-devel] [PATCH 1/3] soundwire: fix style issues
To:     Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        vkoul@kernel.org, broonie@kernel.org, jank@cadence.com,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190404182204.31262-1-pierre-louis.bossart@linux.intel.com>
 <20190404182204.31262-2-pierre-louis.bossart@linux.intel.com>
 <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <52a3a4a0-c81c-3daf-78b3-7668b621ecf1@linux.intel.com>
Date:   Thu, 4 Apr 2019 14:37:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <98050a8abfdd9ec015d4de846b276cf046115e3f.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Joe,

@@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave 
*slave)

>>   		mutex_unlock(&slave->bus->bus_lock);
>>   		if (dev_num < 0) {
>>   			dev_err(slave->bus->dev, "Get dev_num failed: %d",
>> -								dev_num);
>> +				dev_num);
> You could also add the missing terminating '\n' to these formats like:
>
>   			dev_err(slave->bus->dev, "Get dev_num failed: %d\n",
>
Yes indeed, I just fixed that tools reported, but that is a miss. Will 
fix with a v2 (hopefully with other comments).

-Pierre

