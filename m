Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B87C2D0C0
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 13:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCAB206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 13:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbfLUNTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 08:19:49 -0500
Received: from mx2.suse.de ([195.135.220.15]:54256 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726890AbfLUNTt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 08:19:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78058AD11;
        Sat, 21 Dec 2019 13:19:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.5-rc3
Date:   Sat, 21 Dec 2019 14:19:46 +0100
Message-Id: <20191221131946.27017-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc3-tag

xen: branch for v5.5-rc3

It contains 2 cleanup patches and a small series for supporting
reloading the Xen block backend driver.

Thanks.

Juergen

 drivers/block/xen-blkback/xenbus.c         | 56 ++++++++++++++++++++----------
 drivers/block/xen-blkfront.c               |  4 +--
 drivers/xen/grant-table.c                  |  4 ---
 drivers/xen/xenbus/xenbus.h                |  2 --
 drivers/xen/xenbus/xenbus_probe.c          | 35 ++++++-------------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 ++++++++++++-
 include/xen/interface/io/ring.h            | 29 +++++-----------
 include/xen/xenbus.h                       |  1 +
 9 files changed, 83 insertions(+), 73 deletions(-)

Aditya Pakki (1):
      xen/grant-table: remove multiple BUG_ON on gnttab_interface

Nathan Chancellor (1):
      xen/blkfront: Adjust indentation in xlvbd_alloc_gendisk

Paul Durrant (4):
      xenbus: move xenbus_dev_shutdown() into frontend code...
      xenbus: limit when state is forced to closed
      xen/interface: re-define FRONT/BACK_RING_ATTACH()
      xen-blkback: support dynamic unbind/bind
