Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D427BC3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A852F21897
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="QuKQ1KhW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbfIBKbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:31:23 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:59781 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728236AbfIBKbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:31:22 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Sep 2019 06:31:21 EDT
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46MR6N4ZWFzPp4p;
        Mon,  2 Sep 2019 12:25:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1567419900; bh=l5CqRKog55Myo9Fi9oeYz5lLnDQaiqDBNnVexwoenT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=QuKQ1KhWbQbzG0czmIJTXn5/iwHCCc6jzYVsuZ55xuZvkxzJHGYB1NhbsjfZuqR/t
         7jWCXIbcy28YCC4HZF19NZ8Y/CHyb9c2Q9O3ASeD/MsAVV/TM0CnstWzGu/xbJwvxl
         7pwS5kBKYVY7+6eJynyos4Tvu1iisLz0CjyLj+k+8Y+waUogSZGzCamOVVUENiX6/c
         B1aJ8InV+FgH8oFQfZk/UU4x31Nvpb1kLGTZuKjYeYq9FWdqpAUm94iyJOGXgQTq91
         LlEP5zd5Nqa9Ygzphz+VXtk86t6I3W8mcFaW4WLpKr58L2BVfXWSa28jAmwZBSHi+Y
         q7SpPFGKsNvSQ==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a
Received: from Marco-E580.fritz.box (p200300EC6BCD9E0070B165FC7ED4076A.dip0.t-ipconnect.de [IPv6:2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+2H56Xe6abfk+/4FCFPj8JAiP7GkEFJts=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46MR6L0kknzPp4s;
        Mon,  2 Sep 2019 12:24:58 +0200 (CEST)
From:   Marco Ammon <marco.ammon@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        trivial@kernel.org, Marco Ammon <marco.ammon@fau.de>
Subject: [PATCH 2/3] x86: fix typo in comment for alternative_instructions
Date:   Mon,  2 Sep 2019 12:24:35 +0200
Message-Id: <20190902102436.27396-2-marco.ammon@fau.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190902102436.27396-1-marco.ammon@fau.de>
References: <20190902102436.27396-1-marco.ammon@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the documentation for alternative_instructions, "a unlikely" should
actually be "an unlikely". This patch fixes the mistake.

Signed-off-by: Marco Ammon <marco.ammon@fau.de>
---
 arch/x86/kernel/alternative.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 0eefd497e3d8..9d3a971ea364 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -713,7 +713,7 @@ void __init alternative_instructions(void)
 	 * Don't stop machine check exceptions while patching.
 	 * MCEs only happen when something got corrupted and in this
 	 * case we must do something about the corruption.
-	 * Ignoring it is worse than a unlikely patching race.
+	 * Ignoring it is worse than an unlikely patching race.
 	 * Also machine checks tend to be broadcast and if one CPU
 	 * goes into machine check the others follow quickly, so we don't
 	 * expect a machine check to cause undue problems during to code
-- 
2.23.0

