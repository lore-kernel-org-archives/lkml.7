Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3177DC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A54C20811
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 10:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfDWKzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 06:55:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:52938 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfDWKzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 06:55:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 596F3AE20;
        Tue, 23 Apr 2019 10:55:01 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
Cc:     konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, Juergen Gross <jgross@suse.com>
Subject: [PATCH 0/3] xen/swiotlb: fix an issue and improve swiotlb-xen
Date:   Tue, 23 Apr 2019 12:54:54 +0200
Message-Id: <20190423105457.17502-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While hunting an issue in swiotlb-xen I stumbled over a wrong test
and found some areas for improvement.

Juergen Gross (3):
  xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
  xen/swiotlb: simplify range_straddles_page_boundary()
  xen/swiotlb: remember having called xen_create_contiguous_region()

 drivers/xen/swiotlb-xen.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

-- 
2.16.4

