Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C75AC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BFD218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 14:30:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfGZOav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 10:30:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40122 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbfGZOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 10:30:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hr1FA-0006Yw-Nm; Fri, 26 Jul 2019 14:30:48 +0000
Date:   Fri, 26 Jul 2019 15:30:48 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] struct mount leak fix
Message-ID: <20190726143048.GL1131@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Braino introduced in "switch the remnants of releasing the mountpoint
away from fs_pin"; the most visible result is leaking struct mount when
mounting btrfs, making it impossible to shut down.

The following changes since commit 18253e034d2aeee140f82fc9fe89c4bce5c81799:

  Merge branch 'work.dcache2' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2019-07-20 09:15:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 19a1c4092e7ca1ad1a72ac5535f902c483372cd5:

  fix the struct mount leak in umount_tree() (2019-07-26 07:59:06 -0400)

----------------------------------------------------------------
Al Viro (1):
      fix the struct mount leak in umount_tree()

 fs/namespace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
