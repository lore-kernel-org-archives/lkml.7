Return-Path: <SRS0=geQ9=WA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D58BC433FF
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B220E20882
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Aug 2019 21:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lekensteyn.nl header.i=@lekensteyn.nl header.b="L/HAgjqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfHDVY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Aug 2019 17:24:57 -0400
Received: from lekensteyn.nl ([178.21.112.251]:33015 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfHDVY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Aug 2019 17:24:57 -0400
X-Greylist: delayed 1860 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Aug 2019 17:24:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=X5gpk4lm+i+m9UzCnxM5i6Q9YO0ZcDFBQlf5ZYD8GVE=;
        b=L/HAgjqPM9PEqP9Lj2Ck2jCyiB5q6Xjl9+1HFCxAqifWzRAG18wOjQrboErcEvRYGGyeBEerEPmBuSB2bRD9ukpOmfspM0Fh1++DpZMPAtzHmiNTuND6CwoxXEe0LwBBoVr5Q0i67cTnpJ0acH3uApTwGgwTQiKcpYH+OkQ62jcg9k8SjKznsL0nEw8uo+iQf5UicjGk/zHzOjBIV6+SilVEDme3x7mAjoNiQ+K+sS0KtCoYXUDTZQlFnqZWu4AWI4F/GEf2PwRB8M8x+CX0QK+wl05n7KL17xlE4IQ/1G8ZboefZ7n4KqqB4mwoNIByAfu1y7YpegJ5JDcMYEMnQg==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1huNVq-0006PH-Jc; Sun, 04 Aug 2019 22:53:55 +0200
From:   Peter Wu <peter@lekensteyn.nl>
To:     Michael Kerrisk <mtk.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bpf.2: update enum bpf_map_type and enum bpf_prog_type
Date:   Sun,  4 Aug 2019 21:53:53 +0100
Message-Id: <20190804205353.2956-1-peter@lekensteyn.nl>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Taken from Linux v5.3-rc2. Add a reference to the header file to save
the future reader some time figuring out whether more entries exist.

Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 man2/bpf.2 | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/man2/bpf.2 b/man2/bpf.2
index 5a766aaa8..51e3bd111 100644
--- a/man2/bpf.2
+++ b/man2/bpf.2
@@ -367,6 +367,14 @@ enum bpf_map_type {
     BPF_MAP_TYPE_DEVMAP,
     BPF_MAP_TYPE_SOCKMAP,
     BPF_MAP_TYPE_CPUMAP,
+    BPF_MAP_TYPE_XSKMAP,
+    BPF_MAP_TYPE_SOCKHASH,
+    BPF_MAP_TYPE_CGROUP_STORAGE,
+    BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
+    BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
+    BPF_MAP_TYPE_QUEUE,
+    BPF_MAP_TYPE_STACK,
+    /* See /usr/include/linux/bpf.h for the full list. */
 };
 .EE
 .in
@@ -756,6 +764,25 @@ enum bpf_prog_type {
     BPF_PROG_TYPE_KPROBE,
     BPF_PROG_TYPE_SCHED_CLS,
     BPF_PROG_TYPE_SCHED_ACT,
+    BPF_PROG_TYPE_TRACEPOINT,
+    BPF_PROG_TYPE_XDP,
+    BPF_PROG_TYPE_PERF_EVENT,
+    BPF_PROG_TYPE_CGROUP_SKB,
+    BPF_PROG_TYPE_CGROUP_SOCK,
+    BPF_PROG_TYPE_LWT_IN,
+    BPF_PROG_TYPE_LWT_OUT,
+    BPF_PROG_TYPE_LWT_XMIT,
+    BPF_PROG_TYPE_SOCK_OPS,
+    BPF_PROG_TYPE_SK_SKB,
+    BPF_PROG_TYPE_CGROUP_DEVICE,
+    BPF_PROG_TYPE_SK_MSG,
+    BPF_PROG_TYPE_RAW_TRACEPOINT,
+    BPF_PROG_TYPE_CGROUP_SOCK_ADDR,
+    BPF_PROG_TYPE_LWT_SEG6LOCAL,
+    BPF_PROG_TYPE_LIRC_MODE2,
+    BPF_PROG_TYPE_SK_REUSEPORT,
+    BPF_PROG_TYPE_FLOW_DISSECTOR,
+    /* See /usr/include/linux/bpf.h for the full list. */
 };
 .EE
 .in
-- 
2.22.0

