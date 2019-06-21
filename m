Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F8DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82EF62084E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 06:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUF54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:57:56 -0400
Received: from mga09.intel.com ([134.134.136.24]:60521 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbfFUF54 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:57:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 22:57:55 -0700
X-IronPort-AV: E=Sophos;i="5.63,399,1557212400"; 
   d="scan'208";a="187060039"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 22:57:54 -0700
Subject: [-mm PATCH] docs/vm: Update ZONE_DEVICE memory model documentation
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
Date:   Thu, 20 Jun 2019 22:43:37 -0700
Message-ID: <156109575458.1409767.1885676287099277666.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike notes that Sphinx needs a newline before the start of a bulleted
list, and v10 of the subsection patch set changed the subsection size
from an arch-variable 'PMD_SIZE' to a constant 2MB.

Cc: Jonathan Corbet <corbet@lwn.net>
Reported-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Hi Andrew,

Another small fixup to fold on top of the subsection series. Thanks to
Mike for the build test, I also caught that the doc was out of date.

 Documentation/vm/memory-model.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/memory-model.rst b/Documentation/vm/memory-model.rst
index e0af47e02e78..58a12376b7df 100644
--- a/Documentation/vm/memory-model.rst
+++ b/Documentation/vm/memory-model.rst
@@ -205,10 +205,11 @@ subject to its memory ranges being exposed through the sysfs memory
 hotplug api on memory block boundaries. The implementation relies on
 this lack of user-api constraint to allow sub-section sized memory
 ranges to be specified to :c:func:`arch_add_memory`, the top-half of
-memory hotplug. Sub-section support allows for `PMD_SIZE` as the minimum
-alignment granularity for :c:func:`devm_memremap_pages`.
+memory hotplug. Sub-section support allows for 2MB as the cross-arch
+common alignment granularity for :c:func:`devm_memremap_pages`.
 
 The users of `ZONE_DEVICE` are:
+
 * pmem: Map platform persistent memory to be used as a direct-I/O target
   via DAX mappings.
 

