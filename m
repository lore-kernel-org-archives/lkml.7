Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70412C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C6020693
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 17:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556385476;
	bh=RnquHZSvOxDAYjl330pwMESxn/qilHQhKzpxRLn/XOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lCD2guk5CBs+Uy2FNtBWKRc5fOopn7Xy8ErWIT/Ok7kSOanG4dCOEfr39Ps7uRTmz
	 FfzQTu1iBEIlVQP5kM35t032qu7is6XpVyrrS/QyufB6C79suIDaJEYj08vDvx3nCz
	 QCBalL1VxJw3rhR702COh49aXmCc4d7YuvIdi/r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfD0RRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 13:17:55 -0400
Received: from casper.infradead.org ([85.118.1.10]:49060 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0RRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 13:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N1iFC/g18qJXgObbc+D5kEAwjd33njI5fxm4ar8wMps=; b=IUvb7BjJlsbvwaVjNXp9xze3Eb
        HcPMPtybO2mkDatBvMZ6R4oyKytdhrm/RPY55a1q89QcJZRqdTD2jINZrj0UhSY/iZkz6E4135/3z
        nStj0GKYwtVWQn8sO8XW2P9RMby9lyPUkY1i12DAO0PY/oMUNe/JoPR+660qk+MIC0oRksbNPgd7C
        FLtNyc7GK2JM7qoTEN/n3UUTvkq3jVftZZb92Clpqx2QM0oe1OU7NYDgGtx0v9rm1LlG+EFh8okAQ
        ulSprHV8g2QHrCyHzyb2W4LLa14tWQNXiswoSny2bQLJvNLcd2LeE+oM8cMGCf5aVcffGp4rgSCQc
        UwdllKXg==;
Received: from 177.17.250.151.dynamic.adsl.gvt.net.br ([177.17.250.151] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKQxM-0001TO-Rk; Sat, 27 Apr 2019 17:17:45 +0000
Date:   Sat, 27 Apr 2019 14:17:39 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/27] Documentation: x86: convert earlyprintk.txt to
 reST
Message-ID: <20190427141739.6e18f127@coco.lan>
In-Reply-To: <20190426153150.21228-8-changbin.du@gmail.com>
References: <20190426153150.21228-1-changbin.du@gmail.com>
        <20190426153150.21228-8-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 26 Apr 2019 23:31:30 +0800
Changbin Du <changbin.du@gmail.com> escreveu:

> This converts the plain text documentation to reStructuredText format and
> add it to Sphinx TOC tree. No essential content change.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  .../x86/{earlyprintk.txt => earlyprintk.rst}  | 103 ++++++++++--------
>  Documentation/x86/index.rst                   |   1 +
>  2 files changed, 57 insertions(+), 47 deletions(-)
>  rename Documentation/x86/{earlyprintk.txt => earlyprintk.rst} (59%)
> 
> diff --git a/Documentation/x86/earlyprintk.txt b/Documentation/x86/earlyprintk.rst
> similarity index 59%
> rename from Documentation/x86/earlyprintk.txt
> rename to Documentation/x86/earlyprintk.rst
> index 46933e06c972..7714e32501ec 100644
> --- a/Documentation/x86/earlyprintk.txt
> +++ b/Documentation/x86/earlyprintk.rst
> @@ -1,52 +1,58 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============
> +Early Printk
> +============
>  
>  Mini-HOWTO for using the earlyprintk=dbgp boot option with a
>  USB2 Debug port key and a debug cable, on x86 systems.
>  
>  You need two computers, the 'USB debug key' special gadget and
> -and two USB cables, connected like this:
> +and two USB cables, connected like this::
>  
>    [host/target] <-------> [USB debug key] <-------> [client/console]
>  
> -1. There are a number of specific hardware requirements:
> -
> - a.) Host/target system needs to have USB debug port capability.
> -
> - You can check this capability by looking at a 'Debug port' bit in
> - the lspci -vvv output:
> -
> - # lspci -vvv
> - ...
> - 00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
> -         Subsystem: Lenovo ThinkPad T61
> -         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> -         Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> -         Latency: 0
> -         Interrupt: pin D routed to IRQ 19
> -         Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
> -         Capabilities: [50] Power Management version 2
> -                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> -                 Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> -         Capabilities: [58] Debug port: BAR=1 offset=00a0
> +Hardware requirements
> +=====================
> +
> +  a) Host/target system needs to have USB debug port capability.
> +
> +     You can check this capability by looking at a 'Debug port' bit in
> +     the lspci -vvv output::
> +
> +       # lspci -vvv
> +       ...
> +       00:1d.7 USB Controller: Intel Corporation 82801H (ICH8 Family) USB2 EHCI Controller #1 (rev 03) (prog-if 20 [EHCI])
> +               Subsystem: Lenovo ThinkPad T61
> +               Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
> +               Status: Cap+ 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> +               Latency: 0
> +               Interrupt: pin D routed to IRQ 19
> +               Region 0: Memory at fe227000 (32-bit, non-prefetchable) [size=1K]
> +               Capabilities: [50] Power Management version 2
> +                       Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
> +                       Status: D0 PME-Enable- DSel=0 DScale=0 PME+
> +               Capabilities: [58] Debug port: BAR=1 offset=00a0
>                              ^^^^^^^^^^^ <==================== [ HERE ]
> -	 Kernel driver in use: ehci_hcd
> -         Kernel modules: ehci-hcd
> - ...
> +               Kernel driver in use: ehci_hcd
> +               Kernel modules: ehci-hcd
> +       ...
>  
> -( If your system does not list a debug port capability then you probably
> -  won't be able to use the USB debug key. )
> +     .. note::
> +       If your system does not list a debug port capability then you probably
> +       won't be able to use the USB debug key. )

You should remove the close parenthesis on the above line.

>  
> - b.) You also need a NetChip USB debug cable/key:
> +  b) You also need a NetChip USB debug cable/key:
>  
>          http://www.plxtech.com/products/NET2000/NET20DC/default.asp
>  
>       This is a small blue plastic connector with two USB connections;
>       it draws power from its USB connections.
>  
> - c.) You need a second client/console system with a high speed USB 2.0
> -     port.
> +  c) You need a second client/console system with a high speed USB 2.0 port.
>  
> - d.) The NetChip device must be plugged directly into the physical
> -     debug port on the "host/target" system.  You cannot use a USB hub in
> +  d) The NetChip device must be plugged directly into the physical
> +     debug port on the "host/target" system. You cannot use a USB hub in
>       between the physical debug port and the "host/target" system.
>  
>       The EHCI debug controller is bound to a specific physical USB
> @@ -65,24 +71,26 @@ and two USB cables, connected like this:
>       to the hardware vendor, because there is no reason not to wire
>       this port into one of the physically accessible ports.
>  
> - e.) It is also important to note, that many versions of the NetChip
> +  e) It is also important to note, that many versions of the NetChip
>       device require the "client/console" system to be plugged into the
>       right hand side of the device (with the product logo facing up and
>       readable left to right).  The reason being is that the 5 volt
>       power supply is taken from only one side of the device and it
>       must be the side that does not get rebooted.
>  
> -2. Software requirements:
> +Software requirements
> +=====================
>  
> - a.) On the host/target system:
> +  a) On the host/target system:
>  
> -    You need to enable the following kernel config option:
> +    You need to enable the following kernel config option::
>  
>        CONFIG_EARLY_PRINTK_DBGP=y
>  
>      And you need to add the boot command line: "earlyprintk=dbgp".
>  
> -    (If you are using Grub, append it to the 'kernel' line in
> +    .. note::
> +     If you are using Grub, append it to the 'kernel' line in
>      /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
>      append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
>      using Grub2 on an EFI firmware system, append it to the 'linux'
>      or 'linuxefi' line in /boot/grub2/grub.cfg or
>      /boot/efi/EFI/<distro>/grub.cfg.)

