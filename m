Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F409ECE58F
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37D4F2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 02:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571194644;
	bh=QcvjcZhhDwySKoPuQHzX8i9cXnr4fp5bwaMkIAToTLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zscsHWqTz75fcUQI9DeOx2bge/aHHwKLDWArBJ4NsD4+Fc1YhEwOuogHgpuTb6bEX
	 sYCbI8GFk/SFgtUX3Sg5aQPAGAgo1MWMjjiHaAc9EK6KRBwShiF8YAKFK4t+LCPQc2
	 nO+13OWetlHNQGp+SsPIATjrkYg2nl8g8j382m+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbfJPC5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 22:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390685AbfJPC5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 22:57:18 -0400
Received: from lenoir.home (lfbn-ncy-1-150-155.w83-194.abo.wanadoo.fr [83.194.232.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BABCC217D6;
        Wed, 16 Oct 2019 02:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571194638;
        bh=QcvjcZhhDwySKoPuQHzX8i9cXnr4fp5bwaMkIAToTLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EqHsLIOfqpg3R9B8q86h01AFDwPtp+plxWoQU7a5h2/EtZBFL6vS7LOEs5ETRDg7n
         Wu/jaxtd3sTiCk9mkVH6WQYtK59EtG2ynAJbSVevNOroxXL7xP/dsxyuUcwLreTOno
         CW2XTHn6D236HK5uDptpg6EWV82LnreGo94tV0VY=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH 04/14] context_tracking: Remove context_tracking_active()
Date:   Wed, 16 Oct 2019 04:56:50 +0200
Message-Id: <20191016025700.31277-5-frederic@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016025700.31277-1-frederic@kernel.org>
References: <20191016025700.31277-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is a leftover from old removal or rename. We can drop it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wanpeng Li <wanpengli@tencent.com>
Cc: Ingo Molnar <mingo@kernel.org>
---
 include/linux/context_tracking_state.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index f128dc3be0df..f4633c2c29a5 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -42,7 +42,6 @@ static inline bool context_tracking_in_user(void)
 }
 #else
 static inline bool context_tracking_in_user(void) { return false; }
-static inline bool context_tracking_active(void) { return false; }
 static inline bool context_tracking_is_enabled(void) { return false; }
 static inline bool context_tracking_cpu_is_enabled(void) { return false; }
 #endif /* CONFIG_CONTEXT_TRACKING */
-- 
2.23.0

