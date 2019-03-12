Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB88C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5278206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412971;
	bh=MA38JR9SejW1UxfO7lmPRMlzROFuXVbN0atYYCKLyNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GTcLK76w8qriusBZMs3WLUM5t5UGi1AWCd1GZhUG4p9q01yWiHiMgpbp3SSVaAk/5
	 PSqRbgJ19bQih5lN90XDqF0OOTg5iiD8b1rFiwk4w/CqV6zZU2E0v87EwB7pGB8/q5
	 M9RZJuQQKZoDPTmqx1mS9HZVKCOIDug0KXrtVoZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbfCLRt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfCLROu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:14:50 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0825C21850;
        Tue, 12 Mar 2019 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410890;
        bh=MA38JR9SejW1UxfO7lmPRMlzROFuXVbN0atYYCKLyNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aklobceaf0Gu4jzdX/UBATkc7LW3fW2KeCGKdR+z4dAoD7zmQpa8m1dYA/Jp3JOOC
         GyFNr68z7BNq8IYq0AK6byUC9GblhcubQoaM5GYRT2/Lj4XX1EI+mx66oWLdy4p0rP
         U01s66jmJdGD1a83bHoqsiRUlF+6lvJcN0n18N58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/149] arm64: dts: add msm8996 compatible to gicv3
Date:   Tue, 12 Mar 2019 10:08:16 -0700
Message-Id: <20190312170356.176672545@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index cd3865e7a270..8c86c41a0d25 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -399,7 +399,7 @@
 		};
 
 		intc: interrupt-controller@9bc0000 {
-			compatible = "arm,gic-v3";
+			compatible = "qcom,msm8996-gic-v3", "arm,gic-v3";
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;
-- 
2.19.1



