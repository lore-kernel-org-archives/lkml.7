Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E4B20652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 20:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfCHUzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 15:55:04 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbfCHUzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 15:55:03 -0500
Received: from [192.168.1.110] ([95.117.97.241]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M72wZ-1h9lyp1FrL-008Xov; Fri, 08 Mar 2019 21:54:56 +0100
Subject: Re: [PATCH 3/4] Add header file,Kconfig and Makefile
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20190308123547.20578-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <2863fe62-9724-a2d7-f4f8-6a74648afd0a@metux.net>
Date:   Fri, 8 Mar 2019 21:54:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190308123547.20578-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dbztGV8gLxMQdZtBaW7zUmKWPyOw80D5Nv5Fmi5o6STTXIqeTLW
 NgSq2aEWhaoNEUk+/udCEwIxC1Njx7jTG1igCA3vhPS4MRAU/gXwuqQGM/l8qS9gG3L9+Xy
 L3Bdf10Wb6ZHHO2d3jV+l3kXuBi13EqtN6Jse2xae7GwcU6p7NReQc1TXPTMCyjY3G4j+wM
 VcnzgVAo4vFa10AMxDS2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/0KkWbaPCD8=:qltNKWiJkpguw0SiJUzvK7
 QvE+Kl2zoDPWkcXCXiyRoOjnRZ8xY+khfunEwi0z76FM6nxNTDEN7jEcfWSUiVsESR1ac50VW
 Ep0Rx0Zb/3GVi/v6XBb79Sfg1ikbD9fVsnqmm3Sgloo//zSgki+DVBQpzRoWLvHimRHWn9plo
 pTd6xk23zP0zC6NMOsUO3y7/Oz8cO/JMwK3G/7QwujrTNdIM+8G9ZoWdebfnXBHSxlU51WSaW
 dH3he+HzDSqA5SYM9l3dlO1ZmCcWTlE/3WtpqskH3c2/NiY79pH0Kfss5KW8uTTyQcYrF6MqX
 HWuj/ypVxqgiadxKYaAK4WrkeePrW6FhfjvYQkpC29Nkatt8OliXLEKgW6PyH578TWH6jzS+M
 O6WzUKtbXDtzn839URBZ56jIeWWseXE0ckAbZjbtlwtyouXSt3y7cZ5Eyj9E5+fa/waUQ4Sy3
 1GVHDqziZMbHS6kpNZC9Ir6GiwyiG0xAOQrsPKhT6cZ/K4EudUp7/sIkclSihxGUXhmviSpEd
 lXQD630q5hnCQNx9MbdtEkmI9RRBS4sfbkD9HYVB50/5O36DenR1QrrVVKTlKWmxCMdBUU43k
 U4Z0Y0/emIDxljisiTHfPAFQd7i9aZgquu0Ki5lHRq1MbH9RwdcS9lfRTh5sBg2vaIDQAWlOZ
 YuX9KuW4y0gZ8waYGXHmEDzxNKDtxnd52FLvDX2xWTIgGu+0ysPOgOQkzgZGuIDuZVTrAAgvr
 IPORmLOe2byERwWGmqO+hpYeHYkQ3smitfFL3/eDdqQSfR2Ycf90forWDaw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.19 13:35, Morris Ku wrote:
> This patch add header file, Kconfig and Makefile. 
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  char/snx/Kconfig       |   15 +
>  char/snx/Makefile      |    9 +
>  char/snx/driver_extd.h |  170 ++++++
>  char/snx/snx_common.h  | 1157 ++++++++++++++++++++++++++++++++++++++++
>  char/snx/snx_lp.h      |  126 +++++
>  char/snx/snx_ppdev.h   |   43 ++

why isn't that in ./drivers/tty/serial/sunix/ ?

<snip>

> diff --git a/char/snx/Kconfig b/char/snx/Kconfig
> new file mode 100644
> index 00000000..86f38352
> --- /dev/null
> +++ b/char/snx/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Character device configuration
> +#
> +
> +config SNX

please use full name: SUNIX

<snip>

> diff --git a/char/snx/driver_extd.h b/char/snx/driver_extd.h
> new file mode 100644
> index 00000000..27f69570
> --- /dev/null
> +++ b/char/snx/driver_extd.h
> @@ -0,0 +1,170 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _SNXHW_DRVR_EXTR_H_
> +#define _SNXHW_DRVR_EXTR_H_
> +
> +#ifndef SNX_IOCTL
> +#define SNX_IOCTL 0x900
> +#endif
> +
> +#define SNX_COMM_GET_BOARD_CNT          (SNX_IOCTL + 100)
> +#define SNX_COMM_GET_BOARD_INFO         (SNX_IOCTL + 101)
> +
> +#define SNX_GPIO_GET                    (SNX_IOCTL + 200)
> +#define SNX_GPIO_SET                    (SNX_IOCTL + 201)
> +#define SNX_GPIO_READ                   (SNX_IOCTL + 202)
> +#define SNX_GPIO_WRITE                  (SNX_IOCTL + 203)
> +#define SNX_GPIO_SET_DEFAULT            (SNX_IOCTL + 204)
> +#define SNX_GPIO_WRITE_DEFAULT          (SNX_IOCTL + 205)
> +#define SNX_GPIO_GET_INPUT_INVERT       (SNX_IOCTL + 206)
> +#define SNX_GPIO_SET_INPUT_INVERT       (SNX_IOCTL + 207)
> +
> +#define SNX_UART_GET_TYPE               (SNX_IOCTL + 300)
> +#define SNX_UART_SET_TYPE               (SNX_IOCTL + 301)
> +#define SNX_UART_GET_ACS                (SNX_IOCTL + 302)
> +#define SNX_UART_SET_ACS                (SNX_IOCTL + 303)

why exactly do you introduce driver-specific ioctls ?
what is "ACS"

> +#define SNX_GPIO_IN               0
> +#define SNX_GPIO_OUT              1
> +#define SNX_GPIO_LOW              0
> +#define SNX_GPIO_HI               1
> +#define SNX_GPIO_INPUT_INVERT_D   0
> +#define SNX_GPIO_INPUT_INVERT_E   1

GPIO stuff belongs into the gpio subsystem. see drivers/gpio/

<snip>

> diff --git a/char/snx/snx_common.h b/char/snx/snx_common.h
> new file mode 100644
> index 00000000..16dd8f02
> --- /dev/null
> +++ b/char/snx/snx_common.h
> @@ -0,0 +1,1157 @@
> +﻿// SPDX-License-Identifier: GPL-2.0
> +
> +#ifdef	MODVERSIONS
> +#ifndef MODULE
> +#define	MODULE
> +#endif
> +#endif

dont need that. please drop it.

<snip>

> +#ifndef KERNEL_VERSION
> +#define KERNEL_VERSION(ver, rel, seq)	((ver << 16) | (rel << 8) | seq)
> +#endif

same here.

> +#include <linux/errno.h>
> +#include <linux/signal.h>
> +#include <linux/tty.h>
> +#include <linux/tty_flip.h>
> +#include <linux/serial.h>
> +#include <linux/serial_reg.h>
> +#include <linux/ioport.h>
> +#include <linux/mm.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +#include <linux/tty_driver.h>
> +#include <linux/pci.h>
> +#include <linux/circ_buf.h>
> +#include <asm/uaccess.h>
> +#include <asm/io.h>
> +#include <asm/irq.h>
> +#include <asm/segment.h>
> +#include <asm/serial.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/workqueue.h>
> +#include <linux/moduleparam.h>
> +#include <linux/console.h>
> +#include <linux/sysrq.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/kref.h>
> +#include <linux/parport.h>
> +#include <linux/ctype.h>
> +#include <linux/poll.h>
> +#include <linux/sched.h>
> +#include <linux/serial_8250.h>
> +#include <linux/cdev.h>
> +#include <linux/sched/signal.h>

are these really all needed within the header ?

> +extern int snx_board_count;

Why that extern field ?

> +#define SNX_DRIVER_VERSION	"V2.0.4.5"
> +#define SNX_DRIVER_AUTHOR	"SUNIX Co., Ltd.<info@sunix.com.tw>"
> +#define SNX_DRIVER_DESC	"SUNIX Multi-I/O Board Driver Module"

Does it need to be in here ? (see MODULE_*() macros)

<snip>

> +typedef struct _PORT {
> +	char		type;
> +
> +	int		bar1;
> +	unsigned char	offset1;
> +	unsigned char	length1;
> +
> +	int		bar2;
> +	unsigned char	offset2;
> +	unsigned char	length2;
> +
> +	unsigned int	intmask;
> +	unsigned int	chip_flag;
> +
> +} PORT;

please no uppercase type names, and use proper prefix.

> +#if defined(__i386__) && (defined(CONFIG_M386) ||	\
> +defined(CONFIG_M486))
> +#define SNX_SERIAL_INLINE
> +#endif
> +
> +#ifdef SNX_SERIAL_INLINE
> +#define _INLINE_ inline
> +#else
> +#define _INLINE_
> +#endif

