Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E2EC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC6A208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 18:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404354AbfIFSNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 14:13:06 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:57642 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731928AbfIFSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 14:13:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 2A06A181D341A;
        Fri,  6 Sep 2019 18:13:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hand82_546059634e43e
X-Filterd-Recvd-Size: 10002
Received: from XPS-9350.home (unknown [47.151.152.152])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Sep 2019 18:12:59 +0000 (UTC)
Message-ID: <1b1cfc9c8c13b58c47d1d123763c8bc412abf9d4.camel@perches.com>
Subject: [RFC PATCH] tools: Add SPDX license to man pages
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jessica Yu <jeyu@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-doc@vger.kernel.org, Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb <linux-usb@vger.kernel.org>
Date:   Fri, 06 Sep 2019 11:12:58 -0700
In-Reply-To: <20190906083457.7e7934ec@coco.lan>
References: <20190905055614.7958918b@coco.lan>
         <88e638eb959095ab6657d295f9f8c27169569bf2.1567675272.git.mchehab+samsung@kernel.org>
         <20190905092703.GA30899@kroah.com> <20190905090701.37dcf75e@coco.lan>
         <b32c2e46b91e7bcda2a9bd140673f06d71b2487a.camel@perches.com>
         <20190906083457.7e7934ec@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.32.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-09-06 at 08:34 -0300, Mauro Carvalho Chehab wrote:
> Warning: SPDX header for file tools/thermal/tmon/tmon.8 is at line 2
[]
> The last one is interesting... what's the "very first line" where a
> SPDX header tag should be on a man page?

just fyi:

It looks like .man pages could use a comment form
using '.\"' like this example on the first line:

$ head -5 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
.\"  This page Copyright (C) 2010 - 2015 Len Brown <len.brown@intel.com>
.\"  Distributed under the GPL, Copyleft 1994.
.TH X86_ENERGY_PERF_POLICY 8
.SH NAME
x86_energy_perf_policy \- Manage Energy vs. Performance Policy via x86 Model Specific Registers

So maybe:
---
 tools/power/acpi/man/acpidump.8                                 | 1 +
 tools/power/cpupower/man/cpupower-frequency-info.1              | 1 +
 tools/power/cpupower/man/cpupower-frequency-set.1               | 1 +
 tools/power/cpupower/man/cpupower-idle-info.1                   | 1 +
 tools/power/cpupower/man/cpupower-idle-set.1                    | 1 +
 tools/power/cpupower/man/cpupower-info.1                        | 1 +
 tools/power/cpupower/man/cpupower-monitor.1                     | 1 +
 tools/power/cpupower/man/cpupower-set.1                         | 1 +
 tools/power/cpupower/man/cpupower.1                             | 1 +
 tools/power/pm-graph/bootgraph.8                                | 1 +
 tools/power/pm-graph/sleepgraph.8                               | 1 +
 tools/power/x86/turbostat/turbostat.8                           | 1 +
 tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 | 1 +
 tools/thermal/tmon/tmon.8                                       | 1 +
 tools/usb/usbip/doc/usbip.8                                     | 1 +
 tools/usb/usbip/doc/usbipd.8                                    | 1 +
 16 files changed, 16 insertions(+)

diff --git a/tools/power/acpi/man/acpidump.8 b/tools/power/acpi/man/acpidump.8
index 79e2d1d435d1..31513ea4bc6b 100644
--- a/tools/power/acpi/man/acpidump.8
+++ b/tools/power/acpi/man/acpidump.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH ACPIDUMP 8
 .SH NAME
 acpidump \- dump a system's ACPI tables to an ASCII file
diff --git a/tools/power/cpupower/man/cpupower-frequency-info.1 b/tools/power/cpupower/man/cpupower-frequency-info.1
index 6aa8d239dff9..e3f46215c3b6 100644
--- a/tools/power/cpupower/man/cpupower-frequency-info.1
+++ b/tools/power/cpupower/man/cpupower-frequency-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER\-FREQUENCY\-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
diff --git a/tools/power/cpupower/man/cpupower-frequency-set.1 b/tools/power/cpupower/man/cpupower-frequency-set.1
index b50570221a5b..f6b4619e7ef6 100644
--- a/tools/power/cpupower/man/cpupower-frequency-set.1
+++ b/tools/power/cpupower/man/cpupower-frequency-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER\-FREQUENCY\-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP 
diff --git a/tools/power/cpupower/man/cpupower-idle-info.1 b/tools/power/cpupower/man/cpupower-idle-info.1
index 80a1311fa747..d05728573bd9 100644
--- a/tools/power/cpupower/man/cpupower-idle-info.1
+++ b/tools/power/cpupower/man/cpupower-idle-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER-IDLE-INFO" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 21916cff7516..746322ea9b3e 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH "CPUPOWER-IDLE-SET" "1" "0.1" "" "cpupower Manual"
 .SH "NAME"
 .LP
