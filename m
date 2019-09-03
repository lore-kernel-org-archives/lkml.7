Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBEFC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89BCC238C5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528095;
	bh=8lYLVzRxYiXjNKdmJtOuaItGlqRbscReWol9uRFhF5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o13GoyIG8KhZQiXSudL0UCAJtTUFWE3SCaiZtcSYzJDjd1KTpj8CDbrtbFD6FcGap
	 G8sV9ju4qaLonO9CsOZEjYhALc33D3bvPW5+On2giFdMNHEQCh+3DcGrz4rC3SjBmf
	 DqCGwWtsDbTH4tO01B+RWmGPH8+GP/n7uTJMkmrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731072AbfICQ2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:28:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730121AbfICQ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:28:08 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CCF4238CD;
        Tue,  3 Sep 2019 16:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528088;
        bh=8lYLVzRxYiXjNKdmJtOuaItGlqRbscReWol9uRFhF5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vap8iFvG+V9ak3/VEc3LgkC1gqdTEkR88M77SYsN/Mso9n5CmKFU1Q5PHrG1vn6wG
         NHmqgrypCNCweHCQoM+5hwNJhLioh2C/VMpkQV9ByUTFt1RSoENaJxooMWJR8F0dTf
         45Cidd5KGezIGp5YBw0MvvRrmkMTMdTsdwRwoWLA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mathias Kresin <dev@kresin.me>, John Crispin <john@phrozen.org>,
        Andy Gross <andy.gross@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 098/167] ARM: dts: qcom: ipq4019: fix PCI range
Date:   Tue,  3 Sep 2019 12:24:10 -0400
Message-Id: <20190903162519.7136-98-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Kresin <dev@kresin.me>

[ Upstream commit da89f500cb55fb3f19c4b399b46d8add0abbd4d6 ]

The PCI range is invalid and PCI attached devices doen't work.

Signed-off-by: Mathias Kresin <dev@kresin.me>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Andy Gross <andy.gross@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 78db67337ed4a..2c3168d95a2d5 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -387,7 +387,7 @@
 			#size-cells = <2>;
 
 			ranges = <0x81000000 0 0x40200000 0x40200000 0 0x00100000
-				  0x82000000 0 0x48000000 0x48000000 0 0x10000000>;
+				  0x82000000 0 0x40300000 0x40300000 0 0x400000>;
 
 			interrupts = <GIC_SPI 141 IRQ_TYPE_EDGE_RISING>;
 			interrupt-names = "msi";
-- 
2.20.1

