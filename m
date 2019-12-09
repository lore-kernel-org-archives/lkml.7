Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB61C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9281A20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 04:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lSwhsx3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfLIEZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 23:25:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43684 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLIEZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 23:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tOrB9EJaOTeggJU5chNmLVDTtPPvAaO8XlEQZ/DU1S4=; b=lSwhsx3RNJGqO/3wMlesz4FRO
        oQZycmFPPON5bx/+AUDgtPSqpTw4XD03jHCzkwHPzI3IQNw5FH5VAOcvqSCP8nyT8HNbzFvalk8NU
        VvuqSTQrxCWoiZvDYsruACh3n9aYKUwIV/7oJ7xMjjX3MfLaleKqpJdmfFM/PKKIngj7n49+xmCeW
        Uk1+RqJYDd4IzKAZXqkzq1QxJ/qv4w+wJZwpdkM8nYbrKQtZJ7J0PaeOX9kjvbdJtYn97t+Ngw/6A
        eAKuQwlk2TVvY8r4fncI/btQZYdTW8M2DowdngX61Zlm/SVsgFdTbH7/gcBjtdyHcqfwASKsObom6
        lB6djK55g==;
Received: from [2601:1c0:6280:3f0::3deb]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieAbf-0000cZ-2d; Mon, 09 Dec 2019 04:25:11 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Daniel Kiper <daniel.kiper@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: x86: fix boot.rst warning and format
Message-ID: <c6fbf592-0aca-69d9-e903-e869221a041a@infradead.org>
Date:   Sun, 8 Dec 2019 20:25:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a Sphinx documentation format warning by breaking a long line
into 2 lines.

Also drop the ':' usage after the Protocol version numbers since
other Protocol versions don't use colons.

Documentation/x86/boot.rst:72: WARNING: Malformed table.
Text in column margin in table line 57.

Fixes: 2c33c27fd603 ("x86/boot: Introduce kernel_info")
Fixes: 00cd1c154d56 ("x86/boot: Introduce kernel_info.setup_type_max")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Daniel Kiper <daniel.kiper@oracle.com>
---
 Documentation/x86/boot.rst |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-next-20191209.orig/Documentation/x86/boot.rst
+++ linux-next-20191209/Documentation/x86/boot.rst
@@ -69,11 +69,12 @@ Protocol 2.13	(Kernel 3.14) Support 32-
 		xloadflags to support booting a 64-bit kernel from 32-bit
 		EFI
 
-Protocol 2.14:	BURNT BY INCORRECT COMMIT ae7e1238e68f2a472a125673ab506d49158c1889
+Protocol 2.14	BURNT BY INCORRECT COMMIT
+                ae7e1238e68f2a472a125673ab506d49158c1889
 		(x86/boot: Add ACPI RSDP address to setup_header)
 		DO NOT USE!!! ASSUME SAME AS 2.13.
 
-Protocol 2.15:	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
+Protocol 2.15	(Kernel 5.5) Added the kernel_info and kernel_info.setup_type_max.
 =============	============================================================
 
 .. note::

