Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DEFC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA7621743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wvwzv92q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfD3Kwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:52:30 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:32768 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfD3KwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=nTtk8rbDTbbpjpuAwoQzV/q5JhA1Xaj3G5/agqhHoJ4=; b=Wvwzv92qJ3P0XSvT/WZ1Kd/R2l
        ziTcxsQ+oDgI28wUAUgx/cdzEx+584WnUaZnWI1cCooch4VecXwVxzBkWZKq5BYPDMKxT+nfoT/by
        xeR3Xkj62zQ2XYaG86R6zXAyM9dgE8WSaN98SunV5rcb5ulUiTcR7Toi44SRZYeZ6dKLlT+70NVNG
        5XobsZ2yUxCh0uQOlcnmbQOH2Ry02B2UGE/OtGVCnt3LBdTfrLx6rwGvUsLDVvyVdzfOgVq25W7ds
        5hnQwxotNXFS5eVVh1VqC0K9W41PGuC9l+v7ZWR3sh9p8owKQybs1dVyWhTYSTJJ7K7I5JeKa1ZK7
        04T0IcEQ==;
Received: from adsl-173-228-226-134.prtc.net ([173.228.226.134] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLQMu-0007EL-AV; Tue, 30 Apr 2019 10:52:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] LICENSES: Clearly mark dual license only licenses
Date:   Tue, 30 Apr 2019 06:51:29 -0400
Message-Id: <20190430105130.24500-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190430105130.24500-1-hch@lst.de>
References: <20190430105130.24500-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the CDDL the Apache license and the MPL must only be used as
a choice in additional to an GPL2 compatible license.  Copy over the
boilerplate from the CDDL file to the other two after fixing it up to
make it clear the licenses need to be GPL2 compatible, not just the
more generic GPL compatible.  For example the Apache 2 license is GPL3
compatible, but that doesn't matter for the kernel.

Also move these licenses to a separate directory and document the rules
in license-rules.rst.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/process/license-rules.rst | 51 ++++++++++++++++++++++++-
 LICENSES/{other => dual}/Apache-2.0     |  4 ++
 LICENSES/{other => dual}/CDDL-1.0       |  4 +-
 LICENSES/{other => dual}/MPL-1.1        |  4 ++
 4 files changed, 60 insertions(+), 3 deletions(-)
 rename LICENSES/{other => dual}/Apache-2.0 (97%)
 rename LICENSES/{other => dual}/CDDL-1.0 (99%)
 rename LICENSES/{other => dual}/MPL-1.1 (99%)

diff --git a/Documentation/process/license-rules.rst b/Documentation/process/license-rules.rst
index ade495fe6811..507b695fa9da 100644
--- a/Documentation/process/license-rules.rst
+++ b/Documentation/process/license-rules.rst
@@ -281,7 +281,56 @@ kernel, can be broken down into:
 
 |
 
-3. _`Exceptions`:
+3. Dual Licensing Only
+
+   These licenses should only be used to dual license code with another
+   license in addition to a preferred license.  These licenses are available
+   from the directory::
+
+      LICENSES/dual/
+
+   in the kernel source tree.
+
+   The files in this directory contain the full license text and
+   `Metatags`_.  The file names are identical to the SPDX license
+   identifier which shall be used for the license in source files.
+
+   Examples::
+
+      LICENSES/dual/MPL-1.1
+
+   Contains the Mozilla Public License version 1.1 license text and the
+   required metatags::
+
+      LICENSES/dual/Apache-2.0
+
+   Contains the Apache License version 2.0 license text and the required
+   metatags.
+
+   Metatags:
+
+   The metatag requirements for 'other' licenses are identical to the
+   requirements of the `Preferred licenses`_.
+
+   File format example::
+
+      Valid-License-Identifier: MPL-1.1
+      SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
+      Usage-Guide:
+        Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used for
+        dual-licensed files where the other license is GPL2 compatible.
+        If you end up using this it MUST be used together with a GPL2 compatible
+        license using "OR".
+        To use the Mozilla Public License version 1.1 put the following SPDX
+        tag/value pair into a comment according to the placement guidelines in
+        the licensing rules documentation:
+      SPDX-License-Identifier: MPL-1.1
+      License-Text:
+        Full license text
+
+|
+
+4. _`Exceptions`:
 
    Some licenses can be amended with exceptions which grant certain rights
    which the original license does not.  These exceptions are available
diff --git a/LICENSES/other/Apache-2.0 b/LICENSES/dual/Apache-2.0
similarity index 97%
rename from LICENSES/other/Apache-2.0
rename to LICENSES/dual/Apache-2.0
index 7cd903f573e5..6e89ddeab187 100644
--- a/LICENSES/other/Apache-2.0
+++ b/LICENSES/dual/Apache-2.0
@@ -1,6 +1,10 @@
 Valid-License-Identifier: Apache-2.0
 SPDX-URL: https://spdx.org/licenses/Apache-2.0.html
 Usage-Guide:
+  Do NOT use. The Apache-2.0 is not GPL2 compatible. It may only be used
+  for dual-licensed files where the other license is GPL2 compatible.
+  If you end up using this it MUST be used together with a GPL2 compatible
+  license using "OR".
   To use the Apache License version 2.0 put the following SPDX tag/value
   pair into a comment according to the placement guidelines in the
   licensing rules documentation:
diff --git a/LICENSES/other/CDDL-1.0 b/LICENSES/dual/CDDL-1.0
similarity index 99%
rename from LICENSES/other/CDDL-1.0
rename to LICENSES/dual/CDDL-1.0
index 25f614276ddd..b0ca1016db79 100644
--- a/LICENSES/other/CDDL-1.0
+++ b/LICENSES/dual/CDDL-1.0
@@ -1,8 +1,8 @@
 Valid-License-Identifier: CDDL-1.0
 SPDX-URL: https://spdx.org/licenses/CDDL-1.0.html
 Usage-Guide:
-  Do NOT use. The CDDL-1.0 is not GPL compatible. It may only be used for
-  dual-licensed files where the other license is GPL compatible.
+  Do NOT use. The CDDL-1.0 is not GPL2 compatible. It may only be used for
+  dual-licensed files where the other license is GPL2 compatible.
   If you end up using this it MUST be used together with a GPL2 compatible
   license using "OR".
   To use the Common Development and Distribution License 1.0 put the
diff --git a/LICENSES/other/MPL-1.1 b/LICENSES/dual/MPL-1.1
similarity index 99%
rename from LICENSES/other/MPL-1.1
rename to LICENSES/dual/MPL-1.1
index 568b6049efe6..61706859e1b2 100644
--- a/LICENSES/other/MPL-1.1
+++ b/LICENSES/dual/MPL-1.1
@@ -1,6 +1,10 @@
 Valid-License-Identifier: MPL-1.1
 SPDX-URL: https://spdx.org/licenses/MPL-1.1.html
 Usage-Guide:
+  Do NOT use. The MPL-1.1 is not GPL2 compatible. It may only be used for
+  dual-licensed files where the other license is GPL2 compatible.
+  If you end up using this it MUST be used together with a GPL2 compatible
+  license using "OR".
   To use the Mozilla Public License version 1.1 put the following SPDX
   tag/value pair into a comment according to the placement guidelines in
   the licensing rules documentation:
-- 
2.20.1

