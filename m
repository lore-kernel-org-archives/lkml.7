Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C6BC4646B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B6F20820
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 17:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561223836;
	bh=PaLa3Sc1NDz1LEUlevWQAzTMu0D1pVMZfRfoUUFwnl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S18DS2IniaqVxR2ixdXybecVkRoSV38Cn54C6M4EY0nD0dQqEbXj6F3szGVQb5I9Z
	 sDXr6joz1rzFAfsfzvYUaNCGfhx2R3jp7nGOmg0l02Wfw7TSsZlEQv9dnRj7zcYLYB
	 uJlzgx3JgAcaTiawKg8UiNtF/NFWjxivYoRhVDyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfFVRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 13:17:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43804 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbfFVRRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 13:17:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/fqpHAt8CSw6pch/Pj9aN8ynFTK0mhOoYKSJDMULvgk=; b=nv6Rgic/hNzrSqAfC5jG/edRyV
        4P/pbbAa1vt7C0pHqlJX8W1Ah8H3uc/h9DBk+p1xxfVfN6W4KmUTd6OozGjHHustnZ7QBZSmoEOC3
        YWwJYVK70iimup4E5UV4GNWCx37q2oLeKwqcIeEc8KekTGpeeH4ilob3RMuuMI59E5zzuPbWbAkAT
        u5Q0NIQCgeu68pM2J8JWhcFJZ8xdB0RlEuDCJ1wwjrigvJ4LDGSxMG+BPSZUB+tY7ZcN7cwekT15I
        bSfP6x1LbXeWDL64mCMmhQLg61fTGxZrVDW6kiNhTGyYmspTEy7zRsaCXskq+uaRskp3XI1ycNuwG
        Fj2qRlrA==;
Received: from [179.95.45.115] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hejdX-0002tf-Sn; Sat, 22 Jun 2019 17:17:11 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hejdV-00014X-7Z; Sat, 22 Jun 2019 14:17:09 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        gregkh@linuxfoundation.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 4/4] docs: admin-guide, x86: add a features list
Date:   Sat, 22 Jun 2019 14:17:07 -0300
Message-Id: <bb4a41b13f37d20836ca7eb0e392f1fbfc641534.1561222784.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561222784.git.mchehab+samsung@kernel.org>
References: <cover.1561222784.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a feature list matrix at the admin-guide and a x86-specific
feature list to the respective Kernel books.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/features.rst | 3 +++
 Documentation/admin-guide/index.rst    | 1 +
 Documentation/conf.py                  | 2 +-
 Documentation/x86/features.rst         | 3 +++
 Documentation/x86/index.rst            | 1 +
 5 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/features.rst
 create mode 100644 Documentation/x86/features.rst

diff --git a/Documentation/admin-guide/features.rst b/Documentation/admin-guide/features.rst
new file mode 100644
index 000000000000..8c167082a84f
--- /dev/null
+++ b/Documentation/admin-guide/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 20c3020fd73c..14c8464f6ca9 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -17,6 +17,7 @@ etc.
    kernel-parameters
    devices
    abi
+   features
 
 This section describes CPU vulnerabilities and their mitigations.
 
diff --git a/Documentation/conf.py b/Documentation/conf.py
index 598256fb5c98..a0ef76ce5615 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -34,7 +34,7 @@ needs_sphinx = '1.3'
 # Add any Sphinx extension module names here, as strings. They can be
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig', 'kernel_abi']
+extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain', 'kfigure', 'sphinx.ext.ifconfig', 'kernel_abi', 'kernel_feat']
 
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
diff --git a/Documentation/x86/features.rst b/Documentation/x86/features.rst
new file mode 100644
index 000000000000..b663f15053ce
--- /dev/null
+++ b/Documentation/x86/features.rst
@@ -0,0 +1,3 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. kernel-feat:: $srctree/Documentation/features x86
diff --git a/Documentation/x86/index.rst b/Documentation/x86/index.rst
index ae36fc5fc649..ed42c8c9154d 100644
--- a/Documentation/x86/index.rst
+++ b/Documentation/x86/index.rst
@@ -29,3 +29,4 @@ x86-specific Documentation
    usb-legacy-support
    i386/index
    x86_64/index
+   features
-- 
2.21.0

