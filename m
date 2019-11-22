Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C490AC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10032068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 16:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKVQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 11:35:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:54472 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726046AbfKVQfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 11:35:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A955BAC5F;
        Fri, 22 Nov 2019 16:35:15 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9530DDA898; Fri, 22 Nov 2019 17:35:15 +0100 (CET)
From:   David Sterba <dsterba@suse.com>
To:     torvalds@linux-foundation.org
Cc:     David Sterba <dsterba@suse.com>, linux-fdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] AFFS updates for 5.5
Date:   Fri, 22 Nov 2019 17:35:10 +0100
Message-Id: <cover.1574440243.git.dsterba@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a minor bugfix and cleanup for AFFS. Please pull, thanks.

 - fix memory leak during remount

 - use mutex instead of binary semaphore

----------------------------------------------------------------
The following changes since commit af42d3466bdc8f39806b26f593604fdc54140bcb:

  Linux 5.4-rc8 (2019-11-17 14:47:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux.git affs-for-5.5-tag

for you to fetch changes up to 450c3d4166837c496ebce03650c08800991f2150:

  affs: fix a memory leak in affs_remount (2019-11-18 14:26:43 +0100)

----------------------------------------------------------------
Davidlohr Bueso (1):
      affs: Replace binary semaphores with mutexes

Navid Emamdoost (1):
      affs: fix a memory leak in affs_remount

 fs/affs/affs.h  | 16 ++++++++--------
 fs/affs/super.c | 10 ++--------
 2 files changed, 10 insertions(+), 16 deletions(-)
