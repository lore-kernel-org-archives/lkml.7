Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE01FC48BE0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E8E208CA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 08:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561104647;
	bh=f4NKWvI5fAT/6uRFhwbTnoIiNTrpJ0Q7Wv3zsGJMj1M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=bI/joPGbr6sPObyFsNTSEoWniG5lAU+SblVgDw/tl/Ey1FZhmfV/sWMGEQ+DYZSxn
	 mSLPf/2Uff3WhSSOlhkbciLTgBtHrFYchWXS+wzP+/+uWI36gm69FgMPT+mXYXacHj
	 /fU2FiZnzfSNrVmi2Dv5mBQGkHFN5+XtOGAmVmbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfFUIKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 04:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfFUIKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 04:10:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C3BC208C3;
        Fri, 21 Jun 2019 08:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561104644;
        bh=f4NKWvI5fAT/6uRFhwbTnoIiNTrpJ0Q7Wv3zsGJMj1M=;
        h=Date:From:To:Cc:Subject:From;
        b=cwa12WZz9UPZ6mqa3uqj1GBo+t7RH/SCYb9iYUFuzpQhghMDTvJVwCFnytGcA2r73
         EHUIOMAYj/yr9sT6l9vhegaXBFf/A2oFvWvy5GC5apLV8DWPaOy5YpURmGwpy+046m
         kmRzK3wQNYhOIDmr4i+XzEFReoJ7LfMW90gSWPLo=
Date:   Fri, 21 Jun 2019 10:10:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.2-rc6
Message-ID: <20190621081042.GA27967@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d1fdb6d8f6a4109a4263176c84b899076a5f8008:

  Linux 5.2-rc4 (2019-06-08 20:24:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.2-rc6

for you to fetch changes up to 6f828c55e26769666e0ae56b037f948dc26fe0d4:

  Merge tag 'misc-habanalabs-fixes-2019-06-20' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus (2019-06-20 13:30:47 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 5.2-rc6

Here are a number of small driver fixes for 5.2-rc6

Nothing major, just fixes for reported issues:
  - soundwire fixes
  - thunderbolt fixes
  - MAINTAINERS update for fpga maintainer change
  - binder bugfix
  - habanalabs 64bit pointer fix
  - documentation updates

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Tull (1):
      MAINTAINERS: fpga: hand off maintainership to Moritz

Arnd Bergmann (1):
      habanalabs: use u64_to_user_ptr() for reading user pointers

Gavin Schenk (1):
      MAINTAINERS / Documentation: Thorsten Scherer is the successor of Gavin Schenk

Greg Kroah-Hartman (3):
      Merge tag 'soundwire-5.2-rc4' of git://git.kernel.org/.../vkoul/soundwire into char-misc-linus
      Merge tag 'thunderbolt-fixes-for-v5.2-rc6' of git://git.kernel.org/.../westeri/thunderbolt into char-misc-linus
      Merge tag 'misc-habanalabs-fixes-2019-06-20' of git://people.freedesktop.org/~gabbayo/linux into char-misc-linus

Mika Westerberg (2):
      thunderbolt: Make sure device runtime resume completes before taking domain lock
      thunderbolt: Implement CIO reset correctly for Titan Ridge

Srinivas Kandagatla (3):
      soundwire: stream: fix out of boundary access on port properties
      soundwire: stream: fix bad unlock balance
      soundwire: intel: set dai min and max channels correctly

Takashi Iwai (1):
      docs: fb: Add TER16x32 to the available font names

Todd Kjos (1):
      binder: fix possible UAF when freeing buffer

Yang Yingliang (1):
      doc: fix documentation about UIO_MEM_LOGICAL using

 Documentation/ABI/testing/sysfs-bus-siox   |  22 ++--
 Documentation/driver-api/uio-howto.rst     |   4 +-
 Documentation/fb/fbcon.txt                 |   2 +-
 MAINTAINERS                                |   3 +-
 drivers/android/binder.c                   |  16 ++-
 drivers/misc/habanalabs/habanalabs_ioctl.c |   2 +-
 drivers/soundwire/intel.c                  |   4 +-
 drivers/soundwire/stream.c                 |   7 +-
 drivers/thunderbolt/icm.c                  | 188 +++++++++++++++++++----------
 drivers/thunderbolt/switch.c               |  45 +++++--
 drivers/thunderbolt/tb.h                   |   7 ++
 11 files changed, 202 insertions(+), 98 deletions(-)