what is that for ?!

> +struct snx_ser_driver {
> +	struct module	*owner;
> +	const char	*driver_name;
> +	const char	*dev_name;
> +	int		major;
> +	int		minor;
> +	int		nr;
> +	struct snx_ser_state	*state;
> +	struct tty_driver	*tty_driver;
> +};

oh, not good. the struct tty_driver should be contained in
snx_ser_driver (not a pointer to it). or the other way round:
give the tty driver a pointer to a driver-private struct.

and this data looks as it should be assigned to individual
devices, not to driver globally.

> +#include <linux/tty_flip.h>

put all includes together at the top


> +static inline void snx_ser_insert_char
> +(
> +		struct snx_ser_port *port,
> +		unsigned int status,
> +		unsigned int overrun,
> +		unsigned int ch,
> +		unsigned int flag
> +)
> +{
> +	struct snx_ser_info *info = port->info;
> +	struct tty_struct *tty = info->tty;
> +	struct snx_ser_state *state = NULL;
> +	struct tty_port *tport = NULL;
> +
> +	state = tty->driver_data;
> +
> +	tport = &state->tport;
> +
> +	if ((status & port->ignore_status_mask & ~overrun) == 0) {
> +
> +		if (tty_insert_flip_char(tport, ch, flag) == 0)
> +			++port->icount.buf_overrun;
> +	}
> +
> +	if (status & ~port->ignore_status_mask & overrun) {
> +
> +		if (tty_insert_flip_char(tport, 0, TTY_OVERRUN) == 0)
> +			++port->icount.buf_overrun;
> +	}
> +}

