Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA3BC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EEAE20836
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 17:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="ESM1wsI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfCBRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 12:54:26 -0500
Received: from tomli.me ([153.92.126.73]:41934 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbfCBRyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 12:54:23 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 04ab6b38;
        Sat, 2 Mar 2019 17:54:20 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:3d30:3659)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Mar 2019 17:54:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=foHmT6tpUB7T3HL59GtGQQQmGWB4MM4AVOND1ASTjGg=; b=ESM1wsI2X5jVsRXHT0KDSHx0U0CaVy0uVsP72SGkmYUFzP/mWUVOOIPIyjJqL7DOeGvV/ATVDoTBXetlV57+X/+l+/CJga6+LdDsfsbcX+JmnQ8OsiDr7ViX08NepiSWuCDXux4ehw2VLiUzQ+GBVOYkf51kcFVJLp421KrkYKHc4P/xCGSvDpAFxsXob8XrN28uuIO9pNe4U+XGSM2cTKFm+06QnbTRLF5NuxonWB9kttvA+Ebab6e9M4C4CWIY/YY5vWy2vOF40oIXTKmxwNSYKawgUEl2QXZ0EKWRmcd0vDyg16CyCD6H4CzVxsqMX0c5ZCXXhbZFK+QrSXAThg==
From:   Yifeng Li <tomli@tomli.me>
To:     Lee Jones <lee.jones@linaro.org>, linux-mips@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] MAINTAINERS: add myself as a maintainer of MIPS/Loongson2 platform code.
Date:   Sun,  3 Mar 2019 01:53:34 +0800
Message-Id: <20190302175334.5103-8-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190302175334.5103-1-tomli@tomli.me>
References: <20190302175334.5103-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've introduced platform code for Lemote Yeeloong computers and modified
power management-related files. Add myself as a maintainer of these code.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 208f19801a23..a82cd47927c1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10134,6 +10134,15 @@ F:	arch/mips/include/asm/mach-loongson64/
 F:	drivers/*/*loongson2*
 F:	drivers/*/*/*loongson2*
 
+MIPS/LOONGSON2 LEMOTE PLATFORM AND POWER MANAGEMENT DRIVER
+M:	Tom Li <tomli@tomli.me>
+L:	linux-mips@vger.kernel.org
+S:	Maintained
+F:	arch/mips/loongson64/common/platform.c
+F:	arch/mips/loongson64/lemote-2f/pm.c
+F:	arch/mips/loongson64/lemote-2f/sci.c
+F:	arch/mips/loongson64/lemote-2f/platform.c
+
 MIPS/LOONGSON3 ARCHITECTURE
 M:	Huacai Chen <chenhc@lemote.com>
 L:	linux-mips@vger.kernel.org
-- 
2.20.1

