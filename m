Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D0EC28EB4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B189620866
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GepI+C1a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbfFFPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:40:36 -0400
Received: from mout.gmx.net ([212.227.17.22]:33309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfFFPkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:40:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559835627;
        bh=W4DJzVZu72Pfh/thQ5Y5tNvxS3terSjGRw/QoIuXP64=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=GepI+C1a9Ghez/pCGDA9Vk1VzkKOJ8e1MKxrOXEUu+OIUOfl7SwDprvteWHwLq696
         HTPqw0APmuJNlc+UXpDNFhvPhnkjqcEHQGAef/sTAsrAQhejzX9+yB6hjQzaeaCALR
         N9eEU17YLC9Y6DyUYeDfIz+/lP7z9mFVeYVDs3bo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530 ([193.16.224.33]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1hAlua33gu-00ODC6; Thu, 06
 Jun 2019 17:40:27 +0200
Date:   Thu, 6 Jun 2019 17:40:15 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for kernel v5.2-rc4
Message-ID: <20190606154015.GA13868@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Provags-ID: V03:K1:yEQf42Wwdpx1HEzG+5UQkDqf7lZ8Dh9ng1uv1VbR2OOtzsQ69q9
 H1/R2M+tOY/Dr88cFsFiEnCR1TuJQZl3KglubBrR/7amtOPOZnamY+WM3ZoZ4TGPkArUoCj
 HZqkzsZTGqXWa8bXVy3Vwo67s9DTqEaBG4IXISB9WX5yHID6x5KucfPzl7tMZ9lDvdYscv4
 ZDy/qvvVHfYVwCPVWC6UQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FKH3I0ukLis=:I9IdlG5uHoZykPUAEiU+WR
 onYH4mgxNX+zwtanyk4ZVsfez5+EWoKuOKlDJ4VHtcOwbTOrQb0xIGD0co30GQuMO0ER6kfXc
 s8lBWt2kM6O5r8HimaIlsDKXNj32mL9qXoREP4JChZamXxd25RXUhRVnz7uR9CIUrYUcnDQE+
 7/5slwDMOL6kA+Ar6KSZopAWaBlAVdLLnJyB/wVbhGTjKc77QnYCRNyHzSWpjAKupxVGZgJW0
 hLS8NTZbPnBfA0svWbESgE76JWbjDejkDOkFqNC2Cy0Jo3/0nXPZUT4mtqIjSInpR1MPN3xVK
 sjGX18E7YDvD1zHuAoA7OktuV+B+24Se5ONQIw7UIbL/8lRkXVjAxv/nCfU8c4SpQGpGJ836G
 AtmlHFw2S+BLgKveQscjQfllwiMiGOWXsWZhSFmZ99vDB48Bbigf4wlsPEuznwn8RfRLZ+Zfd
 APOsAn9tRi7wV3H5Latv5kxkASAmCoHc4p4ssxLO1iFiJu2jFnjOT3NH4nBZBQSuRGguUJZe/
 b5oG6dGw0C0kR+1icYzSbfcYCSiUWks4gEhATLYSLUcKggQXWF8Boobdal8vrsCOgSVmC3e6f
 0silvlBQba7aWLNaXLxg7B9lAl5HZcXiQ4VpDK4ozEgUjA39NA3a/6hviRap/V22oE6aJbByC
 +rPynLOapyrz5EuoXt2qPeWU2+AVd4Mk+OEMRPm8wDRydb4+uqgzLc+n1WHtxkcSlHegJ8yin
 Bnfq45z6rSGat37PQ6HvVXnMcA+/XB31nOWzH6yHO4Vqu1Lp3ijbfrWY+w60GJcPfusNlIc+G
 pSqQZZqb6k/+Amh7y1OuejE/rOu1cnAl5JjmTWJU4HKJQTWL1XlmCIUa3Q3AFNU5S0/IZxvfO
 +U/OWBgitQnT8WZCvnHhu0LoJ2ZSNFvvaWf7ZzpRAMDqyjW1zz4rghTgZZMzjMPC5vQwwC4Iv
 DtGhOtWW3nABixfN4SGCa+XtyVLTtX/T0zW8M51pSGNrkv9sssPuc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some additional fixes and cleanups for the parisc architecture from:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-5.2-3

Changes include
- Fix crashes when accessing PCI devices on some machines like C240 and J5000.
  The crashes were triggered because we replaced cache flushes by nops in the
  alternative coding where we shouldn't for some machines.
- Dave fixed a race in the usage of the sr1 space register when used to
  load the coherence index.
- Use the hardware lpa instruction to to load the physical address of kernel
  virtual addresses in the iommu driver code.
- The kernel may fail to link when CONFIG_MLONGCALLS isn't set. Solve that by
  rearranging functions in the final vmlinux executeable.
- Some defconfig cleanups and removal of compiler warnings.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (3):
      parisc: Allow building 64-bit kernel without -mlong-calls compiler option
      parisc: Fix compiler warnings in float emulation code
      parisc: Fix crash due alternative coding for NP iopdir_fdc bit

John David Anglin (2):
      parisc: Use implicit space register selection for loading the coherence index of I/O pdirs
      parisc: Use lpa instruction to load physical addresses in driver code

Krzysztof Kozlowski (1):
      parisc: configs: Remove useless UEVENT_HELPER_PATH

Mike Rapoport (1):
      parisc: Kconfig: remove ARCH_DISCARD_MEMBLOCK

Yury Norov (1):
      parisc/slab: cleanup after /proc/slab_allocators removal

 arch/parisc/Kconfig                         |  4 ++--
 arch/parisc/configs/712_defconfig           |  1 -
 arch/parisc/configs/a500_defconfig          |  1 -
 arch/parisc/configs/b180_defconfig          |  1 -
 arch/parisc/configs/c3000_defconfig         |  1 -
 arch/parisc/configs/c8000_defconfig         |  2 --
 arch/parisc/configs/default_defconfig       |  1 -
 arch/parisc/configs/generic-32bit_defconfig |  1 -
 arch/parisc/include/asm/special_insns.h     | 24 ++++++++++++++++++++++++
 arch/parisc/kernel/alternative.c            |  3 ++-
 arch/parisc/kernel/vmlinux.lds.S            | 21 ++++++++++++++-------
 arch/parisc/math-emu/cnv_float.h            |  8 ++++----
 drivers/parisc/ccio-dma.c                   |  6 ++----
 drivers/parisc/sba_iommu.c                  |  5 ++---
 14 files changed, 50 insertions(+), 29 deletions(-)
