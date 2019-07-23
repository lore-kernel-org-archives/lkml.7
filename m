Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC11C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91F6205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 16:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563898471;
	bh=WKwZmQ3mghR8Sji7G4J6WqmqQ+q6nVFcQGnt+GgZwvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Jzx6EEy25aApMQ/dDpcYkBpxOR6ABTdxWgPOGQSuLekUM5ji6IWUNNtYkj9bk+aHd
	 xiO4zS8N+6Yi+p0osYbwZJmpoNBpV1Fa51N2v+02HPuOgVPicgWEM0GQRxOqO1PGbC
	 vsebrg5HOrHGAsvFhi1qquCOmEskIvxexu8RxXMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730092AbfGWQOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 12:14:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbfGWQOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 12:14:30 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 135EB205F4;
        Tue, 23 Jul 2019 16:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563898468;
        bh=WKwZmQ3mghR8Sji7G4J6WqmqQ+q6nVFcQGnt+GgZwvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jTYc9vF/SaD70ecg/bejJKG1fN6J1OeY5yaNfPO71FbuWa88lal0xS64E36klAP26
         ISyTcDGn9Ctdgxu/Lv0JjDfXO9rB0YjFT8MN15xLOzrDfdRjKwbf2rYmJOlslskzMD
         8QTsspph90ZWEKE8zOoVqcZtbzgxxv95iwBY90W0=
Date:   Tue, 23 Jul 2019 09:14:26 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+4efacf59126f1ae87000@syzkaller.appspotmail.com>
Cc:     andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: usb-fuzzer boot error: general protection fault in
 dma_direct_max_mapping_size
