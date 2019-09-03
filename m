Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05FAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B85682053B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 07:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbfICHp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:45:26 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:7344 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICHp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 03:45:26 -0400
IronPort-SDR: NnOPLYU1yOgTEf48OaiyDH3UvjPgQ/D436lgbqX6H15/mSBh7zF8OlTDCqYDevXYgVZIJw8034
 7SFhc6Qx9sXeohxFT8pBplvSxntLre4QHf//CdIAVA2t9UzUqiZn8iKsgtXPVkXnpxyp3vxiL1
 GqtKOMhEOYrHYrc6CQOq3TlDRy9RihcdNhq0hXGNX69yqzN2LBIecDRPnPt1fg4lRAM9G7jPcv
 e6+JZvgGW+MoxIbkQJ1qWpRdny16EeAX800epYiPP4Vs2MsvuELw8sVfVgLxNHE14HvVrUdn7c
 g0w=
X-IronPort-AV: E=Sophos;i="5.64,462,1559548800"; 
   d="scan'208";a="42783682"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 02 Sep 2019 23:45:25 -0800
IronPort-SDR: zS9Qcrp0QIto19fhteCGENLNW3U4uU8+/TQYd7KFyKSKbvz/o5aeusb/voJslW3KcDNEh/0OoB
 0QtOzBfyiTeWHvZH/LR77bRqJp1IvkR2Fr54NRVIeQ3OatphMoxqHYUOj5aLdcSuMNY9XG2AQU
 +n5LDlJZmMaXZXq5SLptpWex/MMpKJAknOdf9nRI9w2hhhrlZ3s1oVRrfLs1+xGSoq6yXOGiJf
 eNiuYAnQ9/DSRAuS0T9/tNmOwTBlg9edRtZ+6fXLlVpkAoqfNogVdskndxYOq2FxrmgJTzVisk
 sIw=
Subject: Re: [PATCH v2 12/49] Input: atmel_mxt_ts - add debug for T92 gesture
 and T93 touch seq msgs
To:     Daniel Thompson <daniel.thompson@linaro.org>
CC:     <nick@shmanahar.org>, <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <george_davis@mentor.com>
References: <20190827062756.20380-1-jiada_wang@mentor.com>
 <20190827062756.20380-3-jiada_wang@mentor.com>
 <20190829152400.iqup6lztqjmcqzrc@holly.lan>
