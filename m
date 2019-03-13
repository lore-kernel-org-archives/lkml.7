Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94279C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFEC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 17:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfCMRgq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:36:46 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:37667 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 13:36:45 -0400
Received: from [192.168.1.110] ([77.4.24.189]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWz4j-1hWSK42xuD-00XHb6; Wed, 13 Mar 2019 18:36:37 +0100
Subject: Re: [PATCH] Respond:Add SUNIX-Multi-I/O card device driver
To:     Morris Ku <saumah@gmail.com>, gregkh@linuxfoundation.org
Cc:     morris_ku@sunix.com, linux-kernel@vger.kernel.org, arnd@arndb.de
References: <20190313133118.14506-1-saumah@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <93cf168f-9282-ba00-11a2-04252c9c93f4@metux.net>
Date:   Wed, 13 Mar 2019 18:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190313133118.14506-1-saumah@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:YEwUroPnyjF1gYuaGsH5xSubDUoAu4atVDJVJmZ/rfHjAVkgbFh
 y8+6KzTwqU958vyjnSmgLTVjmaJp2lvwIVZ3bk7A6v1Pqo/xJ6Qez/zdL2AOCHtlbb2o1fI
 U1DGA28TBOr/twMT6qPTAKthK6mlsmVRvVq7J2XAv30XyP62svNBz8s8tcuH017mti/UVSg
 wjzAgEqz036gfq02ZPmUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ztMKPdvu9S0=:Cxg0Wm1Yfhem6/jaYZmq9l
 x5lxf7WD5ZoVHZH3YwbEH11KB+onWv4Sx6a61q2C9OMpXH0yyRF6d/rYTua/+WjWYD4HdN+NF
 +BsINSxPCGSJJ3XyGQp+qph97ES+Liu3pZhFKfqLxb6wVUfmJaGFIESedmRkO3OIXaU3Ycd4X
 toXJ9kTi0MyNqke7OdwQZnax6s1q7J/2p+XSGJKWcmkVbPv5QPNp0wilyZoaxU3fx+bjh1aJQ
 1Y/8VwGxtMOJ2o+px20OdgfbBxhLObMiaC/cnzFoCZ0st6s0GzTG7UFqwXrz12ZcSCecLDX6O
 aJiTA/s4XCJ9IF3s+du9PhG2Er47m669rtzf9+S3g4AF5qjOJihmM4ubwtt+zxp5lO58c69R3
 zHcYDwdj9ZxleQ0p2BNwbdG05BlS2JrhBWJbfDApBbHBKr1DESrFCMLo3QUPoxOpyMygsQDt2
 ZSsE5dYdRejI5Eu2oT0tkenUufzT1Xs2P+/ngrHVniZFVv1+rZo8EEKV1BCY8BKbIpZwCHOuy
 qurs/6pETH6om6h68fJgidkyZtlI+aA4298gVM5acX9WbOkULgMJ/3ABD1CPCS2mq28jUINBg
 Eu/myD89GTE5ll2lP1snIuDoKsHAct+O5d8FWzE/ZECzLLbtGGHfdlnIM2DQsL0Um+7xbcYJe
 7AKfEZ8xxXhrgaFEGvtzyFAEHcoC2lXLY2tNDrymOGv/vG0PyklGoAIY/y6n9QkF7QrhvfUQh
 oOc+I6aIhoK+g6wLlHyeohBPNUFY/RAL8Na6tMCg1eFg2hBLoZ5m2Niz+Cc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.03.19 14:31, Morris Ku wrote:

Hi,

> +why isn't that in ./drivers/tty/serial/sunix/ ?
> +
> driver support SUNIX Character Devices,
> serial ports and parallel ports,so we suggest 
> that in /drivers/char. 

Well, this seems to be a composite device. so it should be actually
different drivers (initialized by one compound driver) - all of the
subdevices I'm seeing here have their own subsystems, none of them
being a plain chardev. Therefore it probably should go to drivers/mfd
(multi function devices). If you split out the subdevice drivers
(which I'd recommend), these should go to the corresponding subsystem
directories (eg. drivers/tty/serial/ for the serial subdevice).

> +please use full name: SUNIX
> +
> 
> Ok, i'll fix in next verion.

Oh, by the way: SUNIX is the company name ? So, there's probably some
device/product name. I'd put that into the config name, too.

Eg. if the device is called "FANCYIO", then the config symbol would
be SUNIX_FANCYIO.

> +why exactly do you introduce driver-specific ioctls ?
> +
> ioctl functions support SUNIX specific serial,parellel and GPIO 
> ,need to use specific ioctol function to get related inforomation.

Which information, exactly, that aren't supported by the corresponding
subsystems ?

To make it clear: the individual functions of this card should go into
the corresponding subsystem. So, you'd have a serial driver, a parallel
driver, a gpio driver - all living in the corresponding subsystems.
NOT: one driver (more precisely: one chardev) to rule them all.

Note: in Linux we wanna use generic APIs where we can. So, if somebody
wants to use a GPIOs, he goes by the GPIO subsystem - no matter which
hardware it actually is - no hw specific devices/ioctl.

> +what is "ACS"
> +
> RS485 ACS Enable,Enable SUNIX UART Controller waiting transmit 
> data when receive data is going.

See struct uart_port and corresponding helpers (drivers/tty/serial),
it already has infrastructure for that. It also does all the buffering
stuff for you.

> SUNIX Multi-I/O card combaine serial ports,parallel ports and GPIO,
> therefore, the define support SUNIX specific gpio interface. 

See above: don't introduce your own specific interfaces - use the
generic ones. Seriously, that's the way it's going on Linux.

> +> +     char                    *dma_buf;
> +
> +why not void * ?
> +
> i am not sure what you mean ?

Is it really correct that the dma_buf has to be char* ?
(and even w/o signed/unsigned attribute).

For opaque memory buffers, we usually use void*.

> +> +// snx_devtable.c
> +> +extern PCI_BOARD snx_pci_board_conf[];
> +<snip>
> +
> +why all these extern functions ?
> +
> function definition in multiple .c files.

it's not a function, but an array of structs.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
