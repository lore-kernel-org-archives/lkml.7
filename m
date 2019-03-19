Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B086C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A5ED2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UI1Elgpb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbfCSTxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:53:50 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41254 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfCSTxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:53:49 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2JJrfXI121261;
        Tue, 19 Mar 2019 14:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1553025221;
        bh=O2ZCeqxtq/EviMjmY0FZ3aGWM8PxCcHYCeUMzXtl1DI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UI1ElgpbNPyPYb6EqD86IHrFsJcNtxsNDL5SQvNKIQ0ytvq5g4xPutTo+rszArh7g
         8IrPnz9JFz8ZbU9fhLsNIgZfwfIJGOQjC8vihSAJzZZHmXgW3NyLq++FtX+G4b5I4X
         NHKaLTs1Qf6VNlSFirB6aXBisuJxEOwbIWwbftFU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2JJrfIu015295
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Mar 2019 14:53:41 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 19
 Mar 2019 14:53:41 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5 via Frontend Transport;
 Tue, 19 Mar 2019 14:53:41 -0500
Received: from [172.22.68.209] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2JJreaC007229;
        Tue, 19 Mar 2019 14:53:40 -0500
Subject: Re: [PATCH] net: phy: Add DP83825I to the DP83822 driver
To:     Florian Fainelli <f.fainelli@gmail.com>, <andrew@lunn.ch>
CC:     <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190319183251.403-1-dmurphy@ti.com>
 <7188c3e4-b0fa-8985-59f7-2b736a6d5cc5@gmail.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <52aa854a-2dc0-c437-7bfc-e74d6e06cf0a@ti.com>
Date:   Tue, 19 Mar 2019 14:53:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <7188c3e4-b0fa-8985-59f7-2b736a6d5cc5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian

Thanks for the quick review

On 3/19/19 1:55 PM, Florian Fainelli wrote:
> On 3/19/19 11:32 AM, Dan Murphy wrote:
>> Add the DP83825I ethernet PHY to the DP83822 driver.
>> These devices share the same WoL register bits and addresses.
>>
>> The phy_driver init was made into a macro as there may be future
>> devices appended to this driver that will share the register space.
>>
>> http://www.ti.com/lit/gpn/dp83825i
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> Looks good, just a few nitpits below:
> 
>> ---
>>  drivers/net/phy/dp83822.c | 36 ++++++++++++++++++++++--------------
>>  1 file changed, 22 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
>> index bbd8c22067f3..02dc05b86326 100644
>> --- a/drivers/net/phy/dp83822.c
>> +++ b/drivers/net/phy/dp83822.c
>> @@ -15,6 +15,8 @@
>>  #include <linux/netdevice.h>
>>  
>>  #define DP83822_PHY_ID	        0x2000a240
>> +#define DP83825I_PHY_ID		0x2000a150
>> +
>>  #define DP83822_DEVADDR		0x1f
>>  
>>  #define MII_DP83822_PHYSCR	0x11
>> @@ -304,26 +306,32 @@ static int dp83822_resume(struct phy_device *phydev)
>>  	return 0;
>>  }
>>  
>> +#define DP83822_PHY_DRIVER(_id, _name)				\
>> +	{							\
>> +		.phy_id		= _id,				\
> 
> I would put the _id argument between parenthesis to guarantee evaluation
> order in case you need to do smart things about the ID in the future.
> 
>> +		.phy_id_mask	= 0xfffffff0,			\
> 
> You can replace those two lines with PHY_ID_MATCH_MODEL()
> 

Ack to both above. I will replace this with the macro.  I assume I don't have to wrap
_id in additional parenthesis when using the macro.

>> +		.name		= _name,			\
> 
> Likewise
> 

Ack to adding parenthesis around the _name

>> +		.features	= PHY_BASIC_FEATURES,		\
>> +								\
> 
> Looks like you have an extra newline here.
> 

Ack

> With that fixed:
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> 
>> +		.soft_reset	= dp83822_phy_reset,		\
>> +		.config_init	= dp83822_config_init,		\
>> +		.get_wol = dp83822_get_wol,			\
>> +		.set_wol = dp83822_set_wol,			\
>> +		.ack_interrupt = dp83822_ack_interrupt,		\
>> +		.config_intr = dp83822_config_intr,		\
>> +		.suspend = dp83822_suspend,			\
>> +		.resume = dp83822_resume,			\
>> +	}
>> +
>>  static struct phy_driver dp83822_driver[] = {
>> -	{
>> -		.phy_id = DP83822_PHY_ID,
>> -		.phy_id_mask = 0xfffffff0,
>> -		.name = "TI DP83822",
>> -		.features = PHY_BASIC_FEATURES,
>> -		.config_init = dp83822_config_init,
>> -		.soft_reset = dp83822_phy_reset,
>> -		.get_wol = dp83822_get_wol,
>> -		.set_wol = dp83822_set_wol,
>> -		.ack_interrupt = dp83822_ack_interrupt,
>> -		.config_intr = dp83822_config_intr,
>> -		.suspend = dp83822_suspend,
>> -		.resume = dp83822_resume,
>> -	 },
>> +	DP83822_PHY_DRIVER(DP83822_PHY_ID, "TI DP83822"),
>> +	DP83822_PHY_DRIVER(DP83825I_PHY_ID, "TI DP83825I"),
>>  };
>>  module_phy_driver(dp83822_driver);
>>  
>>  static struct mdio_device_id __maybe_unused dp83822_tbl[] = {
>>  	{ DP83822_PHY_ID, 0xfffffff0 },
>> +	{ DP83825I_PHY_ID, 0xfffffff0 },
>>  	{ },
>>  };
>>  MODULE_DEVICE_TABLE(mdio, dp83822_tbl);
>>
> 
> 


-- 
------------------
Dan Murphy
