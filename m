Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7222C432C0
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8DB20674
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575292756;
	bh=8ado/wN5QFL5TwJrbOOqHxsDKHll9YnNJAfUvVS3P0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTLm8GviSfpzpPgu698kISWWGCJLKvCAlKBhbBZhShIzTbzRR+7lSo/DL1DcetGG0
	 rNPNjWHnlZo7B7jRCOfbX8zWvEjb/eTg7Wd5X+py+iQvkhv8sqOcnsV7lJWAViN8gG
	 fOqCQv3S8NwSQ3TFubhRGfbBcB8zG76aeOhG6hmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfLBNTP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 08:19:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40163 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727533AbfLBNTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 08:19:13 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-HiXvAOg6NVmOA0_z491XSw-1; Mon, 02 Dec 2019 08:19:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E8631005510;
        Mon,  2 Dec 2019 13:19:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAC38600C8;
        Mon,  2 Dec 2019 13:19:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH 3/6] bpftool: Rename BPF_DIR Makefile variable to LIBBPF_SRC_DIR
Date:   Mon,  2 Dec 2019 14:18:43 +0100
Message-Id: <20191202131847.30837-4-jolsa@kernel.org>
In-Reply-To: <20191202131847.30837-1-jolsa@kernel.org>
References: <20191202131847.30837-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: HiXvAOg6NVmOA0_z491XSw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To properly describe the usage of the variable.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/bpf/bpftool/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index be6dea7eb9fd..512504956315 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -29,13 +29,13 @@ else
   Q = @
 endif
 
-BPF_DIR = $(srctree)/tools/lib/bpf/
+LIBBPF_SRC_DIR = $(srctree)/tools/lib/bpf/
 
 ifneq ($(OUTPUT),)
   LIBBPF_OUTPUT = $(OUTPUT)/libbpf/
   LIBBPF_PATH = $(LIBBPF_OUTPUT)
 else
-  LIBBPF_PATH = $(BPF_DIR)
+  LIBBPF_PATH = $(LIBBPF_SRC_DIR)
 endif
 
 LIBBPF = $(LIBBPF_PATH)libbpf.a
@@ -44,11 +44,11 @@ BPFTOOL_VERSION := $(shell make -rR --no-print-directory -sC ../../.. kernelvers
 
 $(LIBBPF): FORCE
 	$(if $(LIBBPF_OUTPUT),@mkdir -p $(LIBBPF_OUTPUT))
-	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
+	$(Q)$(MAKE) -C $(LIBBPF_SRC_DIR) OUTPUT=$(LIBBPF_OUTPUT) $(LIBBPF_OUTPUT)libbpf.a
 
 $(LIBBPF)-clean:
 	$(call QUIET_CLEAN, libbpf)
-	$(Q)$(MAKE) -C $(BPF_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
+	$(Q)$(MAKE) -C $(LIBBPF_SRC_DIR) OUTPUT=$(LIBBPF_OUTPUT) clean >/dev/null
 
 prefix ?= /usr/local
 bash_compdir ?= /usr/share/bash-completion/completions
-- 
2.21.0

