Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BC9C432C2
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6137207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 23:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UVGLhPIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411111AbfIXXDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 19:03:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38936 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411090AbfIXXDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 19:03:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so1576033plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z78DOvz8kzmGfG9Z2xiQ3oJZKxQKLVG8/acy4oN8Dcw=;
        b=UVGLhPIlLPwA2fzJ+wVaUhS6pEHgDSU5sIJC63sH0BLpe69DNRtNuiIJyYrzelDeaf
         MgKwl9/FlXbtX52BrZDiA+IeCY/vKSzDzLpECw+WDUR8vBprkRjxxGJizDk3GJ1ZGKKl
         fXYopgvY3t4DldwNzk/tA27LccP149dyOs3YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z78DOvz8kzmGfG9Z2xiQ3oJZKxQKLVG8/acy4oN8Dcw=;
        b=iFGuA7z7fxTxCnJmMjs8nmOHCjHgqGU0MivDYZpTXWJKsIwKdz17giV6ibdCwbi70g
         6w1OkhX85dal42G0/N9i9RVUsPP+LlBKtcm7a4ZyVVWjVEcEDusY+ruaY7lq7SzlJz6D
         PJ/ZW5yJ9UIbxVBqolKI1ThKknRIhv1teKXaUrxdZgazTQNqzG/sclNHPHj7lLkC/18L
         UJXjCZ6pTLhDB1EB+XOxHSJx1e7JpoJ38MpN8T3gwGm0TNIyLIftK98ilpkZVISsgROr
         JiOYTDTzULV5fVGiTyoUX4758SPJUoIFBOBccOtViSv0v1+BJqTWE7ZUyaTkqVGAm39C
         ngZg==
X-Gm-Message-State: APjAAAUZH0AuREauv5TnOJPSmZXt8SRD9WrA732IGneiCLbIeXFHhKba
        ZW1A18Q57Z2hnAdyj/urDXZLbA==
X-Google-Smtp-Source: APXvYqysxzEuZoZvT3DDEQl8xU4WetYZVs/nuAbLjO6TaN9J4WjH9sF+m69lffaPTukZqV9jJJHfuQ==
X-Received: by 2002:a17:902:b482:: with SMTP id y2mr5454384plr.334.1569366131597;
        Tue, 24 Sep 2019 16:02:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n9sm843745pjq.30.2019.09.24.16.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 16:02:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] doc-rst: Reduce CSS padding around Field
Date:   Tue, 24 Sep 2019 16:02:07 -0700
Message-Id: <20190924230208.12414-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190924230208.12414-1-keescook@chromium.org>
References: <20190924230208.12414-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now any ":Field Name: Field Contents" lines end up with significant
padding due to CSS from the "table" CSS which rightly needs padding to
make tables readable. However, field lists don't need this as they tend
to be stacked together. The future heavy use of fields in the parsed
MAINTAINERS file needs this cleaned up, and existing users look better
too. Note the needless white space (and misalignment of name/contents)
between "Date" and "Author":

https://www.kernel.org/doc/html/latest/accounting/psi.html

This patch fixes this by lowering the padding with a more specific CSS.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/sphinx-static/theme_overrides.css | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/sphinx-static/theme_overrides.css b/Documentation/sphinx-static/theme_overrides.css
index e21e36cd6761..459ec5b29d68 100644
--- a/Documentation/sphinx-static/theme_overrides.css
+++ b/Documentation/sphinx-static/theme_overrides.css
@@ -53,6 +53,16 @@ div[class^="highlight"] pre {
     line-height: normal;
 }
 
+/* Keep fields from being strangely far apart due to inheirited table CSS. */
+.rst-content table.field-list th.field-name {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+.rst-content table.field-list td.field-body {
+    padding-top: 1px;
+    padding-bottom: 1px;
+}
+
 @media screen {
 
     /* content column
-- 
2.17.1

