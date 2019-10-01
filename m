Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A40FC388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625AD21924
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569928368;
	bh=JfAVjjgUEXOR8W5/QmvNUNfsGdq2sh1oxI5Wsz310UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FVywt2sfZQJw3KHb84b9/SIs9IAE6VyqD3lgMht/G14YrVdDvA1QVqxrtNllDEBjb
	 H+FsZvPMMhPq+vWcXbgAiC1YwfWkApbaD6WjF/iXjn3ggUhSjv4G5d67bMhm4M9aan
	 TpMwv5b1PrKq5rE2j42TEy0tWOMwfqCay1ROC2rA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbfJALMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:12:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfJALMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:12:46 -0400
Received: from quaco.ghostprotocols.net (177.206.223.101.dynamic.adsl.gvt.net.br [177.206.223.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C0C21A4A;
        Tue,  1 Oct 2019 11:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569928365;
        bh=JfAVjjgUEXOR8W5/QmvNUNfsGdq2sh1oxI5Wsz310UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sgd8aIc3GdgmaCWsdPCj7e1lUEjk4RCnETGYNxLVatfdVqbXWhmRnA7fBEAlUJE4b
         YPCDQk3xg0qPpTetpyyAQEXcE/ktZjED/N2SFbg+ZFSC5YC3yXwfajCDig47EpAsth
         nc3+QZulm6Gmjvfw2Y+vAVan7Qalg6Ls9z78edF0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 04/24] tools headers uapi: Sync drm/i915_drm.h with the kernel sources
Date:   Tue,  1 Oct 2019 08:11:56 -0300
Message-Id: <20191001111216.7208-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001111216.7208-1-acme@kernel.org>
References: <20191001111216.7208-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To pick the change in:

  bf73fc0fa9cf ("drm/i915: Show support for accurate sw PMU busyness tracking")

That don't result in any changes in tooling, just silences this perf
build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/drm/i915_drm.h' differs from latest version at 'include/uapi/drm/i915_drm.h'
  diff -u tools/include/uapi/drm/i915_drm.h include/uapi/drm/i915_drm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-o651nt7vpz93tu3nmx4f3xql@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/drm/i915_drm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/drm/i915_drm.h b/tools/include/uapi/drm/i915_drm.h
index 328d05e77d9f..469dc512cca3 100644
--- a/tools/include/uapi/drm/i915_drm.h
+++ b/tools/include/uapi/drm/i915_drm.h
@@ -521,6 +521,7 @@ typedef struct drm_i915_irq_wait {
 #define   I915_SCHEDULER_CAP_PRIORITY	(1ul << 1)
 #define   I915_SCHEDULER_CAP_PREEMPTION	(1ul << 2)
 #define   I915_SCHEDULER_CAP_SEMAPHORES	(1ul << 3)
+#define   I915_SCHEDULER_CAP_ENGINE_BUSY_STATS	(1ul << 4)
 
 #define I915_PARAM_HUC_STATUS		 42
 
-- 
2.21.0

