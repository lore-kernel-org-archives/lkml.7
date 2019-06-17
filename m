Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6DAC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9772084D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 18:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xEwC/YKC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfFQSzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 14:55:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46379 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfFQSzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 14:55:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HIt0Gu3553142
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 11:55:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HIt0Gu3553142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560797701;
        bh=OZ9+y4s/VPsatrIElcD/Ugi7cw5VVMLhOCyUKcuHdtE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xEwC/YKCQbmuZvlkiv/GKJxg4zdG8UAtH4XaXNBS145RGmMk9FQQ/b2Qk6RoC1X79
         BfWdUCGIdrCs+Z4+Y1z5X0/s1wCllTxkkRRpB2tokiqlYTnFPSHzIq9858CzMoxcex
         ONsNpsfnmNB3RGqxYEuSxaY3ss567gwfpUDT7kC+DikfWBVs31z6agGeR89SlOaJXf
         XkG9MjXGe4IBq1jH6KB1G2wAAp1CzR5kJY5sswvVDMOdAiPnAy9PYbCJ7cem2kxx/l
         LJ7/TgHGvbo6am/AA5Hyievui2GfPD60mhFpTTHuGQe2//miYrATN0Ag5SgpYxbJW3
         +hdszh/5fiqUA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HIt02s3553139;
        Mon, 17 Jun 2019 11:55:00 -0700
Date:   Mon, 17 Jun 2019 11:55:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-8e21be4f815ca8edfee1decd87f298f92123f719@git.kernel.org>
Cc:     acme@redhat.com, hpa@zytor.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, mingo@kernel.org,
        tglx@linutronix.de, songliubraving@fb.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, songliubraving@fb.com,
          linux-kernel@vger.kernel.org, jolsa@kernel.org,
          peterz@infradead.org, acme@redhat.com, hpa@zytor.com
In-Reply-To: <20190521064406.2498925-1-songliubraving@fb.com>
References: <20190521064406.2498925-1-songliubraving@fb.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf data: Add description of header
 HEADER_BPF_PROG_INFO and HEADER_BPF_BTF
Git-Commit-ID: 8e21be4f815ca8edfee1decd87f298f92123f719
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  8e21be4f815ca8edfee1decd87f298f92123f719
Gitweb:     https://git.kernel.org/tip/8e21be4f815ca8edfee1decd87f298f92123f719
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 20 May 2019 23:44:06 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 5 Jun 2019 09:47:52 -0300

perf data: Add description of header HEADER_BPF_PROG_INFO and HEADER_BPF_BTF

This patch addes description of HEADER_BPF_PROG_INFO and HEADER_BPF_BTF to
perf.data-file-format.txt.

Requested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 606f972b1361 ("perf bpf: Save bpf_prog_info information as headers to perf.data")
Link: http://lkml.kernel.org/r/20190521064406.2498925-1-songliubraving@fb.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf.data-file-format.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index 6967e9b02be5..022bb8b1c84a 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -272,6 +272,22 @@ struct {
 
 Two uint64_t for the time of first sample and the time of last sample.
 
+        HEADER_BPF_PROG_INFO = 25,
+
+struct bpf_prog_info_linear, which contains detailed information about
+a BPF program, including type, id, tag, jited/xlated instructions, etc.
+
+        HEADER_BPF_BTF = 26,
+
+Contains BPF Type Format (BTF). For more information about BTF, please
+refer to Documentation/bpf/btf.rst.
+
+struct {
+	u32	id;
+	u32	data_size;
+	char	data[];
+};
+
         HEADER_COMPRESSED = 27,
 
 struct {
