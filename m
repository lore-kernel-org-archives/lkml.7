Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F24C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8A620821
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 20:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbfEVUvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 16:51:22 -0400
Received: from ms.lwn.net ([45.79.88.28]:49340 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbfEVUu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 16:50:58 -0400
Received: from meer.lwn.net (localhost [127.0.0.1])
        by ms.lwn.net (Postfix) with ESMTPA id 54C0BAB5;
        Wed, 22 May 2019 20:50:57 +0000 (UTC)
From:   Jonathan Corbet <corbet@lwn.net>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Markus Heiser <markus.heiser@darmarit.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Oleksandr Natalenko <oleksandr@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Keith Busch <keith.busch@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/8] docs: fix numaperf.rst and add it to the doc tree
Date:   Wed, 22 May 2019 14:50:29 -0600
Message-Id: <20190522205034.25724-4-corbet@lwn.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522205034.25724-1-corbet@lwn.net>
References: <20190522205034.25724-1-corbet@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 13bac55ef7ae ("doc/mm: New documentation for memory performance")
added numaperf.rst, but did not add it to the TOC tree.  There was also an
incorrectly marked literal block leading to this warning sequence:

  numaperf.rst:24: WARNING: Unexpected indentation.
  numaperf.rst:24: WARNING: Inline substitution_reference start-string without end-string.
  numaperf.rst:25: WARNING: Block quote ends without a blank line; unexpected unindent.

Fix the block and add the file to the document tree.

Fixes: 13bac55ef7ae ("doc/mm: New documentation for memory performance")
Cc: Keith Busch <keith.busch@intel.com>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/mm/index.rst    | 1 +
 Documentation/admin-guide/mm/numaperf.rst | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/index.rst b/Documentation/admin-guide/mm/index.rst
index 8edb35f11317..ddf8d8d33377 100644
--- a/Documentation/admin-guide/mm/index.rst
+++ b/Documentation/admin-guide/mm/index.rst
@@ -31,6 +31,7 @@ the Linux memory management.
    ksm
    memory-hotplug
    numa_memory_policy
+   numaperf
    pagemap
    soft-dirty
    transhuge
diff --git a/Documentation/admin-guide/mm/numaperf.rst b/Documentation/admin-guide/mm/numaperf.rst
index b79f70c04397..c067ed145158 100644
--- a/Documentation/admin-guide/mm/numaperf.rst
+++ b/Documentation/admin-guide/mm/numaperf.rst
@@ -15,7 +15,7 @@ characteristics.  Some memory may share the same node as a CPU, and others
 are provided as memory only nodes. While memory only nodes do not provide
 CPUs, they may still be local to one or more compute nodes relative to
 other nodes. The following diagram shows one such example of two compute
-nodes with local memory and a memory only node for each of compute node:
+nodes with local memory and a memory only node for each of compute node::
 
  +------------------+     +------------------+
  | Compute Node 0   +-----+ Compute Node 1   |
-- 
2.21.0

