Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06664C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D584C20684
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfDONKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:10:07 -0400
Received: from mga02.intel.com ([134.134.136.20]:48636 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfDONKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:10:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Apr 2019 06:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,353,1549958400"; 
   d="scan'208";a="149555709"
Received: from ddimarco-mobl1.amr.corp.intel.com (HELO [10.252.206.7]) ([10.252.206.7])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Apr 2019 06:10:00 -0700
Subject: Re: [alsa-devel] [PATCH v3 2/5] soundwire: fix style issues
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com,
        srinivas.kandagatla@linaro.org,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20190411031701.5926-1-pierre-louis.bossart@linux.intel.com>
 <20190411031701.5926-3-pierre-louis.bossart@linux.intel.com>
 <20190414095839.GG28103@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <08ea1442-361a-ecfc-ca26-d3bd8a0ec37b@linux.intel.com>
Date:   Mon, 15 Apr 2019 08:09:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190414095839.GG28103@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   drivers/soundwire/Kconfig          |   2 +-
>>   drivers/soundwire/bus.c            |  87 ++++++++--------
>>   drivers/soundwire/bus.h            |  16 +--
>>   drivers/soundwire/bus_type.c       |   4 +-
>>   drivers/soundwire/cadence_master.c |  87 ++++++++--------
>>   drivers/soundwire/cadence_master.h |  22 ++--
>>   drivers/soundwire/intel.c          |  87 ++++++++--------
>>   drivers/soundwire/intel.h          |   4 +-
>>   drivers/soundwire/intel_init.c     |  12 +--
>>   drivers/soundwire/mipi_disco.c     | 116 +++++++++++----------
>>   drivers/soundwire/slave.c          |  10 +-
>>   drivers/soundwire/stream.c         | 161 +++++++++++++++--------------
> 
> I would prefer this to be a patch per module. It doesnt help to have a
> single patch for all the files!
> 
> It would be great to have cleanup done per logical group, for example
> typos in a patch, aligns in another etc...

You've got to be kidding. I've never seen people ask for this sort of 
detail.

> 
>>   12 files changed, 313 insertions(+), 295 deletions(-)
>>
>> diff --git a/drivers/soundwire/Kconfig b/drivers/soundwire/Kconfig
>> index 19c8efb9a5ee..84876a74874f 100644
>> --- a/drivers/soundwire/Kconfig
>> +++ b/drivers/soundwire/Kconfig
>> @@ -4,7 +4,7 @@
>>   
>>   menuconfig SOUNDWIRE
>>   	bool "SoundWire support"
>> -	---help---
>> +	help
> 
> Not sure if this is a style issue, kernel seems to have 2990 instances
> of this!

this is reported by checkpatch.pl --strict.

> 
>>   	if (msg->page)
>>   		sdw_reset_page(bus, msg->dev_num);
>> @@ -243,7 +244,7 @@ int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>>    * Caller needs to hold the msg_lock lock while calling this
>>    */
>>   int sdw_transfer_defer(struct sdw_bus *bus, struct sdw_msg *msg,
>> -				struct sdw_defer *defer)
>> +		       struct sdw_defer *defer)
> 
> this does not seem aligned to me!

It is, I checked. 2 tabs and 7 spaces.

> 
>>   int sdw_fill_msg(struct sdw_msg *msg, struct sdw_slave *slave,
>> -		u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
>> +		 u32 addr, size_t count, u16 dev_num, u8 flags, u8 *buf)
> 
> this one too

2 tabs and one space.

> 
>> @@ -458,13 +458,13 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>>   		mutex_unlock(&slave->bus->bus_lock);
>>   		if (dev_num < 0) {
>>   			dev_err(slave->bus->dev, "Get dev_num failed: %d",
>> -								dev_num);
>> +				dev_num);
> 
> It might read better if we move the log to second line along with
> dev_num...
> 
>>   int sdw_configure_dpn_intr(struct sdw_slave *slave,
>> -			int port, bool enable, int mask)
>> +			   int port, bool enable, int mask)
> 
> not aligned

it is in the code. It's a diff illusion.

> 
>>   void sdw_extract_slave_id(struct sdw_bus *bus,
>> -			u64 addr, struct sdw_slave_id *id);
>> +			  u64 addr, struct sdw_slave_id *id);
>>   
> 
> Not aligned

it is in the code. It's a diff illusion.

>   
>>   enum sdw_command_response
>>   cdns_xfer_msg_defer(struct sdw_bus *bus,
>> -		struct sdw_msg *msg, struct sdw_defer *defer)
>> +		    struct sdw_msg *msg, struct sdw_defer *defer)
> 
> this one too..
> 
>>   static int cdns_port_params(struct sdw_bus *bus,
>> -		struct sdw_port_params *p_params, unsigned int bank)
>> +			    struct sdw_port_params *p_params, unsigned int bank)
> 
> here as well.. (and giving up on rest)

Please check for yourself that this is a diff illusion w/ tab space.
