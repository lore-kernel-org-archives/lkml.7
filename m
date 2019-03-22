Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF17218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 16:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbfCVQMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 12:12:40 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57943 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfCVQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 12:12:39 -0400
Received: from [192.168.1.110] ([95.115.33.167]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N79q8-1gvWM604Wi-017U44; Fri, 22 Mar 2019 17:12:30 +0100
Subject: Re: [PATCH 2/4] Add support for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, morris_ku@sunix.com
References: <20190319120756.3740-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <10ffdaf1-26a8-3605-b562-28886850af0f@metux.net>
Date:   Fri, 22 Mar 2019 17:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190319120756.3740-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5XRiLkfqSDedaqbN5s6uT5/Qbxzl0iV45u3DKGpW1nlxW4Iw2oR
 CJr+awdOEgEeJQSsRL3M9+WXYnsefJK/C6+EFoi0waJrkiddErGkTLSkMvLDYB8ohlIuoZX
 NVwI1U8CG9ddQ7MUQ0ITkXN0F9POrNCZH3FVlfihFYGhJrSZm8LqCGt2jTiUXi5d5WtLVtK
 UIP4i3ehSeKd59HKxIdxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mC+00f73C08=:w2HWJB7h/dmX6VpPlkTjej
 NjlBHt51MJQ35/Jphk/+N9GelGxsFBuAhEHHF8Q+1nkYMrm6WvJs/GzbzAsqvlionoHVTwP71
 j7bERyuypp1Lu5K9yQw5wCUCdxyKXB8zxF7w/xirWpI3ieYgmEiB0MsdtGCjRFzelN3//hBV1
 NrSgzVWeVF2fB8AhaydZv9DyNvLLtx790EmYNUl8+xiACiloFYLsrHA4r7vhSJmJu/+8PYGrC
 m9PxUu1W0Ceou0jq1WueJZ1L5snqJMiTct3r3Bewuo4rd66E2nE9EaBpSyxKq42G4daff2buZ
 B7h7F2BIMjRDQwtv38/EOGr7nCIzDJ2eVV7Vj027PAR3XmOdIMs/XroDPO6mal+nGXl/5ogWf
 qLCpKqTsr9RqFjV6OQdFM4szOc2cuXhJR0IV1sec2iq9pgrmWQaA1B2Zz1qgIMUYe2PxkbKdR
 5CuNJ+ylZH24QaL1CVAjQXR6dcB3dXCC8YusKItyO/HtuannTgyasOweVLxzXZ9X4s7DDDQhE
 oljDAiopwf5VohZqQLO5HvTrsIwwo7l3OACRNXeoyINkIn3CGaTzLBjeAkttMnMVXqicZh1FT
 5kSpl7C9PZ3uCwJkiTKlWE2UvOAuENqjpxfATHuIL4n/W4mBgfQRezfdNzFfSZxSm13YV/uzG
 QroXjDk8P5nrVK5ql5T2XESamAmo26dqKprMIrD3XRnwXb1XF9eHRwxkDQTIBbF0oOmt7k5gx
 z2Nw81aT/G+Hr7ts2hTFejtdDkZjBHQthkJQraHErRnpRp9WU98q3kyskK8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.03.19 13:07, Morris Ku wrote:
> Driver for SUNIX Multi-I/O card.
> Based on driver/char/serial.c by Linus Torvalds, Theodore Ts'o.
> 
> SUNIX serial card designed with SUNIX UART controller and
> compatible with 16C950 UART specification.
> 
<snip>

> +static const char snx_ser_ic_table[SNX_SER_PORT_MAX_UART][10] = {

Doesn't seem to be used anywhere.

> +	{"UNKNOWN"},
> +	{"SUN1889"},
> +	{"SUN1699"},
> +	{"SUNMATX"},
> +	{"SUN1999"}
> +};
> +
> +static const char snx_par_ic_table[SNX_PAR_PORT_MAX_UART][10] = {

Doesn't seem to be used anywhere.

> +	{"UNKNOWN"},
> +	{"SUN1888"},
> +	{"SUN1689"},
> +	{"SUNMATX"},
> +	{"SUN1999"}
> +};

> +
> +static const char snx_port_remap[2][10] = {

Doesn't seem to be used anywhere.

> +	{"NON-REMAP"},
> +	{"REMAP"}
> +};

<snip>

> +struct sunix_board			sunix_board_table[SNX_BOARDS_MAX];
> +struct sunix_ser_port	    sunix_ser_table[SNX_SER_TOTAL_MAX + 1];
> +struct sunix_par_port	    sunix_par_table[SNX_PAR_TOTAL_MAX];

Allocate these per-device (per card) in sunix_pci_board_probe() and let
the device's private_data point to it.

And better do static zero initialization instead of memset().

<snip>

> +static struct snx_ser_driver	sunix_ser_reg = {
> +	.dev_name = "ttySNX",
> +	.major = 0,
> +	.minor = 0,
> +	.nr = (SNX_SER_TOTAL_MAX + 1),
> +};

Why this struct for something that exists only once and still allocating
more (struct snx_ser_state) in sunix_ser_register_driver() ?
Why not just putting everything into one struct ?

> +static irqreturn_t sunix_interrupt(int irq, void *dev_id)
> +{
> +	struct sunix_ser_port *sp = NULL;
> +	struct sunix_par_port *pp = NULL;
> +	struct sunix_board *sb = NULL;
> +	int i;
> +	int status = 0;
> +
> +	int handled = IRQ_NONE;
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +
> +		if (dev_id == &(sunix_board_table[i])) {

Don't do unncessary loops in time sensitive functions. Instead pass the
pointer to the corresponding struct sunix_board via dev_id - it's the
second parameter of request_irq(). Would make the code much simpler and
smaller.

> +static int snx_set_port_termios(struct snx_ser_state *state)
> +{
> +	struct tty_struct *tty = state->info->tty;
> +	struct SNXTERMIOS *termios;
> +
> +	int retval = 0;
> +
> +	termios = &tty->termios;
> +
> +	retval = snx_ser_startup(state, 0);
> +
> +	if (retval == 0)
> +		snx_ser_update_termios(state);
> +
> +	return 0;
> +}

Don't duplicate already existing functionality - use the serial
subsystem. See: drivers/tty/serial/

> +static int sunix_pci_board_probe(void)
> +{
> +	struct sunix_board *sb;
> +	struct pci_dev *pdev = NULL;
> +	struct pci_dev *pdev_array[4] = {NULL, NULL, NULL, NULL};
> +
> +	int sunix_pci_board_id_cnt;
> +	int tablecnt;
> +	int boardcnt;
> +	int i;
> +	unsigned short int sub_device_id;
> +	unsigned short int device_part_number;
> +	unsigned int bar3_base_add;
> +
> +	int status;
> +	unsigned int bar3_Byte5;
> +	unsigned int bar3_Byte6;
> +	unsigned int bar3_Byte7;
> +	unsigned int oem_id;
> +	unsigned char uart_type;
> +	unsigned char gpio_type;
> +	unsigned char gpio_card_type;
> +	int gpio_ch_cnt;
> +
> +	// clear and init some variable
> +	memset(sunix_board_table, 0, SNX_BOARDS_MAX *
> +	sizeof(struct sunix_board));


> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +		sunix_board_table[i].board_enum = -1;
> +		sunix_board_table[i].board_number = -1;
> +	}
> +
> +	sunix_pci_board_id_cnt =
> +	(sizeof(sunix_pci_board_id) / sizeof(sunix_pci_board_id[0])) - 1;

use ARRAY_SIZE() here.

> +
> +	// search matrix serial board
> +	pdev = NULL;
> +	tablecnt = 0;
> +	boardcnt = 0;
> +	sub_device_id = 0;
> +	status = 0;

Do the initialization at declaration.

> +	while (tablecnt < sunix_pci_board_id_cnt) {
> +
> +		pdev = pci_get_device(VENID_MATRIX, DEVID_M_SERIAL, pdev);

Use separate per-board driver instances instead of one instance for all.
Using multiple cards won't work this way - probe() is called per card.

> +	// search sun1999 muti I/O board
> +	pdev = NULL;
> +	tablecnt = 0;
> +	sub_device_id = 0;
> +	status = 0;
> +	device_part_number = 0;
> +	bar3_base_add = 0;
> +	bar3_Byte5 = 0;
> +	bar3_Byte6 = 0;
> +	bar3_Byte7 = 0;
> +	oem_id = 0;
> +	uart_type = 0;
> +	gpio_type = 0;
> +	gpio_card_type = 0;
> +	gpio_ch_cnt = 0;

Use separate driver instances for that.

> +	while (tablecnt < sunix_pci_board_id_cnt) {
> +
> +		pdev = pci_get_device(VENID_SUN1999, DEVID_S_SERIAL, pdev);

again: multiple cards won't work that way. you'll overwrite the
structures of the previous cards.

> +	// search SUN1999 parallel board
> +	pdev = NULL;
> +	tablecnt = 0;
> +	sub_device_id = 0;
> +	status = 0;

use a separate driver for that.

> +static int sunix_assign_resource(void)
> +{
> +	struct sunix_board *sb = NULL;
> +	struct sunix_ser_port *sp = NULL;
> +	struct sunix_par_port *pp = NULL;
> +
> +	int status = 0;
> +	int i;
> +	int j;
> +	int k;
> +	int ser_n;
> +	int ser_port_index = 0;
> +
> +	memset(sunix_ser_table, 0, (SNX_SER_TOTAL_MAX + 1) *
> +	sizeof(struct sunix_ser_port));
> +
> +	memset(sunix_par_table, 0, (SNX_PAR_TOTAL_MAX) *
> +	sizeof(struct sunix_par_port));

See above: use static zero initialization.

> +		for (j = 0; j < sb->ser_port; j++, n++, sp++) {
> +			if (j < 4) {
> +				AHDC_State = inb(sb->bar_addr[3]+2) & 0x0F &
> +						(0x01 << (((j+1)-1) % 4));
> +				RS422_State = inb(sb->bar_addr[3]+3) &
> +				0xF0 & (0x10 << (((j+1)-1) % 4));
> +			} else if (j < 8) {
> +				AHDC_State = inb(sb->bar_addr[1] + 0x32) &
> +				0x0F & (0x01 << (((j+1)-1) % 4));
> +				RS422_State = inb(sb->bar_addr[1] + 0x33) &
> +				0xF0 & (0x10 << (((j+1)-1) % 4));
> +			}

can't the register space be memory-mapped ?

> +int sunix_register_irq(void)
> +{
> +	struct sunix_board *sb = NULL;
> +	int status = 0;
> +	int i;
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {

use separate per-board device instances.

> +void sunix_release_irq(void)
> +{
> +	struct sunix_board *sb = NULL;
> +	int i;
> +
> +	for (i = 0; i < SNX_BOARDS_MAX; i++) {
> +		sb = &sunix_board_table[i];

use separate per-board device instances.
otherwise hotplug won't work.

> +static int __init snx_init(void)
> +{
> +	int status = 0;
> +
> +	snx_ser_port_total_cnt = snx_par_port_total_cnt = 0;
> +
> +	status = sunix_pci_board_probe();
> +	if (status != 0)
> +		goto step1_fail;
> +

register the drivers first. the pci subsystem will then probe
automatically. (and call the driver's probe() function per board).

> +	if (!capable(CAP_SYS_ADMIN)) {
> +		retval = -EPERM;
> +			if (change_irq ||
> +				change_port ||
> +				(new_serial.baud_base != port->uartclk / 16) ||
> +				(close_delay != state->close_delay) ||
> +				(closing_wait != state->closing_wait) ||
> +				(new_serial.xmit_fifo_size != port->fifosize) ||
> +				(((new_flags ^ old_flags)
> +				& ~SNX_UPF_USR_MASK) != 0)) {
> +				goto exit;
> +			}

As already said: changing things like irqs or io areaas from userland
shouldn't be possible at all by such weird ways. Let the corresponding
bus subsystems (in that case: pci) handle it in generic ways, and care
for probing and hotplug. (anyways, it seems that this doesn't change the
irq the device is  raising, just the one the driver expects - that's
even more wrong)

> +			if (port->flags & SNX_UPF_SPD_MASK) {
> +				pr_info("SNX Info : %s sets custom speed ",
> +					current->comm);
> +				pr_info("on ttySNX%d. This is deprecated.\n",
> +					port->line);

Why do you newly introduce things that are already deprecated ?

> +static int snx_ser_ioctl(struct tty_struct *tty,
> +unsigned int cmd, unsigned long arg)
> +{
> +	struct snx_ser_state *state = NULL;
> +	int ret = -ENOIOCTLCMD;
> +	int line = SNX_SER_DEVNUM(tty);
> +
> +	if (line < SNX_SER_TOTAL_MAX)
> +		state = tty->driver_data;
> +
> +
> +	switch (cmd) {
> +	case TIOCGSERIAL:
> +	{
> +		if (line < SNX_SER_TOTAL_MAX)
> +			ret = snx_ser_get_info(state,
> +				(struct serial_struct *)arg);
> +
> +		break;
> +	}

Dont reimplement existing standard functionality in your own special
way. Use the serial subsystem instead.

> +	case SNX_SER_DUMP_PORT_INFO:
> +	{
> +		int i;
> +		struct snx_ser_port_info snx_port_info[SNX_SER_TOTAL_MAX];
> +		struct snx_ser_port *sdn = NULL;
> +
> +		memset(snx_port_info, 0,
> +			(sizeof(struct snx_ser_port_info) *
> +				SNX_SER_TOTAL_MAX));
> +
> +		if (line == 0) {
> +			for (i = 0; i < SNX_SER_TOTAL_MAX; i++) {
> +				sdn = (struct snx_ser_port *)
> +					&sunix_ser_table[i];
> +
> +				memcpy(&snx_port_info[i].board_name_info[0],
> +					&sdn->pb_info.board_name[0],
> +					SNX_BOARDNAME_LENGTH);
> +
> +				snx_port_info[i].bus_number_info =
> +					sdn->bus_number;
> +				snx_port_info[i].dev_number_info =
> +					sdn->dev_number;
> +				snx_port_info[i].port_info       = sdn->line;
> +				snx_port_info[i].base_info       = sdn->iobase;
> +				snx_port_info[i].irq_info        = sdn->irq;
> +			}
> +
> +			if (copy_to_user((void *)arg, snx_port_info,
> +			SNX_SER_TOTAL_MAX * sizeof(struct snx_ser_port_info)))
> +				ret = -EFAULT;
> +			else
> +				ret = 0;
> +
> +		} else {
> +			ret = 0;
> +		}
> +
> +		ret = 0;
> +		break;
> +	}

This doesn't belong here. Don't invent your own private ioctl's for such
things. Use sysfs or debugfs.

> +
> +	case SNX_SER_DUMP_DRIVER_VER:
> +	{

Same here.

> +	case SNX_COMM_GET_BOARD_CNT:
> +	{

No, This information can already be retrieved just by the number of
serial/tty devices. Anyways this is just metadata for the admin, nothing
that client applications should have to care about.

> +	case SNX_COMM_GET_BOARD_INFO:
> +	{

See above: use debugfs or sysfs if you have to publish extra metadata.

> +	case SNX_UART_GET_TYPE:
> +	{

Don't reimplement existing standard functionality.

> +	case SNX_UART_SET_TYPE: {
> +		struct sunix_board	*sb = NULL;
> +		struct sunix_ser_port *sp = NULL;
> +

what things exactly can be set here, that aren't already
handled by the standard serial subsystem ?

> +		GPIOstate = inb(targetConfigAddress + 0x0C);
> +		GPIOcontrol = inb(targetConfigAddress + 0x0D);

GPIOs don't belong here. We have a separate GPIO subsystem.

> +	case SNX_UART_GET_ACS:
> +	{
> +		SNX_DRVR_UART_GET_ACS gb;
> +		struct sunix_board	*sb = NULL;
> +		int	ACSstate = 0;

What kind of states are these exactly that aren't already
handled by the standard serial subsystem ?

> +extern void snx_ser_update_termios(struct snx_ser_state *state)

Why do you need "extern" here?

> +static const struct tty_operations sunix_tty_ops = {
> +	.open               = snx_ser_open,
> +	.close              = snx_ser_close,
> +	.write              = snx_ser_write,
> +	.put_char           = snx_ser_put_char,
> +	.flush_chars        = snx_ser_flush_chars,
> +	.write_room         = snx_ser_write_room,
> +	.chars_in_buffer    = snx_ser_chars_in_buffer,
> +	.flush_buffer       = snx_ser_flush_buffer,
> +	.ioctl              = snx_ser_ioctl,
> +	.throttle           = snx_ser_throttle,
> +	.unthrottle         = snx_ser_unthrottle,
> +	.send_xchar         = snx_ser_send_xchar,
> +	.set_termios        = snx_ser_set_termios,
> +	.stop               = snx_ser_stop,
> +	.start              = snx_ser_start,
> +	.hangup             = snx_ser_hangup,
> +	.break_ctl          = snx_ser_break_ctl,
> +	.wait_until_sent    = snx_ser_wait_until_sent,
> +	.tiocmget           = snx_ser_tiocmget,
> +	.tiocmset           = snx_ser_tiocmset,
> +};

Don't reimplement existing functionality - use the serial subsystem.

> +static int sunix_ser_add_one_port(struct snx_ser_driver *drv,
> +struct snx_ser_port *port)
> +{
> +	struct snx_ser_state *state = NULL;
> +	struct tty_port *tport;
> +	struct device *tty_dev;
> +
> +	int ret = 0;
> +
> +	if (port->line >= drv->nr)
> +		return -EINVAL;
> +
> +	state = drv->state + port->line;
> +
> +	tport = &state->tport;
> +
> +	down(&ser_port_sem);
> +
> +	if (state->port) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	state->port = port;
> +
> +	port->info = state->info;
> +
> +	sunix_ser_configure_port(drv, state, port);
> +
> +	tty_dev = tty_port_register_device(
> +		tport, snx_driver, port->line, port->dev);

Dont reimplement existing functionality - use the serial subsystem.


Your driver is at least 10 times bigger as it needs to be, reimplements
lots of standard functionality in own private ways and bypasses the
corresponding subsystems. I could never ack that.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
