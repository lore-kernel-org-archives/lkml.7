Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA99BC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0F021851
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 16:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563466708;
	bh=MSb37xjaCMaGDFM4ve1baXDv5W8YHm0nchnq58zBZkc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=zlwQPeUOE/sMiefkE9ijxP3AMTGrrf6dJh7QzHGIi+0rtXmKLZyxkRSN5jgt353Yr
	 qvl+9UvryhDc3L6PV2SOXArRwF3h7KEhmBG6rXFJWpU4R71qNFecuqpfQEIjWWJq5Q
	 uvovoHzeVhToOuw+yDQMi2AxHXfb4rAGNLSgIJKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731624AbfGRQS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 12:18:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfGRQSZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 12:18:25 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C4321850;
        Thu, 18 Jul 2019 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563466704;
        bh=MSb37xjaCMaGDFM4ve1baXDv5W8YHm0nchnq58zBZkc=;
        h=Date:From:To:Cc:Subject:From;
        b=iR2EvuCfyIr0/+yRJX9kLrPyaRPOrjzmxrwW0XecBCF3TDc1NE3n417pkcByR075N
         syRZ/N+v2YpY3/zQivkfAJFUArdzJ3NyYdQ7oe6O9i4OgZOW62cHteM/jyLoKD4RjZ
         OHk1oOSEhOwbMCID/0tNfcEkol6fZpvzxhTn4a9k=
Date:   Thu, 18 Jul 2019 09:18:24 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        david@fromorbit.com, linux-kernel@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: cleanups for 5.3
Message-ID: <20190718161824.GE7093@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

We had a few more lateish cleanup patches come in for 5.3 -- a couple of
syncups with the userspace libxfs code and a conversion of the XFS
administrator's guide to ReST format.

The branch does /not/ merge cleanly against this morning's HEAD due to a
conflict in Documentation/admin-guide/index.rst.  The conflict can be
resolved by adding the "xfs" line after "binderfs".  The series survived
an overnight run of xfstests.

Please let me know if you run into anything weird, I promise I drank two
cups of coffee this time around. :)

--D

The following changes since commit 488ca3d8d088ec4658c87aaec6a91e98acccdd54:

  xfs: chain bios the right way around in xfs_rw_bdev (2019-07-10 10:04:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.3-merge-13

for you to fetch changes up to 89b408a68b9dd163b2705b6f73d8e3cc3579b457:

  Documentation: filesystem: Convert xfs.txt to ReST (2019-07-15 09:15:09 -0700)

----------------------------------------------------------------
Also new for 5.3:
- Bring fs/xfs/libxfs/xfs_trans_inode.c in sync with userspace libxfs.
- Convert the xfs administrator guide to rst and move it into the
  official admin guide under Documentation

----------------------------------------------------------------
Eric Sandeen (2):
      xfs: move xfs_trans_inode.c to libxfs/
      xfs: sync up xfs_trans_inode with userspace

Sheriff Esseson (1):
      Documentation: filesystem: Convert xfs.txt to ReST

 Documentation/admin-guide/index.rst                |   1 +
 .../{filesystems/xfs.txt => admin-guide/xfs.rst}   | 132 ++++++++++-----------
 Documentation/filesystems/dax.txt                  |   2 +-
 MAINTAINERS                                        |   3 +-
 fs/xfs/Makefile                                    |   4 +-
 fs/xfs/{ => libxfs}/xfs_trans_inode.c              |   4 +
 6 files changed, 73 insertions(+), 73 deletions(-)
 rename Documentation/{filesystems/xfs.txt => admin-guide/xfs.rst} (80%)
 rename fs/xfs/{ => libxfs}/xfs_trans_inode.c (96%)
