Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A8C072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DBB217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 19:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391809AbfEXT7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 15:59:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37975 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391612AbfEXT7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 15:59:15 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so10323040wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 May 2019 12:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=98qLq1YzqvDS+bZlxBEFPwpmLRmsqB49UdX6CSq6WFg=;
        b=lCRwNNV938LplZLjKms3k+1DHk82wgUMYjm6jCtkT0W3ppYQ4Zh+n8tXolM9HsA8bP
         RqKHT4gTJ3OUZM19jBPhJAA1tcz09gWjOWLRP8vqgCk7GPQDC9XjY3ac7ZxjzUdMyKAp
         9sFDOD10/ZxKybdDML/aaGxgUVWRxc2Kmy8NK+QcI2cUSjt7hjU7RTynRswdGlXSHddC
         5NgCkOfXBgVWXSwWc+MNQhSu3zcwjmtAGlWik7C3tcmWQ8Zm+m8DmCEt+W5ZLFPVb0Tv
         UyL8vqEBRCrpJMwNW69lsIrfr0n7fWqWlrSxyIGhQt31pRsVpTxUYjv814kGsJVns7yb
         Tp2g==
X-Gm-Message-State: APjAAAWYHYi81ILeGhibCSUjTZ7TVl6hJIPK9wyG4/QmaXZVXLY0/l53
        U48AoyC3q0vAA4yVE+RRGLpe3w==
X-Google-Smtp-Source: APXvYqyRh3OV8dYox0YJl0PBxmCKnOVq+8z+KmDG88Sc4V+O4CxoZp1+fYgDvmYHhZdzy2v+WUx83w==
X-Received: by 2002:a05:600c:230a:: with SMTP id 10mr16603602wmo.13.1558727954156;
        Fri, 24 May 2019 12:59:14 -0700 (PDT)
Received: from raver.teknoraver.net (net-47-53-225-211.cust.vodafonedsl.it. [47.53.225.211])
        by smtp.gmail.com with ESMTPSA id b2sm3237140wrt.20.2019.05.24.12.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 May 2019 12:59:13 -0700 (PDT)
From:   Matteo Croce <mcroce@redhat.com>
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] samples: bpf: add ibumad sample to .gitignore
Date:   Fri, 24 May 2019 21:59:12 +0200
Message-Id: <20190524195912.4966-1-mcroce@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds ibumad to .gitignore which is
currently ommited from the ignore file.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
---
 samples/bpf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index c7498457595a..74d31fd3c99c 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -1,6 +1,7 @@
 cpustat
 fds_example
 hbm
+ibumad
 lathist
 lwt_len_hist
 map_perf_test
-- 
2.21.0

