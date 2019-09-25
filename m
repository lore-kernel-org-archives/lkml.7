Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB3FC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F3F21D7A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 19:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392392AbfIYThu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 15:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:38086 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728595AbfIYTht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 15:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 54FABB033;
        Wed, 25 Sep 2019 19:37:45 +0000 (UTC)
Message-ID: <1569439345.3084.5.camel@suse.com>
Subject: 4f5368b5541a902f6596558b05f5c21a9770dd32 causes regression
From:   Oliver Neukum <oneukum@suse.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, sndirsch@suse.com,
        tzimmermann@suse.com
Date:   Wed, 25 Sep 2019 21:22:25 +0200
Content-Type: multipart/mixed; boundary="=-FIPGJBRkLGTjzbVBxAPV"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-FIPGJBRkLGTjzbVBxAPV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi,

I am seeing a hard lockup during boot with this patch.
I am using only the laptop's internal display.
The last message I see is:

kvm: disabled by BIOS

	Regards
		Oliver

devices are:

00:00.0 Host bridge [0600]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor Host Bridge/DRAM Registers [8086:1910] (rev 07)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0
        Capabilities: [e0] Vendor Specific Information: Len=10 <?>
        Kernel driver in use: skl_uncore

00:01.0 PCI bridge [0604]: Intel Corporation Xeon E3-1200 v5/E3-1500 v5/6th Gen Core Processor PCIe Controller (x16) [8086:1901] (rev 07) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 120
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00003000-00003fff [size=4K]
        Memory behind bridge: dc000000-dc0fffff [size=1M]
        Prefetchable memory behind bridge: 0000000040000000-000000004fffffff [size=256M]
        Capabilities: [88] Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [a0] Express Root Port (Slot+), MSI 00
        Capabilities: [100] Virtual Channel
        Capabilities: [140] Root Complex Link
        Capabilities: [d94] #19
        Kernel driver in use: pcieport

00:02.0 VGA compatible controller [0300]: Intel Corporation HD Graphics 530 [8086:191b] (rev 06) (prog-if 00 [VGA controller])
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0, IRQ 130
        Memory at db000000 (64-bit, non-prefetchable) [size=16M]
        Memory at 50000000 (64-bit, prefetchable) [size=256M]
        I/O ports at 6000 [size=64]
        [virtual] Expansion ROM at 000c0000 [disabled] [size=128K]
        Capabilities: [40] Vendor Specific Information: Len=0c <?>
        Capabilities: [70] Express Root Complex Integrated Endpoint, MSI 00
        Capabilities: [ac] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [d0] Power Management version 2
        Capabilities: [100] Process Address Space ID (PASID)
        Capabilities: [200] Address Translation Service (ATS)
        Capabilities: [300] Page Request Interface (PRI)
        Kernel driver in use: i915
        Kernel modules: i915
                                                                                                                                                                                                                                                                               
00:14.0 USB controller [0c03]: Intel Corporation Sunrise Point-H USB 3.0 xHCI Controller [8086:a12f] (rev 31) (prog-if 30 [XHCI])                                                                                                                                              
        Subsystem: Hewlett-Packard Company Device [103c:80d5]                                                                                                                                                                                                                  
        Flags: bus master, medium devsel, latency 0, IRQ 125                                                                                                                                                                                                                   
        Memory at dc320000 (64-bit, non-prefetchable) [size=64K]                                                                                                                                                                                                               
        Capabilities: [70] Power Management version 2                                                                                                                                                                                                                          
        Capabilities: [80] MSI: Enable+ Count=1/8 Maskable- 64bit+                                                                                                                                                                                                             
        Kernel driver in use: xhci_hcd                                                                                                                                                                                                                                         
        Kernel modules: xhci_pci                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                               
00:14.2 Signal processing controller [1180]: Intel Corporation Sunrise Point-H Thermal subsystem [8086:a131] (rev 31)                                                                                                                                                          
        Subsystem: Hewlett-Packard Company Device [103c:80d5]                                                                                                                                                                                                                  
        Flags: fast devsel, IRQ 18                                                                                                                                                                                                                                             
        Memory at dc34a000 (64-bit, non-prefetchable) [size=4K]                                                                                                                                                                                                                
        Capabilities: [50] Power Management version 3                                                                                                                                                                                                                          
        Capabilities: [80] MSI: Enable- Count=1/1 Maskable- 64bit-                                                                                                                                                                                                             
        Kernel driver in use: intel_pch_thermal                                                                                                                                                                                                                                
        Kernel modules: intel_pch_thermal                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                               
