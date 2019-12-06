Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32ECFC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09361206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfLFQzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:55:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:52264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726287AbfLFQzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:55:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D470CB268;
        Fri,  6 Dec 2019 16:55:12 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.5-rc1
Date:   Fri,  6 Dec 2019 17:55:11 +0100
Message-Id: <20191206165511.14749-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc1-tag

xen: branch for v5.5-rc1

It contains:

- a patch to fix a build warning

- a cleanup of no longer needed code in the Xen event handling

- a small series for the Xen grant driver avoiding high order
  allocations and replacing an insane global limit by a per-call one

- a small series fixing Xen frontend/backend module referencing


Thanks.

Juergen

 drivers/block/xen-blkback/blkback.c |  8 +++++
 drivers/block/xen-blkback/common.h  |  3 ++
 drivers/block/xen-blkback/xenbus.c  | 11 +++++++
 drivers/xen/events/events_base.c    | 16 ++--------
 drivers/xen/gntdev-common.h         |  2 +-
 drivers/xen/gntdev-dmabuf.c         | 11 ++-----
 drivers/xen/gntdev.c                | 64 +++++++++++++++----------------------
 drivers/xen/xenbus/xenbus_probe.c   | 13 +++++++-
 8 files changed, 66 insertions(+), 62 deletions(-)

Colin Ian King (1):
      xen/gntdev: remove redundant non-zero check on ret

Juergen Gross (4):
      xen/events: remove event handling recursion detection
      xen/gntdev: replace global limit of mapped pages by limit per call
      xen/gntdev: switch from kcalloc() to kvcalloc()

Paul Durrant (2):
      xen/xenbus: reference count registered modules
      xen-blkback: allow module to be cleanly unloaded
