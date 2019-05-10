Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95712C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709D4217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 22:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbfEJWJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 18:09:24 -0400
Received: from namei.org ([65.99.196.166]:38510 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbfEJWJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 18:09:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x4AM9M4q019663;
        Fri, 10 May 2019 22:09:22 GMT
Date:   Sat, 11 May 2019 08:09:22 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] security subsystem: Tomoyo updates for v5.2
Message-ID: <alpine.LRH.2.21.1905110801350.9392@namei.org>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull.

These patches include fixes to enable fuzz testing, and a fix for 
calculating whether a filesystem is user-modifiable.

The following changes since commit 1fb3b526df3bd7647e7854915ae6b22299408baf:

  Merge tag 'docs-5.2a' of git://git.lwn.net/linux (2019-05-10 13:24:53 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-tomoyo2

for you to fetch changes up to 4ad98ac46490d5f8441025930070eaf028cfd0f2:

  tomoyo: Don't emit WARNING: string while fuzzing testing. (2019-05-10 14:58:35 -0700)

----------------------------------------------------------------
Tetsuo Handa (4):
      tomoyo: Add a kernel config option for fuzzing testing.
      tomoyo: Check address length before reading address family
      tomoyo: Change pathname calculation for read-only filesystems.
      tomoyo: Don't emit WARNING: string while fuzzing testing.

 security/tomoyo/Kconfig    | 10 ++++++++++
 security/tomoyo/common.c   | 13 ++++++++++++-
 security/tomoyo/network.c  |  4 ++++
 security/tomoyo/realpath.c |  3 ++-
 security/tomoyo/util.c     |  2 ++
 5 files changed, 30 insertions(+), 2 deletions(-)