Same here: You should remove the close parenthesis on the above line.


>       /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
>       append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
>       using Grub2 on an EFI firmware system, append it to the 'linux'

Hmm... there is another note here:

     NOTE: normally earlyprintk console gets turned off once the
     regular console is alive - use "earlyprintk=dbgp,keep" to keep
     this channel open beyond early bootup. This can be useful for
     debugging crashes under Xorg, etc.

Why are you keeping it untouched?

After fixing the above:

Reviewed-by: 

> @@ -101,9 +109,9 @@ and two USB cables, connected like this:
>      this channel open beyond early bootup. This can be useful for
>      debugging crashes under Xorg, etc.
>  
> - b.) On the client/console system:
> +  b) On the client/console system:
>  
> -    You should enable the following kernel config option:
> +    You should enable the following kernel config option::
>  
>        CONFIG_USB_SERIAL_DEBUG=y
>  
> @@ -115,27 +123,28 @@ and two USB cables, connected like this:
>      it up to use /dev/ttyUSB0 - or use a raw 'cat /dev/ttyUSBx' to
>      see the raw output.
>  
> - c.) On Nvidia Southbridge based systems: the kernel will try to probe
> +  c) On Nvidia Southbridge based systems: the kernel will try to probe
>       and find out which port has a debug device connected.
>  
> -3. Testing that it works fine:
> +Testing
> +=======
>  
> -   You can test the output by using earlyprintk=dbgp,keep and provoking
> -   kernel messages on the host/target system. You can provoke a harmless
> -   kernel message by for example doing:
> +You can test the output by using earlyprintk=dbgp,keep and provoking
> +kernel messages on the host/target system. You can provoke a harmless
> +kernel message by for example doing::
>  
>       echo h > /proc/sysrq-trigger
>  
> -   On the host/target system you should see this help line in "dmesg" output:
> +On the host/target system you should see this help line in "dmesg" output::
>  
>       SysRq : HELP : loglevel(0-9) reBoot Crashdump terminate-all-tasks(E) memory-full-oom-kill(F) kill-all-tasks(I) saK show-backtrace-all-active-cpus(L) show-memory-usage(M) nice-all-RT-tasks(N) powerOff show-registers(P) show-all-timers(Q) unRaw Sync show-task-states(T) Unmount show-blocked-tasks(W) dump-ftrace-buffer(Z)
>  
> -   On the client/console system do:
> +On the client/console system do::
>  
>         cat /dev/ttyUSB0
>  
> -   And you should see the help line above displayed shortly after you've
> -   provoked it on the host system.
> +And you should see the help line above displayed shortly after you've
> +provoked it on the host system.
>  
>  If it does not work then please ask about it on the linux-kernel@vger.kernel.org
>  mailing list or contact the x86 maintainers.
> diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
> index 8a666c5abc85..7b8388ebd43d 100644
> --- a/Documentation/x86/index.rst
> +++ b/Documentation/x86/index.rst
> @@ -13,3 +13,4 @@ Linux x86 Support
>     exception-tables
>     kernel-stacks
>     entry_64
> +   earlyprintk



Thanks,
Mauro
