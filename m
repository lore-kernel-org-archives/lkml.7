Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB91C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0434E2183E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410794;
	bh=s/ghMm+s7zPCzfcFEwGQmYzOawheVEFprN6qsTXpzYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y5VaKkzv7hMc79aOQFpIVXxB0GdTljMBJhjVhrZGBZik/cVwVNfiihbkyP5c36SPr
	 GUde+eyKKGvLs5EUBTKUetPKiIfh/XYk6/MbMOvnx8HX+tAz3IIzQmM1X9gsVQ0Plu
	 3F0qDsluXIuKfQEwxOT1bI4vHNvPfiGtjwkvwT0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfCLRNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727584AbfCLRMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:12:40 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32E4621841;
        Tue, 12 Mar 2019 17:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410760;
        bh=s/ghMm+s7zPCzfcFEwGQmYzOawheVEFprN6qsTXpzYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+lDCFlhfQxyzTlKHLVWGGuBcl2r31oWzclS2sIYl2LRNC2fFx7dMd1FCrbAA+UdM
         Mu3QLVq4hxAAFlrpjcbD7zRxaV2dylmfMb7yp0jn1r9qwklQKOFua3hFfnd+rU7lQ3
         rrhFa6lhcbrdhLP4OAXo8WIFxLXkO/w4Xm4NrHuY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 092/171] arm64: dts: add msm8996 compatible to gicv3
Date:   Tue, 12 Mar 2019 10:07:52 -0700
Message-Id: <20190312170355.884679903@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2a81efb0de0e33f2d2c83154af0bd3ce389b3269 ]

Add compatible to gicv3 node to enable quirk required to restrict writing
to GICR_WAKER register which is restricted on msm8996 SoC in Hypervisor.

With this quirk MSM8996 can at least boot out of mainline, which can help
community to work with boards based on MSM8996.

Without this patch Qualcomm DB820c board reboots on mainline.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index b29fe80d7288..461612a5ab5e 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -397,7 +397,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.1



