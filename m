Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E573CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01D2D21D7D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbfKDOoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:44:11 -0500
Received: from mga14.intel.com ([192.55.52.115]:29247 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbfKDOoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:44:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Nov 2019 06:44:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,267,1569308400"; 
   d="scan'208";a="402993324"
Received: from cckuo1-mobl2.amr.corp.intel.com (HELO [10.251.130.8]) ([10.251.130.8])
  by fmsmga006.fm.intel.com with ESMTP; 04 Nov 2019 06:44:07 -0800
Subject: Re: [alsa-devel] [PATCH 04/14] soundwire: bus_type: rename sdw_drv_
 to sdw_slave_drv
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20191023212823.608-1-pierre-louis.bossart@linux.intel.com>
 <20191023212823.608-5-pierre-louis.bossart@linux.intel.com>
 <20191103053003.GH2695@vkoul-mobl.Dlink>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <27887179-cdf7-bd66-2870-a58017921108@linux.intel.com>
Date:   Mon, 4 Nov 2019 08:34:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191103053003.GH2695@vkoul-mobl.Dlink>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/19 12:30 AM, Vinod Koul wrote:
> On 23-10-19, 16:28, Pierre-Louis Bossart wrote:
>> Before we add master driver support, make sure there is no ambiguity
>> and no occirrences of sdw_drv_ functions.
>          ^^^^^^^^^^^
> typo

Ack, will fix.

> 
>>
>> No functionality change.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/bus_type.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
>> index 2b2830b622fa..9a0fd3ee1014 100644
>> --- a/drivers/soundwire/bus_type.c
>> +++ b/drivers/soundwire/bus_type.c
>> @@ -67,7 +67,7 @@ struct bus_type sdw_bus_type = {
>>   };
>>   EXPORT_SYMBOL_GPL(sdw_bus_type);
>>   
>> -static int sdw_drv_probe(struct device *dev)
>> +static int sdw_slave_drv_probe(struct device *dev)
>>   {
>>   	struct sdw_slave *slave = to_sdw_slave_device(dev);
>>   	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
>> @@ -113,7 +113,7 @@ static int sdw_drv_probe(struct device *dev)
>>   	return 0;
>>   }
>>   
>> -static int sdw_drv_remove(struct device *dev)
>> +static int sdw_slave_drv_remove(struct device *dev)
>>   {
>>   	struct sdw_slave *slave = to_sdw_slave_device(dev);
>>   	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
>> @@ -127,7 +127,7 @@ static int sdw_drv_remove(struct device *dev)
>>   	return ret;
>>   }
>>   
>> -static void sdw_drv_shutdown(struct device *dev)
>> +static void sdw_slave_drv_shutdown(struct device *dev)
>>   {
>>   	struct sdw_slave *slave = to_sdw_slave_device(dev);
>>   	struct sdw_driver *drv = to_sdw_slave_driver(dev->driver);
>> @@ -155,13 +155,13 @@ int __sdw_register_slave_driver(struct sdw_driver *drv,
>>   	}
>>   
>>   	drv->driver.owner = owner;
>> -	drv->driver.probe = sdw_drv_probe;
>> +	drv->driver.probe = sdw_slave_drv_probe;
>>   
>>   	if (drv->remove)
>> -		drv->driver.remove = sdw_drv_remove;
>> +		drv->driver.remove = sdw_slave_drv_remove;
>>   
>>   	if (drv->shutdown)
>> -		drv->driver.shutdown = sdw_drv_shutdown;
>> +		drv->driver.shutdown = sdw_slave_drv_shutdown;
>>   
>>   	return driver_register(&drv->driver);
>>   }
>> -- 
>> 2.20.1
> 
