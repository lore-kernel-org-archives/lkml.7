Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1382C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88DBB2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 03:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCGDTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 22:19:55 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:45277 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfCGDTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 22:19:54 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MowOm-1gjUK71CEo-00qQfF; Thu, 07 Mar 2019 04:19:45 +0100
Subject: Re: [PATCH 4/5] Add driver for SUNIX Multi-I/O board
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org
References: <20190227071842.4253-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a3578ee0-9c00-2460-e441-e8d56f472bca@metux.net>
Date:   Thu, 7 Mar 2019 04:19:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190227071842.4253-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/Hp4JqXNh6eAFeZuo6tfYj+M14hHDd+DUeUbjlwDZr18XJqwYoF
 ynwyT+pOvGTsPtr0VcbwZLL+QF04CYcQjP5Ec7e/9npxOLh+EvCBo37XdpMijOCcxyFo2Jy
 bI48qHIflKoT8W5CGf63Yy7rndyQuSCfkrG8RRBQc2xKFCFH8hygW1G+nESuIkPvckqGZVs
 bJjqI/b9nncf8ALih6j0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eC3QWj5ST9I=:5LSJemD9UPANqg/rqvxuvg
 6U1e40hPR0jhdGefIdE2LX4mcTqYSL45yGx9H6K6aKodJC8DnMXgFWo7wSbIO2WF/BxYUVp4T
 /rwhmB+1tZWaqOo6l+Dxq5mJSY5j/zAsmMZ4OGJnoW3zREaPXps9ZmJ2HwYuTiwJgtfbEHLVX
 FORXPOYqDrHVQXBG6dUVRfop1TIUtfQ8eqKEDENHsz0eB/d7uavn1TnKXVDOASisUxi7R+CCB
 +FDKgmMQ8wNmsbpuGeFzebUBc835FnhyfyxBetQZCd3if3Bt/uBBALNpnZPoPjxHY5AME7ZL2
 woTTPi6p/PvBehP2DWnD+MWsn71275RmQPO9qoMxPm0V+fZnIR3+1Z/c0Ky1kXHK3UkxLv2qs
 61ZX11D2qBrRFjs3o7gaMtleahJkfIaJVgeNxmCT0Bzewu9bO6mvccHToaaocN2B6+oi4asDg
 ubaMMnk+udxnlUOrgDoTOUGO9kvp5PlEcAQy5e8aBq/AfX+PP7YWjq7IdE8RZBPDQvqGobsWM
 oEa00yjx8K/m9ynpija0LCe263Lj0jl8cZjG0xulZk17rCFr/j3d8zOl8dTnbrDO6vX/apYEm
 XmqmUbqYeEv86th9VpM/XDWbAXpXuFdL+0wY00sEBXVkNhm0wgmARJ+y/hwfumCAx6k16GN1G
 8/wgoDtMeTnCxPcSPZEQu6mkv+vgFrYjy/ynDDjk9XVGxaZa/CkPLzPgAHxLr76MjtCZtUdlV
 Vi9zb28E6pCXMiSu1vtCZC6iD+LipLUtl+jVPfy6GcGp8Zaz+DkI+xkqRiU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.02.19 08:18, Morris Ku wrote:

Hi,


first of all: the code is pretty unreadable. I doubt that anybody here
seriously likes to review that (nor take it into mainline).

Formatting should be consistent - see other drivers.

./scripts/checkpatch.pl is your friend. You really shut run it and fix
everything it complaints before posting patches. (some maintainers can
get angry if you don't ;-)

> Support SUNIX serial board.
> 
> ---
>  char/snx/snx_serial.c | 4771 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 4771 insertions(+)
>  create mode 100644 char/snx/snx_serial.c
> 
> diff --git a/char/snx/snx_serial.c b/char/snx/snx_serial.c
> new file mode 100644
> index 00000000..94caac1a
> --- /dev/null
> +++ b/char/snx/snx_serial.c
> @@ -0,0 +1,4771 @@
> +#include "snx_common.h"
> +#include "driver_extd.h"
> +
> +#define SNX_ioctl_DBG	0
> +#define	EEPROM_ACCESS_DELAY_COUNT			100000

is this eeprom stuff really specific to the serial ports ?
if not, it probably should go to a separate file, which is called by all
the others, IMHO.

> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 37))
> +		static DEFINE_SEMAPHORE(ser_port_sem);
> +#else
> +		static DECLARE_MUTEX(ser_port_sem);
> +#endif

Drop that. We have only one kernel version here, the current one.

> +
> +
> +#define SNX_HIGH_BITS_OFFSET	((sizeof(long)-sizeof(int))*8)
> +#define sunix_ser_users(state)	((state)->count + ((state)->info ? (state)->info->blocked_open : 0))
> +
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
> +static struct tty_port snx_service_port;
> +#endif

are you really sure this has to be a global field, instead of allocated
per-device ?

