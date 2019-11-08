Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DE0FA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52D22087E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 19:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573239870;
	bh=dwVpEfb1cMtg/YqXg8bKLMmHaJGWaMQOLmtkdsLAl14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0/WVUMCXaF7srj99FSJIeCScJT+JKQR5D823X77BIbFX7SF4YP/4HuAMHAPDEXZ9u
	 Dlp7HqGHhJtQOOTJ76lq/9HyO/DZsrrIIzrf1Np4Ae9r/1yEzBpnNo7m3nK+7VShEL
	 517K1EZh7J7NQhUamQOTzUzNvHp+7pCaSJ0gLFV0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbfKHTE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 14:04:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389782AbfKHTEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 14:04:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4802067B;
        Fri,  8 Nov 2019 19:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573239857;
        bh=dwVpEfb1cMtg/YqXg8bKLMmHaJGWaMQOLmtkdsLAl14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hY34G5EBCg0cBDkxIAIc3woNLlQUqsXiEKqjWaG0thPpIxD5xJoay1M0yMIS9ca5
         HqAexmDgHRKbljJxMhIM+fUFXKNWH7Zl2l8PJksjHSwrLh6VHP5t8pTGkrcbO8apkz
         Syi4HQfOAwEwLAisYhiU1Dv+nvQ9hA5eGtnYPnIs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Tivy <rtivy@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: [PATCH 4.19 78/79] arm64: dts: ti: k3-am65-main: Fix gic-its node unit-address
Date:   Fri,  8 Nov 2019 19:50:58 +0100
Message-Id: <20191108174829.580847686@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191108174745.495640141@linuxfoundation.org>
References: <20191108174745.495640141@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

commit 389ce1a7c5279ebfb682fab220b4021b2bd49c8b upstream.

The gic-its node unit-address has an additional zero compared
to the actual reg value. Fix it.

Fixes: ea47eed33a3f ("arm64: dts: ti: Add Support for AM654 SoC")
Reported-by: Robert Tivy <rtivy@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
@@ -21,7 +21,7 @@
 		 */
 		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 
-		gic_its: gic-its@18200000 {
+		gic_its: gic-its@1820000 {
 			compatible = "arm,gic-v3-its";
 			reg = <0x01820000 0x10000>;
 			msi-controller;