Message-ID: <20190723161425.GA23641@gmail.com>
Mail-Followup-To: syzbot <syzbot+4efacf59126f1ae87000@syzkaller.appspotmail.com>,
        andreyknvl@google.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c3c7b6058e5a47af@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c3c7b6058e5a47af@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 07:48:05AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    1154c0b0 wip
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=1197774c600000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b228fb19779df17d
> dashboard link: https://syzkaller.appspot.com/bug?extid=4efacf59126f1ae87000
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+4efacf59126f1ae87000@syzkaller.appspotmail.com
> 
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> pci 0000:00:00.0: Limiting direct PCI/PCI transfers
> PCI: CLS 0 bytes, default 64
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> software IO TLB: mapped [mem 0xbbffd000-0xbfffd000] (64MB)
> RAPL PMU: API unit is 2^-32 Joules, 0 fixed counters, 10737418240 ms ovfl
> timer
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x212735223b2,
> max_idle_ns: 440795277976 ns
> clocksource: Switched to clocksource tsc
> check: Scanning for low memory corruption every 60 seconds
> Initialise system trusted keyrings
> workingset: timestamp_bits=40 max_order=21 bucket_order=0
> NFS: Registering the id_resolver key type
> Key type id_resolver registered
> Key type id_legacy registered
> 9p: Installing v9fs 9p2000 file system support
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> usbcore: registered new interface driver udlfb
> usbcore: registered new interface driver smscufx
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
> ACPI: Power Button [PWRF]
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1
> ACPI: Sleep Button [SLPF]
> PCI Interrupt Link [LNKC] enabled at IRQ 11
> virtio-pci 0000:00:03.0: virtio_pci: leaving for legacy driver
> PCI Interrupt Link [LNKD] enabled at IRQ 10
> virtio-pci 0000:00:04.0: virtio_pci: leaving for legacy driver
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> 00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> 00:05: ttyS2 at I/O 0x3e8 (irq = 6, base_baud = 115200) is a 16550A
> 00:06: ttyS3 at I/O 0x2e8 (irq = 7, base_baud = 115200) is a 16550A
> Non-volatile memory driver v1.3
> Linux agpgart interface v0.103
> usbcore: registered new interface driver udl
> loop: module loaded
> usbcore: registered new interface driver rtsx_usb
> usbcore: registered new interface driver viperboard
> usbcore: registered new interface driver dln2
> usbcore: registered new interface driver pn533_usb
> usbcore: registered new interface driver port100
> usbcore: registered new interface driver nfcmrvl
> scsi host0: Virtio SCSI HBA
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] SMP KASAN
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc1+ #16
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> RIP: 0010:dma_addressing_limited /./include/linux/dma-mapping.h:692 [inline]
> RIP: 0010:dma_direct_max_mapping_size+0x73/0x19a /kernel/dma/direct.c:408
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1e 01 00 00 48 8b 9d 38 03
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85
> 06 01 00 00 48 8d bd 48 03 00 00 48 8b 1b 48 b8
> RSP: 0000:ffff8881da18f628 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff812d716c
> RDX: 0000000000000000 RSI: ffffffff812d7189 RDI: ffff8881d7428378
> RBP: ffff8881d7428040 R08: ffff8881da180000 R09: ffffed103ade30cb
> R10: ffffed103ade30ca R11: ffff8881d6f18657 R12: ffff8881d7428040
> R13: ffff8881d769e8b0 R14: 0000000000000200 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000006a21000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  dma_max_mapping_size+0xb5/0xf0 /kernel/dma/mapping.c:375
>  __scsi_init_queue+0x17e/0x510 /drivers/scsi/scsi_lib.c:1787
>  scsi_mq_alloc_queue+0xcb/0x170 /drivers/scsi/scsi_lib.c:1833
>  scsi_alloc_sdev+0x82e/0xc50 /drivers/scsi/scsi_scan.c:269
>  scsi_probe_and_add_lun+0x1ee5/0x2cd0 /drivers/scsi/scsi_scan.c:1078
>  __scsi_scan_target+0x273/0xc30 /drivers/scsi/scsi_scan.c:1562
>  scsi_scan_channel.part.0+0x126/0x1a0 /drivers/scsi/scsi_scan.c:1650
>  scsi_scan_channel /drivers/scsi/scsi_scan.c:1677 [inline]
>  scsi_scan_host_selected+0x2bb/0x3f0 /drivers/scsi/scsi_scan.c:1679
>  do_scsi_scan_host /drivers/scsi/scsi_scan.c:1817 [inline]
>  do_scsi_scan_host+0x1e8/0x260 /drivers/scsi/scsi_scan.c:1807
>  scsi_scan_host /drivers/scsi/scsi_scan.c:1847 [inline]
>  scsi_scan_host+0x37c/0x440 /drivers/scsi/scsi_scan.c:1835
>  virtscsi_probe+0x9b7/0xbb5 /drivers/scsi/virtio_scsi.c:847
>  virtio_dev_probe+0x463/0x710 /drivers/virtio/virtio.c:248
>  really_probe+0x281/0x650 /drivers/base/dd.c:548
>  driver_probe_device+0x101/0x1b0 /drivers/base/dd.c:709
>  device_driver_attach+0x108/0x140 /drivers/base/dd.c:983
>  __driver_attach+0xda/0x240 /drivers/base/dd.c:1060
>  bus_for_each_dev+0x14b/0x1d0 /drivers/base/bus.c:304
>  bus_add_driver+0x44e/0x5a0 /drivers/base/bus.c:645
>  driver_register+0x1c4/0x320 /drivers/base/driver.c:170
>  __write_once_size /./include/linux/compiler.h:226 [inline]
>  INIT_LIST_HEAD /./include/linux/list.h:28 [inline]
>  init+0xa1/0x115 /drivers/char/virtio_console.c:2251
>  do_one_initcall+0xf0/0x614 /init/main.c:939
>  do_initcall_level /init/main.c:1007 [inline]
>  do_initcalls /init/main.c:1015 [inline]
>  do_basic_setup /init/main.c:1032 [inline]
>  kernel_init_freeable+0x4a9/0x596 /init/main.c:1192
>  kernel_init+0xd/0x1bf /init/main.c:1110
>  ret_from_fork+0x24/0x30 /arch/x86/entry/entry_64.S:352
> Modules linked in:
> ---[ end trace 73ab592d53bc046f ]---
> RIP: 0010:dma_addressing_limited /./include/linux/dma-mapping.h:692 [inline]
> RIP: 0010:dma_direct_max_mapping_size+0x73/0x19a /kernel/dma/direct.c:408
> Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 1e 01 00 00 48 8b 9d 38 03
> 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da 48 c1 ea 03 <80> 3c 02 00 0f 85
> 06 01 00 00 48 8d bd 48 03 00 00 48 8b 1b 48 b8
> RSP: 0000:ffff8881da18f628 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff812d716c
> RDX: 0000000000000000 RSI: ffffffff812d7189 RDI: ffff8881d7428378
> RBP: ffff8881d7428040 R08: ffff8881da180000 R09: ffffed103ade30cb
> R10: ffffed103ade30ca R11: ffff8881d6f18657 R12: ffff8881d7428040
> R13: ffff8881d769e8b0 R14: 0000000000000200 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8881db300000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000006a21000 CR4: 00000000001406e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> 
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000c3c7b6058e5a47af%40google.com.

Seems there is a fix for this queued in the SCSI tree.

#syz fix: scsi: core: fix the dma_max_mapping_size call

Other threads:

https://marc.info/?l=linux-scsi&m=156378725427719&w=2
https://lkml.kernel.org/lkml/20190722163759.GA28686@codemonkey.org.uk/
https://lkml.kernel.org/lkml/CACVXFVMWM3xg6EEyoyNjkLPv=8+wQKiHj6erMS_gGX25f-Ot4g@mail.gmail.com/

- Eric
