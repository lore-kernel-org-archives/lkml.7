Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A54ECE58A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE7820815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 18:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eGWf2T8s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732348AbfJASZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 14:25:42 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41093 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbfJASZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 14:25:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id s1so10248522pgv.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 11:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z78DOvz8kzmGfG9Z2xiQ3oJZKxQKLVG8/acy4oN8Dcw=;
        b=eGWf2T8sSynGC2rohuPpxezKnt/2MdAbe2kmU38KOEEr1AOEToOk+D0v0KZgZpCnQH
         OaMpO5xtn/aw6XxNXr5X64tnTR2Qmbg+2qEbDNDp6cG8k3Qkw9S8ogPg/E/woKdUQKZR
         WDi2F+Z93nlXJm1SKJW+RCLLKdqR8+/DCZAVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z78DOvz8kzmGfG9Z2xiQ3oJZKxQKLVG8/acy4oN8Dcw=;
        b=ZSgyrWia+Z/NPx1GVFmXSAiylfH4JX2xBdTyDVvFwzsWCZoWTrpf7Qe8cNInwchzT+
         j4qXwHWGQo5K2nVAmf/1b28at8/zbmRQW8+QXzb0qHpQ2R/6mHTXQ5l4AHnAhXBFZkYX
         OCDIviqejqiaDCNdye+e6K7TWkbnZpkav5cZE85Y4z1UakdhRUOE0pVPdgi3Qotxktfc
         IbpUYKuxz2zhqwWzBo2yedgx/oq1E9k++X9cnLxY/EyLwso9bmQhTBAJy6QskK4lQUOm
         yznYtPuItcJYyJSJf5j2L85+10zlauIFxVdASkwXCOuCdEvuhjSlqXI48stuk7KK/LbW
         3rSg==
X-Gm-Message-State: APjAAAU3LnkiX9/1r6YtK6JRwCKyYnNYMOTwTSPsVZTVpQuxf8bgtRPI
        5ivi4ygr0X88e6GovDAIBzLNzw==
X-Google-Smtp-Source: APXvYqxmcbMyJTaRzE/DNM8yFk2B+0LtMbDGHuNUFGXfcfl6cq9uMy+/Tm1S4m5uWiep+jpOqZsiQg==
X-Received: by 2002:a63:d901:: with SMTP id r1mr31912514pgg.159.1569954338929;
        Tue, 01 Oct 2019 11:25:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b11sm17860627pgr.20.2019.10.01.11.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 11:25:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] doc-rst: Reduce CSS padding around Field
Date:   Tue,  1 Oct 2019 11:25:31 -0700
Message-Id: <20191001182532.21538-2-keescook@chromium.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001182532.21538-1-keescook@chromium.org>
References: <20191001182532.21538-1-keescook@chromium.org>
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