> +
> +
> +#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3, 7, 0))
> +
> +struct serial_uart_config {
> +	char	*name;
> +	int		dfl_xmit_fifo_size;
> +	int		flags;
> +};
> +#endif
> +
> +static const struct serial_uart_config snx_uart_config[PORT_SER_MAX_UART + 1] = {

why +1 ?

maybe PORT_SER_MAX_UART and use ARRAY_SIZE() macro instead.

> +	{ "unknown",    1,      0 },
> +	{ "8250",       1,      0 },
> +	{ "16450",      1,      0 },
> +	{ "16550",      1,      0 },
> +	{ "16550A",     16,     UART_CLEAR_FIFO | UART_USE_FIFO },
> +	{ "Cirrus",     1,    	0 },
> +	{ "ST16650",    1,    	0 },
> +	{ "ST16650V2",  32,    	UART_CLEAR_FIFO | UART_USE_FIFO },
> +	{ "TI16750",    64,    	UART_CLEAR_FIFO | UART_USE_FIFO },
> +};
>
> +
> +
> +#if (LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 0))
> +static int		sunix_ser_refcount;
> +static struct tty_struct			*sunix_ser_tty[SNX_SER_TOTAL_MAX + 1];
> +static struct termios				*sunix_ser_termios[SNX_SER_TOTAL_MAX + 1];
> +static struct termios				*sunix_ser_termios_locked[SNX_SER_TOTAL_MAX + 1];
> +#endif

obsolete. drop that.

> +
> +
> +static _INLINE_ void snx_ser_handle_cts_change(struct snx_ser_port *, unsigned int);

what exactly does _INLINE_ suppose to mean ?

<snip>

> +extern int 		sunix_ser_interrupt(struct sunix_board *, struct sunix_ser_port *);

why "extern" here ? where is that function coming from ?

<snip>

> +static unsigned char READ_INTERRUPT_VECTOR_BYTE(struct sunix_ser_port *);

I doubt that upper case function names fit in the kernel coding style.

<snip>

> +		case SNX_SER_DUMP_PORT_INFO:
> +		{
> +			int i;
> +			struct snx_ser_port_info snx_port_info[SNX_SER_TOTAL_MAX];
> +			struct snx_ser_port *sdn = NULL;
> +
> +			memset(snx_port_info, 0, (sizeof(struct snx_ser_port_info) * SNX_SER_TOTAL_MAX));
> +
> +			if (line == 0) {
> +				for (i = 0; i < SNX_SER_TOTAL_MAX; i++) {
> +					sdn = (struct snx_ser_port *) &sunix_ser_table[i];
> +
> +					memcpy(&snx_port_info[i].board_name_info[0], &sdn->pb_info.board_name[0], SNX_BOARDNAME_LENGTH);
> +
> +					snx_port_info[i].bus_number_info = sdn->bus_number;
> +					snx_port_info[i].dev_number_info = sdn->dev_number;
> +					snx_port_info[i].port_info       = sdn->line;
> +					snx_port_info[i].base_info       = sdn->iobase;
> +					snx_port_info[i].irq_info        = sdn->irq;
> +				}
> +
> +				if (copy_to_user((void *)arg, snx_port_info, SNX_SER_TOTAL_MAX * sizeof(struct snx_ser_port_info))) {
> +					ret = -EFAULT;
> +				} else {
> +					ret = 0;
> +				}
> +			} else {
> +				ret = 0;
> +		}
> +
> +			ret = 0;
> +			break;
> +		}
> +
> +		case SNX_SER_DUMP_DRIVER_VER:
> +		{
> +			char driver_ver[SNX_DRIVERVERSION_LENGTH];
> +			memset(driver_ver, 0, (sizeof(char) * SNX_DRIVERVERSION_LENGTH));
> +
> +			if (line == 0) {
> +
> +				memcpy(&driver_ver[0], SNX_DRIVER_VERSION, sizeof(SNX_DRIVER_VERSION));
> +
> +				if (copy_to_user((void *)arg, &driver_ver, (sizeof(char) * SNX_DRIVERVERSION_LENGTH))) {
> +					ret = -EFAULT;
> +				} else {
> +					ret = 0;
> +				}
> +			} else {
> +				ret = 0;
> +			}
> +
> +			break;
> +		}
> +
> +
> +		case SNX_COMM_GET_BOARD_CNT:
> +		{
> +			SNX_DRVR_BOARD_CNT gb;
> +
> +			memset(&gb, 0, (sizeof(SNX_DRVR_BOARD_CNT)));
> +
> +			gb.cnt = snx_board_count;
> +
> +			if (copy_to_user((void *)arg, &gb, (sizeof(SNX_DRVR_BOARD_CNT)))) {
> +				ret = -EFAULT;
> +			} else {
> +			ret = 0;
> +			}
> +
> +			break;
> +		}
> +
> +		case SNX_COMM_GET_BOARD_INFO:
> +		{
> +			struct sunix_board *sb = NULL;
> +			SNX_DRVR_BOARD_INFO		board_info;
> +
> +			memset(&board_info, 0, (sizeof(SNX_DRVR_BOARD_INFO)));
> +
> +			if (copy_from_user(&board_info, (void *)arg, (sizeof(SNX_DRVR_BOARD_INFO)))) {
> +				ret = -EFAULT;
> +			} else {
> +				ret = 0;
> +			}
> +
> +			sb = &sunix_board_table[board_info.board_id - 1];
> +
> +			board_info.subvender_id = sb->pb_info.sub_vendor_id;
> +			board_info.subsystem_id = sb->pb_info.sub_device_id;
> +			board_info.oem_id = sb->oem_id;
> +			board_info.uart_cnt = sb->uart_cnt;
> +			board_info.gpio_chl_cnt = sb->gpio_chl_cnt;
> +			board_info.board_uart_type = sb->board_uart_type;
> +			board_info.board_gpio_type = sb->board_gpio_type;
> +
> +			if (copy_to_user((void *)arg, &board_info, (sizeof(SNX_DRVR_BOARD_INFO)))) {
> +				ret = -EFAULT;
> +			} else {
> +				ret = 0;
> +			}
> +			break;
> +		}
> +

