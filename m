Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366FBC433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081D7205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 08:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Uq3nJ8rD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbfHOIBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 04:01:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43945 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfHOIBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 04:01:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F81Is92231846
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 01:01:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F81Is92231846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565856079;
        bh=Qo5hIdjqn2mP1l8MTFhwo6997MzZjr+UXx68NuqDI3I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Uq3nJ8rDBT5fF3t1qxO+P2qzU4QVVrly0+KP5AvfPTqOpZpU+YtCjWCTVz09uZLwO
         Qov2HRgFqZaQ9r7eMPa6ZXOeoWEzJzRAtY/47mA8ynfuupG06JJ40qrVuH90Sodh2x
         cXmS2akvLjPdB7Y2SxXG8N9E/J3UosIJuz/h2jpxrxyk1w05AMGtO/FNNy1x6p+eJk
         B/+s4EJlU0UMc/2M1HsMgw0B2tak6FxVjgDqQAe1vncL/ApetVUXseKN3DkVKVObqY
         BgbAo60zdaT2Ne64r2maQZonnToCIn9qGL44vpK1btWKUySq9yBDnu5RA7ksIfMCvg
         O5FZV7FOWBbpQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F81IMd2231843;
        Thu, 15 Aug 2019 01:01:18 -0700
Date:   Thu, 15 Aug 2019 01:01:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tony Luck <tipbot@zytor.com>
Message-ID: <tip-5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e@git.kernel.org>
Cc:     dave.hansen@intel.com, mingo@kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@suse.de
Reply-To: linux-kernel@vger.kernel.org, bp@suse.de, x86@kernel.org,
          mingo@kernel.org, tglx@linutronix.de, tony.luck@intel.com,
          dave.hansen@intel.com, hpa@zytor.com
In-Reply-To: <20190814234030.30817-1-tony.luck@intel.com>
References: <20190814234030.30817-1-tony.luck@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] MAINTAINERS, x86/CPU: Tony Luck will maintain
 asm/intel-family.h
Git-Commit-ID: 5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e
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

Commit-ID:  5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e
Gitweb:     https://git.kernel.org/tip/5ed1c835ed8b522ce25071cc2d56a9a09bd5b59e
Author:     Tony Luck <tony.luck@intel.com>
AuthorDate: Wed, 14 Aug 2019 16:40:30 -0700
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Thu, 15 Aug 2019 09:54:05 +0200

MAINTAINERS, x86/CPU: Tony Luck will maintain asm/intel-family.h

There are a few different subsystems in the kernel that depend on model
specific behaviour (perf, EDAC, power, ...). Easier for just one person
to have the task to get new model numbers included instead of having
these groups trip over each other to do it.

 [ bp: s/Cpu/CPU/ and add x86@kernel.org so that it gets CCed too as
   FYI. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190814234030.30817-1-tony.luck@intel.com
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e81e60bd7c26..f3a78403b47f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8064,6 +8064,13 @@ T:	git git://git.code.sf.net/p/intel-sas/isci
 S:	Supported
 F:	drivers/scsi/isci/
 
+INTEL CPU family model numbers
+M:	Tony Luck <tony.luck@intel.com>
+M:	x86@kernel.org
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	arch/x86/include/asm/intel-family.h
+
 INTEL DRM DRIVERS (excluding Poulsbo, Moorestown and derivative chipsets)
 M:	Jani Nikula <jani.nikula@linux.intel.com>
 M:	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
