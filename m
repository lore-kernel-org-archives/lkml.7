Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0416BC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A0D21726
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 14:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbfDEOqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 10:46:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbfDEOqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 10:46:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A4081C023B;
        Fri,  5 Apr 2019 14:46:52 +0000 (UTC)
Received: from x1.home (ovpn-116-153.phx2.redhat.com [10.3.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51EF16660B;
        Fri,  5 Apr 2019 14:46:52 +0000 (UTC)
Date:   Fri, 5 Apr 2019 08:46:48 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO fixes for v5.1-rc4
Message-ID: <20190405084648.67936128@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 05 Apr 2019 14:46:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.1-rc4

for you to fetch changes up to 492855939bdb59c6f947b0b5b44af9ad82b7e38c:

  vfio/type1: Limit DMA mappings per container (2019-04-03 12:43:05 -0600)

----------------------------------------------------------------
VFIO fixes for v5.1-rc4

 - Fix clang printk format errors (Louis Taylor)

 - Declare structure static to fix sparse warning (Wang Hai)

 - Limit user DMA mappings per container (CVE-2019-3882) (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/type1: Limit DMA mappings per container

Louis Taylor (1):
      vfio/pci: use correct format characters

Wang Hai (1):
      vfio/spapr_tce: Make symbol 'tce_iommu_driver_ops' static

 drivers/vfio/pci/vfio_pci.c         |  4 ++--
 drivers/vfio/vfio_iommu_spapr_tce.c |  2 +-
 drivers/vfio/vfio_iommu_type1.c     | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 3 deletions(-)
