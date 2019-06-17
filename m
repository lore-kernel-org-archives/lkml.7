Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839FC31E57
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B7220833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 10:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfFQKmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 06:42:54 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:55387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbfFQKmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:42:54 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1qfu-1hf0xP2jpA-002IOT; Mon, 17 Jun 2019 12:42:43 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sve: fix genksyms generation
Date:   Mon, 17 Jun 2019 12:42:11 +0200
Message-Id: <20190617104237.2082388-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GHkVA1Dy87IfWvGaT0UvEAty23wZsSPrrw8mvVuU4V2xwnZ0ZPo
 9ZiXJCiqGGqG/xdGF30QoA7sBAKCqe0Pwd3K3a5OjVyy6rre9s+3p8O7VYXYstPxVnPUnsH
 iSVy5mih+qkefBykZt4Z0kc2qMoapAtTT7xZAbCSpw1L/zn0QKkkFGcRSU73n9KD5aE2AO1
 hSg0ljYQEjCHA0J5TsSYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKeDETOU9i8=:UKR4EOC8S7Ji6Nbp3eTSLo
 TjYZ2W/CoFLoPLgh1VF7zGGB6JL0jnXjtT38e4nUexrjXcHeNe7UadgYwjdp0Gt/4IRYNqJkw
 +3hyOV8HReErfhFrpThfoUp4RZzFgRifngEBsMsVDd+VaQL1pQ4ucnDlw6GWXMAb2WYbFzf2K
 yh5y/Oh/IYD7QjqJO6nEsvebSte7CA3yzNd/AebLy4XnzqJoi1wpGWmBmWSo9QhPF1U5V7ycz
 VXjAQrKgA4Fv2pA3ta0vfSLXUQ9jYSiJvNwqQ5aDlaoUc+2XmMDx2reiZKSbIdc9qJ8TyG18D
 8Q4CrPqjcceEYxfrKfZRSKlUZs5Bjtv4kjcGo2aGA71Vdd0UiVROH3DgLy0VtoAi+1LjBMx8x
 xpPvkM+GshK8z322rH7gcKdSkKrCsYsGXcpFAvQEikZg/yHeZGS+ijejuVG9XMeDerfZXB/IX
 tKxhiA73pv4rX7s7jbWZAR7/f8mIZ8eWXH9QjVJiRaC9BfpUnlYWBr+G2xOCx3z9eGhrrbxuf
 2oUh6m3hZq4SHf4EWt/gXOKjxVau2WhM0gsBNpV0HhwhSN6avxd3NbZcP/GeS1NvSO/g1oy7f
 B8mob4b1LzoqMXXRqcsbsE4ERRvYlRpJHNy79n3HiqzEA8QiUl9TXjCSix6O7pwzDyxQ/+VM+
 k44uIm6jupiwYmbXI96yFVKLn//KijI1hk9wcu8pDNIXGQ54MvkgE318qxNba/IEkDluAkOJQ
 W+6rqShXIQwyNmzTrbQs/fz4NdOUi/WmWpChVA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genksyms does not understand __uint128_t, so we get a build failure
in the fpsimd module when it cannot export a symbol right:

WARNING: EXPORT symbol "kernel_neon_begin" [vmlinux] version generation failed, symbol will not be versioned.
/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/aarch64-linux/bin/aarch64-linux-ld: arch/arm64/kernel/fpsimd.o: relocation R_AARCH64_ABS32 against `__crc_kernel_neon_begin' can not be used when making a shared object
arch/arm64/kernel/fpsimd.o:(.data+0x0): dangerous relocation: unsupported relocation
arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x0): dangerous relocation: unsupported relocation
arch/arm64/kernel/fpsimd.o:(".discard.addressable"+0x8): dangerous relocation: unsupported relocation

We could teach genksyms about the type, but it's easier to just
work around it by defining that type locally in a way that genksyms
understands.

Fixes: 41040cf7c5f0 ("arm64/sve: Fix missing SVE/FPSIMD endianness conversions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/kernel/fpsimd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 07f238ef47ae..2aba07cccf50 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -400,6 +400,9 @@ static int __init sve_sysctl_init(void) { return 0; }
 #define ZREG(sve_state, vq, n) ((char *)(sve_state) +		\
 	(SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
 
+#ifdef __GENKSYMS__
+typedef __u64 __uint128_t[2];
+#endif
 #ifdef CONFIG_CPU_BIG_ENDIAN
 static __uint128_t arm64_cpu_to_le128(__uint128_t x)
 {
-- 
2.20.0

