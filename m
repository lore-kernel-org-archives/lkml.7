Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D563AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C70A2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 14:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCNOib (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 10:38:31 -0400
Received: from mailproxy07.manitu.net ([217.11.48.71]:36268 "EHLO
        mailproxy07.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfCNOia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 10:38:30 -0400
Received: from [10.55.189.239] (x59cc87ef.dyn.telefonica.de [89.204.135.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy07.manitu.net (Postfix) with ESMTPSA id 24251C810A;
        Thu, 14 Mar 2019 15:40:09 +0100 (CET)
Subject: Re: [PATCH v9 1/4] can: m_can: Create a m_can platform framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190313162629.11937-1-dmurphy@ti.com>
 <87f14a09-244e-c698-1372-f8b49e60faee@grandegger.com>
 <a578dd22-a581-8421-fac4-605fa8f63d1a@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <470e0028-7e4c-b1ba-7c50-7464f4904801@grandegger.com>
Date:   Thu, 14 Mar 2019 15:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <a578dd22-a581-8421-fac4-605fa8f63d1a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am 14.03.19 um 15:04 schrieb Dan Murphy:
> Hello
> 
> On 3/14/19 2:26 AM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> we are close...
>>
>> Am 13.03.19 um 17:26 schrieb Dan Murphy:
>>> Create a m_can platform framework that peripherial
>>> devices can register to and use common code and register sets.
>>> The peripherial devices may provide read/write and configuration
>>> support of the IP.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v9 - Added back the CSR clearing as this is needed for TCAN device, fixed clean
>>> function to clean index for version > 30, removed extra skb free and fixed work
>>> handler to handle FIFO full for perpheral devices - https://lore.kernel.org/patchwork/patch/1050120/
>>>
>>> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
>>> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
>>> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
>>> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
>>> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
>>> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
>>> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
>>> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
>>> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
>>>
>>>  drivers/net/can/m_can/Kconfig          |  13 +-
>>>  drivers/net/can/m_can/Makefile         |   1 +
>>>  drivers/net/can/m_can/m_can.c          | 733 +++++++++++++------------
>>>  drivers/net/can/m_can/m_can.h          | 110 ++++
>>>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>>>  5 files changed, 714 insertions(+), 345 deletions(-)
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
>>> index 9b449400376b..56336aefc567 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
...  snip ...

>>> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>>> +				    struct net_device *dev)
>>> +{
>>> +	struct m_can_priv *priv = netdev_priv(dev);
>>> +
>>> +	if (can_dropped_invalid_skb(dev, skb))
>>> +		return NETDEV_TX_OK;
>>> +
>>> +	if (priv->is_peripherial) {
>>> +		if (priv->tx_skb) {
>>> +			netdev_err(dev, "hard_xmit called while tx busy\n");
>>> +			return NETDEV_TX_BUSY;
>>> +		}
>>> +
>>> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
>>> +			m_can_clean(dev);
>>> +		} else {
>>> +			priv->tx_skb = skb;
>>> +			queue_work(priv->tx_wq, &priv->tx_work);
>>
>> You removed "netif_stop_queue(cdev->net)" here. Does that work with just
>> *one* "tx_skb"? I think you need an array then!? I'm afraid, this will
>> require quite some changes and you should also measure the benefit of
>> queuing outgoing messages first. For the time being, it would be fine
>> for me to stop the queue here and add an appropriate comment.
>>
> 
> Yes I removed this in favor of allowing the work handler to stop the queue.
> 
> If the version is < 30 then the queue is stopped immediately.  If the version > 30 then the queue is
> only stopped if FIFO is full.

Yes, and the next call to m_can_start_xmit() will probably return with
NETDEV_TX_BUSY. You should at least add a "netif_stop_queue(cdev->net)"
before returning NETDEV_TX_BUSY, otherwice the upper layer will retry
immediately resulting in high CPU load. Anyway, the purpose of this
return code is to signal errors/bugs in the start/stop flow control:

https://elixir.bootlin.com/linux/latest/source/Documentation/networking/netdevices.txt#L81

> 
> I did see the message "tcan4x5x spi1.0 can0: hard_xmit called while tx busy" 
> more with no gap and no polling in the cangen request.

You usually should never see that message.

> 
>> BTW, how big is the FIFO size on your system:
>>
> 
> This value is set to 1.
> 
>>   tx_fifo_size = mram_config_vals[7];

Then I'm surprised that you see "hard_xmit called while tx busy" at all.
Are you sure that "cdev->version" is 32 on the tcan4x5?

Wolfgang
