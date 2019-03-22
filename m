Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD42C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCD621917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260247;
	bh=sBNtQa76qkf9lI6F+YZI/Pg3LISw8fDyhQyxtt/NkZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1pnr+IPD/yqdQ84ukG0vZO8ms757t1c8H1pMV9BEPWZZpgAaWMrxoh6zsjfkPVE4
	 x2P3P26Y0WdP8rZ00SAzr226buxLPPYy9dJOw7bnw2rhifQeXUV2+Ya22GFaYm+ca4
	 XshAYuIo4NKld9UM1H+F30jOB4zUaVTdZykp+MHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfCVLdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:33:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729312AbfCVLdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:33:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B1F20449;
        Fri, 22 Mar 2019 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254424;
        bh=sBNtQa76qkf9lI6F+YZI/Pg3LISw8fDyhQyxtt/NkZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cTfdevT31cE5EZQ2biYyNhuuWOyuMlpXq//rnEDrmCWV+m6oefSY1p3M3dhYMchJD
         z+/DngKl8y1NSx6jsVXz7QpkOOx25UFJm9oxEIFZeVY2N7+TRaktl9Bgaudlm4fR0A
         AP+Rq+2Nko/XS6+jDd0qSwf+UCGddYI1A7AlfslM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 116/230] ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
Date:   Fri, 22 Mar 2019 12:14:14 +0100
Message-Id: <20190322111244.793415230@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -150,6 +150,9 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
+			clock-names = "clkout8";
+			clocks = <&cmu CLK_FIN_PLL>;
+			#clock-cells = <1>;
 		};
 
 		mipi_phy: video-phy@10020710 {


