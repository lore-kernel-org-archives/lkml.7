Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA6DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2A71218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfCVQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:36:56 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:51513 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCVQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:36:56 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5FtF-1gxQzb46OT-011Cm0; Fri, 22 Mar 2019 17:36:47 +0100
Subject: Re: [PATCH 3/4] Add support for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190319120818.3791-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <999323c8-fb8c-9fb7-8e79-0f63d12f8a38@metux.net>
Date:   Fri, 22 Mar 2019 17:36:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190319120818.3791-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nLOQMTD0/RWzYWWfKz20+CWFW49aQSCqQMHR/l7Q8u9pOY5OKef
 eyCYvjgziJSFz/8qOxLUZopDPxcelVQmGq926Wv+dGDXg+/jMGcXstTKEPo4YSOoBvcXGor
 agFT9jE5vG2/ItXvXyc0iZ00+p4TZZXR5C0J007YCkrnMIRpal6/LIb7R3FsetFAF2rDYI5
 LZtCn0ENn6tICsRLoiFeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o2mz2uYWF7I=:PsV0djyROephoCC5xwLwdZ
 Twv2z8QFHvVbHMQT9t1NzUvM9cY/R8cuoJ5rxddGGby9W8+R+Q56dYg/qcXBKLBBAzHLrJy/s
 fIKjZ5aCRWWNjkG08ThAQYA2NPNVodk7KZxzyZOr1JGjt7t0YhCoRisf8NwsozngDsq1BQahn
 SSKGsNu691tjVeOCeUbXUD6B8fNPK4vcN+8RQeh0P2JLCFVjrrVwi1GYkEbUGrPSJegUH91oB
 6Bv4e5cQ8HvXvLvYdq6+RsXarxflHxGaqYLA7w/hOHcRh02aHOFQ5vh/5ZvVADVNTMDRx1+d9
 bsqfnA5jlgkHpml2BkQ8qgFBUAouB1bSFLjsKvpdYIKV6brHuyCADrJeZSJvue3O/oiRoK99/
 B2njyqWuIFu5f6ihhiO01GxWLWDRQiLraGC+it2Jgq2+LBmi51e3QnwwJV7UhkbuJ+kyGxlWt
 Kp1FARlAlMImY7U9BwIN1CzwRZAcLJorwiQQW5P4qhRQa8xGZWzjqoTdqkUNROjDvZxkThsiG
 cRNTKV3tT9WqcVYIFr/wwmjvugH49UVLZPD9rEYJLe83//U144POpdfiVx6CfB2sMECLfZuzs
 AtVK2axrg/1DQ6ppxHEKfKFkDOrP5merysV2lG/HYN7rgFwQTZwChfPl/3+zsXycUy7L2+7Dm
 GJqYo4SLUWevIONHRpxZ2fzZFrr0s7BH3o4GMuAmQUIaeXC5Uom8OZD+8g9Y718so27Bna2C9
 rEk4L2n6mbywucuyq5SptfFjBTrJTWXOZfFyHFjx2dFYshKDLdbZQFwc72E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.19 13:08, Morris Ku wrote:


> diff --git a/mfd/sunix/driver_extd.h b/mfd/sunix/driver_extd.h
> new file mode 100644
> index 00000000..6000e285
> --- /dev/null
> +++ b/mfd/sunix/driver_extd.h
> @@ -0,0 +1,90 @@
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
> +#define SNX_UART_GET_TYPE               (SNX_IOCTL + 300)
> +#define SNX_UART_SET_TYPE               (SNX_IOCTL + 301)
> +#define SNX_UART_GET_ACS                (SNX_IOCTL + 302)
> +#define SNX_UART_SET_ACS                (SNX_IOCTL + 303)

Dont introduce your own private ioctls. Use the standard serial
subsystem.