diff --git a/tools/power/cpupower/man/cpupower-info.1 b/tools/power/cpupower/man/cpupower-info.1
index 340bcd0be7de..d77b34bcf1f3 100644
--- a/tools/power/cpupower/man/cpupower-info.1
+++ b/tools/power/cpupower/man/cpupower-info.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-INFO "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-info \- Shows processor power related kernel or hardware configurations
diff --git a/tools/power/cpupower/man/cpupower-monitor.1 b/tools/power/cpupower/man/cpupower-monitor.1
index 70a56476f4b0..4027cf424ea0 100644
--- a/tools/power/cpupower/man/cpupower-monitor.1
+++ b/tools/power/cpupower/man/cpupower-monitor.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-MONITOR "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-monitor \- Report processor frequency and idle statistics
diff --git a/tools/power/cpupower/man/cpupower-set.1 b/tools/power/cpupower/man/cpupower-set.1
index 2bcc696f4496..77dec3ec4c10 100644
--- a/tools/power/cpupower/man/cpupower-set.1
+++ b/tools/power/cpupower/man/cpupower-set.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER\-SET "1" "22/02/2011" "" "cpupower Manual"
 .SH NAME
 cpupower\-set \- Set processor power related kernel or hardware configurations
diff --git a/tools/power/cpupower/man/cpupower.1 b/tools/power/cpupower/man/cpupower.1
index baf741d06e82..0a8b08a1fd90 100644
--- a/tools/power/cpupower/man/cpupower.1
+++ b/tools/power/cpupower/man/cpupower.1
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH CPUPOWER "1" "07/03/2011" "" "cpupower Manual"
 .SH NAME
 cpupower \- Shows and sets processor power related values
diff --git a/tools/power/pm-graph/bootgraph.8 b/tools/power/pm-graph/bootgraph.8
index 64d513f80a2a..4a8981356e1a 100644
--- a/tools/power/pm-graph/bootgraph.8
+++ b/tools/power/pm-graph/bootgraph.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH BOOTGRAPH 8
 .SH NAME
 bootgraph \- Kernel boot timing analysis
diff --git a/tools/power/pm-graph/sleepgraph.8 b/tools/power/pm-graph/sleepgraph.8
index 43aee64316df..ce456d1b7da9 100644
--- a/tools/power/pm-graph/sleepgraph.8
+++ b/tools/power/pm-graph/sleepgraph.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH SLEEPGRAPH 8
 .SH NAME
 sleepgraph \- Suspend/Resume timing analysis
diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index a6db83a88e85..48ac735526df 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH TURBOSTAT 8
 .SH NAME
 turbostat \- Report processor frequency and idle statistics
diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8 b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
index 78c6361898b1..e702d2117062 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .\"  This page Copyright (C) 2010 - 2015 Len Brown <len.brown@intel.com>
 .\"  Distributed under the GPL, Copyleft 1994.
 .TH X86_ENERGY_PERF_POLICY 8
diff --git a/tools/thermal/tmon/tmon.8 b/tools/thermal/tmon/tmon.8
index 2f122de5841b..cffaa0d65478 100644
--- a/tools/thermal/tmon/tmon.8
+++ b/tools/thermal/tmon/tmon.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH TMON 8
 # SPDX-License-Identifier: GPL-2.0
 .SH NAME
diff --git a/tools/usb/usbip/doc/usbip.8 b/tools/usb/usbip/doc/usbip.8
index a6097be25d28..7430d80d5f66 100644
--- a/tools/usb/usbip/doc/usbip.8
+++ b/tools/usb/usbip/doc/usbip.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH USBIP "8" "February 2009" "usbip" "System Administration Utilities"
 .SH NAME
 usbip \- manage USB/IP devices
diff --git a/tools/usb/usbip/doc/usbipd.8 b/tools/usb/usbip/doc/usbipd.8
index ac4635db3f03..5f2f4e2d0c9b 100644
--- a/tools/usb/usbip/doc/usbipd.8
+++ b/tools/usb/usbip/doc/usbipd.8
@@ -1,3 +1,4 @@
+.\" SPDX-License-Identifier: GPL-2.0-only
 .TH USBIP "8" "February 2009" "usbip" "System Administration Utilities"
 .SH NAME
 usbipd \- USB/IP server daemon


