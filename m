Return-Path: <SRS0=snA0=VZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479FAC7618B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1594D2075E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jul 2019 12:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564315320;
	bh=9v+om95SLr/EpX9pJuB6fH1gia/npu2cLUGSeTIWjt8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=N+k5U7eviMvw0I3YIkTUEHkUN6V0qXtNspasem8AXT9/P1c9JtSvpaURgp98TZQKy
	 iDEa3YaeUh5LK2r3Wj4ti4SPM7FJTdsE0Mz8ga4kvtQKdZyzUDd9Rn+x1OsWwkB8Xa
	 WbTxx0GtL9+CzN8bdwklAASA2j2Fd0Wtnc0I72QQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbfG1MB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jul 2019 08:01:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbfG1MB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jul 2019 08:01:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA0D2075E;
        Sun, 28 Jul 2019 12:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564315317;
        bh=9v+om95SLr/EpX9pJuB6fH1gia/npu2cLUGSeTIWjt8=;
        h=Date:From:To:Cc:Subject:From;
        b=lTmZYkg8Du8hN6A7j/ekFh4U481iQmxfRfeD/x+0jHZfxWw4YHqjxFnnmm96Idc5W
         Ncszn2QeniedeucA9r8bPaOCyteEY4Cu4C1HrY98eqt02bSI331mkA8nVADUc0zyo4
         FY5M8RzZygJblPGE56FvF2yDz4q2MHk++dWGVQsE=
Date:   Sun, 28 Jul 2019 14:01:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.3-rc2
Message-ID: <20190728120155.GA16225@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.3-rc2

for you to fetch changes up to d4fddac5a51c378c5d3e68658816c37132611e1f:

  test_firmware: fix a memory leak bug (2019-07-25 14:39:52 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.3-rc2

Here are some small char and misc driver fixes for 5.3-rc2 to resolve
some reported issues.

Nothing major at all, some binder bugfixes for issues found, some new
mei device ids, firmware building warning fixes, habanalabs fixes, a few
other build fixes, and a MAINTAINERS update.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: me: add mule creek canyon (EHL) device ids

Arnd Bergmann (1):
      habanalabs: use %pad for printing a dma_addr_t

Arseny Solokha (1):
      eeprom: make older eeprom drivers select NVMEM_SYSFS

Greg Kroah-Hartman (1):
      Merge tag 'misc-habanalabs-fixes-2019-07-22' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linux

Hridya Valsaraju (1):
      binder: prevent transactions to context manager from its own process.

Kefeng Wang (1):
      hpet: Fix division by zero in hpet_time_div()

Martijn Coenen (1):
      binder: Set end of SG buffer area properly.

Mauro Rossi (1):
      firmware: fix build errors in paged buffer handling code

Nadav Amit (1):
      vmw_balloon: Remove Julien from the maintainers list

Oded Gabbay (1):
      habanalabs: don't reset device when getting VRHOT

Takashi Iwai (1):
      firmware: Fix missing inline

Wenwen Wang (1):
      test_firmware: fix a memory leak bug

YueHaibing (1):
      fpga-manager: altera-ps-spi: Fix build error

 MAINTAINERS                             | 1 -
 drivers/android/binder.c                | 5 +++--
 drivers/base/firmware_loader/firmware.h | 4 ++--
 drivers/char/hpet.c                     | 3 +--
 drivers/fpga/Kconfig                    | 1 +
 drivers/misc/eeprom/Kconfig             | 3 +++
 drivers/misc/habanalabs/goya/goya.c     | 6 +++---
 drivers/misc/mei/hw-me-regs.h           | 3 +++
 drivers/misc/mei/pci-me.c               | 3 +++
 lib/test_firmware.c                     | 5 ++++-
 10 files changed, 23 insertions(+), 11 deletions(-)
