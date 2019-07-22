Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6BFC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F4121E6B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="I5m5Pas3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbfGVInO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:43:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49481 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbfGVInO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:43:14 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6M8h7v13745072
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 22 Jul 2019 01:43:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6M8h7v13745072
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1563784988;
        bh=M2b499By19MqgVxPHTfvyT2HfCZoBaHwd9Uky1rVqGE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=I5m5Pas3Eu3nOgIuFefMBIA7dNLneHdvb0fEPabGFQpYnbyaZlZN5UqnRJxwoqi7X
         TRS4Wkw1B+cPLu+ZvuYtSvF6r4j6/or8sFfY6LGrHJDfALAKR2+uRRO9W7ze7rRueo
         EIyoQh/Rs2WGE9VzFufEORSFD5OH5gtxR9yD6hW89psUfLwWrqVzkAXT9rPjghcl0a
         Aj2iwcz6YBW/NJH8EOQc4dwzQhecSHB51iWvyp8hkvUD2VoWVBRKhth3Wf4Ejrcp02
         I6B9Afsr9gmZnJ4eFNV0YbutedRVkznFNWNdUpdnmP3ntLdeQmZnje/fMi5tIKXuGN
         QyYliPhH40pqQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6M8h7AU3745069;
        Mon, 22 Jul 2019 01:43:07 -0700
Date:   Mon, 22 Jul 2019 01:43:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Gayatri Kammela <tipbot@zytor.com>
Message-ID: <tip-1e0c08e3034de0659367393bfa825188462f22e6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, gayatri.kammela@intel.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, gayatri.kammela@intel.com
In-Reply-To: <20190717234632.32673-2-gayatri.kammela@intel.com>
References: <20190717234632.32673-2-gayatri.kammela@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] cpu/cpuid-deps: Add a tab to cpuid dependent features
Git-Commit-ID: 1e0c08e3034de0659367393bfa825188462f22e6
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

Commit-ID:  1e0c08e3034de0659367393bfa825188462f22e6
Gitweb:     https://git.kernel.org/tip/1e0c08e3034de0659367393bfa825188462f22e6
Author:     Gayatri Kammela <gayatri.kammela@intel.com>
AuthorDate: Wed, 17 Jul 2019 16:46:31 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 22 Jul 2019 10:38:24 +0200

cpu/cpuid-deps: Add a tab to cpuid dependent features

Improve code readability by adding a tab between the elements of each
structure in an array of cpuid-dep struct so longer feature names will fit.

Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20190717234632.32673-2-gayatri.kammela@intel.com

