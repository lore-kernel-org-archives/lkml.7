Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3376BC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040F21783
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 06:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbfGRGw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 02:52:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:53732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbfGRGw1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 02:52:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CA31ACBA;
        Thu, 18 Jul 2019 06:52:26 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH 0/2] xen/gntdev: sanitize user interface handling
Date:   Thu, 18 Jul 2019 08:52:20 +0200
Message-Id: <20190718065222.31310-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Xen gntdev driver's checking of the number of allowed mapped pages
is in need of some sanitizing work.

Juergen Gross (2):
  xen/gntdev: replace global limit of mapped pages by limit per call
  xen/gntdev: switch from kcalloc() to kvcalloc()

 drivers/xen/gntdev-common.h |  2 +-
 drivers/xen/gntdev-dmabuf.c | 11 +++-------
 drivers/xen/gntdev.c        | 52 ++++++++++++++++++---------------------------
 3 files changed, 25 insertions(+), 40 deletions(-)

-- 
2.16.4

