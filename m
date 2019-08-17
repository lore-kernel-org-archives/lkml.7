Return-Path: <SRS0=F9vw=WN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A129C3A59B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 200742077C
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Aug 2019 08:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="5E54YlwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726097AbfHQITi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 04:19:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42111 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfHQITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:19:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7H8JEG03177926
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 17 Aug 2019 01:19:14 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7H8JEG03177926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1566029954;
        bh=07UNe5hT8xvaHkrT7ytvXu3ykvn8iCr4NvX3BxqJG5Q=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=5E54YlwXx4Di1qfVUjjSPIwQr8zKj+rovaiJsO/vPrMggNrvfO+gKddxbMVjqgGyZ
         qWH4AtuuAY0UTYUPv3egtW3yBWi8msHzmoEMb8JTESh35JlJY2ErWF8+SAXs73GyyB
         TKJViLWS9qJq1Z4B4MsyrTvx3Mjb17HNZtYCWhba8jFzwNdXJSzUrb+pMzFirO+HO5
         o6Bd5P6EVQPBpLKf0YWwRPhVdd4R+/mvPOnzihEV8nhDL0ZhY2juJFvaUFBDlSNaUu
         +ltRVLF7FNC78CtZbkZPGXNdEftP4ysUt7m88EwWJL0yfwi/q6Suqeiz4+oOOToQEe
         EhBRayUtMcUmw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7H8JDYL3177923;
        Sat, 17 Aug 2019 01:19:13 -0700
Date:   Sat, 17 Aug 2019 01:19:13 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-12ece2d53d3e8f827e972caf497c165f7729c717@git.kernel.org>
Cc:     x86@kernel.org, tony.luck@intel.com, mingo@redhat.com,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org, bp@suse.de,
        dave.hansen@intel.com, linux-kernel@vger.kernel.org, bp@alien8.de
Reply-To: bp@alien8.de, linux-kernel@vger.kernel.org, bp@suse.de,
          dave.hansen@intel.com, hpa@zytor.com, mingo@kernel.org,
          tglx@linutronix.de, x86@kernel.org, mingo@redhat.com,
          tony.luck@intel.com
In-Reply-To: <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
References: <20190815224704.GA10025@agluck-desk2.amr.corp.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu: Explain Intel model naming convention
Git-Commit-ID: 12ece2d53d3e8f827e972caf497c165f7729c717
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

Commit-ID:  12ece2d53d3e8f827e972caf497c165f7729c717
Gitweb:     https://git.kernel.org/tip/12ece2d53d3e8f827e972caf497c165f7729c717
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Thu, 15 Aug 2019 11:16:24 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sat, 17 Aug 2019 10:06:32 +0200

x86/cpu: Explain Intel model naming convention

Dave Hansen spelled out the rules in an e-mail:

 https://lkml.kernel.org/r/91eefbe4-e32b-d762-be4d-672ff915db47@intel.com

Copy those right into the <asm/intel-family.h> file to make it easy for
people to find them.

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190815224704.GA10025@agluck-desk2.amr.corp.intel.com
---
 arch/x86/include/asm/intel-family.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 0278aa66ef62..fe7c205233f1 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -11,6 +11,21 @@
  * While adding a new CPUID for a new microarchitecture, add a new
  * group to keep logically sorted out in chronological order. Within
  * that group keep the CPUID for the variants sorted by model number.
+ *
+ * The defined symbol names have the following form:
+ *	INTEL_FAM6{OPTFAMILY}_{MICROARCH}{OPTDIFF}
+ * where:
+ * OPTFAMILY	Describes the family of CPUs that this belongs to. Default
+ *		is assumed to be "_CORE" (and should be omitted). Other values
+ *		currently in use are _ATOM and _XEON_PHI
+ * MICROARCH	Is the code name for the micro-architecture for this core.
+ *		N.B. Not the platform name.
+ * OPTDIFF	If needed, a short string to differentiate by market segment.
+ *		Exact strings here will vary over time. _DESKTOP, _MOBILE, and
+ *		_X (short for Xeon server) should be used when they are
+ *		appropriate.
+ *
+ * The #define line may optionally include a comment including platform names.
  */
 
 #define INTEL_FAM6_CORE_YONAH		0x0E
