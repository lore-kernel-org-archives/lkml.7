Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557F1C04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240DC21019
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 12:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558355189;
	bh=xxLEzmsGULtUDU3Io0agV8eEWFU+4vqzpgbIFY8kxKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjgHPM5ne7ezA8ev+JjVhwBB450ZnnrjysSyuE/HYOQtQm3zqn7ezwztD2WrEH8E3
	 8xH9CsqCtgQ3BYSk29FA+CG4O9uYAKcysTbC6FqXfeCl3jK5j5Y0D+ZAGTevIaUQaH
	 XiDczfmPwiZqr86RlTFt/YxP641WgBi07T7H7OtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbfETM01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 08:26:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389284AbfETM0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 08:26:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E9C20645;
        Mon, 20 May 2019 12:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558355175;
        bh=xxLEzmsGULtUDU3Io0agV8eEWFU+4vqzpgbIFY8kxKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8DS3pPZHlm/o1jNb2nsVOQulxPhyJPaET2fb/61sMC1t8KYFW4XcpWDOPXp5Y5uB
         ivLdBkvzjH9CV0j8nPVMAnuKGMXq2QWUgfYcB3qI2ObgfuEGs+RekkV8UfmrbzuZ1W
         k1lVfG/JGe8lAZ446blGGWmLVpofpRr0bRfa02eM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Stuart Menefy <stuart.menefy@mathembedded.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.0 008/123] ARM: dts: exynos: Fix interrupt for shared EINTs on Exynos5260
Date:   Mon, 20 May 2019 14:13:08 +0200
Message-Id: <20190520115245.785495883@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520115245.439864225@linuxfoundation.org>
References: <20190520115245.439864225@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Menefy <stuart.menefy@mathembedded.com>

commit b7ed69d67ff0788d8463e599dd5dd1b45c701a7e upstream.

Fix the interrupt information for the GPIO lines with a shared EINT
interrupt.

Fixes: 16d7ff2642e7 ("ARM: dts: add dts files for exynos5260 SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Stuart Menefy <stuart.menefy@mathembedded.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos5260.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -223,7 +223,7 @@
 			wakeup-interrupt-controller {
 				compatible = "samsung,exynos4210-wakeup-eint";
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 


