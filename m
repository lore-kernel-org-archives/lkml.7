Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7C9C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA80120657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfCKNTb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:19:31 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43373 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfCKNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:29 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mzhax-1gqUxF0ljl-00vj8U for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 005/114] fs: 9p: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:17 +0100
Message-Id: <1552310346-7629-6-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:R30D1OaZ5Nols/dyP35MH8/SF6ijtK6c+BdOzVZJVqgN/hz84Vj
 g0egd7d++AYjbqkrM4Z1L33/jsfoDSfEWlMxZsWmKSzTVJv/jG1VZc4RgwsbTQK5q/kAWg/
 cFVKUo4RAvp6IaL/4XpcO4ysMYPhbgszqSfsy3fLfYPbR+i5R09p3C8Q7R8jvCI0OYkMIPy
 OKn7VtvqUxrDm0zGzBPBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:863297sOTmI=:gjmddDyQhiXRwr16Sxc2vg
 8lxr1jMaREVSayeUwJPpzsPvxTbcyl58oH1DPsK3e3xNA4XbjQoJqkU483gWRz9XT+3vgYUOx
 M7sL6jdGE++CRpW3rzDf9gVs/27AaxOQVxKUO1KfgEyVcLkoyNMX9/Fl+62/sz7eW/XjtQFDu
 yQSqwevQDt4NpSKRtI58hQ+UF9S4BVZGB8pJLrsWOmW8e9EDbTbcJDgT6cJgABJVGYgZTdEx9
 KP0Zi/HnnJ+k7r8lnPdxGjiBTy+gRCtQujeUuuTedfANke6Iv79ksDcfz7iQ02y/OzX4Rb1Vs
 viKcLt7m3pUa42ZizrS07YrHlVf9SSap3wKfYX31fJ7wK8UaO/aJVEg3GQoFbQZT4KP+Mwrcp
 WNeuTV0QM+RF38cTmccaQhZH+uL0H5jZ3ZP3JbZCN4zO3V4PctjqtMAqUlVCsSJ81rZ2mvr5F
 l3Nw+vLdIuTKOSviDtFI3BRtATYw4eo4h1Lg2Cj29ShCw80IuP6e1aoMvj06gcrw6ZK8yt12N
 aTM0cM83BrbdsYxUn/6jq8YVYZii8oVKCtL3rlF0FrkeFdT+wNhX0aywis1baQAdKArgfqZkj
 Ax5T0IavZHrYCGqDhwIn2BepRUhP2rKAMCqFfR8AmUaRTDgUSYDtM9GtIhbi7fiuzk+ddKfdr
 fidLTQjOh5LmG2e8nJUdb3D9EKZb9LrGcDwbb0eTqmI+2/kkqZRLT/9aDgz3kTxT8l0QHpgDM
 lrfn8IhbhQlM5YZ/buDALq4VKdpu3p0pF/6QgA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 fs/9p/Kconfig | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index 11045d8..e416057 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -31,13 +31,13 @@ endif
 
 
 config 9P_FS_SECURITY
-        bool "9P Security Labels"
-        depends on 9P_FS
-        help
-          Security labels support alternative access control models
-          implemented by security modules like SELinux.  This option
-          enables an extended attribute handler for file security
-          labels in the 9P filesystem.
-
-          If you are not using a security module that requires using
-          extended attributes for file security labels, say N.
+	bool "9P Security Labels"
+	depends on 9P_FS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the 9P filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
-- 
1.9.1

