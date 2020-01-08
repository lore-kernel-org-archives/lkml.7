Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A501DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F87206F0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 12:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgAHMxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:53:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:27598 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727119AbgAHMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 07:53:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 04:53:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="271819422"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jan 2020 04:53:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2AEB72FB; Wed,  8 Jan 2020 14:53:18 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Use linux-usb mailing list for Thunderbolt and USB4 patches
Date:   Wed,  8 Jan 2020 15:53:17 +0300
Message-Id: <20200108125317.36444-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108125317.36444-1-mika.westerberg@linux.intel.com>
References: <20200108125317.36444-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that Thunderbolt public specification is called USB4 and is coming
from USB IF it makes sense to use linux-usb as mailing list for patches
touching this driver.

Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8982c6e013b3..57cdf745e92e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16375,6 +16375,7 @@ M:	Andreas Noever <andreas.noever@gmail.com>
 M:	Michael Jamet <michael.jamet@intel.com>
 M:	Mika Westerberg <mika.westerberg@linux.intel.com>
 M:	Yehezkel Bernat <YehezkelShB@gmail.com>
+L:	linux-usb@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
 S:	Maintained
 F:	Documentation/admin-guide/thunderbolt.rst
-- 
2.24.1

