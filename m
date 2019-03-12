Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE99C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA11206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412003;
	bh=FmxATlK46I/HzGDT3AQ1qxBq5vx7hhqAQ50XB7cmm1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wN5YE8rvvZWtefGlaS0uY4R7bLFTNO6IOjDEMmLBE1IYbpEy+w6NClrjQY+60sZMN
	 0S2w614aPoTW9Z6C7b/d0czUg+a7c3Pe3K7EP3aRgAUH1URuI1RB/d3yWnybc5SLDn
	 9XFYI1HpGKYOHq6Mce6WWeDB9ix90FewfbB+67EE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfCLRdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:33:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729400AbfCLRRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:00 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A73206DF;
        Tue, 12 Mar 2019 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411020;
        bh=FmxATlK46I/HzGDT3AQ1qxBq5vx7hhqAQ50XB7cmm1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hTIe8PYDWbJ2wNYvnqySdgcxQXJC5ORV8epFLF0y1maJhgsYmVFGZ/fiSbmSTzwm0
         LoKpKjIhPO9hNq53GbDVGOc9jTn1rFeWWyiG/VZrNexZ4AuDSctj1zO1Zn4ilz9M7L
         5Ax5UnmFPnpSjAOUXyJXLH/mvp7LqRjxuhdMdwek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.14 126/135] ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
Date:   Tue, 12 Mar 2019 10:09:33 -0700
Message-Id: <20190312170352.745559926@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit a66352e005488ecb4b534ba1af58a9f671eba9b8 upstream.

Add minimal parameters needed by the Exynos CLKOUT driver to Exynos3250
PMU node. This fixes the following warning on boot:

exynos_clkout_init: failed to register clkout clock

Fixes: d19bb397e19e ("ARM: dts: exynos: Update PMU node with CLKOUT related data")
Cc: <stable@vger.kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/exynos3250.dtsi |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/arm/boot/dts/exynos3250.dtsi
+++ b/arch/arm/boot/dts/exynos3250.dtsi
@@ -172,6 +172,9 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
+			clock-names = "clkout8";
+			clocks = <&cmu CLK_FIN_PLL>;
+			#clock-cells = <1>;
 		};
 
 		mipi_phy: video-phy {