00:16.0 Communication controller [0780]: Intel Corporation Sunrise Point-H CSME HECI #1 [8086:a13a] (rev 31)                                                                                                                                                                   
        Subsystem: Hewlett-Packard Company Device [103c:80d5]                                                                                                                                                                                                                  
        Flags: bus master, fast devsel, latency 0, IRQ 126                                                                                                                                                                                                                     
        Memory at dc34b000 (64-bit, non-prefetchable) [size=4K]                                                                                                                                                                                                                
        Capabilities: [50] Power Management version 3                                                                                                                                                                                                                          
        Capabilities: [8c] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: mei_me
        Kernel modules: mei_me

00:17.0 SATA controller [0106]: Intel Corporation Sunrise Point-H SATA controller [AHCI mode] [8086:a102] (rev 31) (prog-if 01 [AHCI 1.0])
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 124
        Memory at dc348000 (32-bit, non-prefetchable) [size=8K]
        Memory at dc34e000 (32-bit, non-prefetchable) [size=256]
        I/O ports at 6080 [size=8]
        I/O ports at 6088 [size=4]
        I/O ports at 6040 [size=32]
        Memory at dc34c000 (32-bit, non-prefetchable) [size=2K]
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [70] Power Management version 3
        Capabilities: [a8] SATA HBA v1.0
        Kernel driver in use: ahci
        Kernel modules: ahci

00:1c.0 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #1 [8086:a110] (rev f1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 121
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: None
        Memory behind bridge: dc100000-dc1fffff [size=1M]
        Prefetchable memory behind bridge: None
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [200] L1 PM Substates
        Kernel driver in use: pcieport

00:1c.1 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #2 [8086:a111] (rev f1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 122
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=0
        I/O behind bridge: 00004000-00005fff [size=8K]
        Memory behind bridge: dc200000-dc2fffff [size=1M]
        Prefetchable memory behind bridge: 000000003e900000-000000003eafffff [size=2M]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [200] L1 PM Substates
        Capabilities: [220] #19
        Kernel driver in use: pcieport

00:1c.4 PCI bridge [0604]: Intel Corporation Sunrise Point-H PCI Express Root Port #5 [8086:a114] (rev f1) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 123
        Bus: primary=00, secondary=04, subordinate=6e, sec-latency=0
        I/O behind bridge: 00007000-00007fff [size=4K]
        Memory behind bridge: ac000000-da0fffff [size=737M]
        Prefetchable memory behind bridge: 0000000060000000-00000000a9ffffff [size=1184M]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Capabilities: [a0] Power Management version 3
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Access Control Services
        Capabilities: [220] #19
        Kernel driver in use: pcieport

00:1f.0 ISA bridge [0601]: Intel Corporation Sunrise Point-H LPC Controller [8086:a150] (rev 31)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0

00:1f.2 Memory controller [0580]: Intel Corporation Sunrise Point-H PMC [8086:a121] (rev 31)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: fast devsel
        Memory at dc340000 (32-bit, non-prefetchable) [disabled] [size=16K]

00:1f.3 Audio device [0403]: Intel Corporation Sunrise Point-H HD Audio [8086:a170] (rev 31) (prog-if 80)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 64, IRQ 132
        Memory at dc344000 (64-bit, non-prefetchable) [size=16K]
        Memory at dc330000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [50] Power Management version 3
        Capabilities: [60] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

00:1f.4 SMBus [0c05]: Intel Corporation Sunrise Point-H SMBus [8086:a123] (rev 31)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: medium devsel, IRQ 16
        Memory at dc34d000 (64-bit, non-prefetchable) [size=256]
        I/O ports at efa0 [size=32]
        Kernel driver in use: i801_smbus
        Kernel modules: i2c_i801

