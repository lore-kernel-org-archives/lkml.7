Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE2C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E9302070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfCDSNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 13:13:51 -0500
Received: from mailproxy04.manitu.net ([217.11.48.68]:54958 "EHLO
        mailproxy04.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDSNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 13:13:51 -0500
Received: from [10.0.30.7] (dslb-178-010-196-220.178.010.pools.vodafone-ip.de [178.10.196.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy04.manitu.net (Postfix) with ESMTPSA id C1D77804A7;
        Mon,  4 Mar 2019 19:14:14 +0100 (CET)
Subject: Re: [PATCH v6 1/4] can: m_can: Create a m_can platform framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190301185043.9037-1-dmurphy@ti.com>
 <7ffc0639-de4a-87da-68e0-2d170c241824@grandegger.com>
 <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <2863c42d-065d-39e8-ed20-8279f76f00ae@grandegger.com>
Date:   Mon, 4 Mar 2019 19:13:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5b0959b9-58b7-cc3c-7014-b7cdb883a7cf@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 04.03.19 um 18:22 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/4/19 10:56 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> the series already looks quite good. I still realized a few (minor)
>> issues while browsing the patch/code...
>>
> 
> Thanks for the review.  It is getting there.
> 
>> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>>> Create a m_can platform framework that peripherial
>>> devices can register to and use common code and register sets.
>>> The peripherial devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>
>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>  drivers/net/can/m_can/m_can.c          | 702 +++++++++++++------------
>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>  drivers/net/can/m_can/m_can_platform.c | 198 +++++++
>>>  5 files changed, 681 insertions(+), 343 deletions(-)
>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>
>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>> index 04f20dd39007..f7119fd72df4 100644
>>> --- a/drivers/net/can/m_can/Kconfig
>>> +++ b/drivers/net/can/m_can/Kconfig
>>> @@ -1,5 +1,14 @@
>>>  config CAN_M_CAN
>>> +	tristate "Bosch M_CAN support"
>>> +	---help---
>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>> +
>>> +config CAN_M_CAN_PLATFORM
>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>  	depends on HAS_IOMEM
>>> -	tristate "Bosch M_CAN devices"
>>> +	depends on CAN_M_CAN
>>>  	---help---
>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>> +	  This support is for devices that have the Bosch M_CAN controller
>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>> --- a/drivers/net/can/m_can/Makefile
>>> +++ b/drivers/net/can/m_can/Makefile
>>> @@ -3,3 +3,4 @@
>>>  #
>>>  
>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>> index 9b449400376b..b37d0886f9cb 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c

...snip...

>>> @@ -1451,7 +1459,7 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>  			netif_stop_queue(dev);
>>>  			netdev_warn(dev,
>>>  				    "TX queue active although FIFO is full.");
>>> -			return NETDEV_TX_BUSY;
>>> +			return;
>>
>> m_can_start_xmit() doesn't return NETDEV_TX_BUSY but NETDEV_TX_OK and
>> the queue is stopped! Also the skb is not freed! The code states 
>> "/* This shouldn't happen */" but then it just prints a warning. Did
>> you see that message?
>>
> 
> No I have not seen this warning but I will re-check to be sure.

If we don't return NETDEV_TX_BUSY but NETDEV_TX_OK, we must handle it
differently.

...snip...

>>> +struct m_can_priv;
>>> +struct m_can_ops {
>>> +	/* Device specific call backs */
>>> +	int (*clr_dev_interrupts)(struct m_can_priv *m_can_class);
>>
>> Why not just "clear_interrupt"... to be consistant with the names below.
> 
> I wanted to be clear in the M_CAN code that these are device interrupts and not M_CAN interrupts.
> 
> I can change it to clear_interrupt if you think it makes more sense.

Well, like for "read_reg" etc, I think it's clear that it's a
device-specific function/ops:

	cdev->read_reg
	cdev->clear_interrupt

>>> +	u32 (*read_reg)(struct m_can_priv *m_can_class, int reg);
>>> +	int (*write_reg)(struct m_can_priv *m_can_class, int reg, int val);
>>> +	u32 (*read_fifo)(struct m_can_priv *m_can_class, int addr_offset);
>>> +	int (*write_fifo)(struct m_can_priv *m_can_class, int addr_offset,
>>> +			  int val);
>>> +	int (*device_init)(struct m_can_priv *m_can_class);

And the same here:

	cdev->init

>>> +	int pm_clock_support;
>>
>> A "bool" would be more appropriate, I think.
> 
> 
> I was abiding by this checkpatch warning I got on the is_peripherial.
> 
> CHECK: Avoid using bool structure members because of possible alignment issues - see: https://lkml.org/lkml/2017/11/21/384
> #94: FILE: drivers/net/can/m_can/m_can.h:94:
> +	bool is_peripherial;
> 

Ah, right! I was also surprised to get that warning. The kernel is full
of bool's, but well, we should make "checkpatch" happy (and Linus).

Wolfgang
