Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03065C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C713A2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 10:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="vuYaCkE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFVKGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 06:06:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51889 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfFVKGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 06:06:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5MA6DqV2095891
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 22 Jun 2019 03:06:13 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5MA6DqV2095891
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1561197974;
        bh=r76FjWBZLcA/i0q2QQtWnBDbA0Sk9x0A+rXmmirG0s0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=vuYaCkE+3pfHDPcvHqPiLfvYWjUbw5MOxX15bQVUb5FvQUKRoFYv6TKEZF5TxxjED
         MyfRlsvuySx+m3qxq6Vmtf1nyHEfSZ+ifUFNKOLojmMqD9TYz8/Yku3sDptlRAItsf
         bYY+Dx5vSL8Ws6Gp/7u0ALlPE2nZi/m7Q2ILB/gouKMPozv0pfeeiKFnt5IMLB40d4
         SZvuAvGZKf2aT6peM3vGisEDWkOylG1S9JYMM2GDnBpAeHv1O5U6JZpxD0CaH/mju9
         Mhuyprx9e4sKwbuGXuB0tFxPDWt0hP8NjpgWebcJFmr1gtZL28PRshYr74rP0PaMYp
         SpEzw171xmM/Q==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5MA6CH42095883;
        Sat, 22 Jun 2019 03:06:12 -0700
Date:   Sat, 22 Jun 2019 03:06:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-1fb12b35e5ffe379d109b22cb3069830d0136d9a@git.kernel.org>
Cc:     tglx@linutronix.de, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, chang.seok.bae@intel.com,
        hpa@zytor.com, luto@kernel.org, torvalds@linux-foundation.org,
        mingo@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org
Reply-To: hpa@zytor.com, luto@kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, ak@linux.intel.com, akpm@linux-foundation.org,
          tglx@linutronix.de, ravi.v.shankar@intel.com,
          linux-kernel@vger.kernel.org, chang.seok.bae@intel.com
In-Reply-To: <1557309753-24073-5-git-send-email-chang.seok.bae@intel.com>
References: <1557309753-24073-5-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] kbuild: Raise the minimum required binutils version
 to 2.21
Git-Commit-ID: 1fb12b35e5ffe379d109b22cb3069830d0136d9a
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

Commit-ID:  1fb12b35e5ffe379d109b22cb3069830d0136d9a
Gitweb:     https://git.kernel.org/tip/1fb12b35e5ffe379d109b22cb3069830d0136d9a
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Wed, 8 May 2019 03:02:19 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 22 Jun 2019 11:38:51 +0200

kbuild: Raise the minimum required binutils version to 2.21

It helps to use some new instructions directly in assembly code.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Linux Torvalds <torvalds@linux-foundation.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Link: https://lkml.kernel.org/r/1557309753-24073-5-git-send-email-chang.seok.bae@intel.com

---
 Documentation/process/changes.rst | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 18735dc460a0..0a18075c485e 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with isdn4k-utils.
 ====================== ===============  ========================================
 GNU C                  4.6              gcc --version
 GNU make               3.81             make --version
-binutils               2.20             ld -v
+binutils               2.21             ld -v
 flex                   2.5.35           flex --version
 bison                  2.0              bison --version
 util-linux             2.10o            fdformat --version
@@ -77,9 +77,7 @@ You will need GNU make 3.81 or later to build the kernel.
 Binutils
 --------
 
-The build system has, as of 4.13, switched to using thin archives (`ar T`)
-rather than incremental linking (`ld -r`) for built-in.a intermediate steps.
-This requires binutils 2.20 or newer.
+Binutils 2.21 or newer is needed to build the kernel.
 
 pkg-config
 ----------
