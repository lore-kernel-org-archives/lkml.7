Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380CC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD50208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfDAQx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:53:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39613 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfDAQx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:53:27 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x31Gr9cq1007151
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 1 Apr 2019 09:53:09 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x31Gr9px1007148;
        Mon, 1 Apr 2019 09:53:09 -0700
Date:   Mon, 1 Apr 2019 09:53:09 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-faa3604eda325588451c9c1eb4c8a8d04c1cd633@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, mingo@redhat.com,
        reinette.chatre@intel.com, x86@kernel.org, bp@suse.de,
        xiaochen.shen@intel.com, fenghua.yu@intel.com,
        linux-kernel@vger.kernel.org, tony.luck@intel.com, hpa@zytor.com
Reply-To: tglx@linutronix.de, xiaochen.shen@intel.com, bp@suse.de,
          x86@kernel.org, fenghua.yu@intel.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org,
          tony.luck@intel.com, hpa@zytor.com, reinette.chatre@intel.com,
          mingo@redhat.com
In-Reply-To: <1553896238-22130-1-git-send-email-xiaochen.shen@intel.com>
References: <1553896238-22130-1-git-send-email-xiaochen.shen@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/resctrl: Fix typos in the mba_sc mount option
Git-Commit-ID: faa3604eda325588451c9c1eb4c8a8d04c1cd633
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

Commit-ID:  faa3604eda325588451c9c1eb4c8a8d04c1cd633
Gitweb:     https://git.kernel.org/tip/faa3604eda325588451c9c1eb4c8a8d04c1cd633
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Sat, 30 Mar 2019 05:50:38 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Mon, 1 Apr 2019 18:45:27 +0200

x86/resctrl: Fix typos in the mba_sc mount option

The user can control the MBA memory bandwidth in MBps (Mega
Bytes per second) units of the MBA Software Controller (mba_sc)
by using the "mba_MBps" mount option. For details, see
Documentation/x86/resctrl_ui.txt.

However, commit

  23bf1b6be9c2 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")

changed the mount option name from "mba_MBps" to "mba_mpbs" by mistake.

Change it back from to "mba_MBps" because it is user-visible, and
correct "Opt_mba_mpbs" spelling to "Opt_mba_mbps".

 [ bp: massage commit message. ]

Fixes: 23bf1b6be9c2 ("kernfs, sysfs, cgroup, intel_rdt: Support fs_context")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: dhowells@redhat.com
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1553896238-22130-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 399601eda8e4..54b9eef3eea9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2039,14 +2039,14 @@ out:
 enum rdt_param {
 	Opt_cdp,
 	Opt_cdpl2,
-	Opt_mba_mpbs,
+	Opt_mba_mbps,
 	nr__rdt_params
 };
 
 static const struct fs_parameter_spec rdt_param_specs[] = {
 	fsparam_flag("cdp",		Opt_cdp),
 	fsparam_flag("cdpl2",		Opt_cdpl2),
-	fsparam_flag("mba_mpbs",	Opt_mba_mpbs),
+	fsparam_flag("mba_MBps",	Opt_mba_mbps),
 	{}
 };
 
@@ -2072,7 +2072,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_cdpl2:
 		ctx->enable_cdpl2 = true;
 		return 0;
-	case Opt_mba_mpbs:
+	case Opt_mba_mbps:
 		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 			return -EINVAL;
 		ctx->enable_mba_mbps = true;
