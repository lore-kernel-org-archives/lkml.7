Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA890C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8C32087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414427;
	bh=wjPzTZd5YQ9V8sdGZzVpqoflT/j7Q7dXbq0MxweJD5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YPX9/fq6z4dEyY6+cgKGfBbRWwJIriZcj/Z5cutkhy+L7ARowDtAThUVqojp3xdSR
	 Z6EuBh64BZ2GoKWte/nw0N+jmWsLhFvWQSVbzoBacotnMuRDTZTqieNDVEcymJUtsW
	 wZT7mim9/hqJDK+cw9ihRQvdJKJtujSAjzRny0s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfCLRL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:44462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfCLRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:22 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2087F2171F;
        Tue, 12 Mar 2019 17:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410682;
        bh=wjPzTZd5YQ9V8sdGZzVpqoflT/j7Q7dXbq0MxweJD5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNe7m3IcqBijCx5N5S3uapB0TgGhyjpFq9Rw9Bgd3soe2tAsTh5uI276exuGD1lrR
         ObRIPxeCTX7y/umeGZ9nrZl0agXtQ7CAiFBX+Qh4P44jUTqbRYFyjG8h9BFBaN7fjb
         YVvbyvCdFnLa5sTNcvgTqQMy9RZGDdgjehdDL+HQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5.0 11/25] ARM: dts: exynos: Add minimal clkout parameters to Exynos3250 PMU
Date:   Tue, 12 Mar 2019 10:08:49 -0700
Message-Id: <20190312170404.381012634@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170403.643852550@linuxfoundation.org>
References: <20190312170403.643852550@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -168,6 +168,9 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 			interrupt-parent = <&gic>;
+			clock-names = "clkout8";
+			clocks = <&cmu CLK_FIN_PLL>;
+			#clock-cells = <1>;
 		};
 
 		mipi_phy: video-phy {


