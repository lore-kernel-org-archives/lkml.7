Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C90FC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF062070B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 14:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfHYOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 10:01:54 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:36558 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbfHYOBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 10:01:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6C0CC6083139;
        Sun, 25 Aug 2019 16:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id tqJfLNQv7xsv; Sun, 25 Aug 2019 16:01:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2B6FB608311C;
        Sun, 25 Aug 2019 16:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id h9v8sJCiOh-s; Sun, 25 Aug 2019 16:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 05E1B6089354;
        Sun, 25 Aug 2019 16:01:50 +0200 (CEST)
Date:   Sun, 25 Aug 2019 16:01:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1811413787.73825.1566741710952.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBIFS/JFFS2 fixes for 5.3-rc6
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Index: 1z3uoU3loWp1K/Oo/z0waK5U/6Z3kw==
Thread-Topic: UBIFS/JFFS2 fixes for 5.3-rc6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit d1abaeb3be7b5fa6d7a1fbbd2e14e3310005c4c1:

  Linux 5.3-rc5 (2019-08-18 14:31:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.3-rc6

for you to fetch changes up to 0af83abbd4a6e36a4b209d8c57c26143e40eeec1:

  ubifs: Limit the number of pages in shrink_liability (2019-08-22 17:25:33 +0200)

----------------------------------------------------------------
This pull request contains the following fixes for UBIFS and JFFS2:

UBIFS:

- Don't block too long in writeback_inodes_sb()
- Fix for a possible overrun of the log head
- Fix double unlock in orphan_delete()

JFFS2:

- Remove C++ style from UAPI header and unbreak picky toolchains

----------------------------------------------------------------
Liu Song (1):
      ubifs: Limit the number of pages in shrink_liability

Masahiro Yamada (1):
      jffs2: Remove C++ style comments from uapi header

Richard Weinberger (2):
      ubifs: Fix double unlock around orphan_delete()
      ubifs: Correctly initialize c->min_log_bytes

 fs/ubifs/budget.c          | 2 +-
 fs/ubifs/orphan.c          | 2 --
 fs/ubifs/super.c           | 4 ++++
 include/uapi/linux/jffs2.h | 5 -----
 4 files changed, 5 insertions(+), 8 deletions(-)
