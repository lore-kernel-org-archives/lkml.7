Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD53C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3E222C7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfIZOaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:30:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:57226 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbfIZOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:30:05 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iDUmS-0002VK-1P; Thu, 26 Sep 2019 14:30:04 +0000
Date:   Thu, 26 Sep 2019 15:30:04 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] jffs2 regression fix
Message-ID: <20190926143004.GV26530@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	braino fix for mount API conversion for jffs2...

The following changes since commit 1f52aa08d12f8d359e71b4bfd73ca9d5d668e4da:

  gfs2: Convert gfs2 to fs_context (2019-09-18 22:47:05 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.mount3

for you to fetch changes up to a3bc18a48e2e678efe62f1f9989902f9cd19e0ff:

  jffs2: Fix mounting under new mount API (2019-09-26 10:26:55 -0400)

----------------------------------------------------------------
David Howells (1):
      jffs2: Fix mounting under new mount API

 fs/jffs2/super.c | 2 --
 1 file changed, 2 deletions(-)
