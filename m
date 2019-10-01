Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0816CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8CA321920
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfJAMOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:14:03 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:34317 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725821AbfJAMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:14:02 -0400
Received: from [IPv6:2001:420:44c1:2577:10df:bfa0:cde1:e23a] ([IPv6:2001:420:44c1:2577:10df:bfa0:cde1:e23a])
        by smtp-cloud8.xs4all.net with ESMTPA
        id FH2Ri17rqKKNGFH2ViUKz9; Tue, 01 Oct 2019 14:14:00 +0200
Subject: Re: [PATCH v1 3/4] [media] usb: pulse8-cec: Switch to use %ptT
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20190104193009.30907-1-andriy.shevchenko@linux.intel.com>
 <20190104193009.30907-3-andriy.shevchenko@linux.intel.com>
 <20191001115705.GK32742@smile.fi.intel.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <4f8052d6-844c-b665-1c87-8f6b1f3df4f9@xs4all.nl>
Date:   Tue, 1 Oct 2019 14:13:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001115705.GK32742@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKAX0ab8v0O3Nn2LDZVw2CgshOlO5dpcLVL3OYOX47Uk1Zhq1NB0eFkmJbeWcfTWThdfdEk15D3DbOe/pcEX3I/MgqxNSbN7FtWXESX6M+gYvp7y97Df
 2gQ5v4cZrp9hEl5IWv5EyaaeJQcgngC1fabVh9oRSKaL2bo35xsnQ613ZJR68uI8WRzik5HMtRAI0nupb/5Jza4vns5omXD/V9eZm1AVEr9gXQeBcg/PF2jI
 Hl4phfmiVHQu2extur3Aq9PxTYMZaC5GOTDLpmGXZcTRcNu120tlOPAAK7jbwzDQ/Zec4Nk3yWdXjKZaAEGYF+NnLbtuPrPF5tpvOv43+npFw9FZdIqdMLZL
 xtAUkxUURLuUDPSHkMGHkd6GwV29U0UWnpcEhUxhz3ObrUVR3G4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/19 1:57 PM, Andy Shevchenko wrote:
> On Fri, Jan 04, 2019 at 09:30:08PM +0200, Andy Shevchenko wrote:
>> Use %ptT instead of open coded variant to print content of
>> time64_t type in human readable format.
> 
> Hans, any objections on this?
> 
>> Cc: Hans Verkuil <hverkuil@xs4all.nl>
>> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Thanks!

	Hans

>> ---
>>  drivers/media/usb/pulse8-cec/pulse8-cec.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/media/usb/pulse8-cec/pulse8-cec.c b/drivers/media/usb/pulse8-cec/pulse8-cec.c
>> index b085b14f3f87..05f997e9ce28 100644
>> --- a/drivers/media/usb/pulse8-cec/pulse8-cec.c
>> +++ b/drivers/media/usb/pulse8-cec/pulse8-cec.c
>> @@ -328,7 +328,6 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
>>  	u8 *data = pulse8->data + 1;
>>  	u8 cmd[2];
>>  	int err;
>> -	struct tm tm;
>>  	time64_t date;
>>  
>>  	pulse8->vers = 0;
>> @@ -349,10 +348,7 @@ static int pulse8_setup(struct pulse8 *pulse8, struct serio *serio,
>>  	if (err)
>>  		return err;
>>  	date = (data[0] << 24) | (data[1] << 16) | (data[2] << 8) | data[3];
>> -	time64_to_tm(date, 0, &tm);
>> -	dev_info(pulse8->dev, "Firmware build date %04ld.%02d.%02d %02d:%02d:%02d\n",
>> -		 tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday,
>> -		 tm.tm_hour, tm.tm_min, tm.tm_sec);
>> +	dev_info(pulse8->dev, "Firmware build date %ptT\n", &date);
>>  
>>  	dev_dbg(pulse8->dev, "Persistent config:\n");
>>  	cmd[0] = MSGCODE_GET_AUTO_ENABLED;
>> -- 
>> 2.19.2
>>
> 

