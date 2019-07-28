Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3742EC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109332087C
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564315268;
	bh=IkiXFp33t3tuAUh2KqevsXfdlcxZnX77wmgtAShp/c8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=NO4bhX2hXapK24681ZMrLrTtxBuiavh0UlY6ExozJNGJdxbLwjr+BGQPihc+P48Mo
	 HMP2HPiCYw/0XNLe88IQOajCfGCe3t8I+F6eXJ0qcXnuT/DHeTjRNZgCOmZdS0XX7n
	 skqOiihl9tgb/qQGTj95lMQEhQYCMjRXEhXnoIXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfG1MBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 08:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725983AbfG1MBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 08:01:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC912075E;
        Sun, 28 Jul 2019 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564315265;
        bh=IkiXFp33t3tuAUh2KqevsXfdlcxZnX77wmgtAShp/c8=;
        h=Date:From:To:Cc:Subject:From;
        b=Dor+T93UJL6+17aaMYTFM8EzXQ+2XXSD3inNSX7IVnxOHA3rZAhqK1HhCpEavPHjg
         19FpF3NcDYnkVQOXEcD/ZMNqv5uWvIfkcvrmWyTFzfY8vS4ww4Qg6TsZJxpt4gfC0r
         9ldnqXPZDHTUkxQS3jeapNT8GRzhAzPRSsFcS2Cs=
Date:   Sun, 28 Jul 2019 14:01:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-spdx@vger.kernel.org
Subject: [GIT PULL] SPDX fixes for 5.3-rc2
Message-ID: <20190728120102.GA16018@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-5.3-rc2

for you to fetch changes up to 0ce38c5f929c83dff8ea805f6c6ef2eb97b66431:

  iomap: fix Invalid License ID (2019-07-25 11:05:11 +0200)

----------------------------------------------------------------
SPDX fixes for 5.3-rc2

Here are some small SPDX fixes for 5.3-rc2 for things that came in
during the 5.3-rc1 merge window that we previously missed.

Only 3 small patches here:
	- 2 uapi patches to resolve some SPDX tags that were not correct
	- fix an invalid SPDX tag in the iomap Makefile file

All have been properly reviewed on the public mailing lists.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Masahiro Yamada (3):
      treewide: add "WITH Linux-syscall-note" to SPDX tag of uapi headers
      treewide: remove SPDX "WITH Linux-syscall-note" from kernel-space headers again
      iomap: fix Invalid License ID

 arch/arm64/include/uapi/asm/bpf_perf_event.h   | 2 +-
 arch/csky/include/uapi/asm/byteorder.h         | 2 +-
 arch/csky/include/uapi/asm/cachectl.h          | 2 +-
 arch/csky/include/uapi/asm/perf_regs.h         | 2 +-
 arch/csky/include/uapi/asm/ptrace.h            | 2 +-
 arch/csky/include/uapi/asm/sigcontext.h        | 2 +-
 arch/csky/include/uapi/asm/unistd.h            | 2 +-
 arch/nds32/include/uapi/asm/auxvec.h           | 2 +-
 arch/nds32/include/uapi/asm/byteorder.h        | 2 +-
 arch/nds32/include/uapi/asm/cachectl.h         | 2 +-
 arch/nds32/include/uapi/asm/fp_udfiex_crtl.h   | 2 +-
 arch/nds32/include/uapi/asm/param.h            | 2 +-
 arch/nds32/include/uapi/asm/ptrace.h           | 2 +-
 arch/nds32/include/uapi/asm/sigcontext.h       | 2 +-
 arch/nds32/include/uapi/asm/unistd.h           | 2 +-
 arch/powerpc/include/uapi/asm/bpf_perf_event.h | 2 +-
 arch/riscv/include/uapi/asm/auxvec.h           | 2 +-
 arch/riscv/include/uapi/asm/bitsperlong.h      | 2 +-
 arch/riscv/include/uapi/asm/byteorder.h        | 2 +-
 arch/riscv/include/uapi/asm/hwcap.h            | 2 +-
 arch/riscv/include/uapi/asm/ptrace.h           | 2 +-
 arch/riscv/include/uapi/asm/sigcontext.h       | 2 +-
 arch/riscv/include/uapi/asm/ucontext.h         | 2 +-
 arch/s390/include/uapi/asm/bpf_perf_event.h    | 2 +-
 arch/s390/include/uapi/asm/ipl.h               | 2 +-
 arch/sh/include/uapi/asm/setup.h               | 2 +-
 arch/sh/include/uapi/asm/types.h               | 2 +-
 arch/sparc/include/uapi/asm/oradax.h           | 2 +-
 arch/x86/include/uapi/asm/byteorder.h          | 2 +-
 arch/x86/include/uapi/asm/hwcap2.h             | 2 +-
 arch/x86/include/uapi/asm/sigcontext32.h       | 2 +-
 arch/x86/include/uapi/asm/types.h              | 2 +-
 fs/iomap/Makefile                              | 2 +-
 include/sound/sof/control.h                    | 2 +-
 include/sound/sof/dai-intel.h                  | 2 +-
 include/sound/sof/dai.h                        | 2 +-
 include/sound/sof/header.h                     | 2 +-
 include/sound/sof/info.h                       | 2 +-
 include/sound/sof/pm.h                         | 2 +-
 include/sound/sof/stream.h                     | 2 +-
 include/sound/sof/topology.h                   | 2 +-
 include/sound/sof/trace.h                      | 2 +-
 include/sound/sof/xtensa.h                     | 2 +-
 include/uapi/linux/bpfilter.h                  | 2 +-
 include/uapi/linux/ipmi_bmc.h                  | 2 +-
 include/uapi/linux/isst_if.h                   | 2 +-
 include/uapi/linux/netfilter/nf_synproxy.h     | 2 +-
 include/uapi/linux/psp-sev.h                   | 2 +-
 include/uapi/linux/rxrpc.h                     | 2 +-
 include/uapi/linux/usb/g_uvc.h                 | 2 +-
 include/uapi/linux/vbox_vmmdev_types.h         | 2 +-
 include/uapi/linux/vboxguest.h                 | 2 +-
 include/uapi/linux/virtio_pmem.h               | 2 +-
 include/uapi/linux/vmcore.h                    | 2 +-
 include/uapi/linux/wmi.h                       | 2 +-
 include/uapi/misc/fastrpc.h                    | 2 +-
 include/uapi/rdma/rvt-abi.h                    | 2 +-
 include/uapi/rdma/siw-abi.h                    | 2 +-
 include/uapi/scsi/scsi_bsg_ufs.h               | 2 +-
 include/uapi/sound/skl-tplg-interface.h        | 2 +-
 samples/vfio-mdev/mdpy-defs.h                  | 2 +-
 61 files changed, 61 insertions(+), 61 deletions(-)
