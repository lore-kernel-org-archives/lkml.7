Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E386BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D66206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PwTyUqcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfKLRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 12:42:30 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48844 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726718AbfKLRma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 12:42:30 -0500
Received: from zn.tnic (p200300EC2F0F7D00F1F1C49021D4BA0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:7d00:f1f1:c490:21d4:ba0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C9DD91EC0C9D;
        Tue, 12 Nov 2019 18:42:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1573580549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=KdwSeKpFeGkCZexTwaPuR/scs5WoNzCgE52M59AQT/E=;
        b=PwTyUqcgAEtRQrBVm7ANa3jGGw7BJ9wLkQw4AxawJheGUSTs0TfRmBT6WWAivBeP8XhRcs
        oOTrjzJRnUNaTgCWvFfZpA81BWp0tND0EmhEPTBu9Fo5MiHqdB9QAKLDO6GI/jxuXNYXsc
        NpSOxA1BMwnMq9U8E3kEcH/mF6VOv5o=
From:   Borislav Petkov <bp@alien8.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] tracing: Remove stray tab in TRACE_EVAL_MAP_FILE's help text
Date:   Tue, 12 Nov 2019 18:42:19 +0100
Message-Id: <20191112174219.10933-1-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

There was a stray tab in the help text of the aforementioned config
option which showed like this:

  The "print fmt" of the trace events will show the enum/sizeof names
  instead        of their values. This can cause problems for user space tools
  ...

in menuconfig. Remove it and end a sentence with a fullstop.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 kernel/trace/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index e08527f50d2a..d201bf8ee3b7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -763,7 +763,7 @@ config TRACE_EVAL_MAP_FILE
        depends on TRACING
        help
 	The "print fmt" of the trace events will show the enum/sizeof names
-	instead	of their values. This can cause problems for user space tools
+	instead of their values. This can cause problems for user space tools
 	that use this string to parse the raw data as user space does not know
 	how to convert the string to its value.
 
@@ -784,7 +784,7 @@ config TRACE_EVAL_MAP_FILE
 	they are needed for the "eval_map" file. Enabling this option will
 	increase the memory footprint of the running kernel.
 
-	If unsure, say N
+	If unsure, say N.
 
 config GCOV_PROFILE_FTRACE
 	bool "Enable GCOV profiling on ftrace subsystem"
-- 
2.21.0

