Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA667C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177792190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 15:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mixtli.metztli.it header.i=@mixtli.metztli.it header.b="cglLNjbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfGVPgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 11:36:19 -0400
Received: from mail7.static.mailgun.info ([104.130.122.7]:61658 "EHLO
        mail7.static.mailgun.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729010AbfGVPgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 11:36:17 -0400
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Mon, 22 Jul 2019 11:36:04 EDT
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mixtli.metztli.it; q=dns/txt;
 s=mx; t=1563809764; h=From: Date: Message-Id: To: Subject: Sender;
 bh=8ngMGLRjkk/IDoem0QSqAx0s90NyuGrBxd8fhQhPr8Q=; b=cglLNjbcNgFjn35UFbTCV6RQa3Joq8YfCkm9DXhdM+2hbyypnAxEBMnjBLyR0nPr1ckHm3Zv
 ixm5Pk55yhcy0NBm/z3wt+wBHRgyvFG+5C6aCdj4NAOhJLDsv9ZPSPP6MbgsttjtOF/P6C5Q
 warPC4unbqk6qeVS6hFpT+/RZgI=
X-Mailgun-Sending-Ip: 104.130.122.7
X-Mailgun-Sid: WyIxYzIzYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgIjE3YjU0Il0=
Received: from huitzilopochtli.metztli-it.com (99-130-254-3.lightspeed.sntcca.sbcglobal.net [99.130.254.3])
 by mxa.mailgun.org with ESMTP id 5d35d6b6.7f448105f468-smtp-out-n03;
 Mon, 22 Jul 2019 15:31:02 -0000 (UTC)
Received: by huitzilopochtli.metztli-it.com (Postfix, from userid 1000)
        id 8C5584084340; Mon, 22 Jul 2019 08:31:00 -0700 (PDT)
Subject: Reiser4 successful install on HP ProLiant DL325 Gen10 AMD EPYC 7351P 16-Core Processor/64MB RAM
To:     <edward.shishkin@gmail.com>, <reiserfs-devel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
X-Mailer: mail (GNU Mailutils 3.5)
Message-Id: <20190722153100.8C5584084340@huitzilopochtli.metztli-it.com>
Date:   Mon, 22 Jul 2019 08:31:00 -0700 (PDT)
From:   Metztli Information Technology <jose.r.r@metztli.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For posterity... I am prescient you need some help, sir, but THANK YOU for your reiser4 work for Linux 5.0.xy, Mr. Shishkin,
I would not trust any other file system.

For a couple of snapshots, please see:
< https://metztli.blog/index.php/amatl/aP0 > (short link)
< https://metztli.blog/index.php/amatl/amatl-main/install-reports/metztli-reiser4-successful-install-on-1 >


Subject: installation-reports: Metztli Reiser4 (Debian 10 Buster) successful install on HP ProLiant DL325 Gen10 AMD EPYC 7351P 16-Core Processor, 2 threads per core
Package: installation-reports
Severity: normal

Dear Maintainer,

*** Reporter, please consider answering these questions, where appropriate ***

   * What led up to the situation?
   * What exactly did you do (or not do) that was effective (or
     ineffective)?
   * What was the outcome of this action?
   * What outcome did you expect instead?

*** End of the template - remove these template lines ***


-- Package-specific info:

Boot method: netboot ISO image boot from second hard disk partition
Image version: https://metztli.it/buster/amd/metztli-reiser4-z.iso
https://sourceforge.net/projects/metztli-reiser4/metztli-reiser4-z.iso
Date: July 18, 2019, 08:09 AM PST 

Machine: HP ProLiant DL325 Gen10 AMD EPYC 7351P 16-Core Processor/64GB RAM, 2 threads per core
Partitions: <df -Tl will do; the raw partition table is preferred>
Filesystem     Type      1K-blocks    Used  Available Use% Mounted on
udev           devtmpfs   32890052       0   32890052   0% /dev
tmpfs          tmpfs       6579156    9232    6569924   1% /run
/dev/nvme0n1p5 reiser4   455032208 1409388  453622820   1% /
tmpfs          tmpfs      32895776       0   32895776   0% /dev/shm
tmpfs          tmpfs          5120       0       5120   0% /run/lock
tmpfs          tmpfs      32895776       0   32895776   0% /sys/fs/cgroup
/dev/nvme0n1p4 ext2         984696   29300     905376   4% /boot
/dev/nvme0n1p2 vfat         498720    9192     489528   2% /boot/efi
tmpfs          tmpfs       6579152       0    6579152   0% /run/user/1000
/dev/sda1      reiser4  1856219408   59864 1856159544   1% /mnt/sda-ce

Base System Installation Checklist:
[O] = OK, [E] = Error (please elaborate below), [ ] = didn't try it

Initial boot:           [O]
Detect network card:    [O]
Configure network:      [O]
Detect CD:              [ ]
Load installer modules: [O]
Clock/timezone setup:   [O]
User/password setup:    [O]
Detect hard drives:     [O]
Partition hard drives:  [O]
Install base system:    [O]
Install tasks:          [O]
Install boot loader:    [O]
Overall install:        [O]

Comments/Problems:

Remote dedicated HP server iLO web interface off the remote management module allowed
me access as a local user but did not have administrator privilege to modify the
 boot order --nor select legacy over default efi. Hence, I created a small 200MB JFS
 partion on second hard drive.
Then I copied over Metztli Reiser4 --which downloads Linux kernel 5.0.15 and which
.config I modified for AMD Ryzen CPUs. Selected to install Debian Buster
to NVMe reiser4 -formatted root fs on /dev/nvme0n1p5

Below is the tepito [snippet] that I wrote to /etc/grub.d/40_custom file
to boot Metztli Reiser4:

menuentry 'Metztli Reiser4 Expert Chingon Buster AMD Epyc install' {
set isofile='metztli-reiser4-z.iso'
insmod gzio
insmod part_gpt
insmod jfs
insmod loopback
loopback loop (hd0,gpt1)/ISOs/$isofile
linux (loop)/linux priority=low vga=788 ---
initrd (loop)/initrd.gz
}

then executed (wielding root privilege): update-grub

see: 
< https://metztli.blog/index.php/boot-metztli-reiser4-netboot-on?blog=4 >

Odd that GRUB does not count NVMe as hd0 as that 'honor' is reserved to
/dev/sda in the two(2) disk setup HP Proliant Gen10 provisioned for me.

*I am not* experiencing this issue:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=924895
-- 

Please make sure that the hardware-summary log file, and any other
installation logs that you think would be useful are attached to this
report. Please compress large files using gzip.

Once you have filled out this report, mail it to submit@bugs.debian.org.

==============================================
Installer lsb-release:
==============================================
DISTRIB_ID=Debian
DISTRIB_DESCRIPTION="Debian GNU/Linux installer"
DISTRIB_RELEASE="10 (buster) - installer build 20190715-22:01:04"
X_INSTALLATION_MEDIUM=netboot

==============================================
Installer hardware-summary:
==============================================
uname -a: Linux xochiquetzal 5.0.0-1+reiser4.0.2-amd64 #1 SMP Debian 5.0.15-1+reiser4.0.2 (2019-07-12) x86_64 GNU/Linux
lspci -knn: 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 00:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:01.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:03.3 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:04.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 00:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 00:14.0 SMBus [0c05]: Advanced Micro Devices, Inc. [AMD] FCH SMBus Controller [1022:790b] (rev 59)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:0278]
lspci -knn: 00:14.3 ISA bridge [0601]: Advanced Micro Devices, Inc. [AMD] FCH LPC Bridge [1022:790e] (rev 51)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:0278]
lspci -knn: 00:18.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1460]
lspci -knn: 00:18.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1461]
lspci -knn: 00:18.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1462]
lspci -knn: 00:18.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1463]
lspci -knn: 00:18.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1464]
lspci -knn: 00:18.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1465]
lspci -knn: 00:18.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1466]
lspci -knn: 00:18.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1467]
lspci -knn: 00:19.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1460]
lspci -knn: 00:19.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1461]
lspci -knn: 00:19.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1462]
lspci -knn: 00:19.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1463]
lspci -knn: 00:19.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1464]
lspci -knn: 00:19.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1465]
lspci -knn: 00:19.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1466]
lspci -knn: 00:19.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1467]
lspci -knn: 00:1a.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1460]
lspci -knn: 00:1a.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1461]
lspci -knn: 00:1a.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1462]
lspci -knn: 00:1a.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1463]
lspci -knn: 00:1a.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1464]
lspci -knn: 00:1a.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1465]
lspci -knn: 00:1a.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1466]
lspci -knn: 00:1a.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1467]
lspci -knn: 00:1b.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1460]
lspci -knn: 00:1b.1 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1461]
lspci -knn: 00:1b.2 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1462]
lspci -knn: 00:1b.3 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1463]
lspci -knn: 00:1b.4 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1464]
lspci -knn: 00:1b.5 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1465]
lspci -knn: 00:1b.6 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1466]
lspci -knn: 00:1b.7 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1467]
lspci -knn: 01:00.0 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Slave Instrumentation & System Support [103c:3306] (rev 07)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:00e4]
lspci -knn: 01:00.1 VGA compatible controller [0300]: Matrox Electronics Systems Ltd. Device [102b:0538] (rev 02)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:00e4]
lspci -knn: 01:00.2 System peripheral [0880]: Hewlett-Packard Company Integrated Lights-Out Standard Management Processor Support and Messaging [103c:3307] (rev 07)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:00e4]
lspci -knn: 01:00.4 USB controller [0c03]: Hewlett-Packard Company Device [103c:22f6]
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:00e4]
lspci -knn: 	Kernel driver in use: ehci-pci
lspci -knn: 	Kernel modules: ehci_pci
lspci -knn: 02:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 02:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 03:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 03:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 03:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:145f]
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:0278]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 04:00.0 Ethernet controller [0200]: Broadcom Limited NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
lspci -knn: 	Subsystem: Hewlett-Packard Company Device [103c:22be]
lspci -knn: 	Kernel driver in use: tg3
lspci -knn: 	Kernel modules: tg3
lspci -knn: 04:00.1 Ethernet controller [0200]: Broadcom Limited NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
lspci -knn: 	Subsystem: Hewlett-Packard Company Device [103c:22be]
lspci -knn: 	Kernel driver in use: tg3
lspci -knn: 	Kernel modules: tg3
lspci -knn: 04:00.2 Ethernet controller [0200]: Broadcom Limited NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
lspci -knn: 	Subsystem: Hewlett-Packard Company Device [103c:22be]
lspci -knn: 	Kernel driver in use: tg3
lspci -knn: 	Kernel modules: tg3
lspci -knn: 04:00.3 Ethernet controller [0200]: Broadcom Limited NetXtreme BCM5719 Gigabit Ethernet PCIe [14e4:1657] (rev 01)
lspci -knn: 	Subsystem: Hewlett-Packard Company Device [103c:22be]
lspci -knn: 	Kernel driver in use: tg3
lspci -knn: 	Kernel modules: tg3
lspci -knn: 05:00.0 Non-Volatile memory controller [0108]: Samsung Electronics Co Ltd Device [144d:a808]
lspci -knn: 	Subsystem: Samsung Electronics Co Ltd Device [144d:a801]
lspci -knn: 	Kernel driver in use: nvme
lspci -knn: 	Kernel modules: nvme
lspci -knn: 40:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 40:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 40:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 40:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 41:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 41:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 41:00.2 SATA controller [0106]: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode] [1022:7901] (rev 51)
lspci -knn: 	Subsystem: Hewlett Packard Enterprise Device [1590:0278]
lspci -knn: 	Kernel driver in use: ahci
lspci -knn: 	Kernel modules: ahci
lspci -knn: 42:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 42:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 42:00.3 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] Device [1022:145f]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:145c]
lspci -knn: 	Kernel driver in use: xhci_hcd
lspci -knn: 	Kernel modules: xhci_pci
lspci -knn: 80:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 80:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:03.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 80:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: 80:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: 81:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 81:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 82:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 82:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: c0:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1450]
lspci -knn: c0:01.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:01.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:01.2 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:02.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:03.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:03.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1453]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:04.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:07.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:07.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c0:08.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:1452]
lspci -knn: c0:08.1 PCI bridge [0604]: Advanced Micro Devices, Inc. [AMD] Device [1022:1454]
lspci -knn: 	Kernel driver in use: pcieport
lspci -knn: c1:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1455]
lspci -knn: c1:00.1 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1468]
lspci -knn: c2:00.0 Non-Essential Instrumentation [1300]: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:145a]
lspci -knn: c2:00.2 Encryption controller [1080]: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
lspci -knn: 	Subsystem: Advanced Micro Devices, Inc. [AMD] Device [1022:1456]
usb-list: 
usb-list: Bus 01 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.0.0-1+reiser4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 01 Device 02: USB2744 [0424:2744]
usb-list:    Level 01 Parent 01 Port 01  Class 09(hub  ) Subclass 00 Protocol 02
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 02 Driver hub
usb-list: 
usb-list: Bus 01 Device 03: USB2744 [0424:2660]
usb-list:    Level 02 Parent 02 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 01 Device 04: Hub Controller [0424:2740]
usb-list:    Level 02 Parent 02 Port 03  Class 00(>ifc ) Subclass 00 Protocol 00
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class ff(vend.) Subclass ff Protocol ff Driver <none>
usb-list: 
usb-list: Bus 02 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.0.0-1+reiser4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 02 Device 02: USB5744 [0424:5744]
usb-list:    Level 01 Parent 01 Port 01  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 03 Device 01: EHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 00
usb-list:    Manufacturer: Linux 5.0.0-1+reiser4.0.2-amd64 ehci_hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 03 Device 02: Virtual Keyboard [03f0:7029]
usb-list:    Level 01 Parent 01 Port 00  Class 00(>ifc ) Subclass 00 Protocol 00
usb-list:    Manufacturer: HPE
usb-list:    Interface 00: Class 03(HID  ) Subclass 01 Protocol 01 Driver usbhid
usb-list:    Interface 01: Class 03(HID  ) Subclass 01 Protocol 02 Driver usbhid
usb-list: 
usb-list: Bus 04 Device 01: xHCI Host Controller [1d6b:0002]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 01
usb-list:    Manufacturer: Linux 5.0.0-1+reiser4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 04 Device 02: USB2744 [0424:2744]
usb-list:    Level 01 Parent 01 Port 00  Class 09(hub  ) Subclass 00 Protocol 02
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 02 Driver hub
usb-list: 
usb-list: Bus 04 Device 03: Hub Controller [0424:2740]
usb-list:    Level 02 Parent 02 Port 02  Class 00(>ifc ) Subclass 00 Protocol 00
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class ff(vend.) Subclass ff Protocol ff Driver <none>
usb-list: 
usb-list: Bus 05 Device 01: xHCI Host Controller [1d6b:0003]
usb-list:    Level 00 Parent 00 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Linux 5.0.0-1+reiser4.0.2-amd64 xhci-hcd
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
usb-list: 
usb-list: Bus 05 Device 02: USB5744 [0424:5744]
usb-list:    Level 01 Parent 01 Port 00  Class 09(hub  ) Subclass 00 Protocol 03
usb-list:    Manufacturer: Microchip Tech
usb-list:    Interface 00: Class 09(hub  ) Subclass 00 Protocol 00 Driver hub
lsmod: Module                  Size  Used by
lsmod: fuse                  135168  0
lsmod: ufs                    90112  0
lsmod: qnx4                   16384  0
lsmod: hfsplus               122880  0
lsmod: hfs                    73728  0
lsmod: minix                  45056  0
lsmod: msdos                  20480  0
lsmod: battery                20480  0
lsmod: nls_ascii              16384  1
lsmod: nls_cp437              20480  1
lsmod: dm_mod                151552  0
lsmod: md_mod                172032  0
lsmod: xfs                  1462272  0
lsmod: reiser4               561152  1
lsmod: jfs                   212992  0
lsmod: btrfs                1396736  0
lsmod: xor                    24576  1 btrfs
lsmod: raid6_pq              122880  1 btrfs
lsmod: libcrc32c              16384  2 btrfs,xfs
lsmod: zstd_compress         172032  2 reiser4,btrfs
lsmod: zstd_decompress        81920  2 reiser4,btrfs
lsmod: vfat                   20480  1
lsmod: fat                    86016  2 msdos,vfat
lsmod: ext4                  749568  1
lsmod: crc16                  16384  1 ext4
lsmod: mbcache                16384  1 ext4
lsmod: jbd2                  126976  1 ext4
lsmod: crc32c_generic         16384  3
lsmod: fscrypto               36864  1 ext4
lsmod: ecb                    16384  0
lsmod: usb_storage            73728  0
lsmod: vga16fb                24576  0
lsmod: vgastate               20480  1 vga16fb
lsmod: hid_generic            16384  0
lsmod: usbhid                 61440  0
lsmod: hid                   139264  2 usbhid,hid_generic
lsmod: sd_mod                 57344  0
lsmod: ahci                   40960  0
lsmod: libahci                40960  1 ahci
lsmod: ehci_pci               20480  0
lsmod: xhci_pci               20480  0
lsmod: libata                274432  2 libahci,ahci
lsmod: ehci_hcd               98304  1 ehci_pci
lsmod: xhci_hcd              262144  1 xhci_pci
lsmod: efivars                20480  0
lsmod: scsi_mod              241664  3 sd_mod,usb_storage,libata
lsmod: usbcore               290816  6 xhci_hcd,ehci_pci,usbhid,usb_storage,ehci_hcd,xhci_pci
lsmod: tg3                   184320  0
lsmod: nvme                   49152  4
lsmod: usb_common             16384  1 usbcore
lsmod: libphy                 86016  1 tg3
lsmod: nvme_core              94208  6 nvme
lsmod: wmi                    32768  0
df: Filesystem           1K-blocks      Used Available Use% Mounted on
df: none                   6579156       128   6579028   0% /run
df: devtmpfs              32873100         0  32873100   0% /dev
df: /dev/nvme0n1p5       455032208    953268 454078940   0% /target
df: /dev/nvme0n1p4          984696     29584    905092   3% /target/boot
df: /dev/nvme0n1p2          498720      9192    489528   2% /target/boot/efi
df: /dev/nvme0n1p5       455032208    953268 454078940   0% /dev/.static/dev
df: devtmpfs              32873100         0  32873100   0% /target/dev
free:               total        used        free      shared  buff/cache   available
free: Mem:       65791560      487132    64088456      172340     1215972    64692552
free: Swap:       8000508           0     8000508
/proc/cmdline: BOOT_IMAGE=(loop)/linux priority=low vga=788 ---
/proc/cpuinfo: processor	: 0
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2438.384
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 0
/proc/cpuinfo: initial apicid	: 0
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 1
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2890.601
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 2
/proc/cpuinfo: initial apicid	: 2
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 2
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2328.244
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 8
/proc/cpuinfo: initial apicid	: 8
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 3
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2640.849
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 10
/proc/cpuinfo: initial apicid	: 10
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 4
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2324.774
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 8
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 16
/proc/cpuinfo: initial apicid	: 16
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 5
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2329.403
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 9
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 18
/proc/cpuinfo: initial apicid	: 18
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 6
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2328.018
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 12
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 24
/proc/cpuinfo: initial apicid	: 24
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 7
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2324.946
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 13
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 26
/proc/cpuinfo: initial apicid	: 26
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 8
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2872.672
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 16
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 32
/proc/cpuinfo: initial apicid	: 32
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 9
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2869.584
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 17
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 34
/proc/cpuinfo: initial apicid	: 34
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 10
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2522.338
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 20
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 40
/proc/cpuinfo: initial apicid	: 40
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 11
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2625.599
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 21
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 42
/proc/cpuinfo: initial apicid	: 42
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 12
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2327.599
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 24
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 48
/proc/cpuinfo: initial apicid	: 48
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 13
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2324.342
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 25
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 50
/proc/cpuinfo: initial apicid	: 50
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 14
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2324.612
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 28
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 56
/proc/cpuinfo: initial apicid	: 56
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 15
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2305.787
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 29
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 58
/proc/cpuinfo: initial apicid	: 58
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 16
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2451.679
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 0
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 1
/proc/cpuinfo: initial apicid	: 1
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 17
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2649.739
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 1
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 3
/proc/cpuinfo: initial apicid	: 3
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 18
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2440.540
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 4
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 9
/proc/cpuinfo: initial apicid	: 9
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 19
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2688.420
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 5
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 11
/proc/cpuinfo: initial apicid	: 11
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 20
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2461.740
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 8
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 17
/proc/cpuinfo: initial apicid	: 17
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 21
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2515.134
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 9
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 19
/proc/cpuinfo: initial apicid	: 19
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 22
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2886.874
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 12
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 25
/proc/cpuinfo: initial apicid	: 25
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 23
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2883.341
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 13
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 27
/proc/cpuinfo: initial apicid	: 27
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 24
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2724.430
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 16
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 33
/proc/cpuinfo: initial apicid	: 33
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 25
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2815.412
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 17
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 35
/proc/cpuinfo: initial apicid	: 35
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 26
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2533.465
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 20
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 41
/proc/cpuinfo: initial apicid	: 41
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 27
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2580.137
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 21
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 43
/proc/cpuinfo: initial apicid	: 43
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 28
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2885.724
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 24
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 49
/proc/cpuinfo: initial apicid	: 49
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 29
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2894.537
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 25
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 51
/proc/cpuinfo: initial apicid	: 51
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 30
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2892.885
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 28
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 57
/proc/cpuinfo: initial apicid	: 57
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/cpuinfo: processor	: 31
/proc/cpuinfo: vendor_id	: AuthenticAMD
/proc/cpuinfo: cpu family	: 23
/proc/cpuinfo: model		: 1
/proc/cpuinfo: model name	: AMD EPYC 7351P 16-Core Processor
/proc/cpuinfo: stepping	: 2
/proc/cpuinfo: microcode	: 0x8001227
/proc/cpuinfo: cpu MHz		: 2770.394
/proc/cpuinfo: cache size	: 512 KB
/proc/cpuinfo: physical id	: 0
/proc/cpuinfo: siblings	: 32
/proc/cpuinfo: core id		: 29
/proc/cpuinfo: cpu cores	: 16
/proc/cpuinfo: apicid		: 59
/proc/cpuinfo: initial apicid	: 59
/proc/cpuinfo: fpu		: yes
/proc/cpuinfo: fpu_exception	: yes
/proc/cpuinfo: cpuid level	: 13
/proc/cpuinfo: wp		: yes
/proc/cpuinfo: flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc cpuid extd_apicid amd_dcm aperfmperf pni pclmulqdq monitor ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw skinit wdt tce topoext perfctr_core perfctr_nb bpext perfctr_llc mwaitx cpb hw_pstate ssbd ibpb vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 xsaves clzero irperf xsaveerptr arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flushbyasid decodeassists pausefilter pfthreshold avic v_vmsave_vmload vgif overflow_recov succor smca
/proc/cpuinfo: bugs		: sysret_ss_attrs null_seg spectre_v1 spectre_v2 spec_store_bypass
/proc/cpuinfo: bogomips	: 4790.95
/proc/cpuinfo: TLB size	: 2560 4K pages
/proc/cpuinfo: clflush size	: 64
/proc/cpuinfo: cache_alignment	: 64
/proc/cpuinfo: address sizes	: 48 bits physical, 48 bits virtual
/proc/cpuinfo: power management: ts ttp tm hwpstate cpb eff_freq_ro [13] [14]
/proc/cpuinfo: 
/proc/ioports: 0000-03af : PCI Bus 0000:00
/proc/ioports:   0000-001f : dma1
/proc/ioports:   0020-0021 : pic1
/proc/ioports:   0040-0043 : timer0
/proc/ioports:   0050-0053 : timer1
/proc/ioports:   0060-0060 : keyboard
/proc/ioports:   0061-0061 : PNP0800:00
/proc/ioports:   0064-0064 : keyboard
/proc/ioports:   0070-0071 : rtc0
/proc/ioports:   0080-008f : dma page reg
/proc/ioports:   00a0-00a1 : pic2
/proc/ioports:   00b2-00b2 : APEI ERST
/proc/ioports:   00c0-00df : dma2
/proc/ioports:   00f0-00ff : fpu
/proc/ioports:   02f8-02ff : serial
/proc/ioports: 03b0-03bb : PCI Bus 0000:00
/proc/ioports: 03c0-03df : PCI Bus 0000:00
/proc/ioports: 03e0-0cf7 : PCI Bus 0000:00
/proc/ioports:   03f8-03ff : serial
/proc/ioports:   0400-049f : pnp 00:01
/proc/ioports:     0400-0403 : ACPI PM1a_EVT_BLK
/proc/ioports:     0404-0405 : ACPI PM1a_CNT_BLK
/proc/ioports:     0408-040b : ACPI PM_TMR
/proc/ioports:     0420-0427 : ACPI GPE0_BLK
/proc/ioports:   0b00-0b0f : pnp 00:01
/proc/ioports:   0b20-0b3f : pnp 00:01
/proc/ioports:   0c00-0c01 : pnp 00:01
/proc/ioports:   0c14-0c15 : pnp 00:01
/proc/ioports:   0ca2-0ca3 : IPI0001:00
/proc/ioports:     0ca2-0ca2 : IPMI Address 1
/proc/ioports:     0ca3-0ca3 : IPMI Address 2
/proc/ioports:   0cd0-0cdf : pnp 00:01
/proc/ioports: 0cf8-0cff : PCI conf1
/proc/ioports: 0d00-0fff : PCI Bus 0000:00
/proc/ioports: 1000-3fff : PCI Bus 0000:00
/proc/ioports:   1000-1fff : PCI Bus 0000:01
/proc/ioports:     1000-10ff : 0000:01:00.2
/proc/ioports:     1100-11ff : 0000:01:00.0
/proc/ioports:     1200-12ff : 0000:01:00.0
/proc/ioports:   2000-2fff : PCI Bus 0000:07
/proc/ioports:   3000-3fff : PCI Bus 0000:06
/proc/ioports: 4000-6fff : PCI Bus 0000:40
/proc/ioports:   4000-4fff : PCI Bus 0000:43
/proc/ioports:   5000-5fff : PCI Bus 0000:44
/proc/ioports: 7000-9fff : PCI Bus 0000:80
/proc/ioports:   7000-7fff : PCI Bus 0000:83
/proc/ioports:   8000-8fff : PCI Bus 0000:84
/proc/ioports: a000-cfff : PCI Bus 0000:c0
/proc/ioports:   a000-afff : PCI Bus 0000:c3
/proc/ioports:   b000-bfff : PCI Bus 0000:c4
/proc/ioports:   c000-cfff : PCI Bus 0000:c5
/proc/iomem: 00000000-00000fff : Reserved
/proc/iomem: 00001000-0009ffff : System RAM
/proc/iomem: 000a0000-000bffff : PCI Bus 0000:00
/proc/iomem: 000c0000-000c7fff : Video ROM
/proc/iomem: 000f0000-000fffff : Reserved
/proc/iomem:   000f0000-000fffff : System ROM
/proc/iomem: 00100000-64f45fff : System RAM
/proc/iomem: 64f46000-64f4bfff : Reserved
/proc/iomem: 64f4c000-65470fff : System RAM
/proc/iomem: 65471000-65482fff : ACPI Tables
/proc/iomem: 65483000-6549afff : System RAM
/proc/iomem: 6549b000-6549dfff : ACPI Tables
/proc/iomem: 6549e000-654fdfff : System RAM
/proc/iomem: 654fe000-654fefff : Reserved
/proc/iomem: 654ff000-6df6efff : System RAM
/proc/iomem: 6df6f000-6e796fff : Reserved
/proc/iomem:   6e77c004-6e77c037 : APEI ERST
/proc/iomem:   6e77d000-6e78cfff : APEI ERST
/proc/iomem: 6e797000-6e797fff : System RAM
/proc/iomem: 6e798000-6e79cfff : Reserved
/proc/iomem: 6e79d000-6e79dfff : System RAM
/proc/iomem: 6e79e000-6edcefff : Reserved
/proc/iomem: 6edcf000-76ecefff : System RAM
/proc/iomem: 76ecf000-76fcefff : Unknown E820 type
/proc/iomem: 76fcf000-77fdefff : Reserved
/proc/iomem: 77fdf000-77feefff : ACPI Non-volatile Storage
/proc/iomem: 77fef000-77ffefff : ACPI Tables
/proc/iomem: 77fff000-77ffffff : System RAM
/proc/iomem: 78000000-8fffffff : Reserved
/proc/iomem:   80000000-8fffffff : PCI MMCONFIG 0000 [bus 00-ff]
/proc/iomem: 90000000-aaffffff : PCI Bus 0000:c0
/proc/iomem:   90000000-901fffff : PCI Bus 0000:c1
/proc/iomem:     90000000-900fffff : 0000:c1:00.1
/proc/iomem:     90100000-90101fff : 0000:c1:00.1
/proc/iomem:   90200000-903fffff : PCI Bus 0000:c2
/proc/iomem:     90200000-902fffff : 0000:c2:00.2
/proc/iomem:     90300000-90301fff : 0000:c2:00.2
/proc/iomem:   90400000-905fffff : PCI Bus 0000:c3
/proc/iomem:   90600000-907fffff : PCI Bus 0000:c4
/proc/iomem:   90800000-909fffff : PCI Bus 0000:c5
/proc/iomem:   aaa00000-aaa003ff : IOAPIC 4
/proc/iomem: ab000000-c5ffffff : PCI Bus 0000:80
/proc/iomem:   ab000000-ab1fffff : PCI Bus 0000:81
/proc/iomem:     ab000000-ab0fffff : 0000:81:00.1
/proc/iomem:     ab100000-ab101fff : 0000:81:00.1
/proc/iomem:   ab200000-ab3fffff : PCI Bus 0000:82
/proc/iomem:     ab200000-ab2fffff : 0000:82:00.2
/proc/iomem:     ab300000-ab301fff : 0000:82:00.2
/proc/iomem:   ab400000-ab5fffff : PCI Bus 0000:83
/proc/iomem:   ab600000-ab7fffff : PCI Bus 0000:84
/proc/iomem:   c5a00000-c5a003ff : IOAPIC 3
/proc/iomem: c6000000-e0ffffff : PCI Bus 0000:40
/proc/iomem:   c6000000-c61fffff : PCI Bus 0000:41
/proc/iomem:     c6000000-c60fffff : 0000:41:00.1
/proc/iomem:     c6100000-c6101fff : 0000:41:00.1
/proc/iomem:     c6102000-c6102fff : 0000:41:00.2
/proc/iomem:       c6102000-c6102fff : ahci
/proc/iomem:   c6200000-c64fffff : PCI Bus 0000:42
/proc/iomem:     c6200000-c62fffff : 0000:42:00.3
/proc/iomem:       c6200000-c62fffff : xhci-hcd
/proc/iomem:     c6300000-c63fffff : 0000:42:00.2
/proc/iomem:     c6400000-c6401fff : 0000:42:00.2
/proc/iomem:   c6500000-c66fffff : PCI Bus 0000:43
/proc/iomem:   c6700000-c68fffff : PCI Bus 0000:44
/proc/iomem:   e0a00000-e0a003ff : IOAPIC 2
/proc/iomem: e1000000-febfffff : PCI Bus 0000:00
/proc/iomem:   e1000000-e9bfffff : PCI Bus 0000:01
/proc/iomem:     e1000000-e100ffff : 0000:01:00.2
/proc/iomem:     e4000000-e7ffffff : 0000:01:00.0
/proc/iomem:     e8000000-e8ffffff : 0000:01:00.1
/proc/iomem:       e8000000-e82fffff : efifb
/proc/iomem:     e9000000-e97fffff : 0000:01:00.1
/proc/iomem:     e9800000-e99fffff : 0000:01:00.0
/proc/iomem:     e9a00000-e9afffff : 0000:01:00.2
/proc/iomem:     e9b00000-e9b7ffff : 0000:01:00.2
/proc/iomem:     e9b80000-e9b8ffff : 0000:01:00.2
/proc/iomem:     e9b90000-e9b97fff : 0000:01:00.2
/proc/iomem:     e9ba0000-e9ba3fff : 0000:01:00.1
/proc/iomem:     e9ba4000-e9ba40ff : 0000:01:00.4
/proc/iomem:       e9ba4000-e9ba40ff : ehci_hcd
/proc/iomem:     e9ba5000-e9ba50ff : 0000:01:00.2
/proc/iomem:     e9ba6000-e9ba63ff : 0000:01:00.0
/proc/iomem:   e9c00000-e9cfffff : PCI Bus 0000:04
/proc/iomem:     e9c00000-e9c0ffff : 0000:04:00.3
/proc/iomem:       e9c00000-e9c0ffff : tg3
/proc/iomem:     e9c10000-e9c1ffff : 0000:04:00.3
/proc/iomem:       e9c10000-e9c1ffff : tg3
/proc/iomem:     e9c20000-e9c2ffff : 0000:04:00.3
/proc/iomem:       e9c20000-e9c2ffff : tg3
/proc/iomem:     e9c30000-e9c3ffff : 0000:04:00.2
/proc/iomem:       e9c30000-e9c3ffff : tg3
/proc/iomem:     e9c40000-e9c4ffff : 0000:04:00.2
/proc/iomem:       e9c40000-e9c4ffff : tg3
/proc/iomem:     e9c50000-e9c5ffff : 0000:04:00.2
/proc/iomem:       e9c50000-e9c5ffff : tg3
/proc/iomem:     e9c60000-e9c6ffff : 0000:04:00.1
/proc/iomem:       e9c60000-e9c6ffff : tg3
/proc/iomem:     e9c70000-e9c7ffff : 0000:04:00.1
/proc/iomem:       e9c70000-e9c7ffff : tg3
/proc/iomem:     e9c80000-e9c8ffff : 0000:04:00.1
/proc/iomem:       e9c80000-e9c8ffff : tg3
/proc/iomem:     e9c90000-e9c9ffff : 0000:04:00.0
/proc/iomem:       e9c90000-e9c9ffff : tg3
/proc/iomem:     e9ca0000-e9caffff : 0000:04:00.0
/proc/iomem:       e9ca0000-e9caffff : tg3
/proc/iomem:     e9cb0000-e9cbffff : 0000:04:00.0
/proc/iomem:       e9cb0000-e9cbffff : tg3
/proc/iomem:   e9d00000-e9efffff : PCI Bus 0000:02
/proc/iomem:     e9d00000-e9dfffff : 0000:02:00.1
/proc/iomem:     e9e00000-e9e01fff : 0000:02:00.1
/proc/iomem:   e9f00000-ea1fffff : PCI Bus 0000:03
/proc/iomem:     e9f00000-e9ffffff : 0000:03:00.3
/proc/iomem:       e9f00000-e9ffffff : xhci-hcd
/proc/iomem:     ea000000-ea0fffff : 0000:03:00.2
/proc/iomem:     ea100000-ea101fff : 0000:03:00.2
/proc/iomem:   ea200000-ea2fffff : PCI Bus 0000:05
/proc/iomem:     ea200000-ea203fff : 0000:05:00.0
/proc/iomem:       ea200000-ea203fff : nvme
/proc/iomem:   ea300000-ea4fffff : PCI Bus 0000:06
/proc/iomem:   ea500000-ea6fffff : PCI Bus 0000:07
/proc/iomem:   ea700000-ea7fffff : PCI Bus 0000:04
/proc/iomem:     ea700000-ea73ffff : 0000:04:00.0
/proc/iomem:     ea740000-ea77ffff : 0000:04:00.1
/proc/iomem:     ea780000-ea7bffff : 0000:04:00.2
/proc/iomem:     ea7c0000-ea7fffff : 0000:04:00.3
/proc/iomem:   fda00000-fda003ff : IOAPIC 1
/proc/iomem: fec00000-fec0ffff : PNP0003:00
/proc/iomem:   fec00000-fec003ff : IOAPIC 0
/proc/iomem: fec10000-fec10fff : pnp 00:01
/proc/iomem: fed00000-fed003ff : HPET 0
/proc/iomem:   fed00000-fed001ff : PNP0103:00
/proc/iomem: fed80000-fed80fff : Reserved
/proc/iomem:   fed80000-fed80fff : pnp 00:01
/proc/iomem: fed81d00-fed81dff : pnp 00:01
/proc/iomem: fed81e00-fed81eff : pnp 00:01
/proc/iomem: fedc0000-fedc1fff : pnp 00:01
/proc/iomem: fedc4000-feddffff : pnp 00:01
/proc/iomem: fee00000-feefffff : pnp 00:01
/proc/iomem:   fee00000-fee00fff : Local APIC
/proc/iomem: ff000000-ffffffff : pnp 00:01
/proc/iomem: 100000000-107f1fffff : System RAM
/proc/iomem:   674200000-674c00e80 : Kernel code
/proc/iomem:   674c00e81-675324c7f : Kernel data
/proc/iomem:   6757b6000-6759fffff : Kernel bss
/proc/iomem: 107f200000-107fffffff : Reserved
/proc/iomem: 10000000000-2bf3fffffff : PCI Bus 0000:00
/proc/iomem:   10000000000-100001fffff : PCI Bus 0000:05
/proc/iomem:   10000200000-100003fffff : PCI Bus 0000:06
/proc/iomem:   10000400000-100005fffff : PCI Bus 0000:07
/proc/iomem: 2bf40000000-47e7fffffff : PCI Bus 0000:40
/proc/iomem:   2bf40000000-2bf401fffff : PCI Bus 0000:43
/proc/iomem:   2bf40200000-2bf403fffff : PCI Bus 0000:44
/proc/iomem: 47e80000000-63dbfffffff : PCI Bus 0000:80
/proc/iomem:   47e80000000-47e801fffff : PCI Bus 0000:83
/proc/iomem:   47e80200000-47e803fffff : PCI Bus 0000:84
/proc/iomem: 63dc0000000-ffffffffffff : PCI Bus 0000:c0
/proc/iomem:   63dc0000000-63dc01fffff : PCI Bus 0000:c3
/proc/iomem:   63dc0200000-63dc03fffff : PCI Bus 0000:c4
/proc/iomem:   63dc0400000-63dc05fffff : PCI Bus 0000:c5
/proc/interrupts:             CPU0       CPU1       CPU2       CPU3       CPU4       CPU5       CPU6       CPU7       CPU8       CPU9       CPU10      CPU11      CPU12      CPU13      CPU14      CPU15      CPU16      CPU17      CPU18      CPU19      CPU20      CPU21      CPU22      CPU23      CPU24      CPU25      CPU26      CPU27      CPU28      CPU29      CPU30      CPU31      
/proc/interrupts:    0:         38          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC    2-edge      timer
/proc/interrupts:    8:          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC    8-edge      rtc0
/proc/interrupts:    9:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC    9-fasteoi   acpi
/proc/interrupts:   26:          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 20480-edge      PCIe PME, pciehp
/proc/interrupts:   27:          0          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 22528-edge      PCIe PME, pciehp
/proc/interrupts:   28:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 51200-edge      PCIe PME, pciehp
/proc/interrupts:   29:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 55296-edge      PCIe PME
/proc/interrupts:   30:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67584-edge      PCIe PME
/proc/interrupts:   31:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 116736-edge      PCIe PME
/proc/interrupts:   33:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 133120-edge      PCIe PME
/proc/interrupts:   34:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 33572864-edge      PCIe PME, pciehp
/proc/interrupts:   35:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 33605632-edge      PCIe PME, pciehp
/proc/interrupts:   36:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 33671168-edge      PCIe PME
/proc/interrupts:   38:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 33687552-edge      PCIe PME
/proc/interrupts:   39:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67127296-edge      PCIe PME, pciehp
/proc/interrupts:   40:          0          0          0          0          0          0          0          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67162112-edge      PCIe PME, pciehp
/proc/interrupts:   42:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67225600-edge      PCIe PME
/proc/interrupts:   44:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 67241984-edge      PCIe PME
/proc/interrupts:   45:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100681728-edge      PCIe PME, pciehp
/proc/interrupts:   46:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100683776-edge      PCIe PME, pciehp
/proc/interrupts:   47:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          1          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100714496-edge      PCIe PME, pciehp
/proc/interrupts:   49:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100780032-edge      PCIe PME
/proc/interrupts:   51:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 100796416-edge      PCIe PME
/proc/interrupts:   52:          0          0         70          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621440-edge      nvme0q0
/proc/interrupts:   56:          0          0          0        175          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579008-edge      xhci_hcd
/proc/interrupts:   57:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579009-edge      xhci_hcd
/proc/interrupts:   58:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579010-edge      xhci_hcd
/proc/interrupts:   59:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579011-edge      xhci_hcd
/proc/interrupts:   60:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579012-edge      xhci_hcd
/proc/interrupts:   61:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579013-edge      xhci_hcd
/proc/interrupts:   62:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579014-edge      xhci_hcd
/proc/interrupts:   63:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 1579015-edge      xhci_hcd
/proc/interrupts:   64:       9451          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621441-edge      nvme0q1
/proc/interrupts:   65:          0       3549          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621442-edge      nvme0q2
/proc/interrupts:   66:          0          0       1738          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621443-edge      nvme0q3
/proc/interrupts:   67:          0          0          0      11219          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621444-edge      nvme0q4
/proc/interrupts:   68:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       2243          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621445-edge      nvme0q5
/proc/interrupts:   69:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       1412          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621446-edge      nvme0q6
/proc/interrupts:   70:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       5229          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621447-edge      nvme0q7
/proc/interrupts:   71:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        982          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621448-edge      nvme0q8
/proc/interrupts:   72:          0          0          0          0      28813          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621449-edge      nvme0q9
/proc/interrupts:   73:          0          0          0          0          0       5134          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621450-edge      nvme0q10
/proc/interrupts:   74:          0          0          0          0          0          0      11376          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621451-edge      nvme0q11
/proc/interrupts:   75:          0          0          0          0          0          0          0       6001          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621452-edge      nvme0q12
/proc/interrupts:   76:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       4052          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621453-edge      nvme0q13
/proc/interrupts:   77:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       8128          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621454-edge      nvme0q14
/proc/interrupts:   78:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       8608          0          0          0          0          0          0          0          0          0   PCI-MSI 2621455-edge      nvme0q15
/proc/interrupts:   79:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       9171          0          0          0          0          0          0          0          0   PCI-MSI 2621456-edge      nvme0q16
/proc/interrupts:   80:          0          0          0          0          0          0          0          0       1812          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621457-edge      nvme0q17
/proc/interrupts:   81:          0          0          0          0          0          0          0          0          0       2332          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621458-edge      nvme0q18
/proc/interrupts:   82:          0          0          0          0          0          0          0          0          0          0       4154          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621459-edge      nvme0q19
/proc/interrupts:   83:          0          0          0          0          0          0          0          0          0          0          0      10736          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621460-edge      nvme0q20
/proc/interrupts:   84:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        541          0          0          0          0          0          0          0   PCI-MSI 2621461-edge      nvme0q21
/proc/interrupts:   85:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       1105          0          0          0          0          0          0   PCI-MSI 2621462-edge      nvme0q22
/proc/interrupts:   86:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       3748          0          0          0          0          0   PCI-MSI 2621463-edge      nvme0q23
/proc/interrupts:   87:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       7413          0          0          0          0   PCI-MSI 2621464-edge      nvme0q24
/proc/interrupts:   88:          0          0          0          0          0          0          0          0          0          0          0          0      35749          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621465-edge      nvme0q25
/proc/interrupts:   89:          0          0          0          0          0          0          0          0          0          0          0          0          0      17810          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621466-edge      nvme0q26
/proc/interrupts:   90:          0          0          0          0          0          0          0          0          0          0          0          0          0          0      39336          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621467-edge      nvme0q27
/proc/interrupts:   91:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      40132          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2621468-edge      nvme0q28
/proc/interrupts:   92:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      42744          0          0          0   PCI-MSI 2621469-edge      nvme0q29
/proc/interrupts:   93:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      21767          0          0   PCI-MSI 2621470-edge      nvme0q30
/proc/interrupts:   94:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      26086          0   PCI-MSI 2621471-edge      nvme0q31
/proc/interrupts:   95:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      27432   PCI-MSI 2621472-edge      nvme0q32
/proc/interrupts:   97:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        705          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34082816-edge      ahci[0000:41:00.2]
/proc/interrupts:   98:          0          0          0        970          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IO-APIC    3-fasteoi   ehci_hcd:usb3
/proc/interrupts:  100:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0        117          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609152-edge      xhci_hcd
/proc/interrupts:  101:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609153-edge      xhci_hcd
/proc/interrupts:  102:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609154-edge      xhci_hcd
/proc/interrupts:  103:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609155-edge      xhci_hcd
/proc/interrupts:  104:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609156-edge      xhci_hcd
/proc/interrupts:  105:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609157-edge      xhci_hcd
/proc/interrupts:  106:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609158-edge      xhci_hcd
/proc/interrupts:  107:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 34609159-edge      xhci_hcd
/proc/interrupts:  108:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       9106          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2097152-edge      eno1-tx-0
/proc/interrupts:  109:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      47175          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2097153-edge      eno1-rx-1
/proc/interrupts:  110:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      12357          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2097154-edge      eno1-rx-2
/proc/interrupts:  111:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0      11875          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2097155-edge      eno1-rx-3
/proc/interrupts:  112:       4488          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   PCI-MSI 2097156-edge      eno1-rx-4
/proc/interrupts:  NMI:          1          0          0          0          0          0          0          0          0          0          0          0          1          1          1          1          0          0          0          0          0          1          0          0          0          0          1          0          1          1          1          1   Non-maskable interrupts
/proc/interrupts:  LOC:      14377       8898      20920      22271      11057       9664      10027       9952      10485       9624      17010      15291      16957      16152      17816      19543      13311     109470       8980       8429      10183      10240      10096       9442      10244       9754      22034      14446      17614      15300      17042      17530   Local timer interrupts
/proc/interrupts:  SPU:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Spurious interrupts
/proc/interrupts:  PMI:          1          0          0          0          0          0          0          0          0          0          0          0          1          1          1          1          0          0          0          0          0          1          0          0          0          0          1          0          1          1          1          1   Performance monitoring interrupts
/proc/interrupts:  IWI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          2          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   IRQ work interrupts
/proc/interrupts:  RTR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   APIC ICR read retries
/proc/interrupts:  RES:      19637       4664       4182       3411       4419       5072       3064       3128       4622       4598       6973       5325       7421       7400       7896      12878       3176       2959       2804       4745       3071       2990       2851       3579       4446       4130       6694       5297       7724       7449       7887      17603   Rescheduling interrupts
/proc/interrupts:  CAL:      19678      19607      19461      19496      19647      19453      19374      19435      19718      19583      19470      19474      19651      19567      19625      19594      19395      19306      19087      19191      19291      19202      19288      19059      19412      19417      19251      19324      19468      19516      19392      19295   Function call interrupts
/proc/interrupts:  TLB:       1063       1315       1805        890       4296       1121       1193       2026       1972       1849       1701       1586       4533       5079       5929       8382       1227        857        604       1389       6745       4808       3684        836       1561       1392       1795       1699       8045       2106       5232       8345   TLB shootdowns
/proc/interrupts:  TRM:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Thermal event interrupts
/proc/interrupts:  THR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Threshold APIC interrupts
/proc/interrupts:  DFR:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Deferred Error APIC interrupts
/proc/interrupts:  MCE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Machine check exceptions
/proc/interrupts:  MCP:          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5          5   Machine check polls
/proc/interrupts:  HYP:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Hypervisor callback interrupts
/proc/interrupts:  HRE:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Hyper-V reenlightenment interrupts
/proc/interrupts:  HVS:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Hyper-V stimer0 interrupts
/proc/interrupts:  ERR:          0
/proc/interrupts:  MIS:          0
/proc/interrupts:  PIN:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt notification event
/proc/interrupts:  NPI:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Nested posted-interrupt event
/proc/interrupts:  PIW:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0   Posted-interrupt wakeup event
/proc/meminfo: MemTotal:       65791560 kB
/proc/meminfo: MemFree:        64089496 kB
/proc/meminfo: MemAvailable:   64693592 kB
/proc/meminfo: Buffers:            1244 kB
/proc/meminfo: Cached:          1214728 kB
/proc/meminfo: SwapCached:            0 kB
/proc/meminfo: Active:          1110644 kB
/proc/meminfo: Inactive:         128312 kB
/proc/meminfo: Active(anon):     127304 kB
/proc/meminfo: Inactive(anon):    68232 kB
/proc/meminfo: Active(file):     983340 kB
/proc/meminfo: Inactive(file):    60080 kB
/proc/meminfo: Unevictable:           0 kB
/proc/meminfo: Mlocked:               0 kB
/proc/meminfo: SwapTotal:       8000508 kB
/proc/meminfo: SwapFree:        8000508 kB
/proc/meminfo: Dirty:               584 kB
/proc/meminfo: Writeback:             0 kB
/proc/meminfo: AnonPages:         22624 kB
/proc/meminfo: Mapped:             5032 kB
/proc/meminfo: Shmem:            172340 kB
/proc/meminfo: KReclaimable:     149372 kB
/proc/meminfo: Slab:             223216 kB
/proc/meminfo: SReclaimable:     149372 kB
/proc/meminfo: SUnreclaim:        73844 kB
/proc/meminfo: KernelStack:        6560 kB
/proc/meminfo: PageTables:            0 kB
/proc/meminfo: NFS_Unstable:          0 kB
/proc/meminfo: Bounce:                0 kB
/proc/meminfo: WritebackTmp:          0 kB
/proc/meminfo: CommitLimit:    40896288 kB
/proc/meminfo: Committed_AS:     220560 kB
/proc/meminfo: VmallocTotal:   34359738367 kB
/proc/meminfo: VmallocUsed:           0 kB
/proc/meminfo: VmallocChunk:          0 kB
/proc/meminfo: Percpu:             6400 kB
/proc/meminfo: HardwareCorrupted:     0 kB
/proc/meminfo: AnonHugePages:     16384 kB
/proc/meminfo: ShmemHugePages:        0 kB
/proc/meminfo: ShmemPmdMapped:        0 kB
/proc/meminfo: HugePages_Total:       0
/proc/meminfo: HugePages_Free:        0
/proc/meminfo: HugePages_Rsvd:        0
/proc/meminfo: HugePages_Surp:        0
/proc/meminfo: Hugepagesize:       2048 kB
/proc/meminfo: Hugetlb:               0 kB
/proc/meminfo: DirectMap4k:      620888 kB
/proc/meminfo: DirectMap2M:     6541312 kB
/proc/meminfo: DirectMap1G:    59768832 kB
/proc/bus/input/devices: I: Bus=0003 Vendor=03f0 Product=7029 Version=0101
/proc/bus/input/devices: N: Name="HPE Virtual Keyboard"
/proc/bus/input/devices: P: Phys=usb-0000:01:00.4-1/input0
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:04.1/0000:01:00.4/usb3/3-1/3-1:1.0/0003:03F0:7029.0001/input/input0
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=sysrq kbd leds 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=120013
/proc/bus/input/devices: B: KEY=1000000000007 ff980000000007ff febeffdfffefffff fffffffffffffffe
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: B: LED=1f
/proc/bus/input/devices: 
/proc/bus/input/devices: I: Bus=0003 Vendor=03f0 Product=7029 Version=0101
/proc/bus/input/devices: N: Name="HPE Virtual Keyboard"
/proc/bus/input/devices: P: Phys=usb-0000:01:00.4-1/input1
/proc/bus/input/devices: S: Sysfs=/devices/pci0000:00/0000:00:04.1/0000:01:00.4/usb3/3-1/3-1:1.1/0003:03F0:7029.0002/input/input1
/proc/bus/input/devices: U: Uniq=
/proc/bus/input/devices: H: Handlers=mouse0 
/proc/bus/input/devices: B: PROP=0
/proc/bus/input/devices: B: EV=1f
/proc/bus/input/devices: B: KEY=70000 0 0 0 0
/proc/bus/input/devices: B: REL=900
/proc/bus/input/devices: B: ABS=3
/proc/bus/input/devices: B: MSC=10
/proc/bus/input/devices: 
dmidecode: # dmidecode 3.2
dmidecode: Getting SMBIOS data from sysfs.
dmidecode: SMBIOS 3.1.1 present.
dmidecode: Table at 0x6E798000.
dmidecode: 
dmidecode: Handle 0x0000, DMI type 39, 22 bytes
dmidecode: System Power Supply
dmidecode: 	Location: Not Specified
dmidecode: 	Name: Power Supply 1
dmidecode: 	Manufacturer: HPE
dmidecode: 	Serial Number: 5FKYD0ALLA32P9
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Model Part Number: 837074-B21
dmidecode: 	Revision: Not Specified
dmidecode: 	Max Power Capacity: 500 W
dmidecode: 	Status: Present, Unknown
dmidecode: 	Type: Unknown
dmidecode: 	Input Voltage Range Switching: Unknown
dmidecode: 	Plugged: Yes
dmidecode: 	Hot Replaceable: No
dmidecode: 
dmidecode: Handle 0x0001, DMI type 194, 5 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C2 05 01 00 11
dmidecode: 
dmidecode: Handle 0x0002, DMI type 199, 28 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C7 1C 02 00 27 12 00 08 18 20 09 02 12 80 00 00
dmidecode: 		29 11 00 08 17 20 14 07 11 80 00 00
dmidecode: 
dmidecode: Handle 0x0003, DMI type 201, 16 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C9 10 03 00 10 02 00 00 40 0D 01 00 0E 00 00 80
dmidecode: 
dmidecode: Handle 0x0004, DMI type 0, 26 bytes
dmidecode: BIOS Information
dmidecode: 	Vendor: HPE
dmidecode: 	Version: A41
dmidecode: 	Release Date: 06/07/2018
dmidecode: 	Address: 0xF0000
dmidecode: 	Runtime Size: 64 kB
dmidecode: 	ROM Size: 64 MB
dmidecode: 	Characteristics:
dmidecode: 		PCI is supported
dmidecode: 		PNP is supported
dmidecode: 		BIOS is upgradeable
dmidecode: 		BIOS shadowing is allowed
dmidecode: 		ESCD support is available
dmidecode: 		Boot from CD is supported
dmidecode: 		Selectable boot is supported
dmidecode: 		EDD is supported
dmidecode: 		5.25"/360 kB floppy services are supported (int 13h)
dmidecode: 		5.25"/1.2 MB floppy services are supported (int 13h)
dmidecode: 		3.5"/720 kB floppy services are supported (int 13h)
dmidecode: 		Print screen service is supported (int 5h)
dmidecode: 		8042 keyboard services are supported (int 9h)
dmidecode: 		Serial services are supported (int 14h)
dmidecode: 		Printer services are supported (int 17h)
dmidecode: 		CGA/mono video services are supported (int 10h)
dmidecode: 		ACPI is supported
dmidecode: 		USB legacy is supported
dmidecode: 		BIOS boot specification is supported
dmidecode: 		Function key-initiated network boot is supported
dmidecode: 		Targeted content distribution is supported
dmidecode: 		UEFI is supported
dmidecode: 	BIOS Revision: 1.30
dmidecode: 	Firmware Revision: 1.35
dmidecode: 
dmidecode: Handle 0x0005, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: U44
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 1
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x0006, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J30
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 2
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x0007, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: U287
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 3
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x0008, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J5
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 4
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x0009, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J12
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 5
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x000A, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J12
dmidecode: 	Internal Connector Type: Access Bus (USB)
dmidecode: 	External Reference Designator: USB PORT 6
dmidecode: 	External Connector Type: Access Bus (USB)
dmidecode: 	Port Type: USB
dmidecode: 
dmidecode: Handle 0x000B, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J87
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: COM PORT
dmidecode: 	External Connector Type: DB-9 male
dmidecode: 	Port Type: Serial Port 16550A Compatible
dmidecode: 
dmidecode: Handle 0x000C, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J28
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: Video PORT
dmidecode: 	External Connector Type: DB-15 female
dmidecode: 	Port Type: Video Port
dmidecode: 
dmidecode: Handle 0x000D, DMI type 8, 9 bytes
dmidecode: Port Connector Information
dmidecode: 	Internal Reference Designator: J39
dmidecode: 	Internal Connector Type: None
dmidecode: 	External Reference Designator: ILO NIC PORT
dmidecode: 	External Connector Type: RJ-45
dmidecode: 	Port Type: Network Port
dmidecode: 
dmidecode: Handle 0x000E, DMI type 16, 23 bytes
dmidecode: Physical Memory Array
dmidecode: 	Location: System Board Or Motherboard
dmidecode: 	Use: System Memory
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	Maximum Capacity: 2 TB
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Number Of Devices: 16
dmidecode: 
dmidecode: Handle 0x000F, DMI type 38, 18 bytes
dmidecode: IPMI Device Information
dmidecode: 	Interface Type: KCS (Keyboard Control Style)
dmidecode: 	Specification Version: 2.0
dmidecode: 	I2C Slave Address: 0x10
dmidecode: 	NV Storage Device: Not Present
dmidecode: 	Base Address: 0x0000000000000CA2 (I/O)
dmidecode: 	Register Spacing: Successive Byte Boundaries
dmidecode: 
dmidecode: Handle 0x0010, DMI type 193, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C1 09 10 00 01 01 00 02 03
dmidecode: 	Strings:
dmidecode: 		v1.30 (06/07/2018)
dmidecode: 		         
dmidecode: 		          
dmidecode: 
dmidecode: Handle 0x0011, DMI type 195, 7 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C3 07 11 00 01 17 02
dmidecode: 	Strings:
dmidecode: 		$0E11086A
dmidecode: 
dmidecode: Handle 0x0012, DMI type 198, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C6 0E 12 00 01 00 00 00 00 00 01 0A FF FF
dmidecode: 
dmidecode: Handle 0x0013, DMI type 215, 6 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D7 06 13 00 00 05
dmidecode: 
dmidecode: Handle 0x0014, DMI type 223, 11 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		DF 0B 14 00 66 46 70 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0015, DMI type 230, 11 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E6 0B 15 00 00 00 01 02 00 07 00
dmidecode: 	Strings:
dmidecode: 		LTEON
dmidecode: 		01
dmidecode: 
dmidecode: Handle 0x0016, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x00000000000
dmidecode: 	Ending Address: 0x0007FFFFFFF
dmidecode: 	Range Size: 2 GB
dmidecode: 	Physical Array Handle: 0x000E
dmidecode: 	Partition Width: 1
dmidecode: 
dmidecode: Handle 0x0017, DMI type 19, 31 bytes
dmidecode: Memory Array Mapped Address
dmidecode: 	Starting Address: 0x0000000100000000k
dmidecode: 	Ending Address: 0x000000107FFFFFFFk
dmidecode: 	Range Size: 62 GB
dmidecode: 	Physical Array Handle: 0x000E
dmidecode: 	Partition Width: 1
dmidecode: 
dmidecode: Handle 0x0018, DMI type 236, 21 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EC 15 18 00 A0 01 00 A9 00 00 00 00 00 00 00 00
dmidecode: 		00 08 04 04 01
dmidecode: 	Strings:
dmidecode: 		G9 2x4 SFF BP1
dmidecode: 
dmidecode: Handle 0x0019, DMI type 236, 21 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EC 15 19 00 A2 00 00 A9 00 00 00 00 00 00 00 00
dmidecode: 		00 08 04 04 01
dmidecode: 	Strings:
dmidecode: 		G9 2x4 SFF BP1
dmidecode: 
dmidecode: Handle 0x001A, DMI type 236, 21 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EC 15 1A 00 A0 02 00 DD 00 00 00 00 00 00 00 00
dmidecode: 		00 02 02 00 01
dmidecode: 	Strings:
dmidecode: 		GEN10 1X2 SFF EB1
dmidecode: 
dmidecode: Handle 0x001B, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 32 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: None
dmidecode: 	Locator: PROC 1 DIMM 1
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: HPE
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: 840758-191
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2400 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Bank 10, Hex 0x83
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 32 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x001C, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 1
dmidecode: 	Locator: PROC 1 DIMM 2
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x001D, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 2
dmidecode: 	Locator: PROC 1 DIMM 3
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x001E, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 3
dmidecode: 	Locator: PROC 1 DIMM 4
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x001F, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 4
dmidecode: 	Locator: PROC 1 DIMM 5
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0020, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 5
dmidecode: 	Locator: PROC 1 DIMM 6
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0021, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 6
dmidecode: 	Locator: PROC 1 DIMM 7
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0022, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 7
dmidecode: 	Locator: PROC 1 DIMM 8
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0023, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 8
dmidecode: 	Locator: PROC 1 DIMM 9
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0024, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 9
dmidecode: 	Locator: PROC 1 DIMM 10
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0025, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 10
dmidecode: 	Locator: PROC 1 DIMM 11
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0026, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 11
dmidecode: 	Locator: PROC 1 DIMM 12
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0027, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 12
dmidecode: 	Locator: PROC 1 DIMM 13
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0028, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 13
dmidecode: 	Locator: PROC 1 DIMM 14
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x0029, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: No Module Installed
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 14
dmidecode: 	Locator: PROC 1 DIMM 15
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous
dmidecode: 	Speed: Unknown
dmidecode: 	Manufacturer: UNKNOWN
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: NOT AVAILABLE
dmidecode: 	Rank: Unknown
dmidecode: 	Configured Memory Speed: Unknown
dmidecode: 	Minimum Voltage: Unknown
dmidecode: 	Maximum Voltage: Unknown
dmidecode: 	Configured Voltage: Unknown
dmidecode: 	Memory Technology: Unknown
dmidecode: 	Memory Operating Mode Capability: Unknown
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Unknown
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: None
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x002A, DMI type 17, 84 bytes
dmidecode: Memory Device
dmidecode: 	Array Handle: 0x000E
dmidecode: 	Error Information Handle: Not Provided
dmidecode: 	Total Width: 72 bits
dmidecode: 	Data Width: 64 bits
dmidecode: 	Size: 32 GB
dmidecode: 	Form Factor: DIMM
dmidecode: 	Set: 15
dmidecode: 	Locator: PROC 1 DIMM 16
dmidecode: 	Bank Locator: Not Specified
dmidecode: 	Type: DDR4
dmidecode: 	Type Detail: Synchronous Registered (Buffered)
dmidecode: 	Speed: 2666 MT/s
dmidecode: 	Manufacturer: HPE
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Not Specified
dmidecode: 	Part Number: 840758-191
dmidecode: 	Rank: 2
dmidecode: 	Configured Memory Speed: 2400 MT/s
dmidecode: 	Minimum Voltage: 1.2 V
dmidecode: 	Maximum Voltage: 1.2 V
dmidecode: 	Configured Voltage: 1.2 V
dmidecode: 	Memory Technology: DRAM
dmidecode: 	Memory Operating Mode Capability: Volatile memory
dmidecode: 	Firmware Version: Not Specified
dmidecode: 	Module Manufacturer ID: Bank 10, Hex 0x83
dmidecode: 	Module Product ID: Unknown
dmidecode: 	Memory Subsystem Controller Manufacturer ID: Unknown
dmidecode: 	Memory Subsystem Controller Product ID: Unknown
dmidecode: 	Non-Volatile Size: None
dmidecode: 	Volatile Size: 32 GB
dmidecode: 	Cache Size: None
dmidecode: 	Logical Size: None
dmidecode: 
dmidecode: Handle 0x002B, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 2B 00 1B 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Hynix           
dmidecode: 		HMA84GR7AFR4N-VK    
dmidecode: 		12147A55
dmidecode: 
dmidecode: Handle 0x002C, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 2C 00 1C 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x002D, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 2D 00 1D 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x002E, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 2E 00 1E 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x002F, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 2F 00 1F 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0030, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 30 00 20 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0031, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 31 00 21 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0032, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 32 00 22 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0033, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 33 00 23 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0034, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 34 00 24 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0035, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 35 00 25 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0036, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 36 00 26 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0037, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 37 00 27 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0038, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 38 00 28 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x0039, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 39 00 29 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Unknown         
dmidecode: 		NOT AVAILABLE   
dmidecode: 		NOT AVAILABLE   
dmidecode: 
dmidecode: Handle 0x003A, DMI type 237, 9 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		ED 09 3A 00 2A 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		Hynix           
dmidecode: 		HMA84GR7AFR4N-VK    
dmidecode: 		12147A57
dmidecode: 
dmidecode: Handle 0x003B, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 3B 00 1B 00 11 00 00 00 B0 04 B0 04
dmidecode: 
dmidecode: Handle 0x003C, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 3C 00 1C 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x003D, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 3D 00 1D 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x003E, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 3E 00 1E 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x003F, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 3F 00 1F 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0040, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 40 00 20 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0041, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 41 00 21 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0042, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 42 00 22 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0043, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 43 00 23 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0044, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 44 00 24 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0045, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 45 00 25 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0046, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 46 00 26 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0047, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 47 00 27 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0048, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 48 00 28 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0049, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 49 00 29 00 10 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x004A, DMI type 232, 14 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E8 0E 4A 00 2A 00 11 00 00 00 B0 04 B0 04
dmidecode: 
dmidecode: Handle 0x004B, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L1-Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 1
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 1536 kB
dmidecode: 	Maximum Size: 1536 kB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x004C, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L2-Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 2
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 8192 kB
dmidecode: 	Maximum Size: 8192 kB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 8-way Set-associative
dmidecode: 
dmidecode: Handle 0x004D, DMI type 7, 27 bytes
dmidecode: Cache Information
dmidecode: 	Socket Designation: L3-Cache
dmidecode: 	Configuration: Enabled, Not Socketed, Level 3
dmidecode: 	Operational Mode: Write Back
dmidecode: 	Location: Internal
dmidecode: 	Installed Size: 65536 kB
dmidecode: 	Maximum Size: 65536 kB
dmidecode: 	Supported SRAM Types:
dmidecode: 		Pipeline Burst
dmidecode: 	Installed SRAM Type: Pipeline Burst
dmidecode: 	Speed: 1 ns
dmidecode: 	Error Correction Type: Multi-bit ECC
dmidecode: 	System Type: Unified
dmidecode: 	Associativity: 64-way Set-associative
dmidecode: 
dmidecode: Handle 0x004E, DMI type 4, 48 bytes
dmidecode: Processor Information
dmidecode: 	Socket Designation: Proc 1
dmidecode: 	Type: Central Processor
dmidecode: 	Family: Zen
dmidecode: 	Manufacturer: Advanced Micro Devices, Inc.
dmidecode: 	ID: 12 0F 80 00 FF FB 8B 17
dmidecode: 	Signature: Family 23, Model 1, Stepping 2
dmidecode: 	Flags:
dmidecode: 		FPU (Floating-point unit on-chip)
dmidecode: 		VME (Virtual mode extension)
dmidecode: 		DE (Debugging extension)
dmidecode: 		PSE (Page size extension)
dmidecode: 		TSC (Time stamp counter)
dmidecode: 		MSR (Model specific registers)
dmidecode: 		PAE (Physical address extension)
dmidecode: 		MCE (Machine check exception)
dmidecode: 		CX8 (CMPXCHG8 instruction supported)
dmidecode: 		APIC (On-chip APIC hardware supported)
dmidecode: 		SEP (Fast system call)
dmidecode: 		MTRR (Memory type range registers)
dmidecode: 		PGE (Page global enable)
dmidecode: 		MCA (Machine check architecture)
dmidecode: 		CMOV (Conditional move instruction supported)
dmidecode: 		PAT (Page attribute table)
dmidecode: 		PSE-36 (36-bit page size extension)
dmidecode: 		CLFSH (CLFLUSH instruction supported)
dmidecode: 		MMX (MMX technology supported)
dmidecode: 		FXSR (FXSAVE and FXSTOR instructions supported)
dmidecode: 		SSE (Streaming SIMD extensions)
dmidecode: 		SSE2 (Streaming SIMD extensions 2)
dmidecode: 		HTT (Multi-threading)
dmidecode: 	Version: AMD EPYC 7351P 16-Core Processor               
dmidecode: 	Voltage: 1.0 V
dmidecode: 	External Clock: 100 MHz
dmidecode: 	Max Speed: 2400 MHz
dmidecode: 	Current Speed: 2400 MHz
dmidecode: 	Status: Populated, Enabled
dmidecode: 	Upgrade: Socket SP3
dmidecode: 	L1 Cache Handle: 0x004B
dmidecode: 	L2 Cache Handle: 0x004C
dmidecode: 	L3 Cache Handle: 0x004D
dmidecode: 	Serial Number: Not Specified
dmidecode: 	Asset Tag: Unknown
dmidecode: 	Part Number: Not Specified
dmidecode: 	Core Count: 16
dmidecode: 	Core Enabled: 16
dmidecode: 	Thread Count: 32
dmidecode: 	Characteristics:
dmidecode: 		64-bit capable
dmidecode: 		Multi-Core
dmidecode: 		Hardware Thread
dmidecode: 		Execute Protection
dmidecode: 		Enhanced Virtualization
dmidecode: 		Power/Performance Control
dmidecode: 
dmidecode: Handle 0x004F, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 4F 00 4E 00 1B 00 0B AC 01 00 FF FF FF FF
dmidecode: 		00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0050, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 50 00 4E 00 1C 00 0B AE 01 00 FF FF FF FF
dmidecode: 		00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0051, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 51 00 4E 00 1D 00 0B A8 01 00 FF FF FF FF
dmidecode: 		01 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0052, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 52 00 4E 00 1E 00 0B AA 01 00 FF FF FF FF
dmidecode: 		01 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0053, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 53 00 4E 00 1F 00 0B A4 01 00 FF FF FF FF
dmidecode: 		03 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0054, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 54 00 4E 00 20 00 0B A6 01 00 FF FF FF FF
dmidecode: 		03 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0055, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 55 00 4E 00 21 00 0B A0 01 00 FF FF FF FF
dmidecode: 		02 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0056, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 56 00 4E 00 22 00 0B A2 01 00 FF FF FF FF
dmidecode: 		02 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0057, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 57 00 4E 00 23 00 0C A2 01 01 FF FF FF FF
dmidecode: 		06 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0058, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 58 00 4E 00 24 00 0C A0 01 01 FF FF FF FF
dmidecode: 		06 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0059, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 59 00 4E 00 25 00 0C A6 01 01 FF FF FF FF
dmidecode: 		07 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005A, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 5A 00 4E 00 26 00 0C A4 01 01 FF FF FF FF
dmidecode: 		07 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005B, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 5B 00 4E 00 27 00 0C AA 01 01 FF FF FF FF
dmidecode: 		05 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005C, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 5C 00 4E 00 28 00 0C A8 01 01 FF FF FF FF
dmidecode: 		05 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005D, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 5D 00 4E 00 29 00 0C AE 01 01 FF FF FF FF
dmidecode: 		04 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005E, DMI type 227, 22 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E3 16 5E 00 4E 00 2A 00 0C AC 01 01 FF FF FF FF
dmidecode: 		04 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x005F, DMI type 197, 26 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C5 1A 5F 00 4E 00 00 01 FF 01 00 00 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0060, DMI type 1, 27 bytes
dmidecode: System Information
dmidecode: 	Manufacturer: HPE
dmidecode: 	Product Name: ProLiant DL325 Gen10
dmidecode: 	Version: Not Specified
dmidecode: 	Serial Number: CZJ83907Q4
dmidecode: 	UUID: 36343050-3435-5a43-4a38-333930375134
dmidecode: 	Wake-up Type: Power Switch
dmidecode: 	SKU Number: P04654-B21
dmidecode: 	Family: ProLiant
dmidecode: 
dmidecode: Handle 0x0061, DMI type 226, 21 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E2 15 61 00 50 30 34 36 35 34 43 5A 4A 38 33 39
dmidecode: 		30 37 51 34 01
dmidecode: 	Strings:
dmidecode: 		CZJ83907Q4
dmidecode: 
dmidecode: Handle 0x0062, DMI type 229, 52 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E5 34 62 00 24 57 48 45 00 C0 77 6E 00 00 00 00
dmidecode: 		00 10 01 00 24 53 4D 56 D0 BD FE 7F 00 00 00 00
dmidecode: 		08 00 00 00 24 5A 58 54 00 20 FD 77 00 00 00 00
dmidecode: 		A9 00 00 00
dmidecode: 
dmidecode: Handle 0x0063, DMI type 219, 32 bytes
dmidecode: HPE ProLiant Information
dmidecode: 	Power Features: 0x00000000
dmidecode: 	Omega Features: 0x0000000f
dmidecode: 	Misc. Features: 0x00009807
dmidecode: 		iCRU: Yes
dmidecode: 		UEFI: Yes
dmidecode: 
dmidecode: Handle 0x0064, DMI type 3, 21 bytes
dmidecode: Chassis Information
dmidecode: 	Manufacturer: HPE
dmidecode: 	Type: Rack Mount Chassis
dmidecode: 	Lock: Not Present
dmidecode: 	Version: Not Specified
dmidecode: 	Serial Number: CZJ83907Q4
dmidecode: 	Asset Tag:                                 
dmidecode: 	Boot-up State: Safe
dmidecode: 	Power Supply State: Safe
dmidecode: 	Thermal State: Safe
dmidecode: 	Security Status: Unknown
dmidecode: 	OEM Information: 0x00000000
dmidecode: 	Height: 1 U
dmidecode: 	Number Of Power Cords: 1
dmidecode: 	Contained Elements: 0
dmidecode: 
dmidecode: Handle 0x0065, DMI type 11, 5 bytes
dmidecode: OEM Strings
dmidecode: 	String 1: PSF:                                                            
dmidecode: 	String 2: Product ID: P04654-B21
dmidecode: 	String 3: OEM String: 
dmidecode: 
dmidecode: Handle 0x0066, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 66 00 01 00 01 02 07 01 1E 06 07 E2 07 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		System ROM
dmidecode: 		v1.30 (06/07/2018)
dmidecode: 
dmidecode: Handle 0x0067, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 67 00 02 00 01 02 07 01 1E 06 07 E2 07 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		Redundant System ROM
dmidecode: 		v1.30 (06/07/2018)
dmidecode: 
dmidecode: Handle 0x0068, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 68 00 04 00 01 02 04 10 04 00 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		Power Management Controller Firmware
dmidecode: 		1.0.4
dmidecode: 
dmidecode: Handle 0x0069, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 69 00 08 00 01 00 01 09 09 00 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		System Programmable Logic Device
dmidecode: 
dmidecode: Handle 0x006A, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 6A 00 0C 00 01 02 0A 07 0E 00 0E 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		Intelligent Platform Abstraction Data
dmidecode: 		7.14.0 Build 14
dmidecode: 
dmidecode: Handle 0x006B, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 6B 00 0F 00 01 02 06 14 01 00 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		NVMe Backplane 1 Firmware
dmidecode: 		1.20
dmidecode: 
dmidecode: Handle 0x006C, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 6C 00 10 00 01 02 09 03 14 9A 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		Intelligent Provisioning
dmidecode: 		3.20.154
dmidecode: 
dmidecode: Handle 0x006D, DMI type 216, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		D8 17 6D 00 30 00 01 02 02 25 00 00 00 00 00 00
dmidecode: 		00 00 00 00 00 00 00
dmidecode: 	Strings:
dmidecode: 		Embedded Video Controller
dmidecode: 		2.5
dmidecode: 
dmidecode: Handle 0x006E, DMI type 2, 15 bytes
dmidecode: Base Board Information
dmidecode: 	Manufacturer: HPE
dmidecode: 	Product Name: ProLiant DL325 Gen10
dmidecode: 	Version: Not Specified
dmidecode: 	Serial Number: PWTGH0BRHBA0D8
dmidecode: 	Asset Tag:                                 
dmidecode: 	Features:
dmidecode: 		Board is a hosting board
dmidecode: 		Board is removable
dmidecode: 		Board is replaceable
dmidecode: 	Location In Chassis: Not Specified
dmidecode: 	Chassis Handle: 0x0000
dmidecode: 	Type: Motherboard
dmidecode: 	Contained Object Handles: 0
dmidecode: 
dmidecode: Handle 0x006F, DMI type 224, 12 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		E0 0C 6F 00 00 00 00 01 FE FF 00 00
dmidecode: 
dmidecode: Handle 0x0070, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded LOM 1 Port 1
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:04:00.0
dmidecode: 
dmidecode: Handle 0x0071, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded LOM 1 Port 2
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 2
dmidecode: 	Bus Address: 0000:04:00.1
dmidecode: 
dmidecode: Handle 0x0072, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded LOM 1 Port 3
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 3
dmidecode: 	Bus Address: 0000:04:00.2
dmidecode: 
dmidecode: Handle 0x0073, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded LOM 1 Port 4
dmidecode: 	Type: Ethernet
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 4
dmidecode: 	Bus Address: 0000:04:00.3
dmidecode: 
dmidecode: Handle 0x0074, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded SATA Controller #2
dmidecode: 	Type: SATA Controller
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 2
dmidecode: 	Bus Address: 0000:41:00.2
dmidecode: 
dmidecode: Handle 0x0075, DMI type 41, 11 bytes
dmidecode: Onboard Device
dmidecode: 	Reference Designation: Embedded Device
dmidecode: 	Type: Video
dmidecode: 	Status: Enabled
dmidecode: 	Type Instance: 1
dmidecode: 	Bus Address: 0000:01:00.1
dmidecode: 
dmidecode: Handle 0x0076, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: NVMe Drive Box 2 Bay 1
dmidecode: 	Type: x4 PCI Express 3 SFF-8639
dmidecode: 	Current Usage: In Use
dmidecode: 	Length: Other
dmidecode: 	ID: 9
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Hot-plug devices are supported
dmidecode: 		SMBus signal is supported
dmidecode: 	Bus Address: 0000:05:00.0
dmidecode: 
dmidecode: Handle 0x0077, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: NVMe Slot 
dmidecode: 	Type: x4 PCI Express 3 SFF-8639
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Other
dmidecode: 	ID: 10
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		Hot-plug devices are supported
dmidecode: 		SMBus signal is supported
dmidecode: 	Bus Address: 0000:06:00.0
dmidecode: 
dmidecode: Handle 0x0078, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: PCI-E Slot 1
dmidecode: 	Type: x16 PCI Express 3
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Long
dmidecode: 	ID: 1
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:44:00.0
dmidecode: 
dmidecode: Handle 0x0079, DMI type 9, 17 bytes
dmidecode: System Slot Information
dmidecode: 	Designation: PCI-E Slot 2
dmidecode: 	Type: x8 PCI Express 3
dmidecode: 	Current Usage: Available
dmidecode: 	Length: Short
dmidecode: 	ID: 2
dmidecode: 	Characteristics:
dmidecode: 		3.3 V is provided
dmidecode: 		PME signal is supported
dmidecode: 	Bus Address: 0000:c4:00.0
dmidecode: 
dmidecode: Handle 0x007A, DMI type 32, 11 bytes
dmidecode: System Boot Information
dmidecode: 	Status: No errors detected
dmidecode: 
dmidecode: Handle 0x007B, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 7B 00 70 00 FE FF E4 14 57 16 3C 10 BE 22
dmidecode: 		02 00 FE FF 00 00 04 01 01 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x3,0x3)/Pci(0x0,0x0)
dmidecode: 		NIC.LOM.1.1
dmidecode: 		Network Controller
dmidecode: 		Embedded LOM 1
dmidecode: 
dmidecode: Handle 0x007C, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 7C 00 71 00 FE FF E4 14 57 16 3C 10 BE 22
dmidecode: 		02 00 FE FF 00 00 04 01 01 02 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x3,0x3)/Pci(0x0,0x1)
dmidecode: 		NIC.LOM.1.2
dmidecode: 		Network Controller
dmidecode: 		Embedded LOM 1
dmidecode: 
dmidecode: Handle 0x007D, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 7D 00 72 00 FE FF E4 14 57 16 3C 10 BE 22
dmidecode: 		02 00 FE FF 00 00 04 01 01 03 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x3,0x3)/Pci(0x0,0x2)
dmidecode: 		NIC.LOM.1.3
dmidecode: 		Network Controller
dmidecode: 		Embedded LOM 1
dmidecode: 
dmidecode: Handle 0x007E, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 7E 00 73 00 FE FF E4 14 57 16 3C 10 BE 22
dmidecode: 		02 00 FE FF 00 00 04 01 01 04 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x3,0x3)/Pci(0x0,0x3)
dmidecode: 		NIC.LOM.1.4
dmidecode: 		Network Controller
dmidecode: 		Embedded LOM 1
dmidecode: 
dmidecode: Handle 0x007F, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 7F 00 74 00 FE FF 22 10 01 79 90 15 78 02
dmidecode: 		01 06 FE FF 00 00 06 08 02 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x8,0x1)/Pci(0x0,0x2)
dmidecode: 		SATA.Emb.2.1
dmidecode: 		Embedded SATA Controller #2
dmidecode: 		Embedded SATA Controller #2
dmidecode: 
dmidecode: Handle 0x0080, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 80 00 75 00 FE FF 2B 10 38 05 90 15 E4 00
dmidecode: 		03 00 FE FF 00 00 09 01 01 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x4,0x1)/Pci(0x0,0x1)
dmidecode: 		PCI.Emb.1.1
dmidecode: 		Embedded Video Controller
dmidecode: 		Embedded Video Controller
dmidecode: 
dmidecode: Handle 0x0081, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 81 00 76 00 FE FF 4D 14 08 A8 4D 14 01 A8
dmidecode: 		01 08 FE FF 00 00 10 0F 02 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x1,0x2)/Pci(0x0,0x0)
dmidecode: 		NVMe.DriveBay.2.1
dmidecode: 		NVM Express Controller
dmidecode: 		NVMe Drive Port 5A Box 2 Bay 1
dmidecode: 
dmidecode: Handle 0x0082, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 82 00 77 00 FE FF FF FF FF FF FF FF FF FF
dmidecode: 		FF FF FE FF 00 00 10 0F 02 02 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x1,0x3)/Pci(0x0,0x0)
dmidecode: 		NVMe.DriveBay.2.2
dmidecode: 		Empty Drive Bay 10
dmidecode: 		NVMe Drive Port 5A Box 2 Bay 2
dmidecode: 
dmidecode: Handle 0x0083, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 83 00 78 00 FE FF FF FF FF FF FF FF FF FF
dmidecode: 		FF FF FE FF 00 00 09 0A 01 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x3,0x1)/Pci(0x0,0x0)
dmidecode: 		PCI.Slot.1.1
dmidecode: 		Empty slot 1
dmidecode: 		Slot 1
dmidecode: 
dmidecode: Handle 0x0084, DMI type 203, 34 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CB 22 84 00 79 00 FE FF FF FF FF FF FF FF FF FF
dmidecode: 		FF FF FE FF 00 00 09 0A 02 01 FF FF 01 02 03 04
dmidecode: 		FE FF
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x3)/Pci(0x1,0x2)/Pci(0x0,0x0)
dmidecode: 		PCI.Slot.2.1
dmidecode: 		Empty slot 2
dmidecode: 		Slot 2
dmidecode: 
dmidecode: Handle 0x0085, DMI type 234, 16 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EA 10 85 00 FE FF C0 00 01 A0 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0086, DMI type 234, 8 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EA 08 86 00 FE FF 80 05
dmidecode: 
dmidecode: Handle 0x0087, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 87 00 05 00 03 03 05 00 00 01 00 02 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x1,0x0)/USB(0x0,0x0)
dmidecode: 
dmidecode: Handle 0x0088, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 88 00 06 00 03 03 01 00 00 01 00 02 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x1,0x0)/USB(0x1,0x0)
dmidecode: 
dmidecode: Handle 0x0089, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 89 00 06 00 03 03 01 00 00 01 00 03 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x3,0x0)/USB(0x1,0x0)
dmidecode: 
dmidecode: Handle 0x008A, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8A 00 08 00 03 03 00 00 00 01 00 02 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x1,0x0)/USB(0x2,0x0)
dmidecode: 
dmidecode: Handle 0x008B, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8B 00 08 00 03 03 00 00 00 01 00 03 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x3,0x0)/USB(0x2,0x0)
dmidecode: 
dmidecode: Handle 0x008C, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8C 00 09 00 42 03 02 00 00 01 01 02 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x0,0x0)/USB(0x0,0x0)
dmidecode: 
dmidecode: Handle 0x008D, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8D 00 09 00 42 03 02 00 00 01 01 03 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x2,0x0)/USB(0x0,0x0)
dmidecode: 
dmidecode: Handle 0x008E, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8E 00 0A 00 42 03 02 00 00 02 01 02 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x0,0x0)/USB(0x1,0x0)
dmidecode: 
dmidecode: Handle 0x008F, DMI type 238, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EE 0F 8F 00 0A 00 42 03 02 00 00 02 01 03 01
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x1)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x2,0x0)/USB(0x1,0x0)
dmidecode: 
dmidecode: Handle 0x0090, DMI type 239, 23 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		EF 17 90 00 87 00 24 04 00 00 09 00 01 60 26 00
dmidecode: 		00 00 00 01 02 03 04
dmidecode: 	Strings:
dmidecode: 		PciRoot(0x0)/Pci(0x7,0x1)/Pci(0x0,0x3)/USB(0x1,0x0)/USB(0x0,0x0)
dmidecode: 		Unknown.Unknown.1.1
dmidecode: 		Unknown Device
dmidecode: 		Smsc USB 0
dmidecode: 
dmidecode: Handle 0x0091, DMI type 242, 42 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		F2 2A 91 00 81 00 01 38 25 00 00 00 00 00 00 8B
dmidecode: 		A1 07 00 29 01 00 00 00 00 00 00 00 00 00 00 00
dmidecode: 		00 00 00 0B 06 03 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		S466NX0K913366V
dmidecode: 		Samsung SSD 970 EVO 500GB
dmidecode: 		2B2QEXE7
dmidecode: 
dmidecode: Handle 0x0092, DMI type 242, 42 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		F2 2A 92 00 7F 00 02 00 50 00 C5 E3 BA 7A B2 0E
dmidecode: 		86 1E 00 58 10 00 00 00 00 00 00 00 00 00 00 00
dmidecode: 		00 00 00 00 00 03 00 01 02 03
dmidecode: 	Strings:
dmidecode: 		W461KBAJ
dmidecode: 		MM2000GEFRA
dmidecode: 		HPG8
dmidecode: 
dmidecode: Handle 0x0093, DMI type 196, 15 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		C4 0F 93 00 00 00 00 00 00 00 02 01 00 01 02
dmidecode: 
dmidecode: Handle 0x0094, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 94 00 1B 00 FF 01 01 01 00 00 00 01 01 FF
dmidecode: 		FF 00 AD 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0095, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 95 00 1C 00 FF 02 01 02 00 00 00 01 01 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0096, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 96 00 1D 00 FF 03 01 03 00 00 00 02 02 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0097, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 97 00 1E 00 FF 04 01 04 00 00 00 02 02 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0098, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 98 00 1F 00 FF 05 01 05 00 00 00 04 04 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x0099, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 99 00 20 00 FF 06 01 06 00 00 00 04 04 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009A, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9A 00 21 00 FF 07 01 07 00 00 00 03 03 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009B, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9B 00 22 00 FF 08 01 08 00 00 00 03 03 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009C, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9C 00 23 00 FF 09 01 09 00 00 00 07 07 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009D, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9D 00 24 00 FF 0A 01 0A 00 00 00 07 07 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009E, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9E 00 25 00 FF 0B 01 0B 00 00 00 08 08 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x009F, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 9F 00 26 00 FF 0C 01 0C 00 00 00 08 08 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x00A0, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 A0 00 27 00 FF 0D 01 0D 00 00 00 06 06 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x00A1, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 A1 00 28 00 FF 0E 01 0E 00 00 00 06 06 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x00A2, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 A2 00 29 00 FF 0F 01 0F 00 00 00 05 05 FF
dmidecode: 		FF 00 00 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x00A3, DMI type 202, 25 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		CA 19 A3 00 2A 00 FF 10 01 10 00 00 00 05 05 FF
dmidecode: 		FF 00 AD 00 00 00 00 00 00
dmidecode: 
dmidecode: Handle 0x00A4, DMI type 240, 39 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		F0 27 A4 00 81 00 00 00 00 00 01 00 00 00 00 00
dmidecode: 		00 00 00 0B 00 00 00 00 00 00 00 03 00 00 00 00
dmidecode: 		00 00 00 03 00 00 00
dmidecode: 
dmidecode: Handle 0x00A5, DMI type 240, 39 bytes
dmidecode: OEM-specific Type
dmidecode: 	Header and Data:
dmidecode: 		F0 27 A5 00 7B 00 41 00 12 20 01 00 00 08 00 00
dmidecode: 		00 00 00 03 00 00 00 00 00 00 00 03 00 00 00 00
dmidecode: 		00 00 00 03 00 00 00
dmidecode: 	Strings:
dmidecode: 		20.12.41
dmidecode: 
dmidecode: Handle 0x00A6, DMI type 233, 41 bytes
dmidecode: HPE BIOS PXE NIC PCI and MAC Information
dmidecode: 	NIC 1: PCI device 04:00.0, MAC address 20:67:7C:D6:38:98
dmidecode: 
dmidecode: Handle 0x00A7, DMI type 233, 41 bytes
dmidecode: HPE BIOS PXE NIC PCI and MAC Information
dmidecode: 	NIC 2: PCI device 04:00.1, MAC address 20:67:7C:D6:38:99
dmidecode: 
dmidecode: Handle 0x00A8, DMI type 233, 41 bytes
dmidecode: HPE BIOS PXE NIC PCI and MAC Information
dmidecode: 	NIC 3: PCI device 04:00.2, MAC address 20:67:7C:D6:38:9A
dmidecode: 
dmidecode: Handle 0x00A9, DMI type 233, 41 bytes
dmidecode: HPE BIOS PXE NIC PCI and MAC Information
dmidecode: 	NIC 4: PCI device 04:00.3, MAC address 20:67:7C:D6:38:9B
dmidecode: 
dmidecode: Handle 0xFEFF, DMI type 127, 4 bytes
dmidecode: End Of Table
dmidecode: 

-- System Information:
Debian Release: 10.0
  APT prefers stable
  APT policy: (500, 'stable')
Architecture: amd64 (x86_64)

Kernel: Linux 5.0.0-1+reiser4.0.2-amd64 (SMP w/32 CPU cores)
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8), LANGUAGE=en_US.UTF-8 (charmap=UTF-8)
Shell: /bin/sh linked to /usr/bin/dash
Init: systemd (via /run/systemd/system)
