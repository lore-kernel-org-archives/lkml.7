Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE88CC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFBD42086A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 20:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Ij7GSTo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbfENUAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 16:00:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:59827 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbfENUAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 16:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557864013;
        bh=bBVPIeW9h6+e+mzsT2HWrvVpTPQzQa376JM0zCoFzvE=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=Ij7GSTo4LiDugIb+e6lX70JqLVKSr3L2huFeZXwV6d5HytvcgraAOuLurXFq3xe92
         L1IBk37kKJQU1VMJgeX7NojKmgl4oXgjFsjUWUT/WJfHJ6+18BSz6+6BkkERBC5DfL
         tFWMM3G2WkvmJdz3+yyfCQrxYRU8JjB4RhutYOa8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.dellerweb.de ([92.116.143.159]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MStCY-1hGHBb0D9C-00UI6u; Tue, 14 May 2019 22:00:13 +0200
Date:   Tue, 14 May 2019 22:00:10 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture updates for kernel v5.2
Message-ID: <20190514200010.GA30418@ls3530.dellerweb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:QnTdOC86F13F8u1fEucfi7hAt872mtcWwGDUKecrmCHHRujGr9S
 i+dq2COyBg7fYFZ5AvcmgoHKRjv5HWwQt8dHY4avf3M0h9ara8bRcwhKGc2CdQ8S3gsDM7l
 1zYsG+1m2y3gbbu4UwDrQtri3MBzgYPaGuNWUz01O9QKtzmpG+fT5NfSbEOsZWPddQ0P9BI
 FeRlx/xC0ct1RxWOrk5Eg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IVwLoV9QTMk=:ZsgecqLPsA0p1tWXQJ9TV7
 6Z9Q9QEv3WPAg6C4XqjJna8HcjFDIi3L0tGkSM4qzekhes7bZoX6DU7CWwT8GCB/U475BWyku
 WOwqug6L3nHw9MxFnqm+gPwygkAKF4e+O8nd5Fo57Vd6M7VZ99JeZ0dqlIoyKdILeTfXhxDla
 8WUZGBgJV49JxKjzaN2rv2+3r4yNjCx/gCJxOl0pLjGHQVArimljlg6GSoNzx/2Ab+qv8nutO
 PpPfvDsNfJdDx0P5S48g6Z7lwN2G4ohqcm6xwdRKptShW1uMxkHTvD+3l92KkxB/nyx14wtsB
 xHpjqoa1FK7UCWOd9M9D3hcWt7N78ZyafHA2i2iGfBL0TsQAaR/+sA6yfTym8Q97WfNJrF32P
 j5t351OcbxFlDTLWaRFL2xh9AqpHHL9e5YfYfv9j/aJzDlJeARPi4yNWd3ipvRRjpD44yl0GR
 vsXr4tZbOj9Hd0KjYqFv8ZA2b8czZNJSX8F9vfA17KpEuwqu99WhPCOUxEI9YcSR/Wsmp+a9r
 jSxyoVHSowYK/cW8dEyu0kbQTQ6lNiBGP9eL425f3wMRmwW++U4tQra4WB6W6MIqVu3oOaAqs
 ZlhdaOxMpTDwjTXLrpdrGYhxSUpq3EPa962+EyUS2lwCSjK6QIjWf6+oCkMGYdzWJwJakybdc
 I1tVYUD6njNMVq+qudTZxXVHlRFe1IwJRR+giPEFanIqFBBUNRQKTcWkEbpy1JnB5Sfg/p7RE
 b7uNt9OjgAQnKppCfhu2ZNiMI6rHAqzdpct3r1GsNNTf9loj+y9WZwA7P7DyW4+BOgqEHST8W
 fiJx+J2JRb+lYXp0G/OyT25JB7d+9bcKhj/609/1E5zeXKvt47P8UgsAS9BWMbAijXbIYcJcP
 sg74dX6IgXES8MOjaXSTT0JSb7Vo6bqr8PvBHdmiV+SwissIYnwSC2HWIBMNLw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two small additional enhancements for this merge window for the
parisc architecture for kernel 5.2 from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-2

Two small enhancements, which I didn't included in the last pull request
because I wanted to keep them a few more days in for-next before sending
upstream:

- Replace the ldcw barrier instruction by a nop instruction in the CAS code on
  uniprocessor machines.

- Map variables read-only after init (enable ro_after_init feature).

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (14):
      parisc: Drop LDCW barrier in CAS code when running UP
      parisc: Enable the ro_after_init feature
      parisc: Use __ro_after_init in cache.c
      parisc: Use __ro_after_init in drivers.c
      parisc: Use __ro_after_init in firmware.c
      parisc: Use __ro_after_init in head.S
      parisc: Use __ro_after_init in inventory.c
      parisc: Use __ro_after_init in pci.c
      parisc: Use __ro_after_init in perf_images.h
      parisc: Use __ro_after_init in process.c
      parisc: Use __ro_after_init in processor.c
      parisc: Use __ro_after_init in time.c
      parisc: Use __ro_after_init in unwind.c
      parisc: Use __ro_after_init in init.c

 arch/parisc/include/asm/cache.h  |  3 --
 arch/parisc/kernel/cache.c       | 16 ++++-----
 arch/parisc/kernel/drivers.c     |  2 +-
 arch/parisc/kernel/firmware.c    |  2 +-
 arch/parisc/kernel/head.S        |  2 +-
 arch/parisc/kernel/inventory.c   |  8 ++---
 arch/parisc/kernel/pci.c         |  8 ++---
 arch/parisc/kernel/perf_images.h |  4 +--
 arch/parisc/kernel/process.c     |  2 +-
 arch/parisc/kernel/processor.c   |  4 +--
 arch/parisc/kernel/syscall.S     | 12 ++++---
 arch/parisc/kernel/time.c        |  2 +-
 arch/parisc/kernel/unwind.c      |  2 +-
 arch/parisc/kernel/vmlinux.lds.S |  3 --
 arch/parisc/mm/init.c            | 75 +++++++++++++++++++++-------------------
 15 files changed, 73 insertions(+), 72 deletions(-)