too big for an inline function.


> +#define SNX_CONFIG_PARPORT_1284
> +#define SNX_CONFIG_PARPORT_PC_FIFO
> +
> +#ifdef SNX_CONFIG_PARPORT_1284
> +#undef SNX_CONFIG_PARPORT_1284
> +#endif
> +
> +#ifdef SNX_CONFIG_PARPORT_PC_FIFO
> +#undef SNX_CONFIG_PARPORT_PC_FIFO
> +#endif

parport, serial port, gpio should be separate drivers.

> +struct snx_parport_ops {

Why does the driver introduce its own callback vectors ?
> +
> +struct sunix_par_port {
> +	struct snx_parport	*port;
> +
> +	unsigned char		ctr;
> +	unsigned char		ctr_writable;
> +	int			ecr;
> +	int			fifo_depth;
> +	int			pword;
> +	int			read_intr_threshold;
> +	int			write_intr_threshold;
> +
> +	char			*dma_buf;

why not void * ?

> +	dma_addr_t		dma_handle;
> +	struct list_head	list;
> +
> +	unsigned long		base;
> +	unsigned long		base_hi;
> +	int			irq;
> +	int			portnum;
> +	unsigned int		snx_type;
> +
> +	int			board_enum;
> +	unsigned int		bus_number;
> +	unsigned int		dev_number;
> +
> +	PCI_BOARD		pb_info;
> +
> +	unsigned char		chip_flag;
> +	unsigned int		port_flag;
> +};
> +
> +// snx_devtable.c
> +extern PCI_BOARD snx_pci_board_conf[];
<snip>

why all these extern functions ?

<snip>

> +extern char snx_ser_ic_table[SNX_SER_PORT_MAX_UART][10];
> +extern char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10];
> +extern char snx_port_remap[2][10];

please try not to use global fields. these things look they belong into
the corresponding device private data structs.

> +#define sunix_parport_write_data(p, x)	sunix_parport_pc_write_data(p, x)
> +#define sunix_parport_read_data(p)	sunix_parport_pc_read_data(p)
> +#define sunix_parport_write_control(p, x)	\
> +sunix_parport_pc_write_control(p, x)
> +#define sunix_parport_read_control(p)	sunix_parport_pc_read_control(p)
> +#define sunix_parport_frob_control(p, m, v)	\
> +sunix_parport_pc_frob_control(p, m, v)
> +#define sunix_parport_read_status(p)	\
> +sunix_parport_pc_read_status(p)
> +#define sunix_parport_enable_irq(p)	sunix_parport_pc_enable_irq(p)
> +#define sunix_parport_disable_irq(p)	sunix_parport_pc_disable_irq(p)
> +#define sunix_parport_data_forward(p)	sunix_parport_pc_data_forward(p)
> +#define sunix_parport_data_reverse(p)	sunix_parport_pc_data_reverse(p)

does that really need to be in a header file ?

<snip>

