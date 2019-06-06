Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9CEC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E55720673
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559834251;
	bh=KUu7Ble2WSlIDPUcjDZbizyKce1GDo2QexEABVOtcTM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=mfB4Rdo0O1lz5tLjjEcGBLOJTTKaZNSqGqaqs22GJkGUxmpBEA8JJssHd3FFQFCiI
	 WJyRApFmuojYAeSQh5bJi5LEhpthsB27xB0wjfr2VMectPg0pohFt6wqmgDVsUoRsF
	 9aw1UKj9eHEDCI0Gpe9lpFOkIqEeoCQkRa8wktfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbfFFPRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 11:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729109AbfFFPRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 11:17:30 -0400
Received: from localhost (c-67-169-218-210.hsd1.or.comcast.net [67.169.218.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3F8720652;
        Thu,  6 Jun 2019 15:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559834249;
        bh=KUu7Ble2WSlIDPUcjDZbizyKce1GDo2QexEABVOtcTM=;
        h=Date:From:To:Cc:Subject:From;
        b=ZzcSXQPxsxHHxWvMc/cR/cl8gtpeDB+AiWbboLIC4cmgVBjhEpHD/H+tKU9OtHBlJ
         6b8ZX5Wg9QrSNKeHF1BVKYhjj+3psmGm4lf98yNI2E5jBaIjV6WYaoxrRrWcaNlEh2
         B3ePRkv7fkE5KAqXEeEX5uD8l2Bi0HXJvsHB6Up4=
Date:   Thu, 6 Jun 2019 08:17:27 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        sandeen@sandeen.net, hch@lst.de
Subject: [GIT PULL] xfs: fixes for 5.2-rc4
Message-ID: <20190606151727.GH1200785@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are a couple more bug fixes for 5.2.  They've survived a few days
of fstests and merge cleanly with upstream as of a few minutes ago.  Let
me know if there are problems.

--D

The following changes since commit 5cd213b0fec640a46adc5e6e4dfc7763aa54b3b2:

  xfs: don't reserve per-AG space for an internal log (2019-05-20 11:25:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git tags/xfs-5.2-fixes-2

for you to fetch changes up to 025197ebb08a77eea702011c479ece1229a9525b:

  xfs: inode btree scrubber should calculate im_boffset correctly (2019-06-03 09:18:40 -0700)

----------------------------------------------------------------
Changes since last update:
- Fix some forgotten strings in a log debugging function
- Fix incorrect unit conversion in online fsck code

----------------------------------------------------------------
Darrick J. Wong (2):
      xfs: fix broken log reservation debugging
      xfs: inode btree scrubber should calculate im_boffset correctly

 fs/xfs/scrub/ialloc.c |  3 ++-
 fs/xfs/xfs_log.c      | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)
