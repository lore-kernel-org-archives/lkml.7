Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB809C74A5B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA7A320872
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 16:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562863006;
	bh=SRPiMyIccRI4B0O/NdGPz8Oetbs1P8gxCt0qlY6hKxE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=P/WCWT/FLgqgSLQUFsklXm7BZWjQMb/zecv6MCSj8v5MfVTQMULsjnUeLBgZNuz/s
	 v6fi3yKuUmHG6/+gT3xhMBAORhJfgnD6dfgCoWI8Hdbp6UNuup3JJAwyLG/lwpeYqL
	 SFvAMgxosd8Pca6AecO6I9s5sOw8P9qn/iT4OzxI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbfGKQgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 12:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:39568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfGKQgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 12:36:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EBA620863;
        Thu, 11 Jul 2019 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562863004;
        bh=SRPiMyIccRI4B0O/NdGPz8Oetbs1P8gxCt0qlY6hKxE=;
        h=From:To:Cc:Subject:Date:From;
        b=eg+GSZ7e1xYuoLRBS2980GM1FfYNwoASK5NjfQgLbXXQwJ0/Rxxb64NXfbTcHossB
         T7EGMuNIHLkt+CY7CDYdN4BJKtt+wyc7bextGuy6SoUNH/XIfVZASoETKO/A1ezbS0
         5jF8mdLEYPmztGqJqzrR0ZkpFYvxuM3sVahTu33w=
From:   Sasha Levin <sashal@kernel.org>
To:     corbet@lwn.net, solar@openwall.com
Cc:     will@kernel.org, keescook@chromium.org, peterz@infradead.org,
        gregkh@linuxfoundation.org, tyhicks@canonical.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] Documentation/security-bugs: provide more information about linux-distros
Date:   Thu, 11 Jul 2019 12:36:37 -0400
Message-Id: <20190711163637.30327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide more information about how to interact with the linux-distros
mailing list for disclosing security bugs.

First, clarify that the reporter must read and accept the linux-distros
policies prior to sending a report.

Second, clarify that the reported must provide a tentative public
disclosure date and time in his first contact with linux-distros.

Suggested-by: Solar Designer <solar@openwall.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/admin-guide/security-bugs.rst | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/security-bugs.rst b/Documentation/admin-guide/security-bugs.rst
index dcd6c93c7aac..c62faced9256 100644
--- a/Documentation/admin-guide/security-bugs.rst
+++ b/Documentation/admin-guide/security-bugs.rst
@@ -61,14 +61,19 @@ Coordination
 
 Fixes for sensitive bugs, such as those that might lead to privilege
 escalations, may need to be coordinated with the private
-<linux-distros@vs.openwall.org> mailing list so that distribution vendors
-are well prepared to issue a fixed kernel upon public disclosure of the
-upstream fix. Distros will need some time to test the proposed patch and
-will generally request at least a few days of embargo, and vendor update
-publication prefers to happen Tuesday through Thursday. When appropriate,
-the security team can assist with this coordination, or the reporter can
-include linux-distros from the start. In this case, remember to prefix
-the email Subject line with "[vs]" as described in the linux-distros wiki:
+<linux-distros@vs.openwall.org> mailing list so that distribution vendors are
+well prepared to issue a fixed kernel upon public disclosure of the upstream
+fix. As a reporter, you must read and accept the list's policy as outlined in
+the linux-distros wiki:
+<https://oss-security.openwall.org/wiki/mailing-lists/distros#list-policy-and-instructions-for-reporters>.
+When you report a bug, you must also provide a tentative disclosure date and
+time in your very first message to the list. Distros will need some time to
+test the proposed patch so please allow at least a few days of embargo, and
+vendor update publication prefers to happen Tuesday through Thursday. When
+appropriate, the security team can assist with this coordination, or the
+reporter can include linux-distros from the start. In this case, remember to
+prefix the email Subject line with "[vs]" as described in the linux-distros
+wiki:
 <http://oss-security.openwall.org/wiki/mailing-lists/distros#how-to-use-the-lists>
 
 CVE assignment
-- 
2.20.1

