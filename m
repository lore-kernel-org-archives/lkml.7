Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE11C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6357E2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 16:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570897156;
	bh=qCRTRQxvkK2V3Gin90iarjIfaKv+CaRux0YOEkUjRy8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rFWpmWnUqaL74U4ioRzd77bUo4TAXhQ/v/t2hB5PmGVqXSu+dIhbwwQV9HzLXcyvP
	 3fUA2kbLrk//4lzB+BorjRzLgWGgBfstnzWWR6wYgXwQ57WWd97F4q6CAswvYRdZhl
	 7352WhIeEXiD6WjQ4+GBSvO24YZOMu267tW/h/JY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729482AbfJLQTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 12:19:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbfJLQRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 12:17:14 -0400
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA8921929;
        Sat, 12 Oct 2019 16:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570897033;
        bh=qCRTRQxvkK2V3Gin90iarjIfaKv+CaRux0YOEkUjRy8=;
        h=Date:From:To:Cc:Subject:From;
        b=TQyvD4PYtxBd4gPYzxcnKB9lRtTaQaY7sFHpsV8ALKr4Ut9ZTYUMLL9cHqGiUbWdk
         w0R0PcaMcOZ0HMyIsUISGqJLQcz5PCyYme5ts6nT3QCuQXMjQ1bZ3ok7xqmFQI/eHw
         B0mLn3U8439MOaIfrRssWwg7X+5fEGaKlDv9EDJM=
Date:   Sat, 12 Oct 2019 18:16:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.4-rc3
Message-ID: <20191012161659.GA2191759@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.4-rc3

for you to fetch changes up to 442f1e746e8187b9deb1590176f6b0ff19686b11:

  firmware: google: increment VPD key_len properly (2019-10-11 08:41:34 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.4-rc3.

Here are some small char/misc driver fixes for 5.4-rc3.

Nothing huge here.  Some binder driver fixes (although it is still being
discussed if these all fix the reported issues or not, so more might be
coming later), some mei device ids and fixes, and a google firmware
driver bugfix that fixes a regression, as well as some other tiny fixes.

All have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexander Usyskin (1):
      mei: avoid FW version request on Ibex Peak and earlier

Brian Norris (1):
      firmware: google: increment VPD key_len properly

Christian Brauner (1):
      binder: prevent UAF read in print_binder_transaction_log_entry()

Joel Fernandes (Google) (1):
      binder: Fix comment headers on binder_alloc_prepare_to_free()

Navid Emamdoost (2):
      misc: fastrpc: prevent memory leak in fastrpc_dma_buf_attach
      virt: vbox: fix memory leak in hgcm_call_preprocess_linaddr

Tomas Winkler (1):
      mei: me: add comet point (lake) LP device ids

YueHaibing (1):
      w1: ds250x: Fix build error without CRC16

 drivers/android/binder.c                 |  4 +++-
 drivers/android/binder_alloc.c           |  2 +-
 drivers/android/binder_internal.h        |  2 +-
 drivers/firmware/google/vpd_decode.c     |  2 +-
 drivers/misc/fastrpc.c                   |  1 +
 drivers/misc/mei/bus-fixup.c             | 14 +++++++++++---
 drivers/misc/mei/hw-me-regs.h            |  3 +++
 drivers/misc/mei/hw-me.c                 | 21 ++++++++++++++++++---
 drivers/misc/mei/hw-me.h                 |  8 ++++++--
 drivers/misc/mei/mei_dev.h               |  4 ++++
 drivers/misc/mei/pci-me.c                | 13 ++++++++-----
 drivers/virt/vboxguest/vboxguest_utils.c |  3 ++-
 drivers/w1/slaves/Kconfig                |  1 +
 13 files changed, 60 insertions(+), 18 deletions(-)
