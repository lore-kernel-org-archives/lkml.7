Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2048C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94882147C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 22:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfDCWKr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 18:10:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52436 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfDCWKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 18:10:37 -0400
Received: from 79.184.254.219.ipv4.supernova.orange.pl (79.184.254.219) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 1e34c89d64ffa71c; Thu, 4 Apr 2019 00:10:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/4] cpufreq: intel_pstate: Documentation: Add references sections
Date:   Thu, 04 Apr 2019 00:03:30 +0200
Message-ID: <2330972.sZBoMHM721@aspire.rjw.lan>
In-Reply-To: <4546107.fVFrecLk33@aspire.rjw.lan>
References: <4546107.fVFrecLk33@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add separate refereces sections to the cpufreq.rst and
intel_pstate.rst documents under admin-quide/pm and list the
references to external documentation in there.

Update the ACPI specification URL while at it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/cpufreq.rst      |   10 +++++++---
 Documentation/admin-guide/pm/intel_pstate.rst |   25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 12 deletions(-)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -20,11 +20,10 @@ you have not done that yet.]
 
 For the processors supported by ``intel_pstate``, the P-state concept is broader
 than just an operating frequency or an operating performance point (see the
-`LinuxCon Europe 2015 presentation by Kristen Accardi <LCEU2015_>`_ for more
+LinuxCon Europe 2015 presentation by Kristen Accardi [1]_ for more
 information about that).  For this reason, the representation of P-states used
 by ``intel_pstate`` internally follows the hardware specification (for details
-refer to `Intel® 64 and IA-32 Architectures Software Developer’s Manual
-Volume 3: System Programming Guide <SDM_>`_).  However, the ``CPUFreq`` core
+refer to Intel Software Developer’s Manual [2]_).  However, the ``CPUFreq`` core
 uses frequencies for identifying operating performance points of CPUs and
 frequencies are involved in the user space interface exposed by it, so
 ``intel_pstate`` maps its internal representation of P-states to frequencies too
@@ -561,9 +560,9 @@ or to pin every task potentially sensiti
 
 On the majority of systems supported by ``intel_pstate``, the ACPI tables
 provided by the platform firmware contain ``_PSS`` objects returning information
-that can be used for CPU performance scaling (refer to the `ACPI specification`_
-for details on the ``_PSS`` objects and the format of the information returned
-by them).
+that can be used for CPU performance scaling (refer to the ACPI specification
+[3]_ for details on the ``_PSS`` objects and the format of the information
+returned by them).
 
 The information returned by the ACPI ``_PSS`` objects is used by the
 ``acpi-cpufreq`` scaling driver.  On systems supported by ``intel_pstate``
@@ -728,6 +727,14 @@ P-state is called, the ``ftrace`` filter
            <idle>-0     [000] ..s.  2537.654843: intel_pstate_set_pstate <-intel_pstate_timer_func
 
 
-.. _LCEU2015: http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
-.. _SDM: http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
-.. _ACPI specification: http://www.uefi.org/sites/default/files/resources/ACPI_6_1.pdf
+References
+==========
+
+.. [1] Kristen Accardi, *Balancing Power and Performance in the Linux Kernel*,
+       http://events.linuxfoundation.org/sites/events/files/slides/LinuxConEurope_2015.pdf
+
+.. [2] *Intel® 64 and IA-32 Architectures Software Developer’s Manual Volume 3: System Programming Guide*,
+       http://www.intel.com/content/www/us/en/architecture-and-technology/64-ia-32-architectures-software-developer-system-programming-manual-325384.html
+
+.. [3] *Advanced Configuration and Power Interface Specification*,
+       https://uefi.org/sites/default/files/resources/ACPI_6_3_final_Jan30.pdf
Index: linux-pm/Documentation/admin-guide/pm/cpufreq.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/cpufreq.rst
+++ linux-pm/Documentation/admin-guide/pm/cpufreq.rst
@@ -396,8 +396,8 @@ RT or deadline scheduling classes, the g
 the allowed maximum (that is, the ``scaling_max_freq`` policy limit).  In turn,
 if it is invoked by the CFS scheduling class, the governor will use the
 Per-Entity Load Tracking (PELT) metric for the root control group of the
-given CPU as the CPU utilization estimate (see the `Per-entity load tracking`_
-LWN.net article for a description of the PELT mechanism).  Then, the new
+given CPU as the CPU utilization estimate (see the *Per-entity load tracking*
+LWN.net article [1]_ for a description of the PELT mechanism).  Then, the new
 CPU frequency to apply is computed in accordance with the formula
 
 	f = 1.25 * ``f_0`` * ``util`` / ``max``
@@ -698,4 +698,8 @@ hardware feature (e.g. all Intel ones),
 :c:macro:`CONFIG_X86_ACPI_CPUFREQ_CPB` configuration option is set.
 
 
-.. _Per-entity load tracking: https://lwn.net/Articles/531853/
+References
+==========
+
+.. [1] Jonathan Corbet, *Per-entity load tracking*,
+       https://lwn.net/Articles/531853/

