Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC29CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 927A820B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 02:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbfJ1Cmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 22:42:35 -0400
Received: from 59-120-53-16.HINET-IP.hinet.net ([59.120.53.16]:10324 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730229AbfJ1Cmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 22:42:32 -0400
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id x9S2OTh5087266;
        Mon, 28 Oct 2019 10:24:29 +0800 (GMT-8)
        (envelope-from nickhu@andestech.com)
Received: from atcsqa06.andestech.com (10.0.15.65) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.123.3; Mon, 28 Oct 2019
 10:41:57 +0800
From:   Nick Hu <nickhu@andestech.com>
To:     <aryabinin@virtuozzo.com>, <glider@google.com>,
        <dvyukov@google.com>, <corbet@lwn.net>, <paul.walmsley@sifive.com>,
        <palmer@sifive.com>, <aou@eecs.berkeley.edu>, <tglx@linutronix.de>,
        <gregkh@linuxfoundation.org>, <alankao@andestech.com>,
        <Anup.Patel@wdc.com>, <atish.patra@wdc.com>,
        <kasan-dev@googlegroups.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-mm@kvack.org>, <green.hu@gmail.com>
CC:     Nick Hu <nickhu@andestech.com>
Subject: [PATCH v4 3/3] kasan: Add riscv to KASAN documentation.
Date:   Mon, 28 Oct 2019 10:41:01 +0800
Message-ID: <20191028024101.26655-4-nickhu@andestech.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191028024101.26655-1-nickhu@andestech.com>
References: <20191028024101.26655-1-nickhu@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.65]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com x9S2OTh5087266
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add riscv to the KASAN documentation to mention that riscv
is supporting generic kasan now.

Signed-off-by: Nick Hu <nickhu@andestech.com>
---
 Documentation/dev-tools/kasan.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index b72d07d70239..34fbb7212cbc 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -21,8 +21,8 @@ global variables yet.
 
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
-Currently generic KASAN is supported for the x86_64, arm64, xtensa and s390
-architectures, and tag-based KASAN is supported only for arm64.
+Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
+riscv architectures, and tag-based KASAN is supported only for arm64.
 
 Usage
 -----
-- 
2.17.0

