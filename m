Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818E0C468BD
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B2BB214C6
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 09:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559987907;
	bh=k/mbVdpOfnZ/7eCEEsTZvUZgcOwXfXpbLwfCFOLOB0E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=qYD5kDoX2+KjtANj+5+hvMH08uTraedrJv2Of2upDwKlHlmCHQD9LXJKsD38+DDXg
	 IlZ47glWsPRIOa9nb9bv5BGdOMgslMykyVmhHpOTmx0FfLV5vJVhlZ2MhVopM2dzND
	 dyfX1l5S2uGr9k5PUI6CBwhFytSRhro5OtQVeUJs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfFHJ60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 05:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbfFHJ6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 05:58:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 657092146E;
        Sat,  8 Jun 2019 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559987904;
        bh=k/mbVdpOfnZ/7eCEEsTZvUZgcOwXfXpbLwfCFOLOB0E=;
        h=Date:From:To:Cc:Subject:From;
        b=iJnKoS4xpHyyRk6vpP+XtW+29dwMnYX6jsB/WvR4YpsrPspFf9uNU36HfhivVAtnY
         RxE+h7lo7cxcEyIMM/62XQHseHrOnnMktqtsuGWS5nAVb6ifuWzM7+n8+x3i3JnQTx
         gbnK0nl8CXiJWDNJjHD5f+5jVOOvBSJxEGDvShoA=
Date:   Sat, 8 Jun 2019 11:58:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.2-rc4
Message-ID: <20190608095822.GA27625@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git char-misc-5.2-rc4

for you to fetch changes up to e7bf2ce837475445bfd44ac1193ced0684a70d96:

  Merge tag 'misc-habanalabs-fixes-2019-06-06' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2019-06-06 15:13:22 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.2-rc4

Here are some small char and misc driver fixes for 5.2-rc4 to resolve a
number of reported issues.

The most "notable" one here is the kernel headers in proc^Wsysfs fixes.
Those changes move the header file info into sysfs and fixes the build
issues that you reported.

Other than that, a bunch of small habanalabs driver fixes, some fpga
driver fixes, and a few other tiny driver fixes.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Chengguang Xu (1):
      fpga: dfl: expand minor range when registering chrdev region

Dan Carpenter (2):
      genwqe: Prevent an integer overflow in the ioctl
      test_firmware: Use correct snprintf() limit

Greg Kroah-Hartman (3):
      Merge tag 'lkdtm-next' of https://git.kernel.org/.../kees/linux into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2019-05-24' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2019-06-06' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

Jann Horn (1):
      habanalabs: fix debugfs code

Joel Fernandes (Google) (2):
      kheaders: Move from proc to sysfs
      kheaders: Do not regenerate archive if config is not changed

Kees Cook (2):
      lkdtm/usercopy: Moves the KERNEL_DS test to non-canonical
      lkdtm/bugs: Adjust recursion test to avoid elision

Mariusz Bialonczyk (1):
      w1: ds2408: Fix typo after 49695ac46861 (reset on output_write retry with readback)

Moritz Fischer (1):
      fpga: zynqmp-fpga: Correctly handle error pointer

Oded Gabbay (2):
      uapi/habanalabs: add opcode for enable/disable device debug mode
      habanalabs: fix bug in checking huge page optimization

Omer Shpigelman (1):
      habanalabs: halt debug engines on user process close

Scott Wood (2):
      fpga: dfl: afu: Pass the correct device to dma_mapping_error()
      fpga: dfl: Add lockdep classes for pdata->lock

Tomer Tayar (3):
      habanalabs: Avoid using a non-initialized MMU cache mutex
      habanalabs: Fix virtual address access via debugfs for 2MB pages
      habanalabs: Read upper bits of trace buffer from RWPHI

Wen Yang (1):
      fpga: stratix10-soc: fix use-after-free on s10_init()

YueHaibing (1):
      parport: Fix mem leak in parport_register_dev_model

 drivers/fpga/dfl-afu-dma-region.c             |  2 +-
 drivers/fpga/dfl.c                            | 22 +++++++--
 drivers/fpga/stratix10-soc.c                  |  6 ++-
 drivers/fpga/zynqmp-fpga.c                    |  4 +-
 drivers/misc/genwqe/card_dev.c                |  2 +
 drivers/misc/genwqe/card_utils.c              |  4 ++
 drivers/misc/habanalabs/context.c             |  6 +++
 drivers/misc/habanalabs/debugfs.c             | 65 +++++++++------------------
 drivers/misc/habanalabs/device.c              |  2 +
 drivers/misc/habanalabs/goya/goya.c           |  3 +-
 drivers/misc/habanalabs/goya/goyaP.h          |  1 +
 drivers/misc/habanalabs/goya/goya_coresight.c | 31 ++++++++++++-
 drivers/misc/habanalabs/habanalabs.h          |  2 +
 drivers/misc/habanalabs/memory.c              |  6 ---
 drivers/misc/habanalabs/mmu.c                 |  8 +---
 drivers/misc/lkdtm/bugs.c                     | 23 +++++++---
 drivers/misc/lkdtm/core.c                     |  6 +--
 drivers/misc/lkdtm/lkdtm.h                    |  2 +-
 drivers/misc/lkdtm/usercopy.c                 | 10 +++--
 drivers/parport/share.c                       |  2 +
 drivers/w1/slaves/w1_ds2408.c                 |  2 +-
 include/uapi/misc/habanalabs.h                | 22 ++++++++-
 init/Kconfig                                  | 17 ++++---
 kernel/Makefile                               |  4 +-
 kernel/{gen_ikh_data.sh => gen_kheaders.sh}   | 17 ++++---
 kernel/kheaders.c                             | 40 +++++++----------
 lib/test_firmware.c                           | 14 +++---
 27 files changed, 192 insertions(+), 131 deletions(-)
 rename kernel/{gen_ikh_data.sh => gen_kheaders.sh} (82%)
