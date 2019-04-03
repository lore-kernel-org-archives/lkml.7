Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB51C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEFD2084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfDCWKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:10:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:41564 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCWKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:10:34 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 8aca4a233a5e8d07; Thu, 4 Apr 2019 00:10:32 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@suse.de>
Subject: [PATCH 4/4] admin-guide: pm: intel_epb: Add SPDX license tag and copyright notice
Date:   Thu, 04 Apr 2019 00:08:18 +0200
Message-ID: <8068055.vE1LsT4ZeF@aspire.rjw.lan>
In-Reply-To: <4546107.fVFrecLk33@aspire.rjw.lan>
References: <4546107.fVFrecLk33@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add an SPDX license tag and a copyright notice to the intel_epb.rst
file under Documentation/admin-quide/pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_epb.rst |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/intel_epb.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_epb.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_epb.rst
@@ -1,7 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
 ======================================
 Intel Performance and Energy Bias Hint
 ======================================
 
+:Copyright: |copy| 2019 Intel Corporation
+
+:Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
+
+
 .. kernel-doc:: arch/x86/kernel/cpu/intel_epb.c
    :doc: overview
 

