Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A76C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2193120850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 15:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388488AbfCAPBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:01:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:39916 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728313AbfCAPBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 10:01:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7122AB11C;
        Fri,  1 Mar 2019 15:01:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 03DD31E13E2; Fri,  1 Mar 2019 16:01:23 +0100 (CET)
Date:   Fri, 1 Mar 2019 16:01:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] dtype handling cleanup for v5.1-rc1
Message-ID: <20190301150122.GA15145@quack2.suse.cz>
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

git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git dtype_for_v5.1-rc1

to get a reworked version of the dtype cleanup patches based on your
feedback to the previous version of these. Again the series includes only
the generic code and ext2 cleanup as a sample. The plan is to push cleanups
for other filesystems separately through respective trees once the generic
code lands to reduce number of conflicts.

I'm sending this a bit earlier since I'll be on vacation next week.

Top of the tree is e10892189428. The full shortlog is:

Phillip Potter (2):
      fs: common implementation of file type
      ext2: use common file type conversion

The diffstat is

 MAINTAINERS              |   1 +
 fs/Makefile              |   3 +-
 fs/ext2/dir.c            |  35 +++-------------
 fs/ext2/ext2.h           |  16 --------
 fs/fs_types.c            | 105 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h       |  17 +-------
 include/linux/fs_types.h |  75 +++++++++++++++++++++++++++++++++
 7 files changed, 190 insertions(+), 62 deletions(-)
 create mode 100644 fs/fs_types.c
 create mode 100644 include/linux/fs_types.h

							Thanks
								Honza


-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