what exactly is that for ?

> +		case SNX_GPIO_GET:

gpio stuff doesn't belong into a serial / tty.
for that we have the gpio subsystem. (see drivers/gpio/*)

> +		case SNX_UART_GET_TYPE:
> +		{
> +			struct sunix_board 	*sb = NULL;
> +			SNX_DRVR_UART_GET_TYPE gb;
> +
> +			int bar3_base_Address;
> +			int bar1_base_Address;
> +
> +			int bar3_byte5;
> +			int uart_type;
> +			int	RS422state;
> +			int	AHDCstate;
> +
> +			memset(&gb, 0, (sizeof(SNX_DRVR_UART_GET_TYPE)));
> +
> +			if (copy_from_user(&gb, (void *)arg, (sizeof(SNX_DRVR_UART_GET_TYPE)))) {
> +				ret = -EFAULT;
> +			} else {
> +				ret = 0;
> +			}
> +
> +			sb = &sunix_board_table[gb.board_id - 1];
> +
> +			bar3_base_Address = pci_resource_start(sb->pdev, 3);
> +			bar1_base_Address = pci_resource_start(sb->pdev, 1);
> +
> +			bar3_byte5 = inb(bar3_base_Address + 5);
> +			uart_type = (bar3_byte5 & 0xC0) >> 6;
> +
> +			if (gb.uart_num <= 4) {
> +				AHDCstate = inb(bar3_base_Address + 2) & 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
> +				RS422state = inb(bar3_base_Address + 3) & 0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
> +			} else if (gb.uart_num <= 8) {
> +				AHDCstate = inb(bar1_base_Address + 0x32) & 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
> +				RS422state = inb(bar1_base_Address + 0x33) & 0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
> +			} else if (gb.uart_num <= 12) {
> +				AHDCstate = inb(bar1_base_Address + 0x32 + 0x40) & 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
> +				RS422state = inb(bar1_base_Address + 0x33 + 0x40) & 0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
> +			} else if (gb.uart_num <= 16) {
> +				AHDCstate = inb(bar1_base_Address + 0x32 + 0x80) & 0x0F & (0x01 << ((gb.uart_num - 1) % 4));
> +				RS422state = inb(bar1_base_Address + 0x33 + 0x80) & 0xF0 & (0x10 << ((gb.uart_num - 1) % 4));
> +			} else {
> +				//cmn_err(CE_NOTE, "WARNING : we get an incorrect port number (port = %d)!",gb.uart_num);
> +				break;
> +			}
> +
> +				switch (uart_type) {
> +				case 0: // RS-232
> +				{
> +					gb.uart_type = 0;
> +					break;
> +				}
> +				case 1: // RS-422/485
> +				{
> +					if (AHDCstate && RS422state) {
> +						gb.uart_type = 3;
> +					} else if (AHDCstate && !RS422state) {
> +						gb.uart_type = 2;
> +					} else if (!AHDCstate && RS422state) {
> +						gb.uart_type = 1;
> +					} else {
> +						gb.uart_type = -1;
> +					}
> +					break;
> +				}
> +				case 2:
> +				{
> +					if (AHDCstate && RS422state) {
> +						gb.uart_type = 3;
> +					} else if (AHDCstate && !RS422state) {
> +						gb.uart_type = 2;
> +					} else if (!AHDCstate && RS422state) {
> +						gb.uart_type = 1;
> +					} else if (!AHDCstate && !RS422state) {
> +						gb.uart_type = 0;
> +					} else {
> +						gb.uart_type = -1;
> +					}
> +					break;
> +				}
> +			}
> +
> +			if (copy_to_user((void *)arg, &gb, (sizeof(SNX_DRVR_UART_GET_TYPE)))) {
> +				ret = -EFAULT;
> +			} else {
> +			ret = 0;
> +			}
> +

what is that for ?

> +		case SNX_UART_GET_ACS:
> +		{

what is an "ACS" ?

In general: don't arbitrarily introduce new ioctl()s, especially not
device specific ones - unless there is a damn good reason.


--mtx
-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
