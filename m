Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0627EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A806F21835
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfK2GDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfK2GDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:32 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMn-0008MX-Ce; Fri, 29 Nov 2019 07:02:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E5C401C2102;
        Fri, 29 Nov 2019 07:02:52 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:52 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/insn: perf tools: Add some more instructions
 to the new instructions test
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191125125044.31879-2-adrian.hunter@intel.com>
References: <20191125125044.31879-2-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157500737284.21853.2492102855304609809.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9adab0348803e4b0522d8d9f73c9a18134f12381
Gitweb:        https://git.kernel.org/tip/9adab0348803e4b0522d8d9f73c9a18134f12381
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Mon, 25 Nov 2019 14:50:43 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:46 -03:00

x86/insn: perf tools: Add some more instructions to the new instructions test

Add to the "x86 instruction decoder - new instructions" test the following
instructions:

	v4fmaddps
	v4fmaddss
	v4fnmaddps
	v4fnmaddss
	vaesdec
	vaesdeclast
	vaesenc
	vaesenclast
	vcvtne2ps2bf16
	vcvtneps2bf16
	vdpbf16ps
	gf2p8affineinvqb
	vgf2p8affineinvqb
	gf2p8affineqb
	vgf2p8affineqb
	gf2p8mulb
	vgf2p8mulb
	vp2intersectd
	vp2intersectq
	vp4dpwssd
	vp4dpwssds
	vpclmulqdq
	vpcompressb
	vpcompressw
	vpdpbusd
	vpdpbusds
	vpdpwssd
	vpdpwssds
	vpexpandb
	vpexpandw
	vpopcntb
	vpopcntd
	vpopcntq
	vpopcntw
	vpshldd
	vpshldq
	vpshldvd
	vpshldvq
	vpshldvw
	vpshldw
	vpshrdd
	vpshrdq
	vpshrdvd
	vpshrdvq
	vpshrdvw
	vpshrdw
	vpshufbitqmb

For information about the instructions, refer Intel SDM May 2019
(325462-070US) and Intel Architecture Instruction Set Extensions May
2019 (319433-037).

Committer testing:

  $ perf test x86
  61: x86 rdpmc                                             : Ok
  64: x86 instruction decoder - new instructions            : Ok
  66: x86 bp modify                                         : Ok
  $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: x86@kernel.org
Link: http://lore.kernel.org/lkml/20191125125044.31879-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 366 ++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 484 +++++++++++++-
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 655 ++++++++++++++++++-
 3 files changed, 1505 insertions(+)

diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-32.c b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
index 58f8f2a..e6461ab 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-32.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-32.c
@@ -667,6 +667,86 @@
 "62 f2 55 0f 4f f4    \tvrsqrt14ss %xmm4,%xmm5,%xmm6{%k7}",},
 {{0x62, 0xf2, 0xd5, 0x0f, 0x4f, 0xf4, }, 6, 0, "", "",
 "62 f2 d5 0f 4f f4    \tvrsqrt14sd %xmm4,%xmm5,%xmm6{%k7}",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 50 d9    \tvpdpbusd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 50 d9    \tvpdpbusd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 50 d9    \tvpdpbusd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x50, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 50 9c c8 78 56 34 12 \tvpdpbusd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 51 d9    \tvpdpbusds %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 51 d9    \tvpdpbusds %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 51 d9    \tvpdpbusds %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x51, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 51 9c c8 78 56 34 12 \tvpdpbusds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6e, 0x08, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 08 52 d9    \tvdpbf16ps %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6e, 0x28, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 28 52 d9    \tvdpbf16ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6e, 0x48, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 48 52 d9    \tvdpbf16ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6e, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6e 48 52 9c c8 78 56 34 12 \tvdpbf16ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 52 d9    \tvpdpwssd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 52 d9    \tvpdpwssd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 52 d9    \tvpdpwssd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 52 9c c8 78 56 34 12 \tvpdpwssd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x52, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 52 20    \tvp4dpwssd (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x52, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 52 a4 c8 78 56 34 12 \tvp4dpwssd 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 53 d9    \tvpdpwssds %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 53 d9    \tvpdpwssds %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 53 d9    \tvpdpwssds %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x53, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 53 9c c8 78 56 34 12 \tvpdpwssds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x53, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 53 20    \tvp4dpwssds (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x53, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 53 a4 c8 78 56 34 12 \tvp4dpwssds 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 54 d1    \tvpopcntb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 54 d1    \tvpopcntb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 54 d1    \tvpopcntb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 54 94 c8 78 56 34 12 \tvpopcntb 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 54 d1    \tvpopcntw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 54 d1    \tvpopcntw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 54 d1    \tvpopcntw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 54 94 c8 78 56 34 12 \tvpopcntw 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 55 d1    \tvpopcntd %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 55 d1    \tvpopcntd %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 55 d1    \tvpopcntd %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 55 94 c8 78 56 34 12 \tvpopcntd 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 55 d1    \tvpopcntq %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 55 d1    \tvpopcntq %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 55 d1    \tvpopcntq %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 55 94 c8 78 56 34 12 \tvpopcntq 0x12345678(%eax,%ecx,8),%zmm2",},
 {{0xc4, 0xe2, 0x79, 0x59, 0xf4, }, 5, 0, "", "",
 "c4 e2 79 59 f4       \tvpbroadcastq %xmm4,%xmm6",},
 {{0x62, 0xf2, 0x7d, 0x48, 0x59, 0xf7, }, 6, 0, "", "",
@@ -681,6 +761,38 @@
 "62 f2 7d 48 5b 31    \tvbroadcasti32x8 (%ecx),%zmm6",},
 {{0x62, 0xf2, 0xfd, 0x48, 0x5b, 0x31, }, 6, 0, "", "",
 "62 f2 fd 48 5b 31    \tvbroadcasti64x4 (%ecx),%zmm6",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 62 d1    \tvpexpandb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 62 d1    \tvpexpandb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 62 d1    \tvpexpandb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 62 94 c8 78 56 34 12 \tvpexpandb 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 62 d1    \tvpexpandw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 62 d1    \tvpexpandw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 62 d1    \tvpexpandw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 62 94 c8 78 56 34 12 \tvpexpandw 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 08 63 ca    \tvpcompressb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 28 63 ca    \tvpcompressb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 48 63 ca    \tvpcompressb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 63 94 c8 78 56 34 12 \tvpcompressb %zmm2,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 08 63 ca    \tvpcompressw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 28 63 ca    \tvpcompressw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 48 63 ca    \tvpcompressw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 63 94 c8 78 56 34 12 \tvpcompressw %zmm2,0x12345678(%eax,%ecx,8)",},
 {{0x62, 0xf2, 0x55, 0x48, 0x64, 0xf4, }, 6, 0, "", "",
 "62 f2 55 48 64 f4    \tvpblendmd %zmm4,%zmm5,%zmm6",},
 {{0x62, 0xf2, 0xd5, 0x48, 0x64, 0xf4, }, 6, 0, "", "",
@@ -693,6 +805,86 @@
 "62 f2 55 48 66 f4    \tvpblendmb %zmm4,%zmm5,%zmm6",},
 {{0x62, 0xf2, 0xd5, 0x48, 0x66, 0xf4, }, 6, 0, "", "",
 "62 f2 d5 48 66 f4    \tvpblendmw %zmm4,%zmm5,%zmm6",},
+{{0x62, 0xf2, 0x6f, 0x08, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 08 68 d9    \tvp2intersectd %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x28, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 28 68 d9    \tvp2intersectd %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 48 68 d9    \tvp2intersectd %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6f 48 68 9c c8 78 56 34 12 \tvp2intersectd 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x08, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 08 68 d9    \tvp2intersectq %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x28, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 28 68 d9    \tvp2intersectq %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x48, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 48 68 d9    \tvp2intersectq %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ef 48 68 9c c8 78 56 34 12 \tvp2intersectq 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 70 d9    \tvpshldvw %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 70 d9    \tvpshldvw %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 70 d9    \tvpshldvw %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x70, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 70 9c c8 78 56 34 12 \tvpshldvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 71 d9    \tvpshldvd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 71 d9    \tvpshldvd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 71 d9    \tvpshldvd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 71 9c c8 78 56 34 12 \tvpshldvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 71 d9    \tvpshldvq %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 71 d9    \tvpshldvq %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 71 d9    \tvpshldvq %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 71 9c c8 78 56 34 12 \tvpshldvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6f, 0x08, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 08 72 d9    \tvcvtne2ps2bf16 %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6f, 0x28, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 28 72 d9    \tvcvtne2ps2bf16 %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 48 72 d9    \tvcvtne2ps2bf16 %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6f 48 72 9c c8 78 56 34 12 \tvcvtne2ps2bf16 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7e, 0x08, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 08 72 d1    \tvcvtneps2bf16 %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7e, 0x28, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 28 72 d1    \tvcvtneps2bf16 %ymm1,%xmm2",},
+{{0x62, 0xf2, 0x7e, 0x48, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 48 72 d1    \tvcvtneps2bf16 %zmm1,%ymm2",},
+{{0x62, 0xf2, 0x7e, 0x48, 0x72, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7e 48 72 94 c8 78 56 34 12 \tvcvtneps2bf16 0x12345678(%eax,%ecx,8),%ymm2",},
+{{0x62, 0xf2, 0xed, 0x08, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 72 d9    \tvpshrdvw %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 72 d9    \tvpshrdvw %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 72 d9    \tvpshrdvw %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 72 9c c8 78 56 34 12 \tvpshrdvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 73 d9    \tvpshrdvd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 73 d9    \tvpshrdvd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 73 d9    \tvpshrdvd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 73 9c c8 78 56 34 12 \tvpshrdvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 73 d9    \tvpshrdvq %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 73 d9    \tvpshrdvq %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 73 d9    \tvpshrdvq %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 73 9c c8 78 56 34 12 \tvpshrdvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
 {{0x62, 0xf2, 0x55, 0x48, 0x75, 0xf4, }, 6, 0, "", "",
 "62 f2 55 48 75 f4    \tvpermi2b %zmm4,%zmm5,%zmm6",},
 {{0x62, 0xf2, 0xd5, 0x48, 0x75, 0xf4, }, 6, 0, "", "",
@@ -745,6 +937,14 @@
 "62 f2 55 48 8d f4    \tvpermb %zmm4,%zmm5,%zmm6",},
 {{0x62, 0xf2, 0xd5, 0x48, 0x8d, 0xf4, }, 6, 0, "", "",
 "62 f2 d5 48 8d f4    \tvpermw %zmm4,%zmm5,%zmm6",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 8f d9    \tvpshufbitqmb %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 8f d9    \tvpshufbitqmb %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 8f d9    \tvpshufbitqmb %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x8f, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 8f 9c c8 78 56 34 12 \tvpshufbitqmb 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
 {{0xc4, 0xe2, 0x69, 0x90, 0x4c, 0x7d, 0x02, }, 7, 0, "", "",
 "c4 e2 69 90 4c 7d 02 \tvpgatherdd %xmm2,0x2(%ebp,%xmm7,2),%xmm1",},
 {{0xc4, 0xe2, 0xe9, 0x90, 0x4c, 0x7d, 0x04, }, 7, 0, "", "",
@@ -761,6 +961,38 @@
 "62 f2 7d 49 91 b4 fd 7b 00 00 00 \tvpgatherqd 0x7b(%ebp,%zmm7,8),%ymm6{%k1}",},
 {{0x62, 0xf2, 0xfd, 0x49, 0x91, 0xb4, 0xfd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 f2 fd 49 91 b4 fd 7b 00 00 00 \tvpgatherqq 0x7b(%ebp,%zmm7,8),%zmm6{%k1}",},
+{{0xc4, 0xe2, 0x69, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 9a d9       \tvfmsub132ps %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d 9a d9       \tvfmsub132ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x9a, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 9a d9    \tvfmsub132ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 9a 9c c8 78 56 34 12 \tvfmsub132ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 9a d9       \tvfmsub132pd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xed, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 ed 9a d9       \tvfmsub132pd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x9a, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 9a d9    \tvfmsub132pd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 9a 9c c8 78 56 34 12 \tvfmsub132pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x9a, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 9a 20    \tv4fmaddps (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x9a, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 9a a4 c8 78 56 34 12 \tv4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0xc4, 0xe2, 0x69, 0x9b, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 9b d9       \tvfmsub132ss %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x69, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 69 9b 9c c8 78 56 34 12 \tvfmsub132ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9b, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 9b d9       \tvfmsub132sd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 e9 9b 9c c8 78 56 34 12 \tvfmsub132sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x7f, 0x08, 0x9b, 0x20, }, 6, 0, "", "",
+"62 f2 7f 08 9b 20    \tv4fmaddss (%eax),%xmm0,%xmm4",},
+{{0x62, 0xf2, 0x7f, 0x08, 0x9b, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 08 9b a4 c8 78 56 34 12 \tv4fmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4",},
 {{0x62, 0xf2, 0x7d, 0x49, 0xa0, 0xb4, 0xfd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 f2 7d 49 a0 b4 fd 7b 00 00 00 \tvpscatterdd %zmm6,0x7b(%ebp,%zmm7,8){%k1}",},
 {{0x62, 0xf2, 0xfd, 0x49, 0xa0, 0xb4, 0xfd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
@@ -777,6 +1009,38 @@
 "62 f2 7d 49 a3 b4 fd 7b 00 00 00 \tvscatterqps %ymm6,0x7b(%ebp,%zmm7,8){%k1}",},
 {{0x62, 0xf2, 0xfd, 0x49, 0xa3, 0xb4, 0xfd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 f2 fd 49 a3 b4 fd 7b 00 00 00 \tvscatterqpd %zmm6,0x7b(%ebp,%zmm7,8){%k1}",},
+{{0xc4, 0xe2, 0x69, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 aa d9       \tvfmsub213ps %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d aa d9       \tvfmsub213ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xaa, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 aa d9    \tvfmsub213ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 aa 9c c8 78 56 34 12 \tvfmsub213ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0xe9, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 aa d9       \tvfmsub213pd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xed, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 ed aa d9       \tvfmsub213pd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0xaa, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 aa d9    \tvfmsub213pd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 aa 9c c8 78 56 34 12 \tvfmsub213pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0xaa, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 aa 20    \tv4fnmaddps (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0xaa, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 aa a4 c8 78 56 34 12 \tv4fnmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0xc4, 0xe2, 0x69, 0xab, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 ab d9       \tvfmsub213ss %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x69, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 69 ab 9c c8 78 56 34 12 \tvfmsub213ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0xab, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 ab d9       \tvfmsub213sd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 e9 ab 9c c8 78 56 34 12 \tvfmsub213sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x7f, 0x08, 0xab, 0x20, }, 6, 0, "", "",
+"62 f2 7f 08 ab 20    \tv4fnmaddss (%eax),%xmm0,%xmm4",},
+{{0x62, 0xf2, 0x7f, 0x08, 0xab, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 08 ab a4 c8 78 56 34 12 \tv4fnmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4",},
 {{0x62, 0xf2, 0xd5, 0x48, 0xb4, 0xf4, }, 6, 0, "", "",
 "62 f2 d5 48 b4 f4    \tvpmadd52luq %zmm4,%zmm5,%zmm6",},
 {{0x62, 0xf2, 0xd5, 0x48, 0xb5, 0xf4, }, 6, 0, "", "",
@@ -805,6 +1069,50 @@
 "62 f2 4d 0f cd fd    \tvrsqrt28ss %xmm5,%xmm6,%xmm7{%k7}",},
 {{0x62, 0xf2, 0xcd, 0x0f, 0xcd, 0xfd, }, 6, 0, "", "",
 "62 f2 cd 0f cd fd    \tvrsqrt28sd %xmm5,%xmm6,%xmm7{%k7}",},
+{{0x66, 0x0f, 0x38, 0xcf, 0xd9, }, 5, 0, "", "",
+"66 0f 38 cf d9       \tgf2p8mulb %xmm1,%xmm3",},
+{{0x66, 0x0f, 0x38, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"66 0f 38 cf 9c c8 78 56 34 12 \tgf2p8mulb 0x12345678(%eax,%ecx,8),%xmm3",},
+{{0xc4, 0xe2, 0x69, 0xcf, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 cf d9       \tvgf2p8mulb %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xcf, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d cf d9       \tvgf2p8mulb %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xcf, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 cf d9    \tvgf2p8mulb %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 cf 9c c8 78 56 34 12 \tvgf2p8mulb 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdc, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 dc d9       \tvaesenc %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdc, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d dc d9       \tvaesenc %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdc, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 dc d9    \tvaesenc %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdc, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 dc 9c c8 78 56 34 12 \tvaesenc 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdd, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 dd d9       \tvaesenclast %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdd, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d dd d9       \tvaesenclast %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdd, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 dd d9    \tvaesenclast %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdd, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 dd 9c c8 78 56 34 12 \tvaesenclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xde, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 de d9       \tvaesdec %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xde, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d de d9       \tvaesdec %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xde, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 de d9    \tvaesdec %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xde, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 de 9c c8 78 56 34 12 \tvaesdec 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdf, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 df d9       \tvaesdeclast %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdf, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d df d9       \tvaesdeclast %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdf, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 df d9    \tvaesdeclast %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 df 9c c8 78 56 34 12 \tvaesdeclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
 {{0x62, 0xf3, 0x4d, 0x48, 0x03, 0xfd, 0x12, }, 7, 0, "", "",
 "62 f3 4d 48 03 fd 12 \tvalignd $0x12,%zmm5,%zmm6,%zmm7",},
 {{0x62, 0xf3, 0xcd, 0x48, 0x03, 0xfd, 0x12, }, 7, 0, "", "",
@@ -905,6 +1213,12 @@
 "62 f3 4d 48 43 fd 12 \tvshufi32x4 $0x12,%zmm5,%zmm6,%zmm7",},
 {{0x62, 0xf3, 0xcd, 0x48, 0x43, 0xfd, 0x12, }, 7, 0, "", "",
 "62 f3 cd 48 43 fd 12 \tvshufi64x2 $0x12,%zmm5,%zmm6,%zmm7",},
+{{0xc4, 0xe3, 0x69, 0x44, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 69 44 d9 12    \tvpclmulqdq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0x6d, 0x44, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 6d 44 d9 12    \tvpclmulqdq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x44, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 44 d9 12 \tvpclmulqdq $0x12,%zmm1,%zmm2,%zmm3",},
 {{0x62, 0xf3, 0x4d, 0x48, 0x50, 0xfd, 0x12, }, 7, 0, "", "",
 "62 f3 4d 48 50 fd 12 \tvrangeps $0x12,%zmm5,%zmm6,%zmm7",},
 {{0x62, 0xf3, 0xcd, 0x48, 0x50, 0xfd, 0x12, }, 7, 0, "", "",
@@ -937,6 +1251,58 @@
 "62 f3 7d 08 67 ef 12 \tvfpclassss $0x12,%xmm7,%k5",},
 {{0x62, 0xf3, 0xfd, 0x08, 0x67, 0xef, 0x12, }, 7, 0, "", "",
 "62 f3 fd 08 67 ef 12 \tvfpclasssd $0x12,%xmm7,%k5",},
+{{0x62, 0xf3, 0xed, 0x08, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 70 d9 12 \tvpshldw $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 70 d9 12 \tvpshldw $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 70 d9 12 \tvpshldw $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf3, 0x6d, 0x08, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 08 71 d9 12 \tvpshldd $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0x6d, 0x28, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 28 71 d9 12 \tvpshldd $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 71 d9 12 \tvpshldd $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf3, 0xed, 0x08, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 71 d9 12 \tvpshldq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 71 d9 12 \tvpshldq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 71 d9 12 \tvpshldq $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf3, 0xed, 0x08, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 72 d9 12 \tvpshrdw $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 72 d9 12 \tvpshrdw $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 72 d9 12 \tvpshrdw $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf3, 0x6d, 0x08, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 08 73 d9 12 \tvpshrdd $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0x6d, 0x28, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 28 73 d9 12 \tvpshrdd $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 73 d9 12 \tvpshrdd $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf3, 0xed, 0x08, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 73 d9 12 \tvpshrdq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 73 d9 12 \tvpshrdq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 73 d9 12 \tvpshrdq $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x66, 0x0f, 0x3a, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"66 0f 3a ce d9 12    \tgf2p8affineqb $0x12,%xmm1,%xmm3",},
+{{0xc4, 0xe3, 0xe9, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 e9 ce d9 12    \tvgf2p8affineqb $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0xed, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 ed ce d9 12    \tvgf2p8affineqb $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0xce, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 ce d9 12 \tvgf2p8affineqb $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x66, 0x0f, 0x3a, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"66 0f 3a cf d9 12    \tgf2p8affineinvqb $0x12,%xmm1,%xmm3",},
+{{0xc4, 0xe3, 0xe9, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 e9 cf d9 12    \tvgf2p8affineinvqb $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0xed, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 ed cf d9 12    \tvgf2p8affineinvqb $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0xcf, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 cf d9 12 \tvgf2p8affineinvqb $0x12,%zmm1,%zmm2,%zmm3",},
 {{0x62, 0xf1, 0x4d, 0x48, 0x72, 0xc5, 0x12, }, 7, 0, "", "",
 "62 f1 4d 48 72 c5 12 \tvprord $0x12,%zmm5,%zmm6",},
 {{0x62, 0xf1, 0xcd, 0x48, 0x72, 0xc5, 0x12, }, 7, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-64.c b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
index 656f8ae..567eccc 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-64.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-64.c
@@ -587,6 +587,112 @@
 "62 02 35 07 4f d0    \tvrsqrt14ss %xmm24,%xmm25,%xmm26{%k7}",},
 {{0x62, 0x02, 0xb5, 0x07, 0x4f, 0xd0, }, 6, 0, "", "",
 "62 02 b5 07 4f d0    \tvrsqrt14sd %xmm24,%xmm25,%xmm26{%k7}",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 50 d9    \tvpdpbusd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 50 d9    \tvpdpbusd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x50, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 50 d9    \tvpdpbusd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x50, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 50 9c c8 78 56 34 12 \tvpdpbusd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x50, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 50 9c c8 78 56 34 12 \tvpdpbusd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 51 d9    \tvpdpbusds %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 51 d9    \tvpdpbusds %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x51, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 51 d9    \tvpdpbusds %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x51, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 51 9c c8 78 56 34 12 \tvpdpbusds 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x51, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 51 9c c8 78 56 34 12 \tvpdpbusds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6e, 0x08, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 08 52 d9    \tvdpbf16ps %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6e, 0x28, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 28 52 d9    \tvdpbf16ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6e, 0x48, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6e 48 52 d9    \tvdpbf16ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6e, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6e 48 52 9c c8 78 56 34 12 \tvdpbf16ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6e, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6e 48 52 9c c8 78 56 34 12 \tvdpbf16ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 52 d9    \tvpdpwssd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 52 d9    \tvpdpwssd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x52, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 52 d9    \tvpdpwssd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 52 9c c8 78 56 34 12 \tvpdpwssd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x52, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 52 9c c8 78 56 34 12 \tvpdpwssd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x52, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 52 20    \tvp4dpwssd (%rax),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x52, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 48 52 20 \tvp4dpwssd (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x52, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 52 a4 c8 78 56 34 12 \tvp4dpwssd 0x12345678(%rax,%rcx,8),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x52, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 48 52 a4 c8 78 56 34 12 \tvp4dpwssd 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 53 d9    \tvpdpwssds %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 53 d9    \tvpdpwssds %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x53, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 53 d9    \tvpdpwssds %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x53, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 53 9c c8 78 56 34 12 \tvpdpwssds 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x53, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 53 9c c8 78 56 34 12 \tvpdpwssds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x53, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 53 20    \tvp4dpwssds (%rax),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x53, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 48 53 20 \tvp4dpwssds (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x53, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 53 a4 c8 78 56 34 12 \tvp4dpwssds 0x12345678(%rax,%rcx,8),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x53, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 48 53 a4 c8 78 56 34 12 \tvp4dpwssds 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 54 d1    \tvpopcntb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 54 d1    \tvpopcntb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 54 d1    \tvpopcntb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 54 94 c8 78 56 34 12 \tvpopcntb 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0x7d, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7d 48 54 94 c8 78 56 34 12 \tvpopcntb 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 54 d1    \tvpopcntw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 54 d1    \tvpopcntw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x54, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 54 d1    \tvpopcntw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 54 94 c8 78 56 34 12 \tvpopcntw 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0xfd, 0x48, 0x54, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 fd 48 54 94 c8 78 56 34 12 \tvpopcntw 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 55 d1    \tvpopcntd %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 55 d1    \tvpopcntd %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 55 d1    \tvpopcntd %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 55 94 c8 78 56 34 12 \tvpopcntd 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0x7d, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7d 48 55 94 c8 78 56 34 12 \tvpopcntd 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 55 d1    \tvpopcntq %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 55 d1    \tvpopcntq %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x55, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 55 d1    \tvpopcntq %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 55 94 c8 78 56 34 12 \tvpopcntq 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0xfd, 0x48, 0x55, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 fd 48 55 94 c8 78 56 34 12 \tvpopcntq 0x12345678(%eax,%ecx,8),%zmm2",},
 {{0xc4, 0xe2, 0x79, 0x59, 0xf4, }, 5, 0, "", "",
 "c4 e2 79 59 f4       \tvpbroadcastq %xmm4,%xmm6",},
 {{0x62, 0x02, 0x7d, 0x48, 0x59, 0xd3, }, 6, 0, "", "",
@@ -601,6 +707,46 @@
 "62 62 7d 48 5b 21    \tvbroadcasti32x8 (%rcx),%zmm28",},
 {{0x62, 0x62, 0xfd, 0x48, 0x5b, 0x11, }, 6, 0, "", "",
 "62 62 fd 48 5b 11    \tvbroadcasti64x4 (%rcx),%zmm26",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 08 62 d1    \tvpexpandb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 28 62 d1    \tvpexpandb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 7d 48 62 d1    \tvpexpandb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 62 94 c8 78 56 34 12 \tvpexpandb 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0x7d, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7d 48 62 94 c8 78 56 34 12 \tvpexpandb 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 08 62 d1    \tvpexpandw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 28 62 d1    \tvpexpandw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x62, 0xd1, }, 6, 0, "", "",
+"62 f2 fd 48 62 d1    \tvpexpandw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 62 94 c8 78 56 34 12 \tvpexpandw 0x12345678(%rax,%rcx,8),%zmm2",},
+{{0x67, 0x62, 0xf2, 0xfd, 0x48, 0x62, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 fd 48 62 94 c8 78 56 34 12 \tvpexpandw 0x12345678(%eax,%ecx,8),%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x08, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 08 63 ca    \tvpcompressb %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7d, 0x28, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 28 63 ca    \tvpcompressb %ymm1,%ymm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 7d 48 63 ca    \tvpcompressb %zmm1,%zmm2",},
+{{0x62, 0xf2, 0x7d, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7d 48 63 94 c8 78 56 34 12 \tvpcompressb %zmm2,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0x62, 0xf2, 0x7d, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7d 48 63 94 c8 78 56 34 12 \tvpcompressb %zmm2,0x12345678(%eax,%ecx,8)",},
+{{0x62, 0xf2, 0xfd, 0x08, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 08 63 ca    \tvpcompressw %xmm1,%xmm2",},
+{{0x62, 0xf2, 0xfd, 0x28, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 28 63 ca    \tvpcompressw %ymm1,%ymm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x63, 0xca, }, 6, 0, "", "",
+"62 f2 fd 48 63 ca    \tvpcompressw %zmm1,%zmm2",},
+{{0x62, 0xf2, 0xfd, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 fd 48 63 94 c8 78 56 34 12 \tvpcompressw %zmm2,0x12345678(%rax,%rcx,8)",},
+{{0x67, 0x62, 0xf2, 0xfd, 0x48, 0x63, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 fd 48 63 94 c8 78 56 34 12 \tvpcompressw %zmm2,0x12345678(%eax,%ecx,8)",},
 {{0x62, 0x02, 0x25, 0x40, 0x64, 0xe2, }, 6, 0, "", "",
 "62 02 25 40 64 e2    \tvpblendmd %zmm26,%zmm27,%zmm28",},
 {{0x62, 0x02, 0xa5, 0x40, 0x64, 0xe2, }, 6, 0, "", "",
@@ -613,6 +759,106 @@
 "62 02 25 40 66 e2    \tvpblendmb %zmm26,%zmm27,%zmm28",},
 {{0x62, 0x02, 0xa5, 0x40, 0x66, 0xe2, }, 6, 0, "", "",
 "62 02 a5 40 66 e2    \tvpblendmw %zmm26,%zmm27,%zmm28",},
+{{0x62, 0xf2, 0x6f, 0x08, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 08 68 d9    \tvp2intersectd %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x28, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 28 68 d9    \tvp2intersectd %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 48 68 d9    \tvp2intersectd %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6f 48 68 9c c8 78 56 34 12 \tvp2intersectd 0x12345678(%rax,%rcx,8),%zmm2,%k3",},
+{{0x67, 0x62, 0xf2, 0x6f, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6f 48 68 9c c8 78 56 34 12 \tvp2intersectd 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x08, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 08 68 d9    \tvp2intersectq %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x28, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 28 68 d9    \tvp2intersectq %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x48, 0x68, 0xd9, }, 6, 0, "", "",
+"62 f2 ef 48 68 d9    \tvp2intersectq %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0xef, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ef 48 68 9c c8 78 56 34 12 \tvp2intersectq 0x12345678(%rax,%rcx,8),%zmm2,%k3",},
+{{0x67, 0x62, 0xf2, 0xef, 0x48, 0x68, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ef 48 68 9c c8 78 56 34 12 \tvp2intersectq 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 70 d9    \tvpshldvw %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 70 d9    \tvpshldvw %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x70, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 70 d9    \tvpshldvw %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x70, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 70 9c c8 78 56 34 12 \tvpshldvw 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0x70, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 70 9c c8 78 56 34 12 \tvpshldvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 71 d9    \tvpshldvd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 71 d9    \tvpshldvd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 71 d9    \tvpshldvd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 71 9c c8 78 56 34 12 \tvpshldvd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 71 9c c8 78 56 34 12 \tvpshldvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 71 d9    \tvpshldvq %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 71 d9    \tvpshldvq %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x71, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 71 d9    \tvpshldvq %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 71 9c c8 78 56 34 12 \tvpshldvq 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0x71, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 71 9c c8 78 56 34 12 \tvpshldvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6f, 0x08, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 08 72 d9    \tvcvtne2ps2bf16 %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6f, 0x28, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 28 72 d9    \tvcvtne2ps2bf16 %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 6f 48 72 d9    \tvcvtne2ps2bf16 %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6f, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6f 48 72 9c c8 78 56 34 12 \tvcvtne2ps2bf16 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6f, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6f 48 72 9c c8 78 56 34 12 \tvcvtne2ps2bf16 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7e, 0x08, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 08 72 d1    \tvcvtneps2bf16 %xmm1,%xmm2",},
+{{0x62, 0xf2, 0x7e, 0x28, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 28 72 d1    \tvcvtneps2bf16 %ymm1,%xmm2",},
+{{0x62, 0xf2, 0x7e, 0x48, 0x72, 0xd1, }, 6, 0, "", "",
+"62 f2 7e 48 72 d1    \tvcvtneps2bf16 %zmm1,%ymm2",},
+{{0x62, 0xf2, 0x7e, 0x48, 0x72, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7e 48 72 94 c8 78 56 34 12 \tvcvtneps2bf16 0x12345678(%rax,%rcx,8),%ymm2",},
+{{0x67, 0x62, 0xf2, 0x7e, 0x48, 0x72, 0x94, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7e 48 72 94 c8 78 56 34 12 \tvcvtneps2bf16 0x12345678(%eax,%ecx,8),%ymm2",},
+{{0x62, 0xf2, 0xed, 0x08, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 72 d9    \tvpshrdvw %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 72 d9    \tvpshrdvw %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x72, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 72 d9    \tvpshrdvw %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 72 9c c8 78 56 34 12 \tvpshrdvw 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0x72, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 72 9c c8 78 56 34 12 \tvpshrdvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 73 d9    \tvpshrdvd %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 73 d9    \tvpshrdvd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 73 d9    \tvpshrdvd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 73 9c c8 78 56 34 12 \tvpshrdvd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 73 9c c8 78 56 34 12 \tvpshrdvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x08, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 08 73 d9    \tvpshrdvq %xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf2, 0xed, 0x28, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 28 73 d9    \tvpshrdvq %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x73, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 73 d9    \tvpshrdvq %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 73 9c c8 78 56 34 12 \tvpshrdvq 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0x73, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 73 9c c8 78 56 34 12 \tvpshrdvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
 {{0x62, 0x02, 0x35, 0x40, 0x75, 0xd0, }, 6, 0, "", "",
 "62 02 35 40 75 d0    \tvpermi2b %zmm24,%zmm25,%zmm26",},
 {{0x62, 0x02, 0xa5, 0x40, 0x75, 0xe2, }, 6, 0, "", "",
@@ -667,6 +913,16 @@
 "62 02 25 40 8d e2    \tvpermb %zmm26,%zmm27,%zmm28",},
 {{0x62, 0x02, 0xa5, 0x40, 0x8d, 0xe2, }, 6, 0, "", "",
 "62 02 a5 40 8d e2    \tvpermw %zmm26,%zmm27,%zmm28",},
+{{0x62, 0xf2, 0x6d, 0x08, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 08 8f d9    \tvpshufbitqmb %xmm1,%xmm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x28, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 28 8f d9    \tvpshufbitqmb %ymm1,%ymm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x8f, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 8f d9    \tvpshufbitqmb %zmm1,%zmm2,%k3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x8f, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 8f 9c c8 78 56 34 12 \tvpshufbitqmb 0x12345678(%rax,%rcx,8),%zmm2,%k3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x8f, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 8f 9c c8 78 56 34 12 \tvpshufbitqmb 0x12345678(%eax,%ecx,8),%zmm2,%k3",},
 {{0xc4, 0xe2, 0x69, 0x90, 0x4c, 0x7d, 0x02, }, 7, 0, "", "",
 "c4 e2 69 90 4c 7d 02 \tvpgatherdd %xmm2,0x2(%rbp,%xmm7,2),%xmm1",},
 {{0xc4, 0xe2, 0xe9, 0x90, 0x4c, 0x7d, 0x04, }, 7, 0, "", "",
@@ -683,6 +939,54 @@
 "62 22 7d 41 91 94 dd 7b 00 00 00 \tvpgatherqd 0x7b(%rbp,%zmm27,8),%ymm26{%k1}",},
 {{0x62, 0x22, 0xfd, 0x41, 0x91, 0x94, 0xdd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 22 fd 41 91 94 dd 7b 00 00 00 \tvpgatherqq 0x7b(%rbp,%zmm27,8),%zmm26{%k1}",},
+{{0xc4, 0xe2, 0x69, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 9a d9       \tvfmsub132ps %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d 9a d9       \tvfmsub132ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x9a, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 9a d9    \tvfmsub132ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 9a 9c c8 78 56 34 12 \tvfmsub132ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 9a 9c c8 78 56 34 12 \tvfmsub132ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 9a d9       \tvfmsub132pd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xed, 0x9a, 0xd9, }, 5, 0, "", "",
+"c4 e2 ed 9a d9       \tvfmsub132pd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x9a, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 9a d9    \tvfmsub132pd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 9a 9c c8 78 56 34 12 \tvfmsub132pd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0x9a, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 9a 9c c8 78 56 34 12 \tvfmsub132pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x9a, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 9a 20    \tv4fmaddps (%rax),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x9a, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 48 9a 20 \tv4fmaddps (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0x9a, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 9a a4 c8 78 56 34 12 \tv4fmaddps 0x12345678(%rax,%rcx,8),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0x9a, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 48 9a a4 c8 78 56 34 12 \tv4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0xc4, 0xe2, 0x69, 0x9b, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 9b d9       \tvfmsub132ss %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x69, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 69 9b 9c c8 78 56 34 12 \tvfmsub132ss 0x12345678(%rax,%rcx,8),%xmm2,%xmm3",},
+{{0x67, 0xc4, 0xe2, 0x69, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 69 9b 9c c8 78 56 34 12 \tvfmsub132ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9b, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 9b d9       \tvfmsub132sd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 e9 9b 9c c8 78 56 34 12 \tvfmsub132sd 0x12345678(%rax,%rcx,8),%xmm2,%xmm3",},
+{{0x67, 0xc4, 0xe2, 0xe9, 0x9b, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 e9 9b 9c c8 78 56 34 12 \tvfmsub132sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x7f, 0x08, 0x9b, 0x20, }, 6, 0, "", "",
+"62 f2 7f 08 9b 20    \tv4fmaddss (%rax),%xmm0,%xmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x08, 0x9b, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 08 9b 20 \tv4fmaddss (%eax),%xmm0,%xmm4",},
+{{0x62, 0xf2, 0x7f, 0x08, 0x9b, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 08 9b a4 c8 78 56 34 12 \tv4fmaddss 0x12345678(%rax,%rcx,8),%xmm0,%xmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x08, 0x9b, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 08 9b a4 c8 78 56 34 12 \tv4fmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4",},
 {{0x62, 0x22, 0x7d, 0x41, 0xa0, 0xa4, 0xed, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 22 7d 41 a0 a4 ed 7b 00 00 00 \tvpscatterdd %zmm28,0x7b(%rbp,%zmm29,8){%k1}",},
 {{0x62, 0x22, 0xfd, 0x41, 0xa0, 0x94, 0xdd, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
@@ -699,6 +1003,54 @@
 "62 b2 7d 41 a3 b4 ed 7b 00 00 00 \tvscatterqps %ymm6,0x7b(%rbp,%zmm29,8){%k1}",},
 {{0x62, 0x22, 0xfd, 0x41, 0xa3, 0xa4, 0xed, 0x7b, 0x00, 0x00, 0x00, }, 11, 0, "", "",
 "62 22 fd 41 a3 a4 ed 7b 00 00 00 \tvscatterqpd %zmm28,0x7b(%rbp,%zmm29,8){%k1}",},
+{{0xc4, 0xe2, 0x69, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 aa d9       \tvfmsub213ps %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d aa d9       \tvfmsub213ps %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xaa, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 aa d9    \tvfmsub213ps %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 aa 9c c8 78 56 34 12 \tvfmsub213ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 aa 9c c8 78 56 34 12 \tvfmsub213ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0xe9, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 aa d9       \tvfmsub213pd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xed, 0xaa, 0xd9, }, 5, 0, "", "",
+"c4 e2 ed aa d9       \tvfmsub213pd %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0xaa, 0xd9, }, 6, 0, "", "",
+"62 f2 ed 48 aa d9    \tvfmsub213pd %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0xed, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 ed 48 aa 9c c8 78 56 34 12 \tvfmsub213pd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0xed, 0x48, 0xaa, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 ed 48 aa 9c c8 78 56 34 12 \tvfmsub213pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x7f, 0x48, 0xaa, 0x20, }, 6, 0, "", "",
+"62 f2 7f 48 aa 20    \tv4fnmaddps (%rax),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0xaa, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 48 aa 20 \tv4fnmaddps (%eax),%zmm0,%zmm4",},
+{{0x62, 0xf2, 0x7f, 0x48, 0xaa, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 48 aa a4 c8 78 56 34 12 \tv4fnmaddps 0x12345678(%rax,%rcx,8),%zmm0,%zmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x48, 0xaa, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 48 aa a4 c8 78 56 34 12 \tv4fnmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4",},
+{{0xc4, 0xe2, 0x69, 0xab, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 ab d9       \tvfmsub213ss %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x69, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 69 ab 9c c8 78 56 34 12 \tvfmsub213ss 0x12345678(%rax,%rcx,8),%xmm2,%xmm3",},
+{{0x67, 0xc4, 0xe2, 0x69, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 69 ab 9c c8 78 56 34 12 \tvfmsub213ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0xab, 0xd9, }, 5, 0, "", "",
+"c4 e2 e9 ab d9       \tvfmsub213sd %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0xe9, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"c4 e2 e9 ab 9c c8 78 56 34 12 \tvfmsub213sd 0x12345678(%rax,%rcx,8),%xmm2,%xmm3",},
+{{0x67, 0xc4, 0xe2, 0xe9, 0xab, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 c4 e2 e9 ab 9c c8 78 56 34 12 \tvfmsub213sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3",},
+{{0x62, 0xf2, 0x7f, 0x08, 0xab, 0x20, }, 6, 0, "", "",
+"62 f2 7f 08 ab 20    \tv4fnmaddss (%rax),%xmm0,%xmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x08, 0xab, 0x20, }, 7, 0, "", "",
+"67 62 f2 7f 08 ab 20 \tv4fnmaddss (%eax),%xmm0,%xmm4",},
+{{0x62, 0xf2, 0x7f, 0x08, 0xab, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 7f 08 ab a4 c8 78 56 34 12 \tv4fnmaddss 0x12345678(%rax,%rcx,8),%xmm0,%xmm4",},
+{{0x67, 0x62, 0xf2, 0x7f, 0x08, 0xab, 0xa4, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 7f 08 ab a4 c8 78 56 34 12 \tv4fnmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4",},
 {{0x62, 0x02, 0xa5, 0x40, 0xb4, 0xe2, }, 6, 0, "", "",
 "62 02 a5 40 b4 e2    \tvpmadd52luq %zmm26,%zmm27,%zmm28",},
 {{0x62, 0x02, 0xa5, 0x40, 0xb5, 0xe2, }, 6, 0, "", "",
@@ -727,6 +1079,62 @@
 "62 02 15 07 cd f4    \tvrsqrt28ss %xmm28,%xmm29,%xmm30{%k7}",},
 {{0x62, 0x02, 0xad, 0x07, 0xcd, 0xd9, }, 6, 0, "", "",
 "62 02 ad 07 cd d9    \tvrsqrt28sd %xmm25,%xmm26,%xmm27{%k7}",},
+{{0x66, 0x0f, 0x38, 0xcf, 0xd9, }, 5, 0, "", "",
+"66 0f 38 cf d9       \tgf2p8mulb %xmm1,%xmm3",},
+{{0x66, 0x0f, 0x38, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 10, 0, "", "",
+"66 0f 38 cf 9c c8 78 56 34 12 \tgf2p8mulb 0x12345678(%rax,%rcx,8),%xmm3",},
+{{0x67, 0x66, 0x0f, 0x38, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"67 66 0f 38 cf 9c c8 78 56 34 12 \tgf2p8mulb 0x12345678(%eax,%ecx,8),%xmm3",},
+{{0xc4, 0xe2, 0x69, 0xcf, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 cf d9       \tvgf2p8mulb %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xcf, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d cf d9       \tvgf2p8mulb %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xcf, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 cf d9    \tvgf2p8mulb %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 cf 9c c8 78 56 34 12 \tvgf2p8mulb 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xcf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 cf 9c c8 78 56 34 12 \tvgf2p8mulb 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdc, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 dc d9       \tvaesenc %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdc, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d dc d9       \tvaesenc %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdc, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 dc d9    \tvaesenc %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdc, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 dc 9c c8 78 56 34 12 \tvaesenc 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xdc, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 dc 9c c8 78 56 34 12 \tvaesenc 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdd, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 dd d9       \tvaesenclast %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdd, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d dd d9       \tvaesenclast %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdd, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 dd d9    \tvaesenclast %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdd, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 dd 9c c8 78 56 34 12 \tvaesenclast 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xdd, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 dd 9c c8 78 56 34 12 \tvaesenclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xde, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 de d9       \tvaesdec %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xde, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d de d9       \tvaesdec %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xde, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 de d9    \tvaesdec %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xde, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 de 9c c8 78 56 34 12 \tvaesdec 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xde, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 de 9c c8 78 56 34 12 \tvaesdec 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
+{{0xc4, 0xe2, 0x69, 0xdf, 0xd9, }, 5, 0, "", "",
+"c4 e2 69 df d9       \tvaesdeclast %xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe2, 0x6d, 0xdf, 0xd9, }, 5, 0, "", "",
+"c4 e2 6d df d9       \tvaesdeclast %ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdf, 0xd9, }, 6, 0, "", "",
+"62 f2 6d 48 df d9    \tvaesdeclast %zmm1,%zmm2,%zmm3",},
+{{0x62, 0xf2, 0x6d, 0x48, 0xdf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 11, 0, "", "",
+"62 f2 6d 48 df 9c c8 78 56 34 12 \tvaesdeclast 0x12345678(%rax,%rcx,8),%zmm2,%zmm3",},
+{{0x67, 0x62, 0xf2, 0x6d, 0x48, 0xdf, 0x9c, 0xc8, 0x78, 0x56, 0x34, 0x12, }, 12, 0, "", "",
+"67 62 f2 6d 48 df 9c c8 78 56 34 12 \tvaesdeclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3",},
 {{0x62, 0x03, 0x15, 0x40, 0x03, 0xf4, 0x12, }, 7, 0, "", "",
 "62 03 15 40 03 f4 12 \tvalignd $0x12,%zmm28,%zmm29,%zmm30",},
 {{0x62, 0x03, 0xad, 0x40, 0x03, 0xd9, 0x12, }, 7, 0, "", "",
@@ -827,6 +1235,14 @@
 "62 03 2d 40 43 d9 12 \tvshufi32x4 $0x12,%zmm25,%zmm26,%zmm27",},
 {{0x62, 0x03, 0x95, 0x40, 0x43, 0xf4, 0x12, }, 7, 0, "", "",
 "62 03 95 40 43 f4 12 \tvshufi64x2 $0x12,%zmm28,%zmm29,%zmm30",},
+{{0xc4, 0xe3, 0x69, 0x44, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 69 44 d9 12    \tvpclmulqdq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0x6d, 0x44, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 6d 44 d9 12    \tvpclmulqdq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x44, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 44 d9 12 \tvpclmulqdq $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0x2d, 0x40, 0x44, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 2d 40 44 d9 12 \tvpclmulqdq $0x12,%zmm25,%zmm26,%zmm27",},
 {{0x62, 0x03, 0x2d, 0x40, 0x50, 0xd9, 0x12, }, 7, 0, "", "",
 "62 03 2d 40 50 d9 12 \tvrangeps $0x12,%zmm25,%zmm26,%zmm27",},
 {{0x62, 0x03, 0x95, 0x40, 0x50, 0xf4, 0x12, }, 7, 0, "", "",
@@ -859,6 +1275,74 @@
 "62 93 7d 08 67 eb 12 \tvfpclassss $0x12,%xmm27,%k5",},
 {{0x62, 0x93, 0xfd, 0x08, 0x67, 0xee, 0x12, }, 7, 0, "", "",
 "62 93 fd 08 67 ee 12 \tvfpclasssd $0x12,%xmm30,%k5",},
+{{0x62, 0xf3, 0xed, 0x08, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 70 d9 12 \tvpshldw $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 70 d9 12 \tvpshldw $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 70 d9 12 \tvpshldw $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0x70, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 70 d9 12 \tvpshldw $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x62, 0xf3, 0x6d, 0x08, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 08 71 d9 12 \tvpshldd $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0x6d, 0x28, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 28 71 d9 12 \tvpshldd $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 71 d9 12 \tvpshldd $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0x2d, 0x40, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 2d 40 71 d9 12 \tvpshldd $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x62, 0xf3, 0xed, 0x08, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 71 d9 12 \tvpshldq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 71 d9 12 \tvpshldq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 71 d9 12 \tvpshldq $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0x71, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 71 d9 12 \tvpshldq $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x62, 0xf3, 0xed, 0x08, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 72 d9 12 \tvpshrdw $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 72 d9 12 \tvpshrdw $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 72 d9 12 \tvpshrdw $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0x72, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 72 d9 12 \tvpshrdw $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x62, 0xf3, 0x6d, 0x08, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 08 73 d9 12 \tvpshrdd $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0x6d, 0x28, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 28 73 d9 12 \tvpshrdd $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0x6d, 0x48, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 6d 48 73 d9 12 \tvpshrdd $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0x2d, 0x40, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 2d 40 73 d9 12 \tvpshrdd $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x62, 0xf3, 0xed, 0x08, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 08 73 d9 12 \tvpshrdq $0x12,%xmm1,%xmm2,%xmm3",},
+{{0x62, 0xf3, 0xed, 0x28, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 28 73 d9 12 \tvpshrdq $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 73 d9 12 \tvpshrdq $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0x73, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 73 d9 12 \tvpshrdq $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x66, 0x0f, 0x3a, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"66 0f 3a ce d9 12    \tgf2p8affineqb $0x12,%xmm1,%xmm3",},
+{{0xc4, 0xe3, 0xe9, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 e9 ce d9 12    \tvgf2p8affineqb $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0xed, 0xce, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 ed ce d9 12    \tvgf2p8affineqb $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0xce, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 ce d9 12 \tvgf2p8affineqb $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0xce, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 ce d9 12 \tvgf2p8affineqb $0x12,%zmm25,%zmm26,%zmm27",},
+{{0x66, 0x0f, 0x3a, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"66 0f 3a cf d9 12    \tgf2p8affineinvqb $0x12,%xmm1,%xmm3",},
+{{0xc4, 0xe3, 0xe9, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 e9 cf d9 12    \tvgf2p8affineinvqb $0x12,%xmm1,%xmm2,%xmm3",},
+{{0xc4, 0xe3, 0xed, 0xcf, 0xd9, 0x12, }, 6, 0, "", "",
+"c4 e3 ed cf d9 12    \tvgf2p8affineinvqb $0x12,%ymm1,%ymm2,%ymm3",},
+{{0x62, 0xf3, 0xed, 0x48, 0xcf, 0xd9, 0x12, }, 7, 0, "", "",
+"62 f3 ed 48 cf d9 12 \tvgf2p8affineinvqb $0x12,%zmm1,%zmm2,%zmm3",},
+{{0x62, 0x03, 0xad, 0x40, 0xcf, 0xd9, 0x12, }, 7, 0, "", "",
+"62 03 ad 40 cf d9 12 \tvgf2p8affineinvqb $0x12,%zmm25,%zmm26,%zmm27",},
 {{0x62, 0x91, 0x2d, 0x40, 0x72, 0xc1, 0x12, }, 7, 0, "", "",
 "62 91 2d 40 72 c1 12 \tvprord $0x12,%zmm25,%zmm26",},
 {{0x62, 0x91, 0xad, 0x40, 0x72, 0xc1, 0x12, }, 7, 0, "", "",
diff --git a/tools/perf/arch/x86/tests/insn-x86-dat-src.c b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
index dd85a3a..ddbf07c 100644
--- a/tools/perf/arch/x86/tests/insn-x86-dat-src.c
+++ b/tools/perf/arch/x86/tests/insn-x86-dat-src.c
@@ -510,6 +510,82 @@ int main(void)
 	asm volatile("vrsqrt14ss %xmm24,%xmm25,%xmm26{%k7}");
 	asm volatile("vrsqrt14sd %xmm24,%xmm25,%xmm26{%k7}");
 
+	/* AVX-512: Op code 0f 38 50 */
+
+	asm volatile("vpdpbusd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpbusd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpbusd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpbusd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpdpbusd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 51 */
+
+	asm volatile("vpdpbusds %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpbusds %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpbusds %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpbusds 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpdpbusds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 52 */
+
+	asm volatile("vdpbf16ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vdpbf16ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vdpbf16ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vdpbf16ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vdpbf16ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpdpwssd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpwssd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpwssd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpwssd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpdpwssd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vp4dpwssd (%rax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssd (%eax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssd 0x12345678(%rax,%rcx,8),%zmm0,%zmm4");
+	asm volatile("vp4dpwssd 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 53 */
+
+	asm volatile("vpdpwssds %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpwssds %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpwssds %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpwssds 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpdpwssds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vp4dpwssds (%rax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssds (%eax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssds 0x12345678(%rax,%rcx,8),%zmm0,%zmm4");
+	asm volatile("vp4dpwssds 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 54 */
+
+	asm volatile("vpopcntb %xmm1, %xmm2");
+	asm volatile("vpopcntb %ymm1, %ymm2");
+	asm volatile("vpopcntb %zmm1, %zmm2");
+	asm volatile("vpopcntb 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpopcntb 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpopcntw %xmm1, %xmm2");
+	asm volatile("vpopcntw %ymm1, %ymm2");
+	asm volatile("vpopcntw %zmm1, %zmm2");
+	asm volatile("vpopcntw 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpopcntw 0x12345678(%eax,%ecx,8),%zmm2");
+
+	/* AVX-512: Op code 0f 38 55 */
+
+	asm volatile("vpopcntd %xmm1, %xmm2");
+	asm volatile("vpopcntd %ymm1, %ymm2");
+	asm volatile("vpopcntd %zmm1, %zmm2");
+	asm volatile("vpopcntd 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpopcntd 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpopcntq %xmm1, %xmm2");
+	asm volatile("vpopcntq %ymm1, %ymm2");
+	asm volatile("vpopcntq %zmm1, %zmm2");
+	asm volatile("vpopcntq 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpopcntq 0x12345678(%eax,%ecx,8),%zmm2");
+
 	/* AVX-512: Op code 0f 38 59 */
 
 	asm volatile("vpbroadcastq %xmm4,%xmm6");
@@ -526,6 +602,34 @@ int main(void)
 	asm volatile("vbroadcasti32x8 (%rcx),%zmm28");
 	asm volatile("vbroadcasti64x4 (%rcx),%zmm26");
 
+	/* AVX-512: Op code 0f 38 62 */
+
+	asm volatile("vpexpandb %xmm1, %xmm2");
+	asm volatile("vpexpandb %ymm1, %ymm2");
+	asm volatile("vpexpandb %zmm1, %zmm2");
+	asm volatile("vpexpandb 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpexpandb 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpexpandw %xmm1, %xmm2");
+	asm volatile("vpexpandw %ymm1, %ymm2");
+	asm volatile("vpexpandw %zmm1, %zmm2");
+	asm volatile("vpexpandw 0x12345678(%rax,%rcx,8),%zmm2");
+	asm volatile("vpexpandw 0x12345678(%eax,%ecx,8),%zmm2");
+
+	/* AVX-512: Op code 0f 38 63 */
+
+	asm volatile("vpcompressb %xmm1, %xmm2");
+	asm volatile("vpcompressb %ymm1, %ymm2");
+	asm volatile("vpcompressb %zmm1, %zmm2");
+	asm volatile("vpcompressb %zmm2,0x12345678(%rax,%rcx,8)");
+	asm volatile("vpcompressb %zmm2,0x12345678(%eax,%ecx,8)");
+
+	asm volatile("vpcompressw %xmm1, %xmm2");
+	asm volatile("vpcompressw %ymm1, %ymm2");
+	asm volatile("vpcompressw %zmm1, %zmm2");
+	asm volatile("vpcompressw %zmm2,0x12345678(%rax,%rcx,8)");
+	asm volatile("vpcompressw %zmm2,0x12345678(%eax,%ecx,8)");
+
 	/* AVX-512: Op code 0f 38 64 */
 
 	asm volatile("vpblendmd %zmm26,%zmm27,%zmm28");
@@ -541,6 +645,76 @@ int main(void)
 	asm volatile("vpblendmb %zmm26,%zmm27,%zmm28");
 	asm volatile("vpblendmw %zmm26,%zmm27,%zmm28");
 
+	/* AVX-512: Op code 0f 38 68 */
+
+	asm volatile("vp2intersectd %xmm1, %xmm2, %k3");
+	asm volatile("vp2intersectd %ymm1, %ymm2, %k3");
+	asm volatile("vp2intersectd %zmm1, %zmm2, %k3");
+	asm volatile("vp2intersectd 0x12345678(%rax,%rcx,8),%zmm2,%k3");
+	asm volatile("vp2intersectd 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
+	asm volatile("vp2intersectq %xmm1, %xmm2, %k3");
+	asm volatile("vp2intersectq %ymm1, %ymm2, %k3");
+	asm volatile("vp2intersectq %zmm1, %zmm2, %k3");
+	asm volatile("vp2intersectq 0x12345678(%rax,%rcx,8),%zmm2,%k3");
+	asm volatile("vp2intersectq 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
+	/* AVX-512: Op code 0f 38 70 */
+
+	asm volatile("vpshldvw %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvw %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvw %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvw 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshldvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 71 */
+
+	asm volatile("vpshldvd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshldvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpshldvq %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvq %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvq %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvq 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshldvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 72 */
+
+	asm volatile("vcvtne2ps2bf16 %xmm1, %xmm2, %xmm3");
+	asm volatile("vcvtne2ps2bf16 %ymm1, %ymm2, %ymm3");
+	asm volatile("vcvtne2ps2bf16 %zmm1, %zmm2, %zmm3");
+	asm volatile("vcvtne2ps2bf16 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vcvtne2ps2bf16 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vcvtneps2bf16 %xmm1, %xmm2");
+	asm volatile("vcvtneps2bf16 %ymm1, %xmm2");
+	asm volatile("vcvtneps2bf16 %zmm1, %ymm2");
+	asm volatile("vcvtneps2bf16 0x12345678(%rax,%rcx,8),%ymm2");
+	asm volatile("vcvtneps2bf16 0x12345678(%eax,%ecx,8),%ymm2");
+
+	asm volatile("vpshrdvw %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvw %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvw %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvw 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshrdvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 73 */
+
+	asm volatile("vpshrdvd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshrdvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpshrdvq %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvq %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvq %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvq 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vpshrdvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 38 75 */
 
 	asm volatile("vpermi2b %zmm24,%zmm25,%zmm26");
@@ -613,6 +787,14 @@ int main(void)
 	asm volatile("vpermb %zmm26,%zmm27,%zmm28");
 	asm volatile("vpermw %zmm26,%zmm27,%zmm28");
 
+	/* AVX-512: Op code 0f 38 8f */
+
+	asm volatile("vpshufbitqmb %xmm1, %xmm2, %k3");
+	asm volatile("vpshufbitqmb %ymm1, %ymm2, %k3");
+	asm volatile("vpshufbitqmb %zmm1, %zmm2, %k3");
+	asm volatile("vpshufbitqmb 0x12345678(%rax,%rcx,8),%zmm2,%k3");
+	asm volatile("vpshufbitqmb 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
 	/* AVX-512: Op code 0f 38 90 */
 
 	asm volatile("vpgatherdd %xmm2,0x02(%rbp,%xmm7,2),%xmm1");
@@ -627,6 +809,40 @@ int main(void)
 	asm volatile("vpgatherqd 0x7b(%rbp,%zmm27,8),%ymm26{%k1}");
 	asm volatile("vpgatherqq 0x7b(%rbp,%zmm27,8),%zmm26{%k1}");
 
+	/* AVX-512: Op code 0f 38 9a */
+
+	asm volatile("vfmsub132ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub132ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub132ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vfmsub132ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vfmsub132pd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132pd %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub132pd %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub132pd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vfmsub132pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("v4fmaddps (%rax), %zmm0, %zmm4");
+	asm volatile("v4fmaddps (%eax), %zmm0, %zmm4");
+	asm volatile("v4fmaddps 0x12345678(%rax,%rcx,8),%zmm0,%zmm4");
+	asm volatile("v4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 9b */
+
+	asm volatile("vfmsub132ss %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132ss 0x12345678(%rax,%rcx,8),%xmm2,%xmm3");
+	asm volatile("vfmsub132ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("vfmsub132sd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132sd 0x12345678(%rax,%rcx,8),%xmm2,%xmm3");
+	asm volatile("vfmsub132sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("v4fmaddss (%rax), %xmm0, %xmm4");
+	asm volatile("v4fmaddss (%eax), %xmm0, %xmm4");
+	asm volatile("v4fmaddss 0x12345678(%rax,%rcx,8),%xmm0,%xmm4");
+	asm volatile("v4fmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4");
+
 	/* AVX-512: Op code 0f 38 a0 */
 
 	asm volatile("vpscatterdd %zmm28,0x7b(%rbp,%zmm29,8){%k1}");
@@ -647,6 +863,40 @@ int main(void)
 	asm volatile("vscatterqps %ymm6,0x7b(%rbp,%zmm29,8){%k1}");
 	asm volatile("vscatterqpd %zmm28,0x7b(%rbp,%zmm29,8){%k1}");
 
+	/* AVX-512: Op code 0f 38 aa */
+
+	asm volatile("vfmsub213ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub213ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub213ps 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vfmsub213ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vfmsub213pd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213pd %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub213pd %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub213pd 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vfmsub213pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("v4fnmaddps (%rax), %zmm0, %zmm4");
+	asm volatile("v4fnmaddps (%eax), %zmm0, %zmm4");
+	asm volatile("v4fnmaddps 0x12345678(%rax,%rcx,8),%zmm0,%zmm4");
+	asm volatile("v4fnmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 ab */
+
+	asm volatile("vfmsub213ss %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213ss 0x12345678(%rax,%rcx,8),%xmm2,%xmm3");
+	asm volatile("vfmsub213ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("vfmsub213sd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213sd 0x12345678(%rax,%rcx,8),%xmm2,%xmm3");
+	asm volatile("vfmsub213sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("v4fnmaddss (%rax), %xmm0, %xmm4");
+	asm volatile("v4fnmaddss (%eax), %xmm0, %xmm4");
+	asm volatile("v4fnmaddss 0x12345678(%rax,%rcx,8),%xmm0,%xmm4");
+	asm volatile("v4fnmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4");
+
 	/* AVX-512: Op code 0f 38 b4 */
 
 	asm volatile("vpmadd52luq %zmm26,%zmm27,%zmm28");
@@ -685,6 +935,50 @@ int main(void)
 	asm volatile("vrsqrt28ss %xmm28,%xmm29,%xmm30{%k7}");
 	asm volatile("vrsqrt28sd %xmm25,%xmm26,%xmm27{%k7}");
 
+	/* AVX-512: Op code 0f 38 cf */
+
+	asm volatile("gf2p8mulb %xmm1, %xmm3");
+	asm volatile("gf2p8mulb 0x12345678(%rax,%rcx,8),%xmm3");
+	asm volatile("gf2p8mulb 0x12345678(%eax,%ecx,8),%xmm3");
+
+	asm volatile("vgf2p8mulb %xmm1, %xmm2, %xmm3");
+	asm volatile("vgf2p8mulb %ymm1, %ymm2, %ymm3");
+	asm volatile("vgf2p8mulb %zmm1, %zmm2, %zmm3");
+	asm volatile("vgf2p8mulb 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vgf2p8mulb 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 dc */
+
+	asm volatile("vaesenc %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesenc %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesenc %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesenc 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vaesenc 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 dd */
+
+	asm volatile("vaesenclast %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesenclast %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesenclast %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesenclast 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vaesenclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 de */
+
+	asm volatile("vaesdec %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesdec %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesdec %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesdec 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vaesdec 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 df */
+
+	asm volatile("vaesdeclast %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesdeclast %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesdeclast %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesdeclast 0x12345678(%rax,%rcx,8),%zmm2,%zmm3");
+	asm volatile("vaesdeclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 3a 03 */
 
 	asm volatile("valignd $0x12,%zmm28,%zmm29,%zmm30");
@@ -804,6 +1098,13 @@ int main(void)
 	asm volatile("vshufi32x4 $0x12,%zmm25,%zmm26,%zmm27");
 	asm volatile("vshufi64x2 $0x12,%zmm28,%zmm29,%zmm30");
 
+	/* AVX-512: Op code 0f 3a 44 */
+
+	asm volatile("vpclmulqdq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpclmulqdq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpclmulqdq $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpclmulqdq $0x12,%zmm25,%zmm26,%zmm27");
+
 	/* AVX-512: Op code 0f 3a 50 */
 
 	asm volatile("vrangeps $0x12,%zmm25,%zmm26,%zmm27");
@@ -844,6 +1145,62 @@ int main(void)
 	asm volatile("vfpclassss $0x12,%xmm27,%k5");
 	asm volatile("vfpclasssd $0x12,%xmm30,%k5");
 
+	/* AVX-512: Op code 0f 3a 70 */
+
+	asm volatile("vpshldw $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldw $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldw $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshldw $0x12,%zmm25,%zmm26,%zmm27");
+
+	/* AVX-512: Op code 0f 3a 71 */
+
+	asm volatile("vpshldd $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldd $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldd $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshldd $0x12,%zmm25,%zmm26,%zmm27");
+
+	asm volatile("vpshldq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldq $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshldq $0x12,%zmm25,%zmm26,%zmm27");
+
+	/* AVX-512: Op code 0f 3a 72 */
+
+	asm volatile("vpshrdw $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdw $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdw $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshrdw $0x12,%zmm25,%zmm26,%zmm27");
+
+	/* AVX-512: Op code 0f 3a 73 */
+
+	asm volatile("vpshrdd $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdd $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdd $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshrdd $0x12,%zmm25,%zmm26,%zmm27");
+
+	asm volatile("vpshrdq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdq $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vpshrdq $0x12,%zmm25,%zmm26,%zmm27");
+
+	/* AVX-512: Op code 0f 3a ce */
+
+	asm volatile("gf2p8affineqb $0x12,%xmm1,%xmm3");
+
+	asm volatile("vgf2p8affineqb $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vgf2p8affineqb $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vgf2p8affineqb $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vgf2p8affineqb $0x12,%zmm25,%zmm26,%zmm27");
+
+	/* AVX-512: Op code 0f 3a cf */
+
+	asm volatile("gf2p8affineinvqb $0x12,%xmm1,%xmm3");
+
+	asm volatile("vgf2p8affineinvqb $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vgf2p8affineinvqb $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vgf2p8affineinvqb $0x12,%zmm1,%zmm2,%zmm3");
+	asm volatile("vgf2p8affineinvqb $0x12,%zmm25,%zmm26,%zmm27");
+
 	/* AVX-512: Op code 0f 72 (Grp13) */
 
 	asm volatile("vprord $0x12,%zmm25,%zmm26");
@@ -1946,6 +2303,69 @@ int main(void)
 	asm volatile("vrsqrt14ss %xmm4,%xmm5,%xmm6{%k7}");
 	asm volatile("vrsqrt14sd %xmm4,%xmm5,%xmm6{%k7}");
 
+	/* AVX-512: Op code 0f 38 50 */
+
+	asm volatile("vpdpbusd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpbusd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpbusd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpbusd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 51 */
+
+	asm volatile("vpdpbusds %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpbusds %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpbusds %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpbusds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 52 */
+
+	asm volatile("vdpbf16ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vdpbf16ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vdpbf16ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vdpbf16ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpdpwssd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpwssd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpwssd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpwssd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vp4dpwssd (%eax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssd 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 53 */
+
+	asm volatile("vpdpwssds %xmm1, %xmm2, %xmm3");
+	asm volatile("vpdpwssds %ymm1, %ymm2, %ymm3");
+	asm volatile("vpdpwssds %zmm1, %zmm2, %zmm3");
+	asm volatile("vpdpwssds 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vp4dpwssds (%eax), %zmm0, %zmm4");
+	asm volatile("vp4dpwssds 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 54 */
+
+	asm volatile("vpopcntb %xmm1, %xmm2");
+	asm volatile("vpopcntb %ymm1, %ymm2");
+	asm volatile("vpopcntb %zmm1, %zmm2");
+	asm volatile("vpopcntb 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpopcntw %xmm1, %xmm2");
+	asm volatile("vpopcntw %ymm1, %ymm2");
+	asm volatile("vpopcntw %zmm1, %zmm2");
+	asm volatile("vpopcntw 0x12345678(%eax,%ecx,8),%zmm2");
+
+	/* AVX-512: Op code 0f 38 55 */
+
+	asm volatile("vpopcntd %xmm1, %xmm2");
+	asm volatile("vpopcntd %ymm1, %ymm2");
+	asm volatile("vpopcntd %zmm1, %zmm2");
+	asm volatile("vpopcntd 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpopcntq %xmm1, %xmm2");
+	asm volatile("vpopcntq %ymm1, %ymm2");
+	asm volatile("vpopcntq %zmm1, %zmm2");
+	asm volatile("vpopcntq 0x12345678(%eax,%ecx,8),%zmm2");
+
 	/* AVX-512: Op code 0f 38 59 */
 
 	asm volatile("vpbroadcastq %xmm4,%xmm6");
@@ -1962,6 +2382,30 @@ int main(void)
 	asm volatile("vbroadcasti32x8 (%ecx),%zmm6");
 	asm volatile("vbroadcasti64x4 (%ecx),%zmm6");
 
+	/* AVX-512: Op code 0f 38 62 */
+
+	asm volatile("vpexpandb %xmm1, %xmm2");
+	asm volatile("vpexpandb %ymm1, %ymm2");
+	asm volatile("vpexpandb %zmm1, %zmm2");
+	asm volatile("vpexpandb 0x12345678(%eax,%ecx,8),%zmm2");
+
+	asm volatile("vpexpandw %xmm1, %xmm2");
+	asm volatile("vpexpandw %ymm1, %ymm2");
+	asm volatile("vpexpandw %zmm1, %zmm2");
+	asm volatile("vpexpandw 0x12345678(%eax,%ecx,8),%zmm2");
+
+	/* AVX-512: Op code 0f 38 63 */
+
+	asm volatile("vpcompressb %xmm1, %xmm2");
+	asm volatile("vpcompressb %ymm1, %ymm2");
+	asm volatile("vpcompressb %zmm1, %zmm2");
+	asm volatile("vpcompressb %zmm2,0x12345678(%eax,%ecx,8)");
+
+	asm volatile("vpcompressw %xmm1, %xmm2");
+	asm volatile("vpcompressw %ymm1, %ymm2");
+	asm volatile("vpcompressw %zmm1, %zmm2");
+	asm volatile("vpcompressw %zmm2,0x12345678(%eax,%ecx,8)");
+
 	/* AVX-512: Op code 0f 38 64 */
 
 	asm volatile("vpblendmd %zmm4,%zmm5,%zmm6");
@@ -1977,6 +2421,66 @@ int main(void)
 	asm volatile("vpblendmb %zmm4,%zmm5,%zmm6");
 	asm volatile("vpblendmw %zmm4,%zmm5,%zmm6");
 
+	/* AVX-512: Op code 0f 38 68 */
+
+	asm volatile("vp2intersectd %xmm1, %xmm2, %k3");
+	asm volatile("vp2intersectd %ymm1, %ymm2, %k3");
+	asm volatile("vp2intersectd %zmm1, %zmm2, %k3");
+	asm volatile("vp2intersectd 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
+	asm volatile("vp2intersectq %xmm1, %xmm2, %k3");
+	asm volatile("vp2intersectq %ymm1, %ymm2, %k3");
+	asm volatile("vp2intersectq %zmm1, %zmm2, %k3");
+	asm volatile("vp2intersectq 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
+	/* AVX-512: Op code 0f 38 70 */
+
+	asm volatile("vpshldvw %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvw %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvw %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 71 */
+
+	asm volatile("vpshldvd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpshldvq %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshldvq %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshldvq %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshldvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 72 */
+
+	asm volatile("vcvtne2ps2bf16 %xmm1, %xmm2, %xmm3");
+	asm volatile("vcvtne2ps2bf16 %ymm1, %ymm2, %ymm3");
+	asm volatile("vcvtne2ps2bf16 %zmm1, %zmm2, %zmm3");
+	asm volatile("vcvtne2ps2bf16 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vcvtneps2bf16 %xmm1, %xmm2");
+	asm volatile("vcvtneps2bf16 %ymm1, %xmm2");
+	asm volatile("vcvtneps2bf16 %zmm1, %ymm2");
+	asm volatile("vcvtneps2bf16 0x12345678(%eax,%ecx,8),%ymm2");
+
+	asm volatile("vpshrdvw %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvw %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvw %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvw 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 73 */
+
+	asm volatile("vpshrdvd %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvd %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvd %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vpshrdvq %xmm1, %xmm2, %xmm3");
+	asm volatile("vpshrdvq %ymm1, %ymm2, %ymm3");
+	asm volatile("vpshrdvq %zmm1, %zmm2, %zmm3");
+	asm volatile("vpshrdvq 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 38 75 */
 
 	asm volatile("vpermi2b %zmm4,%zmm5,%zmm6");
@@ -2048,6 +2552,13 @@ int main(void)
 	asm volatile("vpermb %zmm4,%zmm5,%zmm6");
 	asm volatile("vpermw %zmm4,%zmm5,%zmm6");
 
+	/* AVX-512: Op code 0f 38 8f */
+
+	asm volatile("vpshufbitqmb %xmm1, %xmm2, %k3");
+	asm volatile("vpshufbitqmb %ymm1, %ymm2, %k3");
+	asm volatile("vpshufbitqmb %zmm1, %zmm2, %k3");
+	asm volatile("vpshufbitqmb 0x12345678(%eax,%ecx,8),%zmm2,%k3");
+
 	/* AVX-512: Op code 0f 38 90 */
 
 	asm volatile("vpgatherdd %xmm2,0x02(%ebp,%xmm7,2),%xmm1");
@@ -2062,6 +2573,32 @@ int main(void)
 	asm volatile("vpgatherqd 0x7b(%ebp,%zmm7,8),%ymm6{%k1}");
 	asm volatile("vpgatherqq 0x7b(%ebp,%zmm7,8),%zmm6{%k1}");
 
+	/* AVX-512: Op code 0f 38 9a */
+
+	asm volatile("vfmsub132ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub132ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub132ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vfmsub132pd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132pd %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub132pd %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub132pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("v4fmaddps (%eax), %zmm0, %zmm4");
+	asm volatile("v4fmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 9b */
+
+	asm volatile("vfmsub132ss %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("vfmsub132sd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub132sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("v4fmaddss (%eax), %xmm0, %xmm4");
+	asm volatile("v4fmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4");
+
 	/* AVX-512: Op code 0f 38 a0 */
 
 	asm volatile("vpscatterdd %zmm6,0x7b(%ebp,%zmm7,8){%k1}");
@@ -2082,6 +2619,32 @@ int main(void)
 	asm volatile("vscatterqps %ymm6,0x7b(%ebp,%zmm7,8){%k1}");
 	asm volatile("vscatterqpd %zmm6,0x7b(%ebp,%zmm7,8){%k1}");
 
+	/* AVX-512: Op code 0f 38 aa */
+
+	asm volatile("vfmsub213ps %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213ps %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub213ps %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub213ps 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("vfmsub213pd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213pd %ymm1, %ymm2, %ymm3");
+	asm volatile("vfmsub213pd %zmm1, %zmm2, %zmm3");
+	asm volatile("vfmsub213pd 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	asm volatile("v4fnmaddps (%eax), %zmm0, %zmm4");
+	asm volatile("v4fnmaddps 0x12345678(%eax,%ecx,8),%zmm0,%zmm4");
+
+	/* AVX-512: Op code 0f 38 ab */
+
+	asm volatile("vfmsub213ss %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213ss 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("vfmsub213sd %xmm1, %xmm2, %xmm3");
+	asm volatile("vfmsub213sd 0x12345678(%eax,%ecx,8),%xmm2,%xmm3");
+
+	asm volatile("v4fnmaddss (%eax), %xmm0, %xmm4");
+	asm volatile("v4fnmaddss 0x12345678(%eax,%ecx,8),%xmm0,%xmm4");
+
 	/* AVX-512: Op code 0f 38 b4 */
 
 	asm volatile("vpmadd52luq %zmm4,%zmm5,%zmm6");
@@ -2120,6 +2683,44 @@ int main(void)
 	asm volatile("vrsqrt28ss %xmm5,%xmm6,%xmm7{%k7}");
 	asm volatile("vrsqrt28sd %xmm5,%xmm6,%xmm7{%k7}");
 
+	/* AVX-512: Op code 0f 38 cf */
+
+	asm volatile("gf2p8mulb %xmm1, %xmm3");
+	asm volatile("gf2p8mulb 0x12345678(%eax,%ecx,8),%xmm3");
+
+	asm volatile("vgf2p8mulb %xmm1, %xmm2, %xmm3");
+	asm volatile("vgf2p8mulb %ymm1, %ymm2, %ymm3");
+	asm volatile("vgf2p8mulb %zmm1, %zmm2, %zmm3");
+	asm volatile("vgf2p8mulb 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 dc */
+
+	asm volatile("vaesenc %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesenc %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesenc %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesenc 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 dd */
+
+	asm volatile("vaesenclast %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesenclast %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesenclast %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesenclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 de */
+
+	asm volatile("vaesdec %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesdec %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesdec %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesdec 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 38 df */
+
+	asm volatile("vaesdeclast %xmm1, %xmm2, %xmm3");
+	asm volatile("vaesdeclast %ymm1, %ymm2, %ymm3");
+	asm volatile("vaesdeclast %zmm1, %zmm2, %zmm3");
+	asm volatile("vaesdeclast 0x12345678(%eax,%ecx,8),%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 3a 03 */
 
 	asm volatile("valignd $0x12,%zmm5,%zmm6,%zmm7");
@@ -2239,6 +2840,12 @@ int main(void)
 	asm volatile("vshufi32x4 $0x12,%zmm5,%zmm6,%zmm7");
 	asm volatile("vshufi64x2 $0x12,%zmm5,%zmm6,%zmm7");
 
+	/* AVX-512: Op code 0f 3a 44 */
+
+	asm volatile("vpclmulqdq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpclmulqdq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpclmulqdq $0x12,%zmm1,%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 3a 50 */
 
 	asm volatile("vrangeps $0x12,%zmm5,%zmm6,%zmm7");
@@ -2279,6 +2886,54 @@ int main(void)
 	asm volatile("vfpclassss $0x12,%xmm7,%k5");
 	asm volatile("vfpclasssd $0x12,%xmm7,%k5");
 
+	/* AVX-512: Op code 0f 3a 70 */
+
+	asm volatile("vpshldw $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldw $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldw $0x12,%zmm1,%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 3a 71 */
+
+	asm volatile("vpshldd $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldd $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldd $0x12,%zmm1,%zmm2,%zmm3");
+
+	asm volatile("vpshldq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshldq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshldq $0x12,%zmm1,%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 3a 72 */
+
+	asm volatile("vpshrdw $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdw $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdw $0x12,%zmm1,%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 3a 73 */
+
+	asm volatile("vpshrdd $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdd $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdd $0x12,%zmm1,%zmm2,%zmm3");
+
+	asm volatile("vpshrdq $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vpshrdq $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vpshrdq $0x12,%zmm1,%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 3a ce */
+
+	asm volatile("gf2p8affineqb $0x12,%xmm1,%xmm3");
+
+	asm volatile("vgf2p8affineqb $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vgf2p8affineqb $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vgf2p8affineqb $0x12,%zmm1,%zmm2,%zmm3");
+
+	/* AVX-512: Op code 0f 3a cf */
+
+	asm volatile("gf2p8affineinvqb $0x12,%xmm1,%xmm3");
+
+	asm volatile("vgf2p8affineinvqb $0x12,%xmm1,%xmm2,%xmm3");
+	asm volatile("vgf2p8affineinvqb $0x12,%ymm1,%ymm2,%ymm3");
+	asm volatile("vgf2p8affineinvqb $0x12,%zmm1,%zmm2,%zmm3");
+
 	/* AVX-512: Op code 0f 72 (Grp13) */
 
 	asm volatile("vprord $0x12,%zmm5,%zmm6");
