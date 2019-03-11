Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C690C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF31920643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCKTJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:09:02 -0400
Received: from mailgate-2.ics.forth.gr ([139.91.1.5]:45042 "EHLO
        mailgate-2.ics.forth.gr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKTJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:09:02 -0400
X-Greylist: delayed 2360 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Mar 2019 15:09:00 EDT
Received: from av1.ics.forth.gr (av3in [139.91.1.77])
        by mailgate-2.ics.forth.gr (8.14.4/ICS-FORTH/V10-1.8-GATE) with ESMTP id x2BISdx7004303;
        Mon, 11 Mar 2019 18:28:41 GMT
X-AuditID: 8b5b9d4d-90dff7000000235c-e0-5c86a8d6e0ce
Received: from enigma.ics.forth.gr (webmail.ics.forth.gr [139.91.1.35])
        by av1.ics.forth.gr (SMTP Outbound / FORTH / ICS) with SMTP id 2E.8E.09052.6D8A68C5; Mon, 11 Mar 2019 20:28:39 +0200 (EET)
Received: from webmail.ics.forth.gr (localhost [127.0.0.1])
        by enigma.ics.forth.gr (8.15.1//ICS-FORTH/V10.5.0C-EXTNULL-SSL-SASL) with ESMTP id x2BISbRP014201;
        Mon, 11 Mar 2019 20:28:37 +0200
X-ICS-AUTH-INFO: Authenticated user:  at ics.forth.gr
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 11 Mar 2019 20:28:37 +0200
From:   Nick Kossifidis <mick@ics.forth.gr>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, qemu-devel@nongnu.org,
        =?UTF-8?Q?=EC=A0=84=EC=A7=84=EC=98=81?= <jy0.jeon@gmail.com>
Subject: Re: ssh session with qemu-arm using busybox
Organization: FORTH
In-Reply-To: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
References: <CAOuPNLgobR4ejPs_ZUuXpRwkURH0sfb1LD27TKhGg=wrwhUvZg@mail.gmail.com>
Message-ID: <2c5d240eabdb56913f4abcc9aacf2b6b@mailhost.ics.forth.gr>
X-Sender: mick@mailhost.ics.forth.gr
User-Agent: Roundcube Webmail/1.1.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLLMWRmVeSWpSXmKPExsXSHc2orHt9RVuMwcc+eYurT34xWUw88JDd
        YtPja6wWl3fNYbPY9rmFzeL6y2ksFsd7d7A4sHvsnHWX3WPRr0SPzUvqPZ5c28zk8XmTXABr
        FJdNSmpOZllqkb5dAlfGhHmvmAs+C1c0ntjB3MDYx9/FyMkhIWAi8XbGNeYuRi4OIYEjjBIT
        T7axgySEBA4xSrz9VQBRZCoxe28nI4jNKyAocXLmExYQm1nAQmLqlf2MELa8RPPW2cwgNouA
        qkTng+2sIDabgKbE/EsHwepFBDQkdk37xAqyjFmghUni1vt7YEXCQFc8fdAFZvMLCEt8unsR
        zOYUCJR4v7CVBeKgAIktCzcyQxzhIrF150NmiONUJD78fgB2tKiAssSLE9NZJzAKzUJy6ywk
        t85CcusCRuZVjAKJZcZ6mcnFemn5RSUZeulFmxjBkTDXdwfjuQX2hxgFOBiVeHgdittihFgT
        y4orc4EBw8GsJMKbVwUU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznv4RXiQkEB6YklqdmpqQWoR
        TJaJg1OqgdFkWc/JhZHWl8IOlkXPKJN9WHgtvXqbjL3bPf15nd4qE35brlphI/Hc7lagy/3D
        32acrGrKnvmq+eSKhEuW7zWK/ZrOHRYIqfrHsfxwil9m4rvg9SFTq0MtNvgeehoib7245lfS
        z28nMoLiN09kOG7upz7B1m/DEwvuUJ5IF+FLz36Gz+hS/qzEUpyRaKjFXFScCACgdBZFgAIA
        AA==
X-Greylist: inspected by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 11 Mar 2019 18:28:42 +0000 (GMT) for IP:'139.91.1.77' DOMAIN:'av3in' HELO:'av1.ics.forth.gr' FROM:'mick@ics.forth.gr' RCPT:''
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mailgate-2.ics.forth.gr [139.91.1.5]); Mon, 11 Mar 2019 18:28:42 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Στις 2019-03-11 16:34, Pintu Agarwal έγραψε:
> Hi,
> 
> I have a qemu-arm setup with busybox which I normally use to test my
> kernel changes.
> I use this command to boot it:
> 
> QEMU-ARM$
> qemu-system-arm -M vexpress-a9 -m 1024M -kernel
> ../KERNEL/linux/arch/arm/boot/zImage -dtb
> ../KERNEL/linux/arch/arm/boot/dts/vexpress-v2p-ca9.dtb -initrd
> rootfs.img.gz -append "console=ttyAMA0 root=/dev/ram rdinit=/sbin/init
> ip=dhcp" -nographic -smp 4
> 
> This includes, my own custom kernel and rootfs build.
> For rootfs I use busybox and create cpio image and use it as initrd.
> 
> But, every time, if I have to copy some files inside qemu, I need to
> create create roofs image.
> This is painful.
> 
> So, now I am exploring how to transfer files from my ubuntu pc to
> qemu-session using "ssh".
> I know this is possible, but I am still not successful, and bit lazy
> to explore these.
> 
> I am sure, many of you people would have explored already "how to use
> ssh over qemu" and found a easy method.
> So, if anybody have easy setup please share with me.
> 
> I could see that after adding "ip=dhcp" I get the eth0 interface like 
> this:
> / # ifconfig
> eth0      Link encap:Ethernet  HWaddr 52:54:00:12:34:56
>           inet addr:10.0.2.15  Bcast:10.0.2.255  Mask:255.255.255.0
>           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>           RX packets:2 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:2 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:1180 (1.1 KiB)  TX bytes:1180 (1.1 KiB)
>           Interrupt:22
> 
> lo        Link encap:Local Loopback
>           inet addr:127.0.0.1  Mask:255.0.0.0
>           UP LOOPBACK RUNNING  MTU:65536  Metric:1
>           RX packets:0 errors:0 dropped:0 overruns:0 frame:0
>           TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:1000
>           RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
> 
> But I could not ping it from ubuntu PC.
> 
> 
> Regards,
> Pintu
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

You may use the hostfw argument on qemu, e.g...

-netdev user,id=unet,hostfwd=tcp::2222-:22 \
-net user \

and you 'll get guest's port 22 to be forwarded to hosts port 2222, so 
you can do

ssh root@localhost:2222

from the host.

Regards,
Nick
