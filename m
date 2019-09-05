Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA1C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C237A206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 12:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389066AbfIEMDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 08:03:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53882 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730718AbfIEMDU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 08:03:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C59273086208;
        Thu,  5 Sep 2019 12:03:20 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16E361001947;
        Thu,  5 Sep 2019 12:03:20 +0000 (UTC)
From:   Prarit Bhargava <prarit@redhat.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     andriy.shevchenko@intel.com, Prarit Bhargava <prarit@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Arcari <darcari@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/9] tools/power/x86/intel-speed-select: Fix package typo
Date:   Thu,  5 Sep 2019 08:03:03 -0400
Message-Id: <20190905120311.15286-2-prarit@redhat.com>
In-Reply-To: <20190905120311.15286-1-prarit@redhat.com>
References: <20190905120311.15286-1-prarit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 05 Sep 2019 12:03:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

packag_ should be package_.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: David Arcari <darcari@redhat.com>
Cc: linux-kernel@vger.kernel.org
---
 tools/power/x86/intel-speed-select/isst-display.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/isst-display.c b/tools/power/x86/intel-speed-select/isst-display.c
index f368b8323742..0d9a53a5da2d 100644
--- a/tools/power/x86/intel-speed-select/isst-display.c
+++ b/tools/power/x86/intel-speed-select/isst-display.c
@@ -133,7 +133,7 @@ static void format_and_print(FILE *outf, int level, char *header, char *value)
 	last_level = level;
 }
 
-static void print_packag_info(int cpu, FILE *outf)
+static void print_package_info(int cpu, FILE *outf)
 {
 	char header[256];
 
@@ -261,7 +261,7 @@ void isst_ctdp_display_information(int cpu, FILE *outf, int tdp_level,
 	char value[256];
 	int i, base_level = 1;
 
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 
 	for (i = 0; i <= pkg_dev->levels; ++i) {
 		struct isst_pkg_ctdp_level_info *ctdp_level;
@@ -397,7 +397,7 @@ void isst_ctdp_display_information_end(FILE *outf)
 void isst_pbf_display_information(int cpu, FILE *outf, int level,
 				  struct isst_pbf_info *pbf_info)
 {
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 	_isst_pbf_display_information(cpu, outf, level, pbf_info, 4);
 	format_and_print(outf, 1, NULL, NULL);
 }
@@ -406,7 +406,7 @@ void isst_fact_display_information(int cpu, FILE *outf, int level,
 				   int fact_bucket, int fact_avx,
 				   struct isst_fact_info *fact_info)
 {
-	print_packag_info(cpu, outf);
+	print_package_info(cpu, outf);
 	_isst_fact_display_information(cpu, outf, level, fact_bucket, fact_avx,
 				       fact_info, 4);
 	format_and_print(outf, 1, NULL, NULL);
-- 
2.21.0