> +typedef struct _SNX_DRVR_BOARD_CNT {
> +	int                 cnt;
> +
> +} SNX_DRVR_BOARD_CNT, *PSNX_DRVR_BOARD_CNT;
> +
> +typedef struct _SNX_DRVR_UART_INFO {
> +	int                 status;
> +	int                 node_num;
> +	int                 uart_type;
> +
> +} SNX_DRVR_UART_INFO, *PSNX_DRVR_UART_INFO;
> +
> +
> +typedef struct _SNX_DRVR_BOARD_INFO {
> +	int                 board_id;
> +	int                 subvender_id;
> +	int                 subsystem_id;
> +	int                 oem_id;
> +	int                 uart_cnt;
> +	SNX_DRVR_UART_INFO  uart_info[SNX_BOARD_MAX_UARTCNT];
> +	int                 gpio_chl_cnt;
> +	int                 board_uart_type;
> +int                 board_gpio_type;
> +
> +} SNX_DRVR_BOARD_INFO, *PSNX_DRVR_BOARD_INFO;
> +
> +typedef struct _SNX_DRVR_UART_GET_TYPE {
> +	int                 board_id;
> +	int                 uart_num;
> +	int                 uart_type;
> +
> +} SNX_DRVR_UART_GET_TYPE, *PSNX_DRVR_UART_GET_TYPE;
> +
> +
> +typedef struct _SNX_DRVR_UART_SET_TYPE {
> +	int                 board_id;
> +	int                 uart_num;
> +	int                 uart_type;
> +
> +} SNX_DRVR_UART_SET_TYPE, *PSNX_DRVR_UART_SET_TYPE;
> +
> +
> +typedef struct _SNX_DRVR_UART_GET_ACS {
> +	int                 board_id;
> +	int                 uart_num;
> +	int                 uart_acs;
> +
> +} SNX_DRVR_UART_GET_ACS, *PSNX_DRVR_UART_GET_ACS;
> +
> +
> +typedef struct _SNX_DRVR_UART_SET_ACS {
> +	int                 board_id;
> +	int                 uart_num;
> +	int                 uart_acs;
> +
> +} SNX_DRVR_UART_SET_ACS, *PSNX_DRVR_UART_SET_ACS;

Are these structs for the ioctls ?
Beside that fact that you shouldn't introduce them in the first place,
at least their names should reflect what they're really about.

> +#include "driver_extd.h"
> +#include <linux/version.h>

put private includes beyond the public ones.

