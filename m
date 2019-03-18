Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D93C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79D2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbfCRBAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:00:52 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:8677
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727769AbfCRBAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:00:49 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BrAQAv7I5c/44x0HZjHQEBBQEHBQG?=
 =?us-ascii?q?BVAUBCwGCEIE4IRInhAuUCQEBAgEBBoFIiS2QbCAYAYRAAoRQIjcGDQEBAwE?=
 =?us-ascii?q?BAQgBAwJtKIVLBiNWEBgBDAIYDgICRxAGE4ULDKlRgS8aAooJgQskAYsvF3i?=
 =?us-ascii?q?BB4wuglcDiieCMYQtTDuSSQmTJRmLJAOIMIM+nEkigVZNLgo7gmyQWDUwgQU?=
 =?us-ascii?q?BAY1LAQE?=
X-IPAS-Result: =?us-ascii?q?A2BrAQAv7I5c/44x0HZjHQEBBQEHBQGBVAUBCwGCEIE4I?=
 =?us-ascii?q?RInhAuUCQEBAgEBBoFIiS2QbCAYAYRAAoRQIjcGDQEBAwEBAQgBAwJtKIVLB?=
 =?us-ascii?q?iNWEBgBDAIYDgICRxAGE4ULDKlRgS8aAooJgQskAYsvF3iBB4wuglcDiieCM?=
 =?us-ascii?q?YQtTDuSSQmTJRmLJAOIMIM+nEkigVZNLgo7gmyQWDUwgQUBAY1LAQE?=
X-IronPort-AV: E=Sophos;i="5.58,491,1544457600"; 
   d="scan'208";a="206152914"
Received: from unknown (HELO pluto.themaw.net) ([118.208.49.142])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 18 Mar 2019 09:00:46 +0800
Subject: [PATCH 5/5] autofs - add description of ignore pseudo mount option
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 18 Mar 2019 09:00:46 +0800
Message-ID: <155287084617.12593.812733161112154904.stgit@pluto.themaw.net>
In-Reply-To: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
References: <155287082394.12593.6506084453911662450.stgit@pluto.themaw.net>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a idescription of the "ignore" pseudo mount option that can be
used to provide a generic indicator to applications that the mount
entry should be ignored when displaying mount information.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index 409e6411904d..3af38c7fd26d 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -526,6 +526,21 @@ directories.
 Catatonic mode can only be left via the
 **AUTOFS_DEV_IOCTL_OPENMOUNT_CMD** ioctl on the `/dev/autofs`.
 
+The "ignore" mount option
+-------------------------
+
+The "ignore" mount option can be used to provide a generic indicator
+to applications that the mount entry should be ignored when displaying
+mount information.
+
+In other OSes that provide autofs and that provide a mount list to user
+space based on the kernel mount list a no-op mount option ("ignore" is
+the one use on the most common OSes) is allowed so that autofs file
+system users can optionally use it.
+
+This is intended to be used by user space programs to exclude autofs
+mounts from consideration when reading the mounts list.
+
 autofs, name spaces, and shared mounts
 --------------------------------------
 

