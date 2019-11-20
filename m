Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B63FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C7C22520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbfKTNVV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:21:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56715 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730186AbfKTNVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:13 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPut-00077m-Jf; Wed, 20 Nov 2019 14:21:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3609A1C1A0F;
        Wed, 20 Nov 2019 14:21:03 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:03 -0000
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Place CONFIG_SIFIVE_PLIC into the menu
Cc:     j.neuschaefer@gmx.net, Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191002144452.10178-1-j.neuschaefer@gmx.net>
References: <20191002144452.10178-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <157425606311.12247.10868789826502631245.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0149385537e6d36f535fcd83cfcabf83a32f0836
Gitweb:        https://git.kernel.org/tip/0149385537e6d36f535fcd83cfcabf83a32f0836
Author:        Jonathan Neuschäfer <j.neuschaefer@gmx.net>
AuthorDate:    Wed, 02 Oct 2019 16:44:52 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 10 Nov 2019 18:48:35 

irqchip: Place CONFIG_SIFIVE_PLIC into the menu

Somehow CONFIG_SIFIVE_PLIC ended up outside of the "IRQ chip support"
menu.

Fixes: 8237f8bc4f6e ("irqchip: add a SiFive PLIC driver")
Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Acked-by: Palmer Dabbelt <palmer@sifive.com>
Link: https://lore.kernel.org/r/20191002144452.10178-1-j.neuschaefer@gmx.net
---
 drivers/irqchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bbb3234..697e6a8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -487,8 +487,6 @@ config TI_SCI_INTA_IRQCHIP
 	  If you wish to use interrupt aggregator irq resources managed by the
 	  TI System Controller, say Y here. Otherwise, say N.
 
-endmenu
-
 config SIFIVE_PLIC
 	bool "SiFive Platform-Level Interrupt Controller"
 	depends on RISCV
@@ -500,3 +498,5 @@ config SIFIVE_PLIC
 	   interrupt sources are subordinate to the PLIC.
 
 	   If you don't know what to do here, say Y.
+
+endmenu
