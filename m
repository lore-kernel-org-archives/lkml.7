Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87ECAC04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6232A21019
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 21:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbfELVlx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 17:41:53 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:59414 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfELVlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 17:41:52 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 587396083106;
        Sun, 12 May 2019 23:41:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id POWOPeyX2ONQ; Sun, 12 May 2019 23:41:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E33726083105;
        Sun, 12 May 2019 23:41:49 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8XRIXltUOqMA; Sun, 12 May 2019 23:41:49 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BD503608A3BE;
        Sun, 12 May 2019 23:41:49 +0200 (CEST)
Date:   Sun, 12 May 2019 23:41:49 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <1836274340.56055.1557697309728.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.2-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Index: SN9iPxMprvjqEtUbv+z+Su/q/2FDMA==
Thread-Topic: UML changes for v5.2-rc1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 37624b58542fb9f2d9a70e6ea006ef8a5f66c30b:

  Linux 5.1-rc7 (2019-04-28 17:04:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.2-rc1

for you to fetch changes up to 1987b1b8f9f17a06255877e7917d0bb5b5377774:

  um: irq: don't set the chip for all irqs (2019-05-07 23:18:28 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Kconfig cleanups
- Fix cpu_all_mask() usage
- Various bug fixes

----------------------------------------------------------------
Anton Ivanov (1):
      um: Revert to using stack for pt_regs in signal handling

Bartosz Golaszewski (4):
      um: remove unused variable
      um: remove uses of variable length arrays
      um: define set_pte_at() as a static inline function, not a macro
      um: irq: don't set the chip for all irqs

Colin Ian King (1):
      hostfs: fix mismatch between link_file definition and declaration

Daniel Walter (1):
      um: Do not unlock mutex that is not hold.

Enrico Weigelt, metux IT consult (2):
      arch: um: Kconfig: pedantic indention cleanups
      arch: um: drivers: Kconfig: pedantic formatting

Maciej Żenczykowski (1):
      uml: fix a boot splat wrt use of cpu_all_mask

 arch/um/Kconfig               |  58 +++----
 arch/um/drivers/Kconfig       | 352 +++++++++++++++++++++---------------------
 arch/um/drivers/ubd_kern.c    |   4 +-
 arch/um/include/asm/pgtable.h |   7 +-
 arch/um/kernel/irq.c          |   2 +-
 arch/um/kernel/skas/uaccess.c |   1 -
 arch/um/kernel/time.c         |   2 +-
 arch/um/os-Linux/signal.c     |  28 +---
 arch/um/os-Linux/umid.c       |  36 +++--
 fs/hostfs/hostfs.h            |   2 +-
 10 files changed, 253 insertions(+), 239 deletions(-)
