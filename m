Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B64C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF58206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 13:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbfJHN0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 09:26:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:25422 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730317AbfJHN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 09:26:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Oct 2019 06:26:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,270,1566889200"; 
   d="scan'208";a="206634811"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 06:26:06 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] device property: Fix the description of struct fwnode_operations
Date:   Tue,  8 Oct 2019 16:26:06 +0300
Message-Id: <20191008132606.56434-1-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding description for the device_is_available member which
was missing, and fixing the description of the member
property_read_int_array.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/fwnode.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 6ae05b9ce359..fc002aacae8d 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -50,11 +50,11 @@ struct fwnode_reference_args {
  * struct fwnode_operations - Operations for fwnode interface
  * @get: Get a reference to an fwnode.
  * @put: Put a reference to an fwnode.
+ * @device_is_available: Return true if the device is available.
  * @device_get_match_data: Return the device driver match data.
  * @property_present: Return true if a property is present.
- * @property_read_integer_array: Read an array of integer properties. Return
- *				 zero on success, a negative error code
- *				 otherwise.
+ * @property_read_int_array: Read an array of integer properties. Return zero on
+ *			     success, a negative error code otherwise.
  * @property_read_string_array: Read an array of string properties. Return zero
  *				on success, a negative error code otherwise.
  * @get_parent: Return the parent of an fwnode.
-- 
2.23.0