From:   Jiada Wang <jiada_wang@mentor.com>
Message-ID: <7d40a6d7-b032-838d-9a97-c9dc241f365f@mentor.com>
Date:   Tue, 3 Sep 2019 16:45:20 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829152400.iqup6lztqjmcqzrc@holly.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SVR-ORW-MBX-05.mgc.mentorg.com (147.34.90.205) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On 2019/08/30 0:24, Daniel Thompson wrote:
> On Tue, Aug 27, 2019 at 03:27:19PM +0900, Jiada Wang wrote:
>> From: Karl Tsou <karl.funlab@gmail.com>
> 
> This description is a little brief.
> 
>>
>> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>
>> (cherry picked from ndyer/linux/for-upstream commit cb98986f8342107bf4a536aed4160b20839e97c1)
>> Signed-off-by: George G. Davis <george_davis@mentor.com>
>> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
>> ---
>>   drivers/input/touchscreen/atmel_mxt_ts.c | 40 ++++++++++++++++++++++++
>>   1 file changed, 40 insertions(+)
>>
>> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
>> index 4e237209cb34..26861252c088 100644
>> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
>> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
>> @@ -71,6 +71,8 @@
>>   #define MXT_SPT_MESSAGECOUNT_T44	44
>>   #define MXT_SPT_CTECONFIG_T46		46
>>   #define MXT_SPT_DYNAMICCONFIGURATIONCONTAINER_T71 71
>> +#define MXT_PROCI_SYMBOLGESTUREPROCESSOR	92
>> +#define MXT_PROCI_TOUCHSEQUENCELOGGER	93
>>   #define MXT_TOUCH_MULTITOUCHSCREEN_T100 100
>>   #define MXT_PROCI_ACTIVESTYLUS_T107	107
>>   
>> @@ -349,6 +351,10 @@ struct mxt_data {
>>   	u8 T42_reportid_max;
>>   	u16 T44_address;
>>   	u8 T48_reportid;
>> +	u16 T92_address;
>> +	u8 T92_reportid;
>> +	u16 T93_address;
>> +	u8 T93_reportid;
>>   	u8 T100_reportid_min;
>>   	u8 T100_reportid_max;
>>   	u16 T107_address;
>> @@ -1113,6 +1119,24 @@ static int mxt_proc_t48_messages(struct mxt_data *data, u8 *msg)
>>   	return 0;
>>   }
>>   
>> +static void mxt_proc_t92_messages(struct mxt_data *data, u8 *msg)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	u8 status = msg[1];
>> +
>> +	dev_info(dev, "T92 long stroke LSTR=%d %d\n",
>> +		 (status & 0x80) ? 1 : 0,
>> +		 status & 0x0F);
> 
> Shouldn't this be dev_dbg().
> 
> 
>> +}
>> +
>> +static void mxt_proc_t93_messages(struct mxt_data *data, u8 *msg)
>> +{
>> +	struct device *dev = &data->client->dev;
>> +	u8 status = msg[1];
>> +
>> +	dev_info(dev, "T93 report double tap %d\n", status);
> 
> Ditto.
> 

I will replace with dev_dbg() and add appropriate commit description

Thanks,
Jiada
> 
> Daniel.
> 
>> +}
>> +
>>   static int mxt_proc_message(struct mxt_data *data, u8 *message)
>>   {
>>   	u8 report_id = message[0];
>> @@ -1145,6 +1169,10 @@ static int mxt_proc_message(struct mxt_data *data, u8 *message)
>>   	} else if (report_id >= data->T15_reportid_min
>>   		   && report_id <= data->T15_reportid_max) {
>>   		mxt_proc_t15_messages(data, message);
>> +	} else if (report_id == data->T92_reportid) {
>> +		mxt_proc_t92_messages(data, message);
>> +	} else if (report_id == data->T93_reportid) {
>> +		mxt_proc_t93_messages(data, message);
>>   	} else {
>>   		mxt_dump_message(data, message);
>>   	}
>> @@ -1814,6 +1842,10 @@ static void mxt_free_object_table(struct mxt_data *data)
>>   	data->T42_reportid_max = 0;
>>   	data->T44_address = 0;
>>   	data->T48_reportid = 0;
>> +	data->T92_reportid = 0;
>> +	data->T92_address = 0;
>> +	data->T93_reportid = 0;
>> +	data->T93_address = 0;
>>   	data->T100_reportid_min = 0;
>>   	data->T100_reportid_max = 0;
>>   	data->max_reportid = 0;
>> @@ -1906,6 +1938,14 @@ static int mxt_parse_object_table(struct mxt_data *data,
>>   		case MXT_PROCG_NOISESUPPRESSION_T48:
>>   			data->T48_reportid = min_id;
>>   			break;
>> +		case MXT_PROCI_SYMBOLGESTUREPROCESSOR:
>> +			data->T92_reportid = min_id;
>> +			data->T92_address = object->start_address;
>> +			break;
>> +		case MXT_PROCI_TOUCHSEQUENCELOGGER:
>> +			data->T93_reportid = min_id;
>> +			data->T93_address = object->start_address;
>> +			break;
>>   		case MXT_TOUCH_MULTITOUCHSCREEN_T100:
>>   			data->multitouch = MXT_TOUCH_MULTITOUCHSCREEN_T100;
>>   			data->T100_reportid_min = min_id;
>> -- 
>> 2.19.2
>>