00:1f.6 Ethernet controller [0200]: Intel Corporation Ethernet Connection (2) I219-LM [8086:15b7] (rev 31)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0, IRQ 127
        Memory at dc300000 (32-bit, non-prefetchable) [size=128K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [e0] PCI Advanced Features
        Kernel driver in use: e1000e
        Kernel modules: e1000e

01:00.0 VGA compatible controller [0300]: Advanced Micro Devices, Inc. [AMD/ATI] Venus XTX [Radeon HD 8890M / R9 M275X/M375X] [1002:6820] (rev 83) (prog-if 00 [VGA controller])
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0, IRQ 131
        Memory at 40000000 (64-bit, prefetchable) [size=256M]
        Memory at dc000000 (64-bit, non-prefetchable) [size=256K]
        I/O ports at 3000 [size=256]
        Expansion ROM at dc060000 [disabled] [size=128K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Legacy Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [150] Advanced Error Reporting
        Capabilities: [270] #19
        Kernel driver in use: radeon
        Kernel modules: radeon, amdgpu

01:00.1 Audio device [0403]: Advanced Micro Devices, Inc. [AMD/ATI] Cape Verde/Pitcairn HDMI Audio [Radeon HD 7700/7800 Series] [1002:aab0]
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: bus master, fast devsel, latency 0, IRQ 129
        Memory at dc040000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [48] Vendor Specific Information: Len=08 <?>
        Capabilities: [50] Power Management version 3
        Capabilities: [58] Express Legacy Endpoint, MSI 00
        Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [100] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
        Capabilities: [150] Advanced Error Reporting
        Kernel driver in use: snd_hda_intel
        Kernel modules: snd_hda_intel

02:00.0 Network controller [0280]: Intel Corporation Wireless 8260 [8086:24f3] (rev 2a)
        Subsystem: Intel Corporation Dual Band Wireless-AC 8260 [8086:0010]
        Flags: bus master, fast devsel, latency 0, IRQ 128
        Memory at dc100000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [c8] Power Management version 3
        Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [40] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 34-13-e8-ff-ff-36-80-58
        Capabilities: [14c] Latency Tolerance Reporting
        Capabilities: [154] L1 PM Substates
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

03:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS525A PCI Express Card Reader [10ec:525a] (rev 01)
        Subsystem: Hewlett-Packard Company Device [103c:80d5]
        Flags: fast devsel, IRQ 255
        Memory at dc200000 (32-bit, non-prefetchable) [disabled] [size=4K]
        Capabilities: [80] Power Management version 3
        Capabilities: [90] MSI: Enable- Count=1/1 Maskable- 64bit+
        Capabilities: [b0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-00-00-01-00-4c-e0-00
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
--=-FIPGJBRkLGTjzbVBxAPV
Content-Disposition: attachment; filename="gfx_hang_bisect_log.txt"
Content-Type: text/plain; name="gfx_hang_bisect_log.txt"; charset="UTF-8"
Content-Transfer-Encoding: base64

Z2l0IGJpc2VjdCBzdGFydAojIGJhZDogWzllZWRlMjA3ZGQ1OWZjOGE2NzZkYjVlNjlmNjc3Mjgz
MTI2ZDczMzNdIE1lcmdlIGJyYW5jaCAnbWFzdGVyJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9w
dWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvZ3JlZ2toL3VzYgpnaXQgYmlzZWN0IGJhZCA5ZWVkZTIw
N2RkNTlmYzhhNjc2ZGI1ZTY5ZjY3NzI4MzEyNmQ3MzMzCiMgZ29vZDogW2E1NWFhODlhYWI5MGZh
ZTdjODE1YjA1NTFiMDdiZTM3ZGIzNTlkNzZdIExpbnV4IDUuMy1yYzYKZ2l0IGJpc2VjdCBnb29k
IGE1NWFhODlhYWI5MGZhZTdjODE1YjA1NTFiMDdiZTM3ZGIzNTlkNzYKIyBnb29kOiBbOGI1M2M3
NjUzM2FhNDM1NjYwMmFlYTk4Zjk4YTJmM2I0MDUxNDY0Y10gTWVyZ2UgYnJhbmNoICdsaW51cycg
b2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2hlcmJlcnQv
Y3J5cHRvLTIuNgpnaXQgYmlzZWN0IGdvb2QgOGI1M2M3NjUzM2FhNDM1NjYwMmFlYTk4Zjk4YTJm
M2I0MDUxNDY0YwojIGdvb2Q6IFs4YjUzYzc2NTMzYWE0MzU2NjAyYWVhOThmOThhMmYzYjQwNTE0
NjRjXSBNZXJnZSBicmFuY2ggJ2xpbnVzJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvaGVyYmVydC9jcnlwdG8tMi42CmdpdCBiaXNlY3QgZ29vZCA4YjUz
Yzc2NTMzYWE0MzU2NjAyYWVhOThmOThhMmYzYjQwNTE0NjRjCiMgZ29vZDogWzNjMmVkYzM2YTc3
NDIwZDhiZTA1ZDY1NjAxOWRiYzhjMzE1MzU5OTJdIE1lcmdlIHRhZyAncGluY3RybC12NS40LTEn
IG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9saW51c3cv
bGludXgtcGluY3RybApnaXQgYmlzZWN0IGdvb2QgM2MyZWRjMzZhNzc0MjBkOGJlMDVkNjU2MDE5
ZGJjOGMzMTUzNTk5MgojIGJhZDogWzU3NGNjNDUzOTc2MjU2MWQ5NmI0NTZkYmMwNTQ0ZDg4OThi
ZDRjNmVdIE1lcmdlIHRhZyAnZHJtLW5leHQtMjAxOS0wOS0xOCcgb2YgZ2l0Oi8vYW5vbmdpdC5m
cmVlZGVza3RvcC5vcmcvZHJtL2RybQpnaXQgYmlzZWN0IGJhZCA1NzRjYzQ1Mzk3NjI1NjFkOTZi
NDU2ZGJjMDU0NGQ4ODk4YmQ0YzZlCiMgYmFkOiBbNTc0Y2M0NTM5NzYyNTYxZDk2YjQ1NmRiYzA1
NDRkODg5OGJkNGM2ZV0gTWVyZ2UgdGFnICdkcm0tbmV4dC0yMDE5LTA5LTE4JyBvZiBnaXQ6Ly9h
bm9uZ2l0LmZyZWVkZXNrdG9wLm9yZy9kcm0vZHJtCmdpdCBiaXNlY3QgYmFkIDU3NGNjNDUzOTc2
MjU2MWQ5NmI0NTZkYmMwNTQ0ZDg4OThiZDRjNmUKIyBiYWQ6IFtlN2Y3Mjg3YmY1Zjc0NmQyOWYz
NjA3MTc4ODUxMjQ2YTAwNWRkMzk4XSBNZXJnZSB0YWcgJ2RybS1uZXh0LTUuNC0yMDE5LTA4LTA5
JyBvZiBnaXQ6Ly9wZW9wbGUuZnJlZWRlc2t0b3Aub3JnL35hZ2Q1Zi9saW51eCBpbnRvIGRybS1u
ZXh0CmdpdCBiaXNlY3QgYmFkIGU3ZjcyODdiZjVmNzQ2ZDI5ZjM2MDcxNzg4NTEyNDZhMDA1ZGQz
OTgKIyBiYWQ6IFtiMDM4M2MwNjUzYzRiZDJkMjczMmM1NzY3ZWM4ZmEyMjNiM2Q2ZWZkXSBNZXJn
ZSB0YWcgJ2RybS1taXNjLW5leHQtMjAxOS0wOC0wOCcgb2YgZ2l0Oi8vYW5vbmdpdC5mcmVlZGVz
a3RvcC5vcmcvZHJtL2RybS1taXNjIGludG8gZHJtLW5leHQKZ2l0IGJpc2VjdCBiYWQgYjAzODNj
MDY1M2M0YmQyZDI3MzJjNTc2N2VjOGZhMjIzYjNkNmVmZAojIGJhZDogWzU0ZmMwMWI3NzVmZTM1
ZmEwODg5Y2IzMzQ0ZWQ5OGM3MmE1MmQyYzFdIFJldmVydCAiZHJtL3ZnZW06IGRyb3AgRFJNX0FV
VEggdXNhZ2UgZnJvbSB0aGUgZHJpdmVyIgpnaXQgYmlzZWN0IGJhZCA1NGZjMDFiNzc1ZmUzNWZh
MDg4OWNiMzM0NGVkOThjNzJhNTJkMmMxCiMgYmFkOiBbOTEzMjhlYmU0ZjZmMTJlYWE3NzU0YjRh
YzAxYjMwOGNmNjg1MzhkMF0gZHJtL3R2ZTIwMDogZHJvcCB1c2Ugb2YgZHJtUC5oCmdpdCBiaXNl
Y3QgYmFkIDkxMzI4ZWJlNGY2ZjEyZWFhNzc1NGI0YWMwMWIzMDhjZjY4NTM4ZDAKIyBnb29kOiBb
ODgyMDlkMmM1MDM1NzM3Zjk2YmNmYzJmZDczYzBmZDhkODBlOWJmMV0gZHJtL21zbTogZHJvcCBE
Uk1fQVVUSCB1c2FnZSBmcm9tIHRoZSBkcml2ZXIKZ2l0IGJpc2VjdCBnb29kIDg4MjA5ZDJjNTAz
NTczN2Y5NmJjZmMyZmQ3M2MwZmQ4ZDgwZTliZjEKIyBnb29kOiBbZmRiZGNjODNmZmQ3ZDAwMjY1
YTUzMWU3MWYxZDE2NjU2NmMwOWQ2Nl0gZHJtL2JyaWRnZTogZHctaGRtaTogVXNlIGF1dG9tYXRp
YyBDVFMgZ2VuZXJhdGlvbiBtb2RlIHdoZW4gdXNpbmcgbm9uLUFIQiBhdWRpbwpnaXQgYmlzZWN0
IGdvb2QgZmRiZGNjODNmZmQ3ZDAwMjY1YTUzMWU3MWYxZDE2NjU2NmMwOWQ2NgojIGdvb2Q6IFti
NGVlZmE2OWI2MzU2NGYyYzZjNzY0ZmVkZjhjOTA0ZjJhZjgwMWRhXSBkdC1iaW5kaW5nczogZGlz
cGxheTogQ29udmVydCBpbm5vbHV4LGVlMTAxaWEtMDEgcGFuZWwgdG8gRFQgc2NoZW1hCmdpdCBi
aXNlY3QgZ29vZCBiNGVlZmE2OWI2MzU2NGYyYzZjNzY0ZmVkZjhjOTA0ZjJhZjgwMWRhCiMgZ29v
ZDogW2QwMDZhOWI2M2Q0YmJiM2ViMWUyZTYxNjcxMmQ0NWFjZmNkYTcwNDJdIGRybS9jbGllbnQ6
IHJlbW92ZSB0aGUgZXhwb3J0aW5nIG9mIGRybV9jbGllbnRfY2xvc2UKZ2l0IGJpc2VjdCBnb29k
IGQwMDZhOWI2M2Q0YmJiM2ViMWUyZTYxNjcxMmQ0NWFjZmNkYTcwNDIKIyBiYWQ6IFszNzRiZjgy
NWU3YTA3YjZhZTYxYThhODM5YzBlYTE4NGE3NjY1MjY3XSBkcm0vcGFuZWw6IHNpbXBsZTogVXNl
IGRpc3BsYXlfdGltaW5nIGZvciBBVU8gYjEwMWVhbjAxCmdpdCBiaXNlY3QgYmFkIDM3NGJmODI1
ZTdhMDdiNmFlNjFhOGE4MzljMGVhMTg0YTc2NjUyNjcKIyBiYWQ6IFthNGU3ZTk4ZTkwZWJkOWE4
MDFkNmEzODNlMWVkZDEwYjA5ZDE1NWJhXSBkcm0vdmttczogUmVuYW1lIHZrbXNfY3JjLmMgaW50
byB2a21zX2NvbXBvc2VyLmMKZ2l0IGJpc2VjdCBiYWQgYTRlN2U5OGU5MGViZDlhODAxZDZhMzgz
ZTFlZGQxMGIwOWQxNTViYQojIGJhZDogW2U5ZDg1ZjczMWRlMDZhMzVkMmFlNmNkY2Y3ZDBlMDM3
Yzk4ZWY0MWFdIGRybS92a21zOiBBdm9pZCBhc3NpZ25pbmcgMCBmb3IgcG9zc2libGVfY3J0Ywpn
aXQgYmlzZWN0IGJhZCBlOWQ4NWY3MzFkZTA2YTM1ZDJhZTZjZGNmN2QwZTAzN2M5OGVmNDFhCg==


--=-FIPGJBRkLGTjzbVBxAPV--

