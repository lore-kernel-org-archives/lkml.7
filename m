Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C014C3A5A5
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C5D20820
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 10:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="feQQ24a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730956AbfIBKbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 06:31:25 -0400
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:58673 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730880AbfIBKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 06:31:23 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 46MR6F28s5zPnxD;
        Mon,  2 Sep 2019 12:24:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1567419893; bh=7PNfOShZq9XQbGEA9kJNYAZx+o4dL0AwK/oHuiYjAwg=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=feQQ24a7V8rkNC8++tJl1F6MiOhGYEzG8MSD9yOkGWrdNmK+SFOnYD/YS0NTeLGyb
         tZWgv+7F6lMuHhSo45ZiiFWfWLRhArWwGszOGJURhqd4SJRD6ZqF5I2DimVSX3dFdv
         QhcMUJBsMc3ngdr6ErLU/JQ1WDp8h5xRDwBCQNmvxW+F6P0+DVmGWpuK6I8KHnx6b6
         4zGtECDfMz6XbKbDYXltOdjboXBN3RvnAd/ZD0cHC1JnIkweTglT4p1/46W2FpoP2C
         YDXJvN0sr4ilF5O4oKbpy8eHERJyp4HhfENFpJ0BHkjy6zhWgRB3NJc7rPNB8PSNtI
         9uZRdjvH/PMvw==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a
Received: from Marco-E580.fritz.box (p200300EC6BCD9E0070B165FC7ED4076A.dip0.t-ipconnect.de [IPv6:2003:ec:6bcd:9e00:70b1:65fc:7ed4:76a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18+zHK+FqAwN9M7YvgbOTsFhBmB17DGhAg=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 46MR6B4v8RzPp4k;
        Mon,  2 Sep 2019 12:24:50 +0200 (CEST)
From:   Marco Ammon <marco.ammon@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        trivial@kernel.org, Marco Ammon <marco.ammon@fau.de>
Subject: [PATCH 1/3] x86: fix typo in comment for poke_text_early
Date:   Mon,  2 Sep 2019 12:24:34 +0200
Message-Id: <20190902102436.27396-1-marco.ammon@fau.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the documentation for text_poke_early, "protected again" should
actually be "protected against". This patch fixes the spelling mistake.

Signed-off-by: Marco Ammon <marco.ammon@fau.de>
---
 arch/x86/include/asm/text-patching.h | 4 ++--
 arch/x86/kernel/alternative.c        | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 70c09967a999..5e8319bb207a 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,8 +45,8 @@ extern void text_poke_early(void *addr, const void *opcode, size_t len);
  * no thread can be preempted in the instructions being modified (no iret to an
  * invalid instruction possible) or if the instructions are changed from a
  * consistent state to another consistent state atomically.
- * On the local CPU you need to be protected again NMI or MCE handlers seeing an
- * inconsistent instruction while you patch.
+ * On the local CPU you need to be protected against NMI or MCE handlers seeing
+ * an inconsistent instruction while you patch.
  */
 extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index ccd32013c47a..0eefd497e3d8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -753,8 +753,8 @@ void __init alternative_instructions(void)
  * When you use this code to patch more than one byte of an instruction
  * you need to make sure that other CPUs cannot execute this code in parallel.
  * Also no thread must be currently preempted in the middle of these
- * instructions. And on the local CPU you need to be protected again NMI or MCE
- * handlers seeing an inconsistent instruction while you patch.
+ * instructions. And on the local CPU you need to be protected against NMI or
+ * MCE handlers seeing an inconsistent instruction while you patch.
  */
 void __init_or_module text_poke_early(void *addr, const void *opcode,
 				      size_t len)
-- 
2.23.0