> +struct snx_ser_port_info {
> +	char			board_name_info[SNX_BOARDNAME_LENGTH];

Why do you need fixed-length strings here ?


> +	unsigned int	bus_number_info;
> +	unsigned int	dev_number_info;
> +	unsigned int	port_info;
> +	unsigned int	base_info;
> +	unsigned int	irq_info;

Those information belongs into the bus specific device base struct
(eg. struct pci_device). It's there anyways, no need to duplicate it.

BTW: you do know how the inheritance pattern (nested structs) works
in Linux ?

> +struct sunix_board {
> +	int						board_enum;
> +	int						board_number;
> +	unsigned int			bus_number;
> +	unsigned int			dev_number;
> +
> +	unsigned int			ports;
> +	unsigned int			ser_port;
> +	unsigned int			par_port;
> +
> +	unsigned int			ser_port_index;
> +	unsigned int			par_port_index;
> +
> +	unsigned int			bar_addr[SNX_PCICFG_BAR_TOTAL];
> +	unsigned int			irq;
> +
> +	unsigned int			board_flag;
> +
> +	unsigned int			vector_mask;
> +	pci_board		pb_info;
> +	struct pci_dev		*pdev;
> +	int	(*ser_isr)(struct sunix_board *sb, struct sunix_ser_port *port);
> +	int	(*par_isr)(struct sunix_board *sb, struct sunix_par_port *port);

What exactly are these for ?

The individual subdevices (like uarts, gpio, etc) shall be handled
completely by their own subdrivers (which are just instanciated by an
upper layer mfd driver). So, instead of these long call chains, the
corresponding irqs shall be bound to the subdriver's callbacks directly.
ISR's are a very time-critical path. Such things are bad for RT !
(and yes: Linux *is* an RT-capable kernel - tglx+friends have invested
*a lot* brain+sweat into that, try not to damage this)

> +#define SNX_IOCTL  0x900
> +#define SNX_SER_DUMP_PORT_INFO  (SNX_IOCTL + 50)
> +#define SNX_SER_DUMP_PORT_PERF  (SNX_IOCTL + 51)
> +#define SNX_SER_DUMP_DRIVER_VER (SNX_IOCTL + 52)
> +#define SNX_PAR_DUMP_PORT_INFO  (SNX_IOCTL + 53)
> +#define SNX_PAR_DUMP_DRIVER_VER (SNX_IOCTL + 54)

dont introduce your own hardware specific ioctls.

> +#define SNX_UPF_SKIP_TEST			(1 << 6)
> +#define SNX_UPF_HARDPPS_CD		(1 << 11)
> +#define SNX_UPF_LOW_LATENCY		(1 << 13)
> +#define SNX_UPF_BUGGY_UART		(1 << 14)
> +#define SNX_UPF_MAGIC_MULTIPLIER	(1 << 16)

better use the BIT() macro + friends - much easier to understand.

> +struct snx_ser_driver {
> +	struct module	*owner;
> +	const char	*driver_name;
> +	const char	*dev_name;
> +	int		major;
> +	int		minor;
> +	int		nr;
> +	struct snx_ser_state	*state;
> +};

WTF ?! You seriously redefine (parts of) struct device and then hard-
typecast ?! *NO*, this is *not* how the LDM works. If you wanna inherit
from it, put a struct driver field (not a pointer to it!) into your own
struct and corresponding macros (container_of()+friends) to typecast.

See here:

> +struct sunix_ser_port {
> +	struct snx_ser_port port;

<snip>

> +#ifdef SNX_CONFIG_PARPORT_1284
> +#undef SNX_CONFIG_PARPORT_1284
> +#endif
> +
> +#ifdef SNX_CONFIG_PARPORT_PC_FIFO
> +#undef SNX_CONFIG_PARPORT_PC_FIFO
> +#endif

what is this ?!

> +#ifndef min
> +#define min(a, b) ((a) < (b) ? (a) : (b))
> +#endif

WTF ?

> +struct snx_parport_ops {
> +	void	(*write_data)(struct snx_parport *p, unsigned char d);
> +	unsigned char	(*read_data)(struct snx_parport *p);
> +	void	(*write_control)(struct snx_parport *p, unsigned char ctl);
> +	unsigned char	(*read_control)(struct snx_parport *p);
> +	unsigned char	(*frob_control)(struct snx_parport *p,
> +					unsigned char mask, unsigned char val);
> +	unsigned char	(*read_status)(struct snx_parport *p);
> +	void		(*enable_irq)(struct snx_parport *p);
> +	void		(*disable_irq)(struct snx_parport *p);
> +	void		(*data_forward)(struct snx_parport *p);
> +	void		(*data_reverse)(struct snx_parport *p);
> +	void		(*init_state)(struct snx_pardevice *d,
> +						struct snx_parport_state *s);

What exactly is this ?

By the way: if the board acts as an interrupt controller, then you
seriously should implement a separate interrupt controller driver for
it and keep this logic out of the other subdrivers. (just as Arnd
already explained).

> +struct snx_pardevice {
> +	const char					*name;
> +	struct snx_parport			*port;
> +
> +	int							daisy;
> +	int				(*preempt)(void *);
> +	void			(*wakeup)(void *);
> +	void			*private;
> +	void			(*irq_func)(int, void *, struct pt_regs *);

What exactly are these callbacks for ? The same weird thing like w/
struct snx_ser_driver ?

> +	struct snx_pardevice		*next;
> +	struct snx_pardevice		*prev;
> +	struct snx_parport_state	*state;

What do you need this linked list for ?
BTW: we have standard data structures and helpers for such things.

> +struct snx_parport {
> +	unsigned long	base;
> +	unsigned long	base_hi;
> +	unsigned int	size;
> +	const char		*name;
> +	unsigned int	modes;
> +	int		irq;
> +	int		dma;
> +	int		muxport;
> +	int		portnum;
> +
> +	struct snx_parport		*physport;
> +	struct snx_pardevice	*devices;
> +	struct snx_pardevice	*cad;

See my comment on struct snx_ser_driver.

> +// snx_devtable.c
> +//extern pci_board snx_pci_board_conf[];
> +
> +// snx_ieee1284_ops.c
> +extern size_t	sunix_parport_ieee1284_write_compat(
> +struct snx_parport *port, const void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_read_nibble(
> +struct snx_parport *port, void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_read_byte(
> +struct snx_parport *port, void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_ecp_write_data(
> +struct snx_parport *port, const void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_ecp_read_data(
> +struct snx_parport *port, void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_ecp_write_addr(
> +struct snx_parport *port, const void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_epp_write_data(
> +struct snx_parport *port, const void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_epp_read_data(
> +struct snx_parport *port, void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_epp_write_addr(
> +struct snx_parport *port, const void *buffer, size_t len, int flags);
> +extern size_t	sunix_parport_ieee1284_epp_read_addr(
> +struct snx_parport *port, void *buffer, size_t len, int flags);
> +
> +// snx_ieee1284.c
> +extern int	sunix_parport_wait_event(struct snx_parport *port,
> +				signed long timeout);
> +extern int		sunix_parport_poll_peripheral(struct snx_parport *port,
> +unsigned char mask, unsigned char result, int usec);
> +
> +extern int	sunix_parport_wait_peripheral(struct snx_parport *port,
> +	unsigned char mask, unsigned char result);
> +
> +extern int		sunix_parport_negotiate(struct snx_parport *port,
> +					int mode);
> +extern ssize_t	sunix_parport_write(struct snx_parport *port,
> +					const void *buffer, size_t len);
> +extern ssize_t	sunix_parport_read(struct snx_parport *port,
> +					void *buffer, size_t len);
> +extern long	sunix_parport_set_timeout(struct snx_pardevice *dev,
> +					long inactivity);
> +
> +// snx_share.c
> +extern int		sunix_parport_default_spintime;
> +extern int	sunix_parport_register_driver(struct snx_parport_driver *drv);
> +extern void	sunix_parport_unregister_driver(struct snx_parport_driver *drv);
> +extern void	sunix_parport_put_port(struct snx_parport *port);
> +extern void	sunix_parport_announce_port(struct snx_parport *port);
> +extern void	sunix_parport_remove_port(struct snx_parport *port);
> +extern void	sunix_parport_unregister_device(struct snx_pardevice *dev);
> +extern int	sunix_parport_claim(struct snx_pardevice *dev);
> +extern int	sunix_parport_claim_or_block(struct snx_pardevice *dev);
> +extern void	sunix_parport_release(struct snx_pardevice *dev);
> +extern struct snx_parport *sunix_parport_get_port(struct snx_parport *port);
> +
> +extern struct snx_parport *sunix_parport_register_port(
> +struct sunix_par_port *priv,  struct snx_parport_ops *ops);
> +
> +extern struct snx_parport *sunix_parport_find_number(int number);
> +extern struct snx_parport *sunix_parport_find_base(unsigned long base);
> +extern struct snx_pardevice *sunix_parport_register_device(
> +	struct snx_parport	*port,
> +	const char			*name,
> +	int		(*pf)(void *),
> +	void	(*kf)(void *),
> +	void	(*irq_func)(int, void *, struct pt_regs *),
> +	int		flags,
> +	void	*handle
> +	);
> +
> +// snx_parallel.c
> +extern int		sunix_par_parport_init(void);
> +extern void		sunix_par_parport_exit(void);
> +
> +// snx_serial.c
> +extern int		sunix_ser_register_ports(struct snx_ser_driver *drv);
> +extern void		sunix_ser_unregister_ports(struct snx_ser_driver *drv);
> +extern int		sunix_ser_register_driver(struct snx_ser_driver *drv);
> +extern void		sunix_ser_unregister_driver(struct snx_ser_driver *drv);
> +extern int		sunix_ser_interrupt(struct sunix_board *sb,
> +struct sunix_ser_port *first_sp);
> +extern void		snx_ser_change_speed(struct snx_ser_state *state,
> +struct SNXTERMIOS *old_termios);
> +
> +// snx_ppdev.c
> +extern int	sunix_par_ppdev_init(void);
> +extern void	sunix_par_ppdev_exit(void);
> +
> +// snx_lp.c
> +extern int	sunix_par_lp_init(void);
> +extern void	sunix_par_lp_exit(void);
> +
> +// snx_main.c
> +extern struct sunix_board	sunix_board_table[SNX_BOARDS_MAX];
> +extern struct sunix_ser_port	sunix_ser_table[SNX_SER_TOTAL_MAX + 1];
> +extern struct sunix_par_port	sunix_par_table[SNX_PAR_TOTAL_MAX];
> +
> +extern int      snx_ser_startup(struct snx_ser_state *state, int init_hw);
> +extern void     snx_ser_update_termios(struct snx_ser_state *state);

why all these extern's ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
