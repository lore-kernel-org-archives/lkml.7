Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB272C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9812084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfDCWKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:10:55 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49194 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbfDCWKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:10:36 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 69f964f146cc3a38; Thu, 4 Apr 2019 00:10:33 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/4] Documentation: PM: Add SPDX license tags to multiple files
Date:   Thu, 04 Apr 2019 00:04:43 +0200
Message-ID: <30491576.jJB0AOblsF@aspire.rjw.lan>
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

Add SPDX license tags to .rst files under Documentation/driver-api/pm
and Documentation/admin-quide/pm.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst       |    2 ++
 Documentation/admin-guide/pm/cpuidle.rst       |    2 ++
 Documentation/admin-guide/pm/index.rst         |    2 ++
 Documentation/admin-guide/pm/intel_pstate.rst  |    2 ++
 Documentation/admin-guide/pm/sleep-states.rst  |    2 ++
 Documentation/admin-guide/pm/strategies.rst    |    2 ++
 Documentation/admin-guide/pm/system-wide.rst   |    2 ++
 Documentation/admin-guide/pm/working-state.rst |    2 ++
 Documentation/driver-api/pm/cpuidle.rst        |    2 ++
 Documentation/driver-api/pm/devices.rst        |    2 ++
 Documentation/driver-api/pm/index.rst          |    2 ++
 Documentation/driver-api/pm/notifiers.rst      |    2 ++
 Documentation/driver-api/pm/types.rst          |    2 ++
 13 files changed, 26 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpufreq_policy| replace:: :c:type:`struct cpufreq_policy <cpufreq_policy>`
 .. |intel_pstate| replace:: :doc:`intel_pstate <intel_pstate>`
 
Index: linux-pm/Documentation/admin-guide/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpuidle.rst
+++ linux-pm/Documentation/admin-guide/pm/cpuidle.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpuidle_state| replace:: :c:type:`struct cpuidle_state <cpuidle_state>`
 .. |cpufreq| replace:: :doc:`CPU Performance Scaling <cpufreq>`
 
Index: linux-pm/Documentation/admin-guide/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/index.rst
+++ linux-pm/Documentation/admin-guide/pm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ================
 Power Management
 ================
Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================================
 ``intel_pstate`` CPU Performance Scaling Driver
 ===============================================
Index: linux-pm/Documentation/admin-guide/pm/sleep-states.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/sleep-states.rst
+++ linux-pm/Documentation/admin-guide/pm/sleep-states.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 System Sleep States
 ===================
Index: linux-pm/Documentation/admin-guide/pm/strategies.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/strategies.rst
+++ linux-pm/Documentation/admin-guide/pm/strategies.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===========================
 Power Management Strategies
 ===========================
Index: linux-pm/Documentation/admin-guide/pm/system-wide.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/system-wide.rst
+++ linux-pm/Documentation/admin-guide/pm/system-wide.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ============================
 System-Wide Power Management
 ============================
Index: linux-pm/Documentation/admin-guide/pm/working-state.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/working-state.rst
+++ linux-pm/Documentation/admin-guide/pm/working-state.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============================
 Working-State Power Management
 ==============================
Index: linux-pm/Documentation/driver-api/pm/cpuidle.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/cpuidle.rst
+++ linux-pm/Documentation/driver-api/pm/cpuidle.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct cpuidle_governor| replace:: :c:type:`struct cpuidle_governor <cpuidle_governor>`
 .. |struct cpuidle_device| replace:: :c:type:`struct cpuidle_device <cpuidle_device>`
 .. |struct cpuidle_driver| replace:: :c:type:`struct cpuidle_driver <cpuidle_driver>`
Index: linux-pm/Documentation/driver-api/pm/devices.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/devices.rst
+++ linux-pm/Documentation/driver-api/pm/devices.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. |struct dev_pm_ops| replace:: :c:type:`struct dev_pm_ops <dev_pm_ops>`
 .. |struct dev_pm_domain| replace:: :c:type:`struct dev_pm_domain <dev_pm_domain>`
 .. |struct bus_type| replace:: :c:type:`struct bus_type <bus_type>`
Index: linux-pm/Documentation/driver-api/pm/index.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/index.rst
+++ linux-pm/Documentation/driver-api/pm/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===============================
 CPU and Device Power Management
 ===============================
Index: linux-pm/Documentation/driver-api/pm/notifiers.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/notifiers.rst
+++ linux-pm/Documentation/driver-api/pm/notifiers.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =============================
 Suspend/Hibernation Notifiers
 =============================
Index: linux-pm/Documentation/driver-api/pm/types.rst
===================================================================
--- linux-pm.orig/Documentation/driver-api/pm/types.rst
+++ linux-pm/Documentation/driver-api/pm/types.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================================
 Device Power Management Data Types
 ==================================

