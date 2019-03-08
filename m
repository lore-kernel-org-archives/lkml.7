Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6B7C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D8C22085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="q3KVYEkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfCHMeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:34:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49282 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:34:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x28CY4kE007858;
        Fri, 8 Mar 2019 06:34:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1552048444;
        bh=sH008Bby5gtys/xfcSMMwv3+pSUdBZH396zi6gqpQ/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=q3KVYEkjo80RKjBzj2uyX3OecjKM0ex/ou34UrqdSbmIldiGykr5P5a0S6qVCcMH1
         gMG5u2CPvB8Vfbzc0FCYVYlGkzUG5uQwGFMmVj2ceekc7R8RZ1B5L3nQfrcX8XSejR
         r1Tfn/eW7KGUKDR/lZgNqzthGV1qqVxQu1WOgUws=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x28CY4K5106498
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Mar 2019 06:34:04 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 8
 Mar 2019 06:34:03 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 8 Mar 2019 06:34:04 -0600
Received: from [172.22.83.167] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x28CY3Bu025292;
        Fri, 8 Mar 2019 06:34:03 -0600
Subject: Re: [PATCH v7 2/4] can: m_can: Rename m_can_priv to m_can_classdev
To:     Wolfgang Grandegger <wg@grandegger.com>, <mkl@pengutronix.de>,
        <davem@davemloft.net>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20190305155220.14037-1-dmurphy@ti.com>
 <20190305155220.14037-2-dmurphy@ti.com>
 <1138f22c-028c-184a-19c0-5b8f64bd977f@grandegger.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <e85a4d42-2c96-a95c-e3bb-31a3c928a1f2@ti.com>
Date:   Fri, 8 Mar 2019 06:33:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <1138f22c-028c-184a-19c0-5b8f64bd977f@grandegger.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfgang

On 3/8/19 4:25 AM, Wolfgang Grandegger wrote:
> 
> 
> Am 05.03.19 um 16:52 schrieb Dan Murphy:
>> Rename the common m_can_priv class structure to
>> m_can_classdev as this is more descriptive.
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>
>> v7 - Fixed remaining checkpatch issues, renamed priv to cdev - https://lore.kernel.org/patchwork/patch/1047219/
>>
>> v6 - No changes only rebase changes possibly can squash into the first patch - 
>> https://lore.kernel.org/patchwork/patch/1042444/
>>
>>  drivers/net/can/m_can/m_can.c          | 524 ++++++++++++-------------
>>  drivers/net/can/m_can/m_can.h          |  28 +-
>>  drivers/net/can/m_can/m_can_platform.c |  16 +-
>>  3 files changed, 284 insertions(+), 284 deletions(-)
> 
> ...snip...
> 
>> diff --git a/drivers/net/can/m_can/m_can.h b/drivers/net/can/m_can/m_can.h
>> index b60f27dd9f33..1299cc747194 100644
>> --- a/drivers/net/can/m_can/m_can.h
>> +++ b/drivers/net/can/m_can/m_can.h
>> @@ -57,19 +57,19 @@ struct mram_cfg {
>>  	u8  num;
>>  };
>>  
>> -struct m_can_priv;
>> +struct m_can_classdev;
>>  struct m_can_ops {
>>  	/* Device specific call backs */
>> -	int (*clear_interrupts)(struct m_can_priv *m_can_class);
>> -	u32 (*read_reg)(struct m_can_priv *m_can_class, int reg);
>> -	int (*write_reg)(struct m_can_priv *m_can_class, int reg, int val);
>> -	u32 (*read_fifo)(struct m_can_priv *m_can_class, int addr_offset);
>> -	int (*write_fifo)(struct m_can_priv *m_can_class, int addr_offset,
>> +	int (*clear_interrupts)(struct m_can_classdev *m_can_class);
>> +	u32 (*read_reg)(struct m_can_classdev *m_can_class, int reg);
>> +	int (*write_reg)(struct m_can_classdev *m_can_class, int reg, int val);
>> +	u32 (*read_fifo)(struct m_can_classdev *m_can_class, int addr_offset);
>> +	int (*write_fifo)(struct m_can_classdev *m_can_class, int addr_offset,
> 
> Could you please replace the variable name "m_can_class" with "cdev"
> here and below and in "c_can_platform.c " and "tcan4x5x.c" as well.
> 

OK I will update the header

The tcan and m_can_platform source files are converted to cdev as opposed to m_can_class variable.

Dan

> Thanks,
> 
> Wolfgang.
> 


-- 
------------------
Dan Murphy
