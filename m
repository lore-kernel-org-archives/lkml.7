Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2CFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F0C20811
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 08:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfCUI7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 04:59:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:43544 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725985AbfCUI7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 04:59:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0B396AEF3;
        Thu, 21 Mar 2019 08:59:51 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6C6E21E42C8; Thu, 21 Mar 2019 09:59:50 +0100 (CET)
Date:   Thu, 21 Mar 2019 09:59:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] fanotify and inotify fixes for v5.1-rc2
Message-ID: <20190321085950.GA29086@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  could you please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify_for_v5.1-rc2

to get one inotify and one fanotify fix.

Top of the tree is b2d22b6bb33a. The full shortlog is:

Jan Kara (1):
      fanotify: Allow copying of file handle to userspace

ZhangXiaoxu (1):
      inotify: Fix fsnotify_mark refcount leak in inotify_update_existing_watch()

The diffstat is

 fs/notify/fanotify/fanotify_user.c | 12 +++++++++++-
 fs/notify/inotify/inotify_user.c   |  7 +++++--
 2 files changed, 16 insertions(+), 3 deletions(-)

							Thanks
								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
