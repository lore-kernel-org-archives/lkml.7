Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5911C43603
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82EA20663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 06:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfLOGGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Dec 2019 01:06:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:45572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbfLOGGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Dec 2019 01:06:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A3191B12D;
        Sun, 15 Dec 2019 06:06:22 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.5-rc2
Date:   Sun, 15 Dec 2019 07:06:21 +0100
Message-Id: <20191215060621.8328-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.5b-rc2-tag

xen: branch for v5.5-rc2

It contains two fixes: one for a resource accounting bug in some
configurations and a fix for another patch which went into rc1.

Thanks.

Juergen

 drivers/block/xen-blkback/xenbus.c | 10 ++++++++++
 drivers/xen/balloon.c              |  3 ++-
 2 files changed, 12 insertions(+), 1 deletion(-)

Juergen Gross (1):
      xen/balloon: fix ballooned page accounting without hotplug enabled

Paul Durrant (1):
      xen-blkback: prevent premature module unload
