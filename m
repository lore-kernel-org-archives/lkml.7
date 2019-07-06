Return-Path: <SRS0=CMjL=VD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3297C5B57D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 03:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9218421670
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jul 2019 03:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfGFDDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 23:03:41 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49182 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfGFDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 23:03:41 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hjazD-0001H5-9d; Sat, 06 Jul 2019 03:03:39 +0000
Date:   Sat, 6 Jul 2019 04:03:39 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [git pull] fix bogus default y in Kconfig (VALIDATE_FS_PARSER)
Message-ID: <20190706030339.GN17978@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	That thing should not be turned on by default, especially since
it's not quiet in case it finds no problems.  Geert has sent the obvious
fix quite a few times, but it fell through the cracks.

The following changes since commit 570d7a98e7d6d5d8706d94ffd2d40adeaa318332:

  vfs: move_mount: reject moving kernel internal mounts (2019-07-01 10:46:36 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to 75f2d86b20bf6aec0392d6dd2ae3ffff26d2ae0e:

  fs: VALIDATE_FS_PARSER should default to n (2019-07-05 11:22:11 -0400)

----------------------------------------------------------------
Geert Uytterhoeven (1):
      fs: VALIDATE_FS_PARSER should default to n

 fs/Kconfig | 1 -
 1 file changed, 1 deletion(-)
