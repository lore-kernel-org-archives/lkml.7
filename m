Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1696DC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6C6208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 12:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561723970;
	bh=NVHzlpmUQ72ZWLHFmtEs75k0rxX4M0GYyDHiRZk8N6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U9jyWWGp67HYJnODmFZvM6Knh/A7oCyCqCPFcoKTkxDEy9bpuTZgPzM6aA0PzH4bD
	 VuOaIfojmFm4p/bmWUkuVoMtOM0Q0zHIr8JstLI4f5nHu5GaR5K/zvart1k5tppZEa
	 bOUKXrg7L98dqF5kiDYhHG0yCjYXk8+AYV1X/K2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfF1MMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 08:12:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58232 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbfF1MMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 08:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=c2MTeld4vzkJB1O7NzF5HLwc9FIFwZiTcGNkD8j/Q/E=; b=Roa70AufGatpCUuFbqPrEsV9bL
        50WmazvYf/i05ux+Sv3ILOHBmqIYwz46yoxM2gtAJZM2Pe/XRm37QQouZKcK3yG5COs89XtDKUY/P
        vmRB4mG80uBRdR2HJ/pvMY8JJ4Ex2+ul7jhXxAZWZdnK5e9HMtJbO0H3oj6KPQ+KQQUzvaDuRa10c
        BiLNKx+XKKScMtCekk/AyDsY0WItKsyaMNvGd+rHKhvVJEKGx/ou68V8NSFBMM7OvXlSo2TtKSEo3
        D3uCrBCG4pTambaQVk3fQBDDThPKNwgaPPsAiNzBaodmvIreYfV3+lGN6amg7UCf5XtPo4MbijTqa
        /CvMHh0g==;
Received: from [186.213.242.156] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hgpk3-0005BV-8Z; Fri, 28 Jun 2019 12:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1hgpk0-0004zP-7d; Fri, 28 Jun 2019 09:12:32 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/9] docs: trace: fix a broken label
Date:   Fri, 28 Jun 2019 09:12:24 -0300
Message-Id: <ebdaa804ada383289de537a66c5b345fe0f37f9d.1561723736.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561723736.git.mchehab+samsung@kernel.org>
References: <cover.1561723736.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx warnings about his:

	Documentation/trace/kprobetrace.rst:68: WARNING: undefined label: user_mem_access (if the link has no caption the label must precede a section header)

The problem is quite simple: Sphinx wants a blank line after
references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/trace/kprobetrace.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index fbb314bfa112..89ba487d4399 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -96,6 +96,7 @@ which shows given pointer in "symbol+offset" style.
 For $comm, the default type is "string"; any other type is invalid.
 
 .. _user_mem_access:
+
 User Memory Access
 ------------------
 Kprobe events supports user-space memory access. For that purpose, you can use
-- 
2.21.0