> +static inline unsigned char sunix_parport_pc_frob_control(
> +struct snx_parport *p, unsigned char mask, unsigned char val)
> +{
> +	const unsigned char wm = (PARPORT_CONTROL_STROBE |
> +							PARPORT_CONTROL_AUTOFD |
> +							PARPORT_CONTROL_INIT |
> +							PARPORT_CONTROL_SELECT);
> +
> +	if (mask & 0x20) {
> +		if (val & 0x20)
> +			sunix_parport_pc_data_reverse(p);
> +		else
> +			sunix_parport_pc_data_forward(p);
> +
> +	}
> +
> +	mask &= wm;
> +	val &= wm;
> +
> +	return __sunix_parport_pc_frob_control(p, mask, val);
> +}

do these functions really *need* to be in the header and static inline ?
(IOW: are they really needed from multiple .c files ?)

> diff --git a/char/snx/snx_lp.h b/char/snx/snx_lp.h
> new file mode 100644
> index 00000000..8c48deea
> --- /dev/null
> +++ b/char/snx/snx_lp.h

<snip>

> +#define __KERNEL__	1
> +
> +#ifdef __KERNEL__

doesn't belong here. drop that.

> +
> +#include <linux/mutex.h>

put this at the top. if it's really needed here.

> diff --git a/char/snx/snx_ppdev.h b/char/snx/snx_ppdev.h
> new file mode 100644
> index 00000000..635f99e1
> --- /dev/null
> +++ b/char/snx/snx_ppdev.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include "snx_common.h"
> +
> +#define SNX_PP_IOCTL	'p'
> +
> +struct snx_ppdev_frob_struct {
> +	unsigned char mask;
> +	unsigned char val;
> +};
> +
> +
> +#define SNX_PPSETMODE		_IOW(SNX_PP_IOCTL, 0x80, int)
> +#define SNX_PPRSTATUS		_IOR(SNX_PP_IOCTL, 0x81, unsigned char)
> +#define SNX_PPRCONTROL		_IOR(SNX_PP_IOCTL, 0x83, unsigned char)
> +#define SNX_PPWCONTROL		_IOW(SNX_PP_IOCTL, 0x84, unsigned char)
> +#define SNX_PPFCONTROL		_IOW(SNX_PP_IOCTL, 0x8e,\
> +struct snx_ppdev_frob_struct)
> +#define SNX_PPRDATA		_IOR(SNX_PP_IOCTL, 0x85, unsigned char)
> +#define SNX_PPWDATA		_IOW(SNX_PP_IOCTL, 0x86, unsigned char)
> +#define SNX_PPCLAIM		_IO(SNX_PP_IOCTL, 0x8b)
> +#define SNX_PPRELEASE		_IO(SNX_PP_IOCTL, 0x8c)
> +#define SNX_PPYIELD		_IO(SNX_PP_IOCTL, 0x8d)
> +#define SNX_PPEXCL		_IO(SNX_PP_IOCTL, 0x8f)
> +#define SNX_PPDATADIR		_IOW(SNX_PP_IOCTL, 0x90, int)
> +#define SNX_PPNEGOT		_IOW(SNX_PP_IOCTL, 0x91, int)
> +#define SNX_PPWCTLONIRQ		_IOW(SNX_PP_IOCTL, 0x92, unsigned char)
> +#define SNX_PPCLRIRQ		_IOR(SNX_PP_IOCTL, 0x93, int)
> +#define SNX_PPSETPHASE		_IOW(SNX_PP_IOCTL, 0x94, int)
> +#define SNX_PPGETTIME		_IOR(SNX_PP_IOCTL, 0x95, struct timeval)
> +#define SNX_PPSETTIME		_IOW(SNX_PP_IOCTL, 0x96, struct timeval)
> +#define SNX_PPGETMODES		_IOR(SNX_PP_IOCTL, 0x97, unsigned int)
> +#define SNX_PPGETMODE		_IOR(SNX_PP_IOCTL, 0x98, int)
> +#define SNX_PPGETPHASE		_IOR(SNX_PP_IOCTL, 0x99, int)
> +#define SNX_PPGETFLAGS		_IOR(SNX_PP_IOCTL, 0x9a, int)
> +#define SNX_PPSETFLAGS		_IOW(SNX_PP_IOCTL, 0x9b, int)
> +
> +#define SNX_PP_FASTWRITE	(1<<2)
> +#define SNX_PP_FASTREAD		(1<<3)
> +#define SNX_PP_W91284PIC	(1<<4)
> +
> +#define SNX_PP_FLAGMASK		(SNX_PP_FASTWRITE | SNX_PP_FASTREAD \

what exactly are these needed for ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
