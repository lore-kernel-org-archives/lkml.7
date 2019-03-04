Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9B5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE95E206BA
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 19:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbfCDTdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:33:10 -0500
Received: from mailproxy02.manitu.net ([217.11.48.66]:51852 "EHLO
        mailproxy02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfCDTdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 14:33:09 -0500
Received: from [10.0.30.7] (dslb-178-010-196-220.178.010.pools.vodafone-ip.de [178.10.196.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wg@grandegger.com)
        by mailproxy02.manitu.net (Postfix) with ESMTPSA id 68FF81020090;
        Mon,  4 Mar 2019 20:36:48 +0100 (CET)
Subject: Re: [PATCH v6 4/4] can: tcan4x5x: Add tcan4x5x driver to the kernel
To:     Dan Murphy <dmurphy@ti.com>, mkl@pengutronix.de,
        davem@davemloft.net
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190301185043.9037-1-dmurphy@ti.com>
 <20190301185043.9037-4-dmurphy@ti.com>
 <1b66dbcc-8fa9-5ad4-6f30-a397d0779cb2@grandegger.com>
 <7766a908-d1e8-0c87-e157-5d839863323a@ti.com>
From:   Wolfgang Grandegger <wg@grandegger.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wg@grandegger.com; prefer-encrypt=mutual; keydata=
 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
 8QEfHnPzgykCs2DOOQ==
Message-ID: <22823e49-b82a-13ec-b901-7c274cd69398@grandegger.com>
Date:   Mon, 4 Mar 2019 20:33:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <7766a908-d1e8-0c87-e157-5d839863323a@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dan,

Am 04.03.19 um 20:07 schrieb Dan Murphy:
> Wolfgang
> 
> On 3/4/19 12:29 PM, Wolfgang Grandegger wrote:
>> Hello Dan,
>>
>> Am 01.03.19 um 19:50 schrieb Dan Murphy:
>>> Add the TCAN4x5x SPI CAN driver.  This device uses the
>>> Bosch MCAN IP core along with a SPI interface map.
>>> Register to the MCAN common core code to manage the MCAN IP.
>>>
>>> This device has a special method to indicate a write/read
>>> operation on the data payload.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v6 - Updated Kconfig help and added REGMAP_SPI dependency, fixed coding style issues,
>>> removed setting GPIO high in wake routine, change -EIO to return ret in init and
>>> setup functions - https://lore.kernel.org/patchwork/patch/1042443/
>>>
>>>  drivers/net/can/m_can/Kconfig    |   9 +
>>>  drivers/net/can/m_can/Makefile   |   1 +
>>>  drivers/net/can/m_can/tcan4x5x.c | 529 +++++++++++++++++++++++++++++++
>>>  3 files changed, 539 insertions(+)
>>>  create mode 100644 drivers/net/can/m_can/tcan4x5x.c
>>>
>>> diff --git a/drivers/net/can/m_can/Kconfig b/drivers/net/can/m_can/Kconfig
>>> index f7119fd72df4..cf4f32765efa 100644
>>> --- a/drivers/net/can/m_can/Kconfig
>>> +++ b/drivers/net/can/m_can/Kconfig
>>> @@ -12,3 +12,12 @@ config CAN_M_CAN_PLATFORM
>>>  	  Say Y here if you want support for IO Mapped Bosch M_CAN controller.
>>>  	  This support is for devices that have the Bosch M_CAN controller
>>>  	  IP embedded into the device and the IP is IO Mapped to the processor.
>>> +
>>> +config CAN_M_CAN_TCAN4X5X
>>> +	depends on CAN_M_CAN
>>> +	depends on REGMAP_SPI
>>> +	tristate "TCAN4X5X M_CAN device"
>>> +	---help---
>>> +	  Say Y here if you want support for Texas Instruments TCAN4x5x
>>> +	  M_CAN controller.  This device is a peripherial device that uses the
>>> +	  SPI bus for communication.
>>> diff --git a/drivers/net/can/m_can/Makefile b/drivers/net/can/m_can/Makefile
>>> index 057bbcdb3c74..e77f0eccff97 100644
>>> --- a/drivers/net/can/m_can/Makefile
>>> +++ b/drivers/net/can/m_can/Makefile
>>> @@ -4,3 +4,4 @@
>>>  
>>>  obj-$(CONFIG_CAN_M_CAN) += m_can.o
>>>  obj-$(CONFIG_CAN_M_CAN_PLATFORM) += m_can_platform.o
>>> +obj-$(CONFIG_CAN_M_CAN_TCAN4X5X) += tcan4x5x.o
>>> diff --git a/drivers/net/can/m_can/tcan4x5x.c b/drivers/net/can/m_can/tcan4x5x.c
>>> new file mode 100644
>>> index 000000000000..a91b976bb522
>>> --- /dev/null
>>> +++ b/drivers/net/can/m_can/tcan4x5x.c
>>> @@ -0,0 +1,529 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +// SPI to CAN driver for the Texas Instruments TCAN4x5x
>>> +// Copyright (C) 2018-19 Texas Instruments Incorporated - http://www.ti.com/
>>> +
>>> +#include <linux/regmap.h>
>>> +#include <linux/spi/spi.h>
>>> +
>>> +#include <linux/regulator/consumer.h>
>>> +#include <linux/gpio/consumer.h>
>>> +
>>> +#include "m_can.h"
>>> +
>>> +#define DEVICE_NAME "tcan4x5x"
>>> +#define TCAN4X5X_EXT_CLK_DEF	40000000
>>> +
>>> +#define TCAN4X5X_DEV_ID0	0x00
>>> +#define TCAN4X5X_DEV_ID1	0x04
>>> +#define TCAN4X5X_REV		0x08
>>> +#define TCAN4X5X_STATUS		0x0C
>>> +#define TCAN4X5X_ERROR_STATUS	0x10
>>> +#define TCAN4X5X_CONTROL	0x14
>>> +
>>> +#define TCAN4X5X_CONFIG		0x800
>>> +#define TCAN4X5X_TS_PRESCALE	0x804
>>> +#define TCAN4X5X_TEST_REG	0x808
>>> +#define TCAN4X5X_INT_FLAGS	0x820
>>> +#define TCAN4X5X_MCAN_INT_REG	0x824
>>> +#define TCAN4X5X_INT_EN		0x830
>>> +
>>> +/* Interrupt bits */
>>> +#define TCAN4X5X_CANBUSTERMOPEN_INT_EN	BIT(30)
>>> +#define TCAN4X5X_CANHCANL_INT_EN	BIT(29)
>>> +#define TCAN4X5X_CANHBAT_INT_EN		BIT(28)
>>> +#define TCAN4X5X_CANLGND_INT_EN		BIT(27)
>>> +#define TCAN4X5X_CANBUSOPEN_INT_EN	BIT(26)
>>> +#define TCAN4X5X_CANBUSGND_INT_EN	BIT(25)
>>> +#define TCAN4X5X_CANBUSBAT_INT_EN	BIT(24)
>>> +#define TCAN4X5X_UVSUP_INT_EN		BIT(22)
>>> +#define TCAN4X5X_UVIO_INT_EN		BIT(21)
>>> +#define TCAN4X5X_TSD_INT_EN		BIT(19)
>>> +#define TCAN4X5X_ECCERR_INT_EN		BIT(16)
>>> +#define TCAN4X5X_CANINT_INT_EN		BIT(15)
>>> +#define TCAN4X5X_LWU_INT_EN		BIT(14)
>>> +#define TCAN4X5X_CANSLNT_INT_EN		BIT(10)
>>> +#define TCAN4X5X_CANDOM_INT_EN		BIT(8)
>>> +#define TCAN4X5X_CANBUS_ERR_INT_EN	BIT(5)
>>> +#define TCAN4X5X_BUS_FAULT		BIT(4)
>>> +#define TCAN4X5X_MCAN_INT		BIT(1)
>>> +#define TCAN4X5X_ENABLE_TCAN_INT	(TCAN4X5X_MCAN_INT | \
>>> +					TCAN4X5X_BUS_FAULT | \
>>> +					TCAN4X5X_CANBUS_ERR_INT_EN | \
>>> +					TCAN4X5X_CANINT_INT_EN)
>>> +
>>> +/* MCAN Interrupt bits */
>>> +#define TCAN4X5X_MCAN_IR_ARA		BIT(29)
>>> +#define TCAN4X5X_MCAN_IR_PED		BIT(28)
>>> +#define TCAN4X5X_MCAN_IR_PEA		BIT(27)
>>> +#define TCAN4X5X_MCAN_IR_WD		BIT(26)
>>> +#define TCAN4X5X_MCAN_IR_BO		BIT(25)
>>> +#define TCAN4X5X_MCAN_IR_EW		BIT(24)
>>> +#define TCAN4X5X_MCAN_IR_EP		BIT(23)
>>> +#define TCAN4X5X_MCAN_IR_ELO		BIT(22)
>>> +#define TCAN4X5X_MCAN_IR_BEU		BIT(21)
>>> +#define TCAN4X5X_MCAN_IR_BEC		BIT(20)
>>> +#define TCAN4X5X_MCAN_IR_DRX		BIT(19)
>>> +#define TCAN4X5X_MCAN_IR_TOO		BIT(18)
>>> +#define TCAN4X5X_MCAN_IR_MRAF		BIT(17)
>>> +#define TCAN4X5X_MCAN_IR_TSW		BIT(16)
>>> +#define TCAN4X5X_MCAN_IR_TEFL		BIT(15)
>>> +#define TCAN4X5X_MCAN_IR_TEFF		BIT(14)
>>> +#define TCAN4X5X_MCAN_IR_TEFW		BIT(13)
>>> +#define TCAN4X5X_MCAN_IR_TEFN		BIT(12)
>>> +#define TCAN4X5X_MCAN_IR_TFE		BIT(11)
>>> +#define TCAN4X5X_MCAN_IR_TCF		BIT(10)
>>> +#define TCAN4X5X_MCAN_IR_TC		BIT(9)
>>> +#define TCAN4X5X_MCAN_IR_HPM		BIT(8)
>>> +#define TCAN4X5X_MCAN_IR_RF1L		BIT(7)
>>> +#define TCAN4X5X_MCAN_IR_RF1F		BIT(6)
>>> +#define TCAN4X5X_MCAN_IR_RF1W		BIT(5)
>>> +#define TCAN4X5X_MCAN_IR_RF1N		BIT(4)
>>> +#define TCAN4X5X_MCAN_IR_RF0L		BIT(3)
>>> +#define TCAN4X5X_MCAN_IR_RF0F		BIT(2)
>>> +#define TCAN4X5X_MCAN_IR_RF0W		BIT(1)
>>> +#define TCAN4X5X_MCAN_IR_RF0N		BIT(0)
>>> +#define TCAN4X5X_ENABLE_MCAN_INT	(TCAN4X5X_MCAN_IR_TC | \
>>> +					TCAN4X5X_MCAN_IR_RF0N | \
>>> +					TCAN4X5X_MCAN_IR_RF1N | \
>>> +					TCAN4X5X_MCAN_IR_RF0F | \
>>> +					TCAN4X5X_MCAN_IR_RF1F)
>>> +#define TCAN4X5X_MRAM_START	0x8000
>>> +#define TCAN4X5X_MCAN_OFFSET	0x1000
>>> +#define TCAN4X5X_MAX_REGISTER	0x8fff
>>> +
>>> +#define TCAN4X5X_CLEAR_ALL_INT	0xffffffff
>>> +#define TCAN4X5X_SET_ALL_INT	0xffffffff
>>> +
>>> +#define TCAN4X5X_WRITE_CMD	(0x61 << 24)
>>> +#define TCAN4X5X_READ_CMD	(0x41 << 24)
>>> +
>>> +#define TCAN4X5X_MODE_SEL_MASK		(BIT(7) | BIT(6))
>>> +#define TCAN4X5X_MODE_SLEEP		0x00
>>> +#define TCAN4X5X_MODE_STANDBY		BIT(6)
>>> +#define TCAN4X5X_MODE_NORMAL		BIT(7)
>>> +
>>> +#define TCAN4X5X_SW_RESET	BIT(2)
>>> +
>>> +#define TCAN4X5X_MCAN_CONFIGURED	BIT(5)
>>> +#define TCAN4X5X_WATCHDOG_EN		BIT(3)
>>> +#define TCAN4X5X_WD_60_MS_TIMER		0
>>> +#define TCAN4X5X_WD_600_MS_TIMER	BIT(28)
>>> +#define TCAN4X5X_WD_3_S_TIMER		BIT(29)
>>> +#define TCAN4X5X_WD_6_S_TIMER		(BIT(28) | BIT(29))
>>> +
>>> +struct tcan4x5x_priv {
>>> +	struct regmap *regmap;
>>> +	struct spi_device *spi;
>>> +	struct mutex tcan4x5x_lock; /* SPI device lock */
>>> +
>>> +	struct m_can_classdev *mcan_dev;
>>> +
>>> +	struct gpio_desc *reset_gpio;
>>> +	struct gpio_desc *interrupt_gpio;
>>> +	struct gpio_desc *device_wake_gpio;
>>> +	struct gpio_desc *device_state_gpio;
>>> +	struct regulator *power;
>>> +
>>> +	/* Register based ip */
>>> +	int mram_start;
>>> +	int reg_offset;
>>> +};
>>> +
>>> +static struct can_bittiming_const tcan4x5x_bittiming_const = {
>>> +	.name = DEVICE_NAME,
>>> +	.tseg1_min = 2,
>>> +	.tseg1_max = 31,
>>> +	.tseg2_min = 2,
>>> +	.tseg2_max = 16,
>>> +	.sjw_max = 16,
>>> +	.brp_min = 1,
>>> +	.brp_max = 32,
>>> +	.brp_inc = 1,
>>> +};
>>> +
>>> +static struct can_bittiming_const tcan4x5x_data_bittiming_const = {
>>> +	.name = DEVICE_NAME,
>>> +	.tseg1_min = 1,
>>> +	.tseg1_max = 32,
>>> +	.tseg2_min = 1,
>>> +	.tseg2_max = 16,
>>> +	.sjw_max = 16,
>>> +	.brp_min = 1,
>>> +	.brp_max = 32,
>>> +	.brp_inc = 1,
>>> +};
>>> +
>>> +static void tcan4x5x_check_wake(struct tcan4x5x_priv *priv)
>>> +{
>>> +	int wake_state = 0;
>>> +
>>> +	if (priv->device_state_gpio)
>>> +		wake_state = gpiod_get_value(priv->device_state_gpio);
>>> +
>>> +	if (priv->device_wake_gpio && wake_state) {
>>> +		gpiod_set_value(priv->device_wake_gpio, 0);
>>> +		usleep_range(5, 50);
>>> +		gpiod_set_value(priv->device_wake_gpio, 1);
>>> +	}
>>> +}
>>> +
>>> +static int regmap_spi_gather_write(void *context, const void *reg,
>>> +				   size_t reg_len, const void *val,
>>> +				   size_t val_len)
>>> +{
>>> +	struct device *dev = context;
>>> +	struct spi_device *spi = to_spi_device(dev);
>>> +	struct spi_message m;
>>> +	u32 addr;
>>> +	struct spi_transfer t[2] = {
>>> +		{ .tx_buf = &addr, .len = reg_len, .cs_change = 0,},
>>> +		{ .tx_buf = val, .len = val_len, },
>>> +	};
>>> +
>>> +	addr = TCAN4X5X_WRITE_CMD | (*((u16 *)reg) << 8) | val_len >> 3;
>>> +
>>> +	spi_message_init(&m);
>>> +	spi_message_add_tail(&t[0], &m);
>>> +	spi_message_add_tail(&t[1], &m);
>>> +
>>> +	return spi_sync(spi, &m);
>>> +}
>>> +
>>> +static int tcan4x5x_regmap_write(void *context, const void *data, size_t count)
>>> +{
>>> +	u16 *reg = (u16 *)(data);
>>> +	const u32 *val = data + 4;
>>> +
>>> +	return regmap_spi_gather_write(context, reg, 4, val, count);
>>> +}
>>> +
>>> +static int regmap_spi_async_write(void *context,
>>> +				  const void *reg, size_t reg_len,
>>> +				  const void *val, size_t val_len,
>>> +				  struct regmap_async *a)
>>> +{
>>> +	return -ENOTSUPP;
>>> +}
>>> +
>>> +static struct regmap_async *regmap_spi_async_alloc(void)
>>> +{
>>> +	return NULL;
>>> +}
>>> +
>>> +static int tcan4x5x_regmap_read(void *context,
>>> +				const void *reg, size_t reg_size,
>>> +				void *val, size_t val_size)
>>> +{
>>> +	struct device *dev = context;
>>> +	struct spi_device *spi = to_spi_device(dev);
>>> +
>>> +	u32 addr = TCAN4X5X_READ_CMD | (*((u16 *)reg) << 8) | val_size >> 2;
>>> +
>>> +	return spi_write_then_read(spi, &addr, reg_size, (u32 *)val, val_size);
>>> +}
>>> +
>>> +static struct regmap_bus tcan4x5x_bus = {
>>> +	.write = tcan4x5x_regmap_write,
>>> +	.gather_write = regmap_spi_gather_write,
>>> +	.async_write = regmap_spi_async_write,
>>> +	.async_alloc = regmap_spi_async_alloc,
>>> +	.read = tcan4x5x_regmap_read,
>>> +	.read_flag_mask = 0x00,
>>> +	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
>>> +	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
>>> +};
>>> +
>>> +static u32 tcan4x5x_read_reg(struct m_can_classdev *m_can_class, int reg)
>>> +{
>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>> +	u32 val;
>>> +
>>> +	tcan4x5x_check_wake(priv);
>>> +
>>> +	regmap_read(priv->regmap, priv->reg_offset + reg, &val);
>>> +
>>> +	return val;
>>> +}
>>> +
>>> +static u32 tcan4x5x_read_fifo(struct m_can_classdev *m_can_class,
>>> +			      int addr_offset)
>>> +{
>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>> +	u32 val;
>>> +
>>> +	tcan4x5x_check_wake(priv);
>>> +
>>> +	regmap_read(priv->regmap, priv->mram_start + addr_offset, &val);
>>> +
>>> +	return val;
>>> +}
>>> +
>>> +static int tcan4x5x_write_reg(struct m_can_classdev *m_can_class,
>>> +			      int reg, int val)
>>> +{
>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>> +
>>> +	tcan4x5x_check_wake(priv);
>>> +
>>> +	return regmap_write(priv->regmap, priv->reg_offset + reg, val);
>>> +}
>>> +
>>> +static int tcan4x5x_write_fifo(struct m_can_classdev *m_can_class,
>>> +			       int addr_offset, int val)
>>> +{
>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>> +
>>> +	tcan4x5x_check_wake(priv);
>>> +
>>> +	return regmap_write(priv->regmap, priv->mram_start + addr_offset, val);
>>> +}
>>> +
>>> +static int tcan4x5x_power_enable(struct regulator *reg, int enable)
>>> +{
>>> +	if (IS_ERR_OR_NULL(reg))
>>> +		return 0;
>>> +
>>> +	if (enable)
>>> +		return regulator_enable(reg);
>>> +	else
>>> +		return regulator_disable(reg);
>>> +}
>>> +
>>> +static int tcan4x5x_write_tcan_reg(struct m_can_classdev *m_can_class,
>>> +				   int reg, int val)
>>> +{
>>> +	struct tcan4x5x_priv *priv = (struct tcan4x5x_priv *)m_can_class->device_data;
>>> +
>>> +	tcan4x5x_check_wake(priv);
>>> +
>>> +	return regmap_write(priv->regmap, reg, val);
>>> +}
>>> +
>>> +static int tcan4x5x_clear_interrupts(struct m_can_classdev *class_dev)
>>> +{
>>> +	struct tcan4x5x_priv *tcan4x5x = (struct tcan4x5x_priv *)class_dev->device_data;
>>> +	int ret;
>>> +
>>> +	tcan4x5x_check_wake(tcan4x5x);
>>> +
>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_STATUS,
>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_MCAN_INT_REG,
>>> +				      TCAN4X5X_ENABLE_MCAN_INT);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_INT_FLAGS,
>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = tcan4x5x_write_tcan_reg(class_dev, TCAN4X5X_ERROR_STATUS,
>>> +				      TCAN4X5X_CLEAR_ALL_INT);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return ret;
>>> +}
>>
>> Hm, handling the interrupt seems to be a quite heavy operation. How does
>> the device and system digest small messages (dlc=0) coming in at a very
>> high rate?
>>
>> Any chance to optimize accesses be reading more than on word?
>>
> 
> The device does support writing consecutive registers.  The MCAN_INT and INT_FLAGS are consecutive
> and the STATUS and ERROR_STATUS are consecutive.  So we would still need 2 writes so not sure that this will
> optimize enough for your concern.

Yes, that's what I realized as well. Two SPI transfers instead of four
is already an improvement.

> Also the m_can code is missing bulk writes which I did not want to introduce at this time.
> My concern was more functionality and maintaining current io mapped functionality.

That's fine. I'm just curious.

> Bulk writes for peripheral devices is preferred.

Of course.

Wolfgang.
