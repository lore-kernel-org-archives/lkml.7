Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9914CC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FAB221D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 14:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfIZORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 10:17:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:41498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726500AbfIZORq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 10:17:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C499AED5;
        Thu, 26 Sep 2019 14:17:45 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: features for 5.4-rc1
Date:   Thu, 26 Sep 2019 16:17:43 +0200
Message-Id: <20190926141743.25426-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.4-rc1-tag

xen: features for 5.4-rc1

It contains only two small patches this time:

- a small cleanup for swiotlb-xen
- a fix for PCI initialization for some platforms

Thanks.

Juergen

 drivers/xen/pci.c         | 21 +++++++++++++++------
 drivers/xen/swiotlb-xen.c |  5 ++---
 2 files changed, 17 insertions(+), 9 deletions(-)

Igor Druzhinin (1):
      xen/pci: reserve MCFG areas earlier

Souptick Joarder (1):
      swiotlb-xen: Convert to use macro
