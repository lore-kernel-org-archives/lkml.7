Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB28C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517E0205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfESTyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 15:54:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:41970 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfESTyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 15:54:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9100D608325B;
        Sun, 19 May 2019 21:54:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Yw-_UYOxrkNz; Sun, 19 May 2019 21:54:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5192F6083279;
        Sun, 19 May 2019 21:54:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8tku6GKN3dxf; Sun, 19 May 2019 21:54:11 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 30BB3608325B;
        Sun, 19 May 2019 21:54:11 +0200 (CEST)
Date:   Sun, 19 May 2019 21:54:11 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <273612995.64271.1558295651158.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBIFS fixes for 5.2-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Index: WLFwXOwMNVbr8u9epEt1vaZn/sWOVw==
Thread-Topic: UBIFS fixes for 5.2-rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 2bbacd1a92788ee334c7e92b765ea16ebab68dfe:

  Merge tag 'kconfig-v5.2' of git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild (2019-05-15 09:06:14 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.2-rc2

for you to fetch changes up to 4dd0481584d09221849ac8a3af4cd3cefd58c11e:

  ubifs: Convert xattr inum to host order (2019-05-15 21:56:48 +0200)

----------------------------------------------------------------
This pull request contains the following fixes for UBIFS:

- Build errors wrt. xattrs
- Mismerge which lead to a wrong Kconfig ifdef
- Missing endianness conversion

----------------------------------------------------------------
Richard Weinberger (2):
      ubifs: Use correct config name for encryption
      ubifs: Convert xattr inum to host order

YueHaibing (1):
      ubifs: Fix build error without CONFIG_UBIFS_FS_XATTR

 fs/ubifs/sb.c    | 4 ++--
 fs/ubifs/ubifs.h | 6 +++++-
 fs/ubifs/xattr.c | 2 +-
 3 files changed, 8 insertions(+), 4 deletions(-)
