Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84AD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC3D20851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 17:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfCHR6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 12:58:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:25767 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCHR6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 12:58:11 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6FC433092656;
        Fri,  8 Mar 2019 17:58:11 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 621F6600C8;
        Fri,  8 Mar 2019 17:58:11 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 55571181A135;
        Fri,  8 Mar 2019 17:58:11 +0000 (UTC)
Date:   Fri, 8 Mar 2019 12:58:11 -0500 (EST)
From:   Bob Peterson <rpeterso@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <129739656.10752219.1552067891284.JavaMail.zimbra@redhat.com>
In-Reply-To: <2063498114.10752149.1552067836491.JavaMail.zimbra@redhat.com>
Subject: GFS2: Pull request (merge window)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.117.58, 10.4.195.10]
Thread-Topic: GFS2: Pull request (merge window)
Thread-Index: O9QePR0aZJDfM7k/6TpJmZxwuy2WCg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Fri, 08 Mar 2019 17:58:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please consider pulling the following changes for the GFS2 file system.

Regards,

Bob Peterson
----------------------------------------------------------------
The following changes since commit 49a57857aeea06ca831043acbb0fa5e0f50602fd:

  Linux 5.0-rc3 (2019-01-21 13:14:44 +1300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-5.1.fixes

for you to fetch changes up to 605b0487f0bc1ae9963bf52ece0f5c8055186f81:

  gfs2: Fix missed wakeups in find_insert_glock (2019-03-08 15:49:01 +0100)

----------------------------------------------------------------
We've only got three patches ready for this merge window:

 - Fix a hang related to missed wakeups for glocks from Andreas Gruenbacher.
 - Rework of how gfs2 manages its debugfs files from Greg K-H.
 - An incorrect assert when truncating or deleting files from Tim Smith.

----------------------------------------------------------------
Andreas Gruenbacher (1):
      gfs2: Fix missed wakeups in find_insert_glock

Greg Kroah-Hartman (1):
      gfs: no need to check return value of debugfs_create functions

Tim Smith (1):
      gfs2: Fix an incorrect gfs2_assert()

 fs/gfs2/glock.c  | 72 ++++++++++++--------------------------------------------
 fs/gfs2/glock.h  |  4 ++--
 fs/gfs2/incore.h |  3 ---
 fs/gfs2/inode.h  |  4 ++--
 fs/gfs2/main.c   |  6 +----
 5 files changed, 20 insertions(+), 69 deletions(-)
