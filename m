Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE766C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EE82146F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:08:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbfCHRIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:08:39 -0500
Received: from mailproxy03.manitu.net ([217.11.48.67]:34670 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbfCHRIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:08:39 -0500
Received: from [10.48.228.204] (x59cc82cc.dyn.telefonica.de [89.204.130.204])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id E0461D40045;
        Fri,  8 Mar 2019 18:12:26 +0100 (CET)
Subject: Re: [PATCH v7 1/4] can: m_can: Create a m_can platform framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190305155220.14037-1-dmurphy@ti.com>
 <5065d6ba-f195-a695-77b1-b837cac1a199@grandegger.com>
 <bbc9db2f-0702-4f24-db64-a41dc0607d2d@ti.com>
 <bf2613ae-67f6-661d-0faa-786308c249a0@grandegger.com>
 <cea76d80-d85c-2963-2745-4509450e2ea9@grandegger.com>
 <6016c8aa-01b6-38d5-0e1f-3a999aae6a13@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <1f6f77c6-dcf2-6212-5d4e-1eb699e603f1@grandegger.com>
Date:   Fri, 8 Mar 2019 18:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <6016c8aa-01b6-38d5-0e1f-3a999aae6a13@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 08.03.19 um 16:48 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/8/19 8:41 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> thinking more about it...
>>
>> Am 08.03.19 um 14:29 schrieb Wolfgang Grandegger:
>>> Hello Dan,
>>>
>>> Am 08.03.19 um 13:44 schrieb Dan Murphy:
>>>> Wolfgang
>>>>
>>>> On 3/8/19 4:10 AM, Wolfgang Grandegger wrote:
>>>>> Hallo Dan,
>>>>>
>>>>> Am 05.03.19 um 16:52 schrieb Dan Murphy:
>>>>>> Create a m_can platform framework that peripherial
>>>>>> devices can register to and use common code and register sets.
>>>>>> The peripherial devices may provide read/write and configuration
>>>>>> support of the IP.
>>>>>>
>>>>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>>>>> ---
>>>>>>
>>>>>>
>>>>>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>>>>>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>>>>>>
>>>>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>>>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>>>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>>>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>>>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>>>>
>>>>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>>>>  drivers/net/can/m_can/m_can.c          | 700 +++++++++++++------------
>>>>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>>>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>>>>>  5 files changed, 682 insertions(+), 344 deletions(-)
>>>>>>  create mode 100644 drivers/net/can/m_can/m_can.h
>>>>>>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
>>>>>>
>>>>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>>>>> index 04f20dd39007..f7119fd72df4 100644
>>>>>> --- a/drivers/net/can/m_can/Kconfig
>>>>>> +++ b/drivers/net/can/m_can/Kconfig
>>>>>> @@ -1,5 +1,14 @@
>>>>>>  config CAN_M_CAN
>>>>>> +	tristate "Bosch M_CAN support"
>>>>>> +	---help---
>>>>>> +	  Say Y here if you want support for Bosch M_CAN controller framework.
>>>>>> +	  This is common support for devices that embed the Bosch M_CAN IP.
>>>>>> +
>>>>>> +config CAN_M_CAN_PLATFORM
>>>>>> +	tristate "Bosch M_CAN support for io-mapped devices"
>>>>>>  	depends on HAS_IOMEM
>>>>>> -	tristate "Bosch M_CAN devices"
>>>>>> +	depends on CAN_M_CAN
>>>>>>  	---help---
>>>>>> -	  Say Y here if you want to support for Bosch M_CAN controller.
>>>>>> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>>>>> +	  This support is for devices that have the Bosch M_CAN controller
>>>>>> +	  IP embedded into the device and the IP is IO Mapped to the processor.
>>>>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>>>>> index 8bbd7f24f5be..057bbcdb3c74 100644
>>>>>> --- a/drivers/net/can/m_can/Makefile
>>>>>> +++ b/drivers/net/can/m_can/Makefile
>>>>>> @@ -3,3 +3,4 @@
>>>>>>  #
>>>>>>  
>>>>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>>>> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>>>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
>>>>>> index 9b449400376b..a60278d94126 100644
>>>>>> --- a/drivers/net/can/m_can/m_can.c
>>>>>> +++ b/drivers/net/can/m_can/m_can.c
>>>>>
>>>>> ... snip...
>>>>>
>>>>>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>>>>> +				    struct net_device *dev)
>>>>>> +{
>>>>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>>>>> +
>>>>>> +	if (can_dropped_invalid_skb(dev, skb))
>>>>>> +		return NETDEV_TX_OK;
>>>>>> +
>>>>>> +	if (priv->is_peripherial) {
>>>>>> +		if (priv->tx_skb) {
>>>>>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>>>>>> +			return NETDEV_TX_BUSY;
>>>>>> +		}
>>>>>
>>>>> The problem with that approach is, that the upper layer will try to
>>>>> resubmit the current "skb" but not the previous "tx_skb". And the
>>>>> previous "tx_skb" has not been freed yet. I would just drop and free the
>>>>> skb and return NETDEV_TX_OK in m_can_tx_handler() for peripheral devices
>>>>> (like can_dropped_invalid_skb() does).
>>>>>
>>>>
>>>> OK.
>>>>
>>>> So would this also be a bug in the hi3110 and mcp251x drivers (line 521) as well because besides checking tx_length
>>>> this is how these drivers are written.
>>>
>>> This is different. When entering the "start_xmit" routine, the previous
>>> TX is still in progress. It will (hopefully) complete soon. Therefore
>>> returning NETDEV_TX_BUSY is OK. The "start_xmit" routine will be
>>> recalled soon with the same "skb". That scenario should/could also not
>>> happen.
>>
>> In principle, this also applies to the m_can peripheral devices. If
>> tx_skb is not NULL, the TX is still in progress and returning
>> NETDEV_TX_BUSY is just fine.
>>
>>>
>>> In contrast, in "m_can_tx_handler()", the skb could not be handled
>>> because the FIFO is full. The "start_xmit" routine for peripheral
>>> devices for that skb already returned NETDEV_TX_OK. Therefore the only
>>> meaningful action is to drop the skb. Also this error should not happen
>>> and if, something is going really wrong. Therefore I think, a
>>> WARN_ONCE() would be even more appropriate. But that should be a
>>> separate patch.
>>
>> But that's a different issue/error. The tx_skb cannot be processed in
>> "m_can_tx_handler()". Either we drop it or we re-queue it (retry later).
>>
> 
> OK I am a bit confused on this.  Are you saying this is not an issue?
> Or are you saying I need to check for tx_len like the other code?

If you check for tx_skb in the "start_xmit" routine like the hi3110 and
mcp251x, it will work the same way. But only, if the "tx_handler()" has
fully processed the message. It simple means, the TX is still in
progress and will complete soon. But in "m_can_tx_handler()" we return
without handling the message! It will never be sent and freed. Or will
the "m_can_tx_handler()" retry?

> Again if this code is an issue here I believe this is an issue in the hi3110 and mcp251x

I don't think so.

Sorry for confusion.

Wolfgang.

