Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48A4AC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A85020856
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 03:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfEGDfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 23:35:41 -0400
Received: from namei.org ([65.99.196.166]:37834 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfEGDfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 23:35:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x473Zd9w005961;
        Tue, 7 May 2019 03:35:39 GMT
Date:   Tue, 7 May 2019 13:35:39 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Security subsystem: general updates for v5.2
Message-ID: <alpine.LRH.2.21.1905071333580.5714@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few bugfixes and documentation updates.

Please pull.


The following changes since commit 8c2ffd9174779014c3fe1f96d9dc3641d9175f00:

  Linux 5.1-rc2 (2019-03-24 14:02:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general

for you to fetch changes up to 6beff00b79ca0b5caf0ce6fb8e11f57311bd95f8:

  seccomp: fix up grammar in comment (2019-04-23 16:21:12 -0700)

----------------------------------------------------------------
Denis Efremov (11):
      LSM: fix documentation for sb_copy_data hook
      LSM: fix documentation for the syslog hook
      LSM: fix documentation for the socket_post_create hook
      LSM: fix documentation for the task_setscheduler hook
      LSM: fix documentation for the socket_getpeersec_dgram hook
      LSM: fix documentation for the path_chmod hook
      LSM: fix documentation for the audit_* hooks
      LSM: fix documentation for the msg_queue_* hooks
      LSM: fix documentation for the sem_* hooks
      LSM: fix documentation for the shm_* hooks
      LSM: lsm_hooks.h: fix documentation format

James Morris (2):
      Merge tag 'v5.1-rc2' into next-general
      Revert "security: inode: fix a missing check for securityfs_create_file"

Jann Horn (3):
      Yama: mark local symbols as static
      security: don't use RCU accessors for cred->session_keyring
      keys: safe concurrent user->{session,uid}_keyring access

Kangjie Lu (1):
      security: inode: fix a missing check for securityfs_create_file

Mukesh Ojha (1):
      Yama: mark function as static

Tycho Andersen (1):
      seccomp: fix up grammar in comment

 include/linux/cred.h         |   2 +-
 include/linux/lsm_hooks.h    | 170 +++++++++++++++++++++----------------------
 include/linux/sched/user.h   |   7 ++
 kernel/seccomp.c             |   2 +-
 security/keys/process_keys.c |  41 +++++------
 security/keys/request_key.c  |  14 ++--
 security/yama/yama_lsm.c     |   8 +-
 7 files changed, 119 insertions(+), 125 deletions(-)
