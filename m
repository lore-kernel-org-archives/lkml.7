Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CE4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E779E214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 13:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YBP5bpYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfCLNSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 09:18:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46608 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfCLNSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 09:18:11 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x2CDI2KW093729;
        Tue, 12 Mar 2019 08:18:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552396682;
        bh=kthSb2SkLrOHrs77izkk9U8IGmOZU29sR4jhSQUlWMA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YBP5bpYo+iJqBGsNUjU1g386Ailn8J+tQcU4ZXpKAWEkHoMm01lbfPy4tm6WTpS06
         EeFGfuNPULsV4tRFlFi8APP0/IK+lzbQYwcCJ6vdz5VMAqz0WV4unsEgh6xqGYWROO
         U32OlSiXXUXFmBm5uzP0Me3+l6iwRMF7QCP783Po=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x2CDI1LV039580
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Mar 2019 08:18:01 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 12
 Mar 2019 08:18:01 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 12 Mar 2019 08:18:01 -0500
Received: from [172.22.79.221] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x2CDI1lj006862;
        Tue, 12 Mar 2019 08:18:01 -0500
Subject: Re: [PATCH v8 1/4] can: m_can: Create a m_can platform framework
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190312121254.8043-1-dmurphy@ti.com>
 <da6a94ba-e843-891f-cbbc-9ba1e9324f77@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <ca927ad9-709f-6817-7130-488ad0bbbbbf@ti.com>
Date:   Tue, 12 Mar 2019 08:17:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <da6a94ba-e843-891f-cbbc-9ba1e9324f77@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/12/19 7:43 AM, Wolfgang Grandegger wrote:
> Hello Dan,
> 
> Am 12.03.19 um 13:12 schrieb Dan Murphy:
>> Create a m_can platform framework that peripherial
>> devices can register to and use common code and register sets.
>> The peripherial devices may provide read/write and configuration
>> support of the IP.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
>> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
>>
>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>
>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>  drivers/net/can/m_can/Makefile         |   1 +
>>  drivers/net/can/m_can/m_can.c          | 717 +++++++++++++------------
>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>  5 files changed, 699 insertions(+), 344 deletions(-)
>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>
>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>> index 04f20dd39007..f7119fd72df4 100644
>> --- a/drivers/net/can/m_can/Kconfig
>> +++ b/drivers/net/can/m_can/Kconfig
>> @@ -1,5 +1,14 @@
>>  config CAN_M_CAN
>> +	tristate "Bosch M_CAN support"
>> +	---help---
>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>> +
>> +config CAN_M_CAN_PLATFORM
>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>  	depends on HAS_IOMEM
>> -	tristate "Bosch M_CAN devices"
>> +	depends on CAN_M_CAN
>>  	---help---
>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>> +	  This support is for devices that have the Bosch M_CAN controller
>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>> index 8bbd7f24f5be..057bbcdb3c74 100644
>> --- a/drivers/net/can/m_can/Makefile
>> +++ b/drivers/net/can/m_can/Makefile
>> @@ -3,3 +3,4 @@
>>  #
>>  
>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
> 
> ... snip ...
> 
>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>> -static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
>> -			   void __iomem *addr)
>> +static int m_can_dev_setup(struct m_can_priv *m_can_dev)
>>  {
>> -	struct m_can_priv *priv;
>> +	struct net_device *dev = m_can_dev->net;
>>  	int m_can_version;
>>  
>> -	m_can_version = m_can_check_core_release(addr);
>> +	m_can_version = m_can_check_core_release(m_can_dev);
> 
> What is m_can_version for the tcan4x5x?
> 

I believe it is Bosch M-CAN Revision 3.2.1.1

> ... snip ...
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
