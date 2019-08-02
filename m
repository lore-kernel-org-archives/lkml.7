Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92B2C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83E63216C8
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436741AbfHBOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:47:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:56126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404067AbfHBOrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:47:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6E8FAC91;
        Fri,  2 Aug 2019 14:47:47 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: fixes for 5.3-rc3
Date:   Fri,  2 Aug 2019 16:47:46 +0200
Message-Id: <20190802144746.18653-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.3a-rc3-tag

xen: fixes for 5.3-rc3

It contains:
- a small cleanup
- a fix for a build error on ARM with some configs
- a fix of a patch for the Xen gntdev driver
- 3 patches for fixing a potential problem in the swiotlb-xen driver
  which Konrad was fine with me carrying them through the Xen tree

Thanks.


Juergen

 drivers/xen/gntdev.c                            |  2 +-
 drivers/xen/privcmd.c                           | 35 ++++---------------------
 drivers/xen/swiotlb-xen.c                       | 34 +++++++-----------------
 drivers/xen/xen-pciback/conf_space_capability.c |  3 +--
 drivers/xen/xlate_mmu.c                         | 32 ++++++++++++++++++++++
 include/linux/page-flags.h                      |  4 +++
 include/xen/xen-ops.h                           |  3 +++
 7 files changed, 56 insertions(+), 57 deletions(-)

Arnd Bergmann (1):
      xen: avoid link error on ARM

Juergen Gross (3):
      xen/swiotlb: fix condition for calling xen_destroy_contiguous_region()
      xen/swiotlb: simplify range_straddles_page_boundary()
      xen/swiotlb: remember having called xen_create_contiguous_region()

Souptick Joarder (1):
      xen/gntdev.c: Replace vm_map_pages() with vm_map_pages_zero()

YueHaibing (1):
      xen/pciback: remove set but not used variable 'old_state'
