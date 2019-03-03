Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DCCC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B351020863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 03:43:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfCCDnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 22:43:11 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:54414 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCCDnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 22:43:11 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0I1d-0003Tb-On; Sun, 03 Mar 2019 03:43:00 +0000
Date:   Sun, 3 Mar 2019 03:42:53 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [git pull] vfs.git fixes
Message-ID: <20190303034249.GO2217@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted fixes that sat in -next for a while, all over the
place.

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to d3d6a18d7d351cbcc9b33dbedf710e65f8ce1595:

  aio: Fix locking in aio_poll() (2019-02-21 22:16:47 -0500)

----------------------------------------------------------------
Al Viro (2):
      fix cgroup_do_mount() handling of failure exits
      cgroup: saner refcounting for cgroup_root

Bart Van Assche (1):
      aio: Fix locking in aio_poll()

Chandan Rajendra (1):
      copy_mount_string: Limit string length to PATH_MAX

YueHaibing (1):
      exec: Fix mem leak in kernel_read_file

 fs/aio.c                        | 12 ++++++---
 fs/exec.c                       |  2 +-
 fs/kernfs/mount.c               |  8 ++++--
 fs/namespace.c                  |  2 +-
 kernel/cgroup/cgroup-internal.h |  2 +-
 kernel/cgroup/cgroup-v1.c       | 58 +++++++++--------------------------------
 kernel/cgroup/cgroup.c          | 25 +++++++++---------
 7 files changed, 44 insertions(+), 65 deletions(-)