---
 arch/x86/kernel/cpu/cpuid-deps.c | 96 ++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index b5353244749b..630a9f77fb6b 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -20,54 +20,54 @@ struct cpuid_dep {
  * but it's difficult to tell that to the init reference checker.
  */
 static const struct cpuid_dep cpuid_deps[] = {
-	{ X86_FEATURE_FXSR,		X86_FEATURE_FPU	      },
-	{ X86_FEATURE_XSAVEOPT,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_XSAVEC,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_XSAVES,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_AVX,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_PKU,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_MPX,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_XGETBV1,		X86_FEATURE_XSAVE     },
-	{ X86_FEATURE_CMOV,		X86_FEATURE_FXSR      },
-	{ X86_FEATURE_MMX,		X86_FEATURE_FXSR      },
-	{ X86_FEATURE_MMXEXT,		X86_FEATURE_MMX       },
-	{ X86_FEATURE_FXSR_OPT,		X86_FEATURE_FXSR      },
-	{ X86_FEATURE_XSAVE,		X86_FEATURE_FXSR      },
-	{ X86_FEATURE_XMM,		X86_FEATURE_FXSR      },
-	{ X86_FEATURE_XMM2,		X86_FEATURE_XMM       },
-	{ X86_FEATURE_XMM3,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_XMM4_1,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_XMM4_2,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_XMM3,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_PCLMULQDQ,	X86_FEATURE_XMM2      },
-	{ X86_FEATURE_SSSE3,		X86_FEATURE_XMM2,     },
-	{ X86_FEATURE_F16C,		X86_FEATURE_XMM2,     },
-	{ X86_FEATURE_AES,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_SHA_NI,		X86_FEATURE_XMM2      },
-	{ X86_FEATURE_FMA,		X86_FEATURE_AVX       },
-	{ X86_FEATURE_AVX2,		X86_FEATURE_AVX,      },
-	{ X86_FEATURE_AVX512F,		X86_FEATURE_AVX,      },
-	{ X86_FEATURE_AVX512IFMA,	X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512PF,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512ER,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512CD,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512DQ,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512BW,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512VL,		X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512VBMI,	X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512_VBMI2,	X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_GFNI,		X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VAES,		X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_VPCLMULQDQ,	X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_AVX512_VNNI,	X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_AVX512_BITALG,	X86_FEATURE_AVX512VL  },
-	{ X86_FEATURE_AVX512_4VNNIW,	X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512_4FMAPS,	X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_AVX512_VPOPCNTDQ, X86_FEATURE_AVX512F   },
-	{ X86_FEATURE_CQM_OCCUP_LLC,	X86_FEATURE_CQM_LLC   },
-	{ X86_FEATURE_CQM_MBM_TOTAL,	X86_FEATURE_CQM_LLC   },
-	{ X86_FEATURE_CQM_MBM_LOCAL,	X86_FEATURE_CQM_LLC   },
-	{ X86_FEATURE_AVX512_BF16,	X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_FXSR,			X86_FEATURE_FPU	      },
+	{ X86_FEATURE_XSAVEOPT,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_XSAVEC,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_XSAVES,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_AVX,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_PKU,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_MPX,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_XGETBV1,			X86_FEATURE_XSAVE     },
+	{ X86_FEATURE_CMOV,			X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMX,			X86_FEATURE_FXSR      },
+	{ X86_FEATURE_MMXEXT,			X86_FEATURE_MMX       },
+	{ X86_FEATURE_FXSR_OPT,			X86_FEATURE_FXSR      },
+	{ X86_FEATURE_XSAVE,			X86_FEATURE_FXSR      },
+	{ X86_FEATURE_XMM,			X86_FEATURE_FXSR      },
+	{ X86_FEATURE_XMM2,			X86_FEATURE_XMM       },
+	{ X86_FEATURE_XMM3,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_XMM4_1,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_XMM4_2,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_XMM3,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_PCLMULQDQ,		X86_FEATURE_XMM2      },
+	{ X86_FEATURE_SSSE3,			X86_FEATURE_XMM2,     },
+	{ X86_FEATURE_F16C,			X86_FEATURE_XMM2,     },
+	{ X86_FEATURE_AES,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_SHA_NI,			X86_FEATURE_XMM2      },
+	{ X86_FEATURE_FMA,			X86_FEATURE_AVX       },
+	{ X86_FEATURE_AVX2,			X86_FEATURE_AVX,      },
+	{ X86_FEATURE_AVX512F,			X86_FEATURE_AVX,      },
+	{ X86_FEATURE_AVX512IFMA,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512PF,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512ER,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512CD,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512DQ,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512BW,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512VL,			X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512VBMI,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512_VBMI2,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_GFNI,			X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_VAES,			X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_VPCLMULQDQ,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_AVX512_VNNI,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_AVX512_BITALG,		X86_FEATURE_AVX512VL  },
+	{ X86_FEATURE_AVX512_4VNNIW,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512_4FMAPS,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_AVX512_VPOPCNTDQ,		X86_FEATURE_AVX512F   },
+	{ X86_FEATURE_CQM_OCCUP_LLC,		X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_TOTAL,		X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_CQM_MBM_LOCAL,		X86_FEATURE_CQM_LLC   },
+	{ X86_FEATURE_AVX512_BF16,		X86_FEATURE_AVX512VL  },
 	{}
 };
 
