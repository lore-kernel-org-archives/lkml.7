Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAD3C73C56
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36FB2082A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 16:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfGIQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 12:57:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52236 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbfGIQ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 12:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4611A3082B4B;
        Tue,  9 Jul 2019 16:57:27 +0000 (UTC)
Received: from redhat.com (null.msp.redhat.com [10.15.80.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EEE3C5DD6F;
        Tue,  9 Jul 2019 16:57:26 +0000 (UTC)
Date:   Tue, 9 Jul 2019 11:57:25 -0500
From:   David Teigland <teigland@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] dlm updates for 5.3
Message-ID: <20190709165725.GA2190@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Tue, 09 Jul 2019 16:57:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull dlm updates from tag:

git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.3

Apart from a couple trivial fixes, the more notable fix makes the dlm
continuing waiting for a user space result if a signal interrupts the
wait event.

Thanks,
Dave


David Teigland (1):
      dlm: Fix test for -ERESTARTSYS

David Windsor (1):
      dlm: check if workqueues are NULL before flushing/destroying

Greg Kroah-Hartman (1):
      dlm: no need to check return value of debugfs_create functions

Mark Syms (1):
      dlm: retry wait_event_interruptible in event of ERESTARTSYS


 fs/dlm/debug_fs.c     | 21 ++-------------------
 fs/dlm/dlm_internal.h |  8 ++++----
 fs/dlm/lockspace.c    |  6 ++++--
 fs/dlm/lowcomms.c     | 18 ++++++++++++------
 fs/dlm/main.c         |  5 +----
 5 files changed, 23 insertions(+), 35 deletions(-)

