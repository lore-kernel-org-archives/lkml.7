Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C52BC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A74208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 06:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfGMGRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 02:17:43 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbfGMGRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 02:17:43 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C0C1F14EF7478;
        Fri, 12 Jul 2019 23:17:42 -0700 (PDT)
Date:   Fri, 12 Jul 2019 23:17:42 -0700 (PDT)
Message-Id: <20190712.231742.1744524168822613248.davem@davemloft.net>
To:     torvalds@linux-foundation.org
CC:     akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT] Sparc
From:   David Miller <davem@davemloft.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 12 Jul 2019 23:17:43 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just a few small changes:

1) Fix console naming inconsistency with hypervisor consoles, from
   John Paul Adrian Glaubitz

2) Fix userland compilation due to use of u_int, from Masahiro Yamada.

Please pull, thanks a lot.

The following changes since commit 30d1d92a888d03681b927c76a35181b4eed7071f:

  Merge tag 'nds32-for-linux-5.2-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/greentime/linux (2019-06-03 10:23:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git 

for you to fetch changes up to 61daf52c4ddd433924687850fa04ed85c0d806dd:

  sparc64: Add missing newline at end of file (2019-07-09 14:53:57 -0700)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      sparc64: Add missing newline at end of file

John Paul Adrian Glaubitz (1):
      sunhv: Fix device naming inconsistency between sunhv_console and sunhv_reg

Krzysztof Kozlowski (1):
      sparc: configs: Remove useless UEVENT_HELPER_PATH

Masahiro Yamada (1):
      sparc: fix unknown type name u_int in uapi header

Thomas Huth (1):
      sparc: Remove redundant copy of the LGPL-2.0

 arch/sparc/configs/sparc32_defconfig     |   1 -
 arch/sparc/configs/sparc64_defconfig     |   1 -
 arch/sparc/include/uapi/asm/openpromio.h |   3 +-
 arch/sparc/lib/COPYING.LIB               | 481 -----------------------------------------------------------------------------
 arch/sparc/lib/NG4clear_page.S           |   2 +-
 drivers/tty/serial/sunhv.c               |   2 +-
 6 files changed, 3 insertions(+), 487 deletions(-)
 delete mode 100644 arch/sparc/lib/COPYING.LIB
