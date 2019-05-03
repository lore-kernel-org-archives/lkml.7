Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D574EC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AFF2087F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 05:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="EHkAhj55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfECF6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 01:58:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59027 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbfECF6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 01:58:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x435wPcL2618875
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 2 May 2019 22:58:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x435wPcL2618875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556863106;
        bh=4gFiNc6aYZNRTTk314IoaB/2DWOUvIoG/2Ua+VpEQH4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=EHkAhj55jswPaTTpLu738ycSZCmp2A2bIp3O9t+QnjOHCWc1QYWWujLMl5FanQNWa
         6ez8u1dEvjfriTHNDv/L1V98OTpW5husqtfnYgg+RxiHoo9tFqkrt2mNFQjsO+pk6F
         j27BHAGlNQHn34/2UzVw9+i9pXVK39Kp/kgBuzzxDIiE+/L6nSmuCZv/zD3TDETF/e
         NQ973DHQeL33UZPeLqqBKx05YjH6rKtToF4shS+PbRTvs52lnSaBc8DcxWB28v1LM6
         1CCgXDSeY7PHurYoxhx3Pm+hsy3/wTE9PPhb2CWqjRiE5o+Dxk7w9Yt9Mby8IcxpDu
         frQ+YSO6rCcbA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x435wP082618872;
        Thu, 2 May 2019 22:58:25 -0700
Date:   Thu, 2 May 2019 22:58:25 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-18f90d372cf35b387663f1567de701e5393f6eb5@git.kernel.org>
Cc:     tglx@linutronix.de, hpa@zytor.com, arnd@arndb.de, acme@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, adrian.hunter@intel.com,
        Vineet.Gupta1@synopsys.com, mingo@kernel.org
Reply-To: hpa@zytor.com, tglx@linutronix.de, namhyung@kernel.org,
          acme@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, mingo@kernel.org, adrian.hunter@intel.com,
          Vineet.Gupta1@synopsys.com
In-Reply-To: <20190426193531.GC28586@kernel.org>
References: <20190426193531.GC28586@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools arch uapi: Copy missing unistd.h headers
 for arc, hexagon and riscv
Git-Commit-ID: 18f90d372cf35b387663f1567de701e5393f6eb5
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

Commit-ID:  18f90d372cf35b387663f1567de701e5393f6eb5
Gitweb:     https://git.kernel.org/tip/18f90d372cf35b387663f1567de701e5393f6eb5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 22 Apr 2019 15:21:35 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 2 May 2019 16:00:20 -0400

tools arch uapi: Copy missing unistd.h headers for arc, hexagon and riscv

Since those were introduced in:

  c8ce48f06503 ("asm-generic: Make time32 syscall numbers optional")

But when the asm-generic/unistd.h was sync'ed with tools/ in:

  1a787fc5ba18 ("tools headers uapi: Sync copy of asm-generic/unistd.h with the kernel sources")

I forgot to copy the files for the architectures that define
__ARCH_WANT_TIME32_SYSCALLS, so the perf build was breaking there, as
reported by Vineet Gupta for the ARC architecture.

After updating my ARC container to use the glibc based toolchain + cross
building libnuma, zlib and elfutils, I finally managed to reproduce the
problem and verify that this now is fixed and will not regress as will
be tested before each pull req sent upstream.

Reported-by: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jiri Olsa <jolsa@kernel.org>
CC: linux-snps-arc@lists.infradead.org
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/r/20190426193531.GC28586@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 {arch => tools/arch}/arc/include/uapi/asm/unistd.h     | 0
 {arch => tools/arch}/hexagon/include/uapi/asm/unistd.h | 0
 {arch => tools/arch}/riscv/include/uapi/asm/unistd.h   | 0
 3 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/arch/arc/include/uapi/asm/unistd.h b/tools/arch/arc/include/uapi/asm/unistd.h
similarity index 100%
copy from arch/arc/include/uapi/asm/unistd.h
copy to tools/arch/arc/include/uapi/asm/unistd.h
diff --git a/arch/hexagon/include/uapi/asm/unistd.h b/tools/arch/hexagon/include/uapi/asm/unistd.h
similarity index 100%
copy from arch/hexagon/include/uapi/asm/unistd.h
copy to tools/arch/hexagon/include/uapi/asm/unistd.h
diff --git a/arch/riscv/include/uapi/asm/unistd.h b/tools/arch/riscv/include/uapi/asm/unistd.h
similarity index 100%
copy from arch/riscv/include/uapi/asm/unistd.h
copy to tools/arch/riscv/include/uapi/asm/unistd.h
