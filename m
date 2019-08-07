Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32D39C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F11EF21E6B
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 13:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="1JXyZH8p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388279AbfHGN3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 09:29:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46645 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfHGN3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 09:29:10 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x77DT0tU2699386
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 7 Aug 2019 06:29:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x77DT0tU2699386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565184540;
        bh=vlGMZafSUwhnnkknP0oAFVc3rI8uT6Wj0pvYag4NIWo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=1JXyZH8pKN9j0GX5lGJjbgPAQzc93c+it7qlXJxN/y0GQ6dK84xX69UOAgaiIF/CE
         Aps2HOd3qaQgx2sq5PKrqugHbMP8P6YmZbn2zQDUvfQAVUODhQl11tDUAySRqN1i86
         NPXZdgzQH44fSgiAB/w3WewVNnguolGA6CvX7ytPQmNZMWy1sgcnVYIjFlEEjMCRwE
         6N9a3FMxP3Cy4wT6eJMlgMbFzo09gTRI757ekySG9vx5tOH6wDWDDskO4dggonE+Qh
         7xQZ+8czcO+yYutV/HmILoFnDUIG2MINlm6nEA+VrpghNFvarIr58kj9l4vbBYGZoH
         iX66Z63vJNGnQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x77DSxGM2699383;
        Wed, 7 Aug 2019 06:28:59 -0700
Date:   Wed, 7 Aug 2019 06:28:59 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Sean Christopherson <tipbot@zytor.com>
Message-ID: <tip-6444b40eeda4f78f57b255dd7ecb8d3e5936eea2@git.kernel.org>
Cc:     sean.j.christopherson@intel.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, sean.j.christopherson@intel.com, hpa@zytor.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org
In-Reply-To: <20190805212134.12001-1-sean.j.christopherson@intel.com>
References: <20190805212134.12001-1-sean.j.christopherson@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/apic] x86/apic: Annotate global config variables as
 "read-only after init"
Git-Commit-ID: 6444b40eeda4f78f57b255dd7ecb8d3e5936eea2
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

Commit-ID:  6444b40eeda4f78f57b255dd7ecb8d3e5936eea2
Gitweb:     https://git.kernel.org/tip/6444b40eeda4f78f57b255dd7ecb8d3e5936eea2
Author:     Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate: Mon, 5 Aug 2019 14:21:34 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 7 Aug 2019 15:24:21 +0200

x86/apic: Annotate global config variables as "read-only after init"

Mark the APIC's global config variables that are constant after boot as
__ro_after_init to help document that the majority of the APIC config is
not changed at runtime, and to harden the kernel a smidge.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190805212134.12001-1-sean.j.christopherson@intel.com

---
 arch/x86/kernel/apic/apic.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 831274e3c09f..3a31875bd0a3 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -65,10 +65,10 @@ unsigned int num_processors;
 unsigned disabled_cpus;
 
 /* Processor that is doing the boot up */
-unsigned int boot_cpu_physical_apicid = -1U;
+unsigned int boot_cpu_physical_apicid __ro_after_init = -1U;
 EXPORT_SYMBOL_GPL(boot_cpu_physical_apicid);
 
-u8 boot_cpu_apic_version;
+u8 boot_cpu_apic_version __ro_after_init;
 
 /*
  * The highest APIC ID seen during enumeration.
@@ -85,13 +85,13 @@ physid_mask_t phys_cpu_present_map;
  * disable_cpu_apicid=<int>, mostly used for the kdump 2nd kernel to
  * avoid undefined behaviour caused by sending INIT from AP to BSP.
  */
-static unsigned int disabled_cpu_apicid __read_mostly = BAD_APICID;
+static unsigned int disabled_cpu_apicid __ro_after_init = BAD_APICID;
 
 /*
  * This variable controls which CPUs receive external NMIs.  By default,
  * external NMIs are delivered only to the BSP.
  */
-static int apic_extnmi = APIC_EXTNMI_BSP;
+static int apic_extnmi __ro_after_init = APIC_EXTNMI_BSP;
 
 /*
  * Map cpu index to physical APIC ID
@@ -114,7 +114,7 @@ EXPORT_EARLY_PER_CPU_SYMBOL(x86_cpu_to_acpiid);
 DEFINE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid, BAD_APICID);
 
 /* Local APIC was disabled by the BIOS and enabled by the kernel */
-static int enabled_via_apicbase;
+static int enabled_via_apicbase __ro_after_init;
 
 /*
  * Handle interrupt mode configuration register (IMCR).
@@ -172,23 +172,23 @@ static __init int setup_apicpmtimer(char *s)
 __setup("apicpmtimer", setup_apicpmtimer);
 #endif
 
-unsigned long mp_lapic_addr;
-int disable_apic;
+unsigned long mp_lapic_addr __ro_after_init;
+int disable_apic __ro_after_init;
 /* Disable local APIC timer from the kernel commandline or via dmi quirk */
 static int disable_apic_timer __initdata;
 /* Local APIC timer works in C2 */
-int local_apic_timer_c2_ok;
+int local_apic_timer_c2_ok __ro_after_init;
 EXPORT_SYMBOL_GPL(local_apic_timer_c2_ok);
 
 /*
  * Debug level, exported for io_apic.c
  */
-int apic_verbosity;
+int apic_verbosity __ro_after_init;
 
-int pic_mode;
+int pic_mode __ro_after_init;
 
 /* Have we found an MP table */
-int smp_found_config;
+int smp_found_config __ro_after_init;
 
 static struct resource lapic_resource = {
 	.name = "Local APIC",
@@ -199,7 +199,7 @@ unsigned int lapic_timer_period = 0;
 
 static void apic_pm_activate(void);
 
-static unsigned long apic_phys;
+static unsigned long apic_phys __ro_after_init;
 
 /*
  * Get the LAPIC version
@@ -1278,7 +1278,7 @@ void __init sync_Arb_IDs(void)
 			APIC_INT_LEVELTRIG | APIC_DM_INIT);
 }
 
-enum apic_intr_mode_id apic_intr_mode;
+enum apic_intr_mode_id apic_intr_mode __ro_after_init;
 
 static int __init apic_intr_mode_select(void)
 {
