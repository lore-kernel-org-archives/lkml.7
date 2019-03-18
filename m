Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20145C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 01:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727750AbfCRBAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 21:00:41 -0400
Received: from icp-osb-irony-out8.external.iinet.net.au ([203.59.1.225]:8677
        "EHLO icp-osb-irony-out8.external.iinet.net.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727725AbfCRBAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 21:00:37 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQk?=
 =?us-ascii?q?LAYIQgTghEieEC5QJAQECAQEGgRA4iS2JXoUTgXsgGAGEQAKEUCI0CQ0BAQM?=
 =?us-ascii?q?BAQEIAQMCbSiFSwYjVhAYAQwCGA4CAkcQBhOFCwypUYEvGgKKCYELJAGLLxd?=
 =?us-ascii?q?4gQeBRIpqglcDjFiEeTuSSQmTJRmBfIkoA4gwLYMRiGCTUziBVk0uCoMnkFg?=
 =?us-ascii?q?1MIEFAQGNSwEB?=
X-IPAS-Result: =?us-ascii?q?A2BeAAAv7I5c/44x0HZjHgEGBwaBUQkLAYIQgTghEieEC?=
 =?us-ascii?q?5QJAQECAQEGgRA4iS2JXoUTgXsgGAGEQAKEUCI0CQ0BAQMBAQEIAQMCbSiFS?=
 =?us-ascii?q?wYjVhAYAQwCGA4CAkcQBhOFCwypUYEvGgKKCYELJAGLLxd4gQeBRIpqglcDj?=
 =?us-ascii?q?FiEeTuSSQmTJRmBfIkoA4gwLYMRiGCTUziBVk0uCoMnkFg1MIEFAQGNSwEB?=
X-IronPort-AV: E=Sophos;i="5.58,491,1544457600"; 
   d="scan'208";a="206152891"
Received: from unknown (HELO pluto.themaw.net) ([118.208.49.142])
  by icp-osb-irony-out8.iinet.net.au with ESMTP; 18 Mar 2019 09:00:35 +0800
Subject: [PATCH 3/5] autofs - update AUTOFS_EXP_LEAVES description
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kernel Mailing List <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Mon, 18 Mar 2019 09:00:35 +0800
Message-ID: <155287083538.12593.18163159677020718048.stgit@pluto.themaw.net>
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

Update the description of AUTOFS_EXP_LEAVES to cover its possible
future use with amd format mount maps.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 Documentation/filesystems/autofs.txt |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/autofs.txt b/Documentation/filesystems/autofs.txt
index ac50b47f02bd..8fe43c97cb96 100644
--- a/Documentation/filesystems/autofs.txt
+++ b/Documentation/filesystems/autofs.txt
@@ -262,8 +262,12 @@ up.
 
 There is an option with indirect mounts to consider each of the leaves
 that has been mounted on instead of considering the top-level names.
-This is intended for compatibility with version 4 of autofs and should
-be considered as deprecated.
+This was originally intended for compatibility with version 4 of autofs
+and should be considered as deprecated for Sun Format automount maps.
+However, it may be used again for amd format mount maps (which are
+generally indirect maps) because the amd automounter allows for the
+setting of an expire timeout for individual mounts. But there are
+some difficulties in making the needed changes for this.
 
 When autofs considers a directory it checks the `last_used` time and
 compares it with the "timeout" value set when the filesystem was

