Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LOTS_OF_MONEY,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7362EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8FC218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 13:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfGCNTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 09:19:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbfGCNTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 09:19:04 -0400
Received: from [192.168.1.110] ([95.114.150.241]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N3bCH-1iiyh62CiR-010fKK; Wed, 03 Jul 2019 15:18:59 +0200
Subject: [priv] Re: [PATCH 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices.
To:     jeyentam <je.yen.tam@ni.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190702032323.28967-1-je.yen.tam@ni.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <435fe9ba-04c9-e797-f750-4eebffa82fe9@metux.net>
Date:   Wed, 3 Jul 2019 15:18:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190702032323.28967-1-je.yen.tam@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ZraLU6jp07TzmqFrdpAh1/pJG17eTeKa+NEbflnuowq2gylTRPQ
 cTTFuZzCqz9imexlEL1Y/bIj8yC8vx6t9OrG0l715jNll3ZULqckRboS6wGNt3cT74YuhNb
 jzsw/ROntEX2H2g9HZ6nuYVpSpbc3rBI4HAqK/d+JfM6TWPqPY9ABQ9qfoJs5LWPNQSwj+t
 AqBJmVMDza0OxUtJvrtKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9nJDnKfsRV8=:nIyfrdfVogZnxdtcaBIs4o
 iu+SAjT44lhiCnv9gxvPdu2+W5JKUu12hR2fJ4yh9IMIys+QNX60HDEY4XOPuBX8CFn2Eg4wa
 k5qDraTDTYN7yMCoB0BTMgh0awxd3gde6enVv3z9H8O64saq9b7+DpXNGsyrwAHx9LSck4RL+
 6sLQlAJF79/pSG8Rj307n7hIZhiPI42OeRPUkoVmeT6sZRbr61WseJwJVxZmCNUnTGuMTmfDh
 Yin29vpbnUvFUSPkHv6aJkZqHOyC+fi/MP4ha9NGndP7P27ZrqqgJp4vbQfe2Kp6E+SGXhIxw
 8KVPWJC4NM2K+oi/TYv13S3Y8S0kSSF0SUV/cDWSQmEIOy5K3Evs0O1Jh/OKeLI4e89pcZjVY
 TLNehBYgWABVR45zFJnAkisWmdsvjaYnlyynTaWv8+Tj5CQ73Wm2W8da2gAwbBNzEys9vs++X
 94RndhFFdVbXpqOEj6/+qAkykpGRWFStjwE1CneLFTujn+KeUT0zsjlctmzMuiRaY96oBlP2d
 gk31gZ1ftIYTClytUHaaGLrWfkwdpfOQoivsvX4PkhQWfwI8/tg7SWj4tujRSMbso78yMdW0C
 JUTY5NF0bsrdGGRYbVhV5DjYLfFFLnu0dPO6z6k5Oqv+15lXynLHp6Y4+cZ7IJne9YRmjTzPt
 XxWRX2Dyo1Nf7FzpuVLmDIUIg59HjJk5CNabWuGwV2ZyX+HelhfDAkoHsYUazyy4S5DE2rHsp
 l5z3yUwMnuBVLVnZ04AISeWda0LmKa792+wThxinV+bv8AXvim3KkKT/zj0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.07.19 05:23, jeyentam wrote:

Hi,

better writing to you personally, off-list.

> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>
                  ^^^^^^
maybe it would be nice to have your real name here.

> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - *  Probe module for 8250/16550-type PCI serial ports.
> + *	Probe module for 8250/16550-type PCI serial ports.
>   *
> - *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
> + *	Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
>   *
> - *  Copyright (C) 2001 Russell King, All Rights Reserved.
> + *	Copyright (C) 2001 Russell King, All Rights Reserved.
>   */
>  #undef DEBUG
>  #include <linux/module.h>

Why all these whitespace-only changes ? I doubt that anybody seriously
wanna review that.

As I know Greg, he's doesn't like whitespace-only changes at all, unless
you give him an really good reason for it.

> @@ -730,8 +730,16 @@ static int pci_ni8430_init(struct pci_dev *dev)
>  }
>  
>  /* UART Port Control Register */
> -#define NI8430_PORTCON	0x0f
> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)

I'd prefer that name change as a separate (previous) patch.

> +#define NI16550_PCR_OFFSET				  0x0f
> +#define NI16550_PCR_RS422				  0x00
> +#define NI16550_PCR_ECHO_RS485			  0x01
> +#define NI16550_PCR_DTR_RS485			  0x02
> +#define NI16550_PCR_AUTO_RS485			  0x03
> +#define NI16550_PCR_WIRE_MODE_MASK		  0x03
> +#define NI16550_PCR_TXVR_ENABLE_BIT		  (1 << 3)
> +#define NI16550_PCR_RS485_TERMINATION_BIT (1 << 6)
> +#define NI16550_ACR_DTR_AUTO_DTR		  (0x2 << 3)
> +#define NI16550_ACR_DTR_MANUAL_DTR		  (0x0 << 3)

you should use the BIT() macro here.

> +static int pci_ni8431_config_rs485(struct uart_port *port,
> +	struct serial_rs485 *rs485)
> +{
> +	u8 pcr, acr;
> +
> +	struct uart_8250_port *up;
> +
> +	up = container_of(port, struct uart_8250_port, port);
> +
> +	acr = up->acr;
> +
> +	dev_dbg(port->dev, "ni16550_config_rs485\n");

don't leave in such hackish debug helpers

> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);

is that indirection really necessary ? (IOW: are there separate
implementations needed ?)

> +static int pci_ni8431_setup(struct serial_private *priv,
> +		 const struct pciserial_board *board,
> +		 struct uart_8250_port *uart, int idx)
> +{
> +	u8 pcr, acr;
> +	struct pci_dev *dev = priv->dev;
> +	void __iomem *addr;
> +	unsigned int bar, offset = board->first_offset;

maybe size_t for offset ?

> @@ -1956,6 +2077,87 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
>  		.setup		= pci_ni8430_setup,
>  		.exit		= pci_ni8430_exit,
>  	},
> +	{
> +		.vendor		= PCI_VENDOR_ID_NI,
> +		.device		= PCIE_DEVICE_ID_NI_PXIE8430_2328,
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.init		= pci_ni8430_init,
> +		.setup		= pci_ni8430_setup,
> +		.exit		= pci_ni8430_exit,
> +	},

We should have a config sym for that, so only those who really need the
device can enable it.

OTOH, it would be even nicer to have this as an extra module.


Nevertheless its good that you NI folks now start making your products
usable on mainline kernel, instead of this really ridiculous and broken-
by-design "nikal"/daqmx crap (which even sometimes introduce 0day-
exploitable leaks allowing remote machine takeover - I've posted one
@full-disclosure several month ago. One of the reasons why I was banned
from the forums - criticism in general seems to be disliked there)

Over the recent years, I tried to get some specs on the cRIOs, in order
to write proper drivers and bring them to mainline (currently these
boxes might be nice for dumb PLC, but nothing more, and the marketing
claim "linux support" is just wrong). But there was no way of getting
anything from NI (not even after several calls with product management
and development team). And playing around w/ LV was in no way any
option. So I had to tell my client that cRIOs are completely unusable
for him, and some >$1M purchases went off the table.
(I've rarely seen any company so hostile against Linux support like NI)


good luck,

--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
