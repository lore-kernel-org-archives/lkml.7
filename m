Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AA4C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766B9213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 05:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfCVFYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 01:24:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:45672 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727524AbfCVFXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 01:23:16 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-00015s-JW; Fri, 22 Mar 2019 05:23:13 +0000
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1h7Ce9-0001oB-B5; Fri, 22 Mar 2019 05:23:13 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     torvalds@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>
Date:   Fri, 22 Mar 2019 05:20:17 +0000
Message-ID: <lsq.1553232017.771830163@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 00/16] 3.16.64-rc1 review
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the start of the stable review cycle for the 3.16.64 release.
There are 16 patches in this series, which will be posted as responses
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Mon Mar 25 18:00:00 UTC 2019.
Anything received after that time might be too late.

All the patches have also been committed to the linux-3.16.y-rc branch of
https://git.kernel.org/pub/scm/linux/kernel/git/bwh/linux-stable-rc.git .
A shortlog and diffstat can be found below.

Ben.

-------------

Brian Foster (1):
      xfs: don't BUG() on mixed direct and mapped I/O
         [04197b341f23b908193308b8d63d17ff23232598]

Christoffer Dall (2):
      KVM: PPC: Move xics_debugfs_init out of create
         [023e9fddc3616b005c3753fc1bb6526388cd7a30]
      KVM: Protect device ops->create and list_add with kvm->lock
         [a28ebea2adc4a2bef5989a5a181ec238f59fbcad]

Dan Carpenter (1):
      KVM: use after free in kvm_ioctl_create_device()
         [a0f1d21c1ccb1da66629627a74059dd7f5ac9c61]

Hui Peng (1):
      USB: hso: Fix OOB memory access in hso_probe/hso_get_config_data
         [5146f95df782b0ac61abde36567e718692725c89]

Jann Horn (1):
      kvm: fix kvm_ioctl_create_device() reference counting (CVE-2019-6974)
         [cfa39381173d5f969daf43582c95ad679189cbc9]

Jiri Kosina (1):
      HID: debug: fix error handling in hid_debug_events_read()
         [8fec02a73e31407e14986fca67dab48d4f777f0e]

Kees Cook (1):
      swiotlb: clean up reporting
         [7d63fb3af87aa67aa7d24466e792f9d7c57d8e79]

Oliver Hartkopp (1):
      can: gw: ensure DLC boundaries after CAN frame modification
         [0aaa81377c5a01f686bcdb8c7a6929a7bf330c68]

Paolo Bonzini (1):
      KVM: x86: work around leak of uninitialized stack contents (CVE-2019-7222)
         [353c0956a618a07ba4bbe7ad00ff29fe70e8412a]

Peter Shier (1):
      KVM: nVMX: unconditionally cancel preemption timer in free_nested (CVE-2019-7221)
         [ecec76885bcfe3294685dc363fd1273df0d5d65f]

Rasmus Villemoes (1):
      HID: debug: improve hid_debug_event()
         [92529623d242cea4440958d7bcebdf291f4ab15e]

Rohit Vaswani (1):
      mm: cma: fix incorrect type conversion for size during dma allocation
         [67a2e213e7e937c41c52ab5bc46bf3f4de469f6e]

Vasily Averin (1):
      sunrpc: use-after-free in svc_process_common()
         [d4b09acf924b84bae77cad090a9d108e70b43643]

Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation
         [13054abbaa4f1fd4e6f3b4b63439ec033b4c8035]

Willy Tarreau (1):
      net/appletalk: fix minor pointer leak to userspace in SIOCFINDIPDDPRT
         [9824dfae5741275473a23a7ed5756c7b6efacc9d]

 Makefile                       |   4 +-
 arch/arm/kvm/arm.c             |   9 ++--
 arch/powerpc/kvm/book3s_xics.c |  12 +++--
 arch/x86/kvm/vmx.c             |   1 +
 arch/x86/kvm/x86.c             |   7 +++
 drivers/base/dma-contiguous.c  |   4 +-
 drivers/hid/hid-debug.c        | 119 ++++++++++++++++-------------------------
 drivers/net/appletalk/ipddp.c  |   8 ++-
 drivers/net/usb/hso.c          |  18 ++++++-
 fs/xfs/xfs_aops.c              |  21 +++++++-
 include/linux/dma-contiguous.h |   4 +-
 include/linux/hid-debug.h      |   9 ++--
 include/linux/kvm_host.h       |  12 +++++
 include/linux/sunrpc/svc.h     |   5 +-
 lib/swiotlb.c                  |  18 +++----
 net/can/gw.c                   |  30 +++++++++--
 net/sunrpc/svc.c               |  10 ++--
 net/sunrpc/svc_xprt.c          |   5 +-
 net/sunrpc/svcsock.c           |   2 +-
 virt/kvm/arm/vgic.c            |  11 +---
 virt/kvm/kvm_main.c            |  19 ++++++-
 21 files changed, 202 insertions(+), 126 deletions(-)

-- 
Ben Hutchings
Make three consecutive correct guesses and you will be considered
an expert.

