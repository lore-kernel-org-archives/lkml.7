Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3302C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7244A20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 06:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfCSGYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 02:24:09 -0400
Received: from mailproxy03.manitu.net ([217.11.48.67]:60038 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCSGYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 02:24:09 -0400
Received: from [10.0.30.7] (dslb-094-218-061-001.094.218.pools.vodafone-ip.de [94.218.61.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy03.manitu.net (Postfix) with ESMTPSA id 59DD5D40212;
        Tue, 19 Mar 2019 07:28:50 +0100 (CET)
Subject: Re: [PATCH v10 1/4] can: m_can: Create a m_can platform framework
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190315170257.12847-1-dmurphy@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <0b9fc85a-25bc-d85e-83c9-bc974e0b44e5@grandegger.com>
Date:   Tue, 19 Mar 2019 07:24:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190315170257.12847-1-dmurphy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

checkpatch still reports one "line over 80 characters".

Am 15.03.19 um 18:02 schrieb Dan Murphy:
> Create a m_can platform framework that peripherial
> devices can register to and use common code and register sets.
> The peripherial devices may provide read/write and configuration
> support of the IP.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v10 - Fixed misspelled peripheral, moved index declaration, and added back stop
> queue on TX_BUSY in hard_xmit - https://lore.kernel.org/patchwork/patch/1050487/
> 
> v9 - Added back the CSR clearing as this is needed for TCAN device, fixed clean
> function to clean index for version > 30, removed extra skb free and fixed work
> handler to handle FIFO full for perpheral devices - https://lore.kernel.org/patchwork/patch/1050120/
> v8 - Added a clean function for the tx_skb, cleaned up skb on BUS_OFF and on xmit
> BUSY - https://lore.kernel.org/patchwork/patch/1047980/
> v7 - Fixed remaining new checkpatch issues, removed CSR setting, fixed tx hard
> start function to return tx_busy, and renamed device callbacks - https://lore.kernel.org/patchwork/patch/1047220/
> v6 - Squashed platform patch to this patch for bissectablity, fixed coding style
> issues, updated Kconfig help, placed mcan reg offsets back into c file, renamed
> priv->skb to priv->tx_skb and cleared perp interrupts at ISR start -
> Patch 1 comments - https://lore.kernel.org/patchwork/patch/1042446/
> Patch 2 comments - https://lore.kernel.org/patchwork/patch/1042442/
> 
>  drivers/net/can/m_can/Kconfig          |  13 +-
>  drivers/net/can/m_can/Makefile         |   1 +
>  drivers/net/can/m_can/m_can.c          | 735 +++++++++++++------------
>  drivers/net/can/m_can/m_can.h          | 110 ++++
>  drivers/net/can/m_can/m_can_platform.c | 202 +++++++
>  5 files changed, 716 insertions(+), 345 deletions(-)
>  create mode 100644 drivers/net/can/m_can/m_can.h
>  create mode 100644 drivers/net/can/m_can/m_can_platform.c
> 
> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
> index 04f20dd39007..f7119fd72df4 100644
> --- a/drivers/net/can/m_can/Kconfig
> +++ b/drivers/net/can/m_can/Kconfig
> @@ -1,5 +1,14 @@
>  config CAN_M_CAN
> +	tristate "Bosch M_CAN support"
> +	---help---
> +	  Say Y here if you want support for Bosch M_CAN controller framework.
> +	  This is common support for devices that embed the Bosch M_CAN IP.
> +
> +config CAN_M_CAN_PLATFORM
> +	tristate "Bosch M_CAN support for io-mapped devices"
>  	depends on HAS_IOMEM
> -	tristate "Bosch M_CAN devices"
> +	depends on CAN_M_CAN
>  	---help---
> -	  Say Y here if you want to support for Bosch M_CAN controller.
> +	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
> +	  This support is for devices that have the Bosch M_CAN controller
> +	  IP embedded into the device and the IP is IO Mapped to the processor.
> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
> index 8bbd7f24f5be..057bbcdb3c74 100644
> --- a/drivers/net/can/m_can/Makefile
> +++ b/drivers/net/can/m_can/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
> +obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
> index 9b449400376b..14c5879f6a5f 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -1,20 +1,14 @@
> -/*
> - * CAN bus driver for Bosch M_CAN controller
> - *
> - * Copyright (C) 2014 Freescale Semiconductor, Inc.
> - *	Dong Aisheng <b29396@freescale.com>
> - *
> - * Bosch M_CAN user manual can be obtained from:
> +// SPDX-License-Identifier: GPL-2.0
> +// CAN bus driver for Bosch M_CAN controller
> +// Copyright (C) 2014 Freescale Semiconductor, Inc.
> +//      Dong Aisheng <b29396@freescale.com>
> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
> +
> +/* Bosch M_CAN user manual can be obtained from:
>   * http://www.bosch-semiconductors.de/media/pdf_1/ipmodules_1/m_can/
>   * mcan_users_manual_v302.pdf
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2. This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
> -#include <linux/clk.h>
> -#include <linux/delay.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -28,11 +22,7 @@
>  #include <linux/can/dev.h>
>  #include <linux/pinctrl/consumer.h>
>  
> -/* napi related */
> -#define M_CAN_NAPI_WEIGHT	64
> -
> -/* message ram configuration data length */
> -#define MRAM_CFG_LEN	8
> +#include "m_can.h"
>  
>  /* registers definition */
>  enum m_can_reg {
> @@ -86,28 +76,11 @@ enum m_can_reg {
>  	M_CAN_TXEFA	= 0xf8,
>  };
>  
> -/* m_can lec values */
> -enum m_can_lec_type {
> -	LEC_NO_ERROR = 0,
> -	LEC_STUFF_ERROR,
> -	LEC_FORM_ERROR,
> -	LEC_ACK_ERROR,
> -	LEC_BIT1_ERROR,
> -	LEC_BIT0_ERROR,
> -	LEC_CRC_ERROR,
> -	LEC_UNUSED,
> -};
> +/* napi related */
> +#define M_CAN_NAPI_WEIGHT	64
>  
> -enum m_can_mram_cfg {
> -	MRAM_SIDF = 0,
> -	MRAM_XIDF,
> -	MRAM_RXF0,
> -	MRAM_RXF1,
> -	MRAM_RXB,
> -	MRAM_TXE,
> -	MRAM_TXB,
> -	MRAM_CFG_NUM,
> -};
> +/* message ram configuration data length */
> +#define MRAM_CFG_LEN	8
>  
>  /* Core Release Register (CREL) */
>  #define CREL_REL_SHIFT		28
> @@ -347,74 +320,86 @@ enum m_can_mram_cfg {
>  #define TX_EVENT_MM_SHIFT	TX_BUF_MM_SHIFT
>  #define TX_EVENT_MM_MASK	(0xff << TX_EVENT_MM_SHIFT)
>  
> -/* address offset and element number for each FIFO/Buffer in the Message RAM */
> -struct mram_cfg {
> -	u16 off;
> -	u8  num;
> -};
> -
> -/* m_can private data structure */
> -struct m_can_priv {
> -	struct can_priv can;	/* must be the first member */
> -	struct napi_struct napi;
> -	struct net_device *dev;
> -	struct device *device;
> -	struct clk *hclk;
> -	struct clk *cclk;
> -	void __iomem *base;
> -	u32 irqstatus;
> -	int version;
> -
> -	/* message ram configuration */
> -	void __iomem *mram_base;
> -	struct mram_cfg mcfg[MRAM_CFG_NUM];
> -};
> +static u32 m_can_read(struct m_can_priv *priv, enum m_can_reg reg)
> +{
> +	if (priv->ops->read_reg)
> +		return priv->ops->read_reg(priv, reg);
> +	else
> +		return -EINVAL;
> +}
>  
> -static inline u32 m_can_read(const struct m_can_priv *priv, enum m_can_reg reg)
> +static int m_can_write(struct m_can_priv *priv, enum m_can_reg reg, u32 val)
>  {
> -	return readl(priv->base + reg);
> +	if (priv->ops->write_reg)
> +		return priv->ops->write_reg(priv, reg, val);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline void m_can_write(const struct m_can_priv *priv,
> -			       enum m_can_reg reg, u32 val)
> +static u32 m_can_fifo_read(struct m_can_priv *priv,
> +			   u32 fgi, unsigned int offset)
>  {
> -	writel(val, priv->base + reg);
> +	u32 addr_offset = priv->mcfg[MRAM_RXF0].off + fgi * RXF0_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->read_fifo)
> +		return priv->ops->read_fifo(priv, addr_offset);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline u32 m_can_fifo_read(const struct m_can_priv *priv,
> -				  u32 fgi, unsigned int offset)
> +static u32 m_can_fifo_write(struct m_can_priv *priv,
> +			    u32 fpi, unsigned int offset, u32 val)
>  {
> -	return readl(priv->mram_base + priv->mcfg[MRAM_RXF0].off +
> -		     fgi * RXF0_ELEMENT_SIZE + offset);
> +	u32 addr_offset = priv->mcfg[MRAM_TXB].off + fpi * TXB_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->write_fifo)
> +		return priv->ops->write_fifo(priv, addr_offset, val);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline void m_can_fifo_write(const struct m_can_priv *priv,
> -				    u32 fpi, unsigned int offset, u32 val)
> +static u32 m_can_fifo_write_no_off(struct m_can_priv *priv,
> +				   u32 fpi, u32 val)
>  {
> -	writel(val, priv->mram_base + priv->mcfg[MRAM_TXB].off +
> -	       fpi * TXB_ELEMENT_SIZE + offset);
> +	if (priv->ops->write_fifo)
> +		return priv->ops->write_fifo(priv, fpi, val);
> +	else
> +		return 0;
>  }
>  
> -static inline u32 m_can_txe_fifo_read(const struct m_can_priv *priv,
> -				      u32 fgi,
> -				      u32 offset) {
> -	return readl(priv->mram_base + priv->mcfg[MRAM_TXE].off +
> -			fgi * TXE_ELEMENT_SIZE + offset);
> +static u32 m_can_txe_fifo_read(struct m_can_priv *priv, u32 fgi, u32 offset)
> +{
> +	u32 addr_offset = priv->mcfg[MRAM_TXE].off + fgi * TXE_ELEMENT_SIZE +
> +			  offset;
> +
> +	if (priv->ops->read_fifo)
> +		return priv->ops->read_fifo(priv, addr_offset);
> +	else
> +		return -EINVAL;
>  }
>  
> -static inline bool m_can_tx_fifo_full(const struct m_can_priv *priv)
> +static inline bool m_can_tx_fifo_full(struct m_can_priv *priv)
>  {
>  		return !!(m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQF);
>  }
>  
> -static inline void m_can_config_endisable(const struct m_can_priv *priv,
> -					  bool enable)
> +void m_can_config_endisable(struct m_can_priv *priv, bool enable)
>  {
>  	u32 cccr = m_can_read(priv, M_CAN_CCCR);
>  	u32 timeout = 10;
>  	u32 val = 0;
>  
> +	/* Clear the Clock stop request if it was set */
> +	if (cccr & CCCR_CSR)
> +		cccr &= ~CCCR_CSR;
> +
>  	if (enable) {
> +		/* Clear the Clock stop request if it was set */
> +		if (cccr & CCCR_CSR)
> +			cccr &= ~CCCR_CSR;
> +
>  		/* enable m_can configuration */
>  		m_can_write(priv, M_CAN_CCCR, cccr | CCCR_INIT);
>  		udelay(5);
> @@ -430,7 +415,7 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  
>  	while ((m_can_read(priv, M_CAN_CCCR) & (CCCR_INIT | CCCR_CCE)) != val) {
>  		if (timeout == 0) {
> -			netdev_warn(priv->dev, "Failed to init module\n");
> +			netdev_warn(priv->net, "Failed to init module\n");
>  			return;
>  		}
>  		timeout--;
> @@ -438,17 +423,34 @@ static inline void m_can_config_endisable(const struct m_can_priv *priv,
>  	}
>  }
>  
> -static inline void m_can_enable_all_interrupts(const struct m_can_priv *priv)
> +static inline void m_can_enable_all_interrupts(struct m_can_priv *priv)
>  {
>  	/* Only interrupt line 0 is used in this driver */
>  	m_can_write(priv, M_CAN_ILE, ILE_EINT0);
>  }
>  
> -static inline void m_can_disable_all_interrupts(const struct m_can_priv *priv)
> +static inline void m_can_disable_all_interrupts(struct m_can_priv *priv)
>  {
>  	m_can_write(priv, M_CAN_ILE, 0x0);
>  }
>  
> +static void m_can_clean(struct net_device *net)
> +{
> +	struct m_can_priv *priv = netdev_priv(net);
> +
> +	if (priv->tx_skb) {
> +		int putidx = 0;
> +
> +		net->stats.tx_errors++;
> +		if (priv->version > 30)
> +			putidx = ((m_can_read(priv, M_CAN_TXFQS) & TXFQS_TFQPI_MASK)
> +					  >> TXFQS_TFQPI_SHIFT);
> +
> +		can_free_echo_skb(priv->net, putidx);
> +		priv->tx_skb = NULL;
> +	}
> +}
> +
>  static void m_can_read_fifo(struct net_device *dev, u32 rxfs)
>  {
>  	struct net_device_stats *stats = &dev->stats;
> @@ -633,9 +635,12 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  {
>  	int err;
>  
> -	err = pm_runtime_get_sync(priv->device);
> +	if (priv->pm_clock_support == 0)
> +		return 0;
> +
> +	err = pm_runtime_get_sync(priv->dev);
>  	if (err < 0) {
> -		pm_runtime_put_noidle(priv->device);
> +		pm_runtime_put_noidle(priv->dev);
>  		return err;
>  	}
>  
> @@ -644,7 +649,8 @@ static int m_can_clk_start(struct m_can_priv *priv)
>  
>  static void m_can_clk_stop(struct m_can_priv *priv)
>  {
> -	pm_runtime_put_sync(priv->device);
> +	if (priv->pm_clock_support)
> +		pm_runtime_put_sync(priv->dev);
>  }
>  
>  static int m_can_get_berr_counter(const struct net_device *dev,
> @@ -811,9 +817,8 @@ static int m_can_handle_bus_errors(struct net_device *dev, u32 irqstatus,
>  	return work_done;
>  }
>  
> -static int m_can_poll(struct napi_struct *napi, int quota)
> +static int m_can_rx_handler(struct net_device *dev, int quota)
>  {
> -	struct net_device *dev = napi->dev;
>  	struct m_can_priv *priv = netdev_priv(dev);
>  	int work_done = 0;
>  	u32 irqstatus, psr;
> @@ -831,13 +836,33 @@ static int m_can_poll(struct napi_struct *napi, int quota)
>  
>  	if (irqstatus & IR_RF0N)
>  		work_done += m_can_do_rx_poll(dev, (quota - work_done));
> +end:
> +	return work_done;
> +}
> +
> +static int m_can_rx_peripheral(struct net_device *dev)
> +{
> +	struct m_can_priv *priv = netdev_priv(dev);
> +
> +	m_can_rx_handler(dev, 1);
>  
> +	m_can_enable_all_interrupts(priv);
> +
> +	return 0;
> +}
> +
> +static int m_can_poll(struct napi_struct *napi, int quota)
> +{
> +	struct net_device *dev = napi->dev;
> +	struct m_can_priv *priv = netdev_priv(dev);
> +	int work_done;
> +
> +	work_done = m_can_rx_handler(dev, quota);
>  	if (work_done < quota) {
>  		napi_complete_done(napi, work_done);
>  		m_can_enable_all_interrupts(priv);
>  	}
>  
> -end:
>  	return work_done;
>  }
>  
> @@ -894,6 +919,9 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	if (ir & IR_ALL_INT)
>  		m_can_write(priv, M_CAN_IR, ir);
>  
> +	if (priv->ops->clear_interrupts)
> +		priv->ops->clear_interrupts(priv);
> +
>  	/* schedule NAPI in case of
>  	 * - rx IRQ
>  	 * - state change IRQ
> @@ -902,7 +930,10 @@ static irqreturn_t m_can_isr(int irq, void *dev_id)
>  	if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X)) {
>  		priv->irqstatus = ir;
>  		m_can_disable_all_interrupts(priv);
> -		napi_schedule(&priv->napi);
> +		if (!priv->is_peripheral)
> +			napi_schedule(&priv->napi);
> +		else
> +			m_can_rx_peripheral(dev);
>  	}
>  
>  	if (priv->version == 30) {
> @@ -1155,6 +1186,9 @@ static void m_can_chip_config(struct net_device *dev)
>  	m_can_set_bittiming(dev);
>  
>  	m_can_config_endisable(priv, false);
> +
> +	if (priv->ops->init)
> +		priv->ops->init(priv);
>  }
>  
>  static void m_can_start(struct net_device *dev)
> @@ -1173,6 +1207,7 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>  {
>  	switch (mode) {
>  	case CAN_MODE_START:
> +		m_can_clean(dev);
>  		m_can_start(dev);
>  		netif_wake_queue(dev);
>  		break;
> @@ -1188,20 +1223,17 @@ static int m_can_set_mode(struct net_device *dev, enum can_mode mode)
>   * else it returns the release and step coded as:
>   * return value = 10 * <release> + 1 * <step>
>   */
> -static int m_can_check_core_release(void __iomem *m_can_base)
> +static int m_can_check_core_release(struct m_can_priv *priv)
>  {
>  	u32 crel_reg;
>  	u8 rel;
>  	u8 step;
>  	int res;
> -	struct m_can_priv temp_priv = {
> -		.base = m_can_base
> -	};
>  
>  	/* Read Core Release Version and split into version number
>  	 * Example: Version 3.2.1 => rel = 3; step = 2; substep = 1;
>  	 */
> -	crel_reg = m_can_read(&temp_priv, M_CAN_CREL);
> +	crel_reg = m_can_read(priv, M_CAN_CREL);
>  	rel = (u8)((crel_reg & CREL_REL_MASK) >> CREL_REL_SHIFT);
>  	step = (u8)((crel_reg & CREL_STEP_MASK) >> CREL_STEP_SHIFT);
>  
> @@ -1219,18 +1251,26 @@ static int m_can_check_core_release(void __iomem *m_can_base)
>  /* Selectable Non ISO support only in version 3.2.x
>   * This function checks if the bit is writable.
>   */
> -static bool m_can_niso_supported(const struct m_can_priv *priv)
> +static bool m_can_niso_supported(struct m_can_priv *priv)
>  {
> -	u32 cccr_reg, cccr_poll;
> -	int niso_timeout;
> +	u32 cccr_reg, cccr_poll = 0;
> +	int niso_timeout = -ETIMEDOUT;
> +	int i;
>  
>  	m_can_config_endisable(priv, true);
>  	cccr_reg = m_can_read(priv, M_CAN_CCCR);
>  	cccr_reg |= CCCR_NISO;
>  	m_can_write(priv, M_CAN_CCCR, cccr_reg);
>  
> -	niso_timeout = readl_poll_timeout((priv->base + M_CAN_CCCR), cccr_poll,
> -					  (cccr_poll == cccr_reg), 0, 10);
> +	for (i = 0; i <= 10; i++) {
> +		cccr_poll = m_can_read(priv, M_CAN_CCCR);
> +		if (cccr_poll == cccr_reg) {
> +			niso_timeout = 0;
> +			break;
> +		}
> +
> +		usleep_range(1, 5);
> +	}
>  
>  	/* Clear NISO */
>  	cccr_reg &= ~(CCCR_NISO);
> @@ -1242,107 +1282,79 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
>  	return !niso_timeout;
>  }
>  
> -static int m_can_dev_setup(struct platform_device *pdev, struct net_device *dev,
> -			   void __iomem *addr)
> +static int m_can_dev_setup(struct m_can_priv *m_can_dev)
>  {
> -	struct m_can_priv *priv;
> +	struct net_device *dev = m_can_dev->net;
>  	int m_can_version;
>  
> -	m_can_version = m_can_check_core_release(addr);
> +	m_can_version = m_can_check_core_release(m_can_dev);
>  	/* return if unsupported version */
>  	if (!m_can_version) {
> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
>  			m_can_version);
>  		return -EINVAL;
>  	}
>  
> -	priv = netdev_priv(dev);
> -	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> +	if (!m_can_dev->is_peripheral)
> +		netif_napi_add(dev, &m_can_dev->napi,
> +			       m_can_poll, M_CAN_NAPI_WEIGHT);
>  
>  	/* Shared properties of all M_CAN versions */
> -	priv->version = m_can_version;
> -	priv->dev = dev;
> -	priv->base = addr;
> -	priv->can.do_set_mode = m_can_set_mode;
> -	priv->can.do_get_berr_counter = m_can_get_berr_counter;
> +	m_can_dev->version = m_can_version;
> +	m_can_dev->can.do_set_mode = m_can_set_mode;
> +	m_can_dev->can.do_get_berr_counter = m_can_get_berr_counter;
>  
>  	/* Set M_CAN supported operations */
> -	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> +	m_can_dev->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
>  					CAN_CTRLMODE_LISTENONLY |
>  					CAN_CTRLMODE_BERR_REPORTING |
>  					CAN_CTRLMODE_FD;
>  
>  	/* Set properties depending on M_CAN version */
> -	switch (priv->version) {
> +	switch (m_can_dev->version) {
>  	case 30:
>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		priv->can.bittiming_const = &m_can_bittiming_const_30X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_30X;
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_30X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_30X;
>  		break;
>  	case 31:
>  		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
>  		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_31X;
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_31X;
>  		break;
>  	case 32:
> -		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> -		priv->can.data_bittiming_const =
> -				&m_can_data_bittiming_const_31X;
> -		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
> +		m_can_dev->can.bittiming_const = m_can_dev->bit_timing ?
> +			m_can_dev->bit_timing : &m_can_bittiming_const_31X;
> +
> +		m_can_dev->can.data_bittiming_const = m_can_dev->data_timing ?
> +						m_can_dev->data_timing :
> +						&m_can_data_bittiming_const_31X;
> +
> +		m_can_dev->can.ctrlmode_supported |=
> +						(m_can_niso_supported(m_can_dev)
>  						? CAN_CTRLMODE_FD_NON_ISO
>  						: 0);
>  		break;
>  	default:
> -		dev_err(&pdev->dev, "Unsupported version number: %2d",
> -			priv->version);
> +		dev_err(m_can_dev->dev, "Unsupported version number: %2d",
> +			m_can_dev->version);
>  		return -EINVAL;
>  	}
>  
> -	return 0;
> -}
> -
> -static int m_can_open(struct net_device *dev)
> -{
> -	struct m_can_priv *priv = netdev_priv(dev);
> -	int err;
> -
> -	err = m_can_clk_start(priv);
> -	if (err)
> -		return err;
> -
> -	/* open the can device */
> -	err = open_candev(dev);
> -	if (err) {
> -		netdev_err(dev, "failed to open can device\n");
> -		goto exit_disable_clks;
> -	}
> -
> -	/* register interrupt handler */
> -	err = request_irq(dev->irq, m_can_isr, IRQF_SHARED, dev->name,
> -			  dev);
> -	if (err < 0) {
> -		netdev_err(dev, "failed to request interrupt\n");
> -		goto exit_irq_fail;
> -	}
> -
> -	/* start the m_can controller */
> -	m_can_start(dev);
> -
> -	can_led_event(dev, CAN_LED_EVENT_OPEN);
> -	napi_enable(&priv->napi);
> -	netif_start_queue(dev);
> +	if (m_can_dev->ops->init)
> +		m_can_dev->ops->init(m_can_dev);
>  
>  	return 0;
> -
> -exit_irq_fail:
> -	close_candev(dev);
> -exit_disable_clks:
> -	m_can_clk_stop(priv);
> -	return err;
>  }
>  
>  static void m_can_stop(struct net_device *dev)
> @@ -1361,10 +1373,18 @@ static int m_can_close(struct net_device *dev)
>  	struct m_can_priv *priv = netdev_priv(dev);
>  
>  	netif_stop_queue(dev);
> -	napi_disable(&priv->napi);
> +	if (!priv->is_peripheral)
> +		napi_disable(&priv->napi);
>  	m_can_stop(dev);
>  	m_can_clk_stop(priv);
>  	free_irq(dev->irq, dev);
> +
> +	if (priv->is_peripheral) {
> +		priv->tx_skb = NULL;
> +		destroy_workqueue(priv->tx_wq);
> +		priv->tx_wq = NULL;
> +	}
> +
>  	close_candev(dev);
>  	can_led_event(dev, CAN_LED_EVENT_STOP);
>  
> @@ -1385,18 +1405,15 @@ static int m_can_next_echo_skb_occupied(struct net_device *dev, int putidx)
>  	return !!priv->can.echo_skb[next_idx];
>  }
>  
> -static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> -				    struct net_device *dev)
> +static netdev_tx_t m_can_tx_handler(struct m_can_priv *priv)
>  {
> -	struct m_can_priv *priv = netdev_priv(dev);
> -	struct canfd_frame *cf = (struct canfd_frame *)skb->data;
> +	struct canfd_frame *cf = (struct canfd_frame *)priv->tx_skb->data;
> +	struct net_device *dev = priv->net;
> +	struct sk_buff *skb = priv->tx_skb;
>  	u32 id, cccr, fdflags;
>  	int i;
>  	int putidx;
>  
> -	if (can_dropped_invalid_skb(dev, skb))
> -		return NETDEV_TX_OK;
> -
>  	/* Generate ID field for TX buffer Element */
>  	/* Common to all supported M_CAN versions */
>  	if (cf->can_id & CAN_EFF_FLAG) {
> @@ -1451,7 +1468,13 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  			netif_stop_queue(dev);
>  			netdev_warn(dev,
>  				    "TX queue active although FIFO is full.");
> -			return NETDEV_TX_BUSY;
> +			if (priv->is_peripheral) {
> +				kfree_skb(skb);
> +				dev->stats.tx_dropped++;
> +				return NETDEV_TX_OK;
> +			} else {
> +				return NETDEV_TX_BUSY;
> +			}
>  		}
>  
>  		/* get put index for frame */
> @@ -1492,14 +1515,114 @@ static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
>  		m_can_write(priv, M_CAN_TXBAR, (1 << putidx));
>  
>  		/* stop network queue if fifo full */
> -			if (m_can_tx_fifo_full(priv) ||
> -			    m_can_next_echo_skb_occupied(dev, putidx))
> -				netif_stop_queue(dev);
> +		if (m_can_tx_fifo_full(priv) ||
> +		    m_can_next_echo_skb_occupied(dev, putidx))
> +			netif_stop_queue(dev);
> +	}
> +
> +	return NETDEV_TX_OK;
> +}
> +
> +static void m_can_tx_work_queue(struct work_struct *ws)
> +{
> +	struct m_can_priv *priv = container_of(ws, struct m_can_priv,
> +						tx_work);
> +	m_can_tx_handler(priv);
> +	priv->tx_skb = NULL;
> +}
> +
> +static netdev_tx_t m_can_start_xmit(struct sk_buff *skb,
> +				    struct net_device *dev)
> +{
> +	struct m_can_priv *priv = netdev_priv(dev);
> +
> +	if (can_dropped_invalid_skb(dev, skb))
> +		return NETDEV_TX_OK;
> +
> +	if (priv->is_peripheral) {
> +		if (priv->tx_skb) {
> +			netdev_err(dev, "hard_xmit called while tx busy\n");
> +			return NETDEV_TX_BUSY;
> +		}
> +
> +		if (priv->can.state == CAN_STATE_BUS_OFF) {
> +			m_can_clean(dev);
> +		} else {

Could you please add a comment here about stopping the queue early. I
would also mention that an improved version may use an array of tx_skbs
 to support queueing of outgoing messages.

> +			priv->tx_skb = skb;
> +			netif_stop_queue(priv->net);
> +			queue_work(priv->tx_wq, &priv->tx_work);
> +		}
> +	} else {
> +		priv->tx_skb = skb;
> +		return m_can_tx_handler(priv);
>  	}
>  
>  	return NETDEV_TX_OK;
>  }

At the next respin, you can then add my

  Acked-by: Wolfgang Grandegger <wg@grandegger.com>

to the Patch 1/1, 1/2 and 1/4.

Thanks for your contribution and patience.

Wolfgang
