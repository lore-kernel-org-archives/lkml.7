Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D843C49ED6
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 370E42075C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 02:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbfILCyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 22:54:52 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:51600 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727576AbfILCyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 22:54:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 36473100E806B;
        Thu, 12 Sep 2019 02:54:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: band82_814fcf5b47631
X-Filterd-Recvd-Size: 2846
Received: from joe-laptop.perches.com (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 12 Sep 2019 02:54:48 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Dan Williams <dan.j.williams@intel.com>, linux-nvdimm@lists.01.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] nvdimm: Use more common kernel coding style
Date:   Wed, 11 Sep 2019 19:54:30 -0700
Message-Id: <cover.1568256705.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather than have a local coding style, use the typical kernel style.

Joe Perches (13):
  nvdimm: Use more typical whitespace
  nvdimm: Move logical continuations to previous line
  nvdimm: Use octal permissions
  nvdimm: Use a more common kernel spacing style
  nvdimm: Use "unsigned int" in preference to "unsigned"
  nvdimm: Add and remove blank lines
  nvdimm: Use typical kernel brace styles
  nvdimm: Use typical kernel style indentation
  nvdimm: btt.h: Neaten #defines to improve readability
  nvdimm: namespace_devs: Move assignment operators
  nvdimm: Use more common logic testing styles and bare ; positions
  nvdimm: namespace_devs: Change progess typo to progress
  nvdimm: Miscellaneous neatening

 drivers/nvdimm/badrange.c       |  22 +-
 drivers/nvdimm/blk.c            |  39 ++--
 drivers/nvdimm/btt.c            | 249 +++++++++++----------
 drivers/nvdimm/btt.h            |  56 ++---
 drivers/nvdimm/btt_devs.c       |  68 +++---
 drivers/nvdimm/bus.c            | 138 ++++++------
 drivers/nvdimm/claim.c          |  50 ++---
 drivers/nvdimm/core.c           |  42 ++--
 drivers/nvdimm/dax_devs.c       |   3 +-
 drivers/nvdimm/dimm.c           |   3 +-
 drivers/nvdimm/dimm_devs.c      | 107 ++++-----
 drivers/nvdimm/e820.c           |   2 +-
 drivers/nvdimm/label.c          | 213 +++++++++---------
 drivers/nvdimm/label.h          |   6 +-
 drivers/nvdimm/namespace_devs.c | 472 +++++++++++++++++++++-------------------
 drivers/nvdimm/nd-core.h        |  31 +--
 drivers/nvdimm/nd.h             |  94 ++++----
 drivers/nvdimm/nd_virtio.c      |  20 +-
 drivers/nvdimm/of_pmem.c        |   6 +-
 drivers/nvdimm/pfn_devs.c       | 136 ++++++------
 drivers/nvdimm/pmem.c           |  57 ++---
 drivers/nvdimm/pmem.h           |   2 +-
 drivers/nvdimm/region.c         |  20 +-
 drivers/nvdimm/region_devs.c    | 160 +++++++-------
 drivers/nvdimm/security.c       | 138 ++++++------
 drivers/nvdimm/virtio_pmem.c    |  10 +-
 26 files changed, 1115 insertions(+), 1029 deletions(-)

-- 
2.15.0

