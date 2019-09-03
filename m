Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 080BEC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2B223878
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528045;
	bh=jL960mftVsy4K2E1ETmoVa7GLoiRlSFtBXSAOIO1zaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E9zHUOQL5kr/K09+nX44KIEgtHs4xqyMgF3KBVCcHVepou5AVDxnfaBNjloGqN7m2
	 pMKPQ67BEngHiAuO3eOMUPiKAJUTrtKuuepHAHPTMTXAQu9+DJsxYgvgZl/ATw5htZ
	 x8rE6QOoPqWnmZKv1hl50awRn2eP3wExpmDt0iCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbfICQ1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:27:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730835AbfICQ1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:27:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB63623431;
        Tue,  3 Sep 2019 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528040;
        bh=jL960mftVsy4K2E1ETmoVa7GLoiRlSFtBXSAOIO1zaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nZRvBFHJg3rBVs21y87VOcjcF/AVWl9K9aqWSULDUtETkz20eL8K/nhz3oYoE7fCn
         YucNfy2jDlLY9TThDuHutSQz7AyOC87+moElzAs6YdGhdXanAHWnXqoLt30er1euZH
         s1S+3jlEZaa/734RKitO+EU/fCbl/RN0hawF7Dzc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 067/167] dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
Date:   Tue,  3 Sep 2019 12:23:39 -0400
Message-Id: <20190903162519.7136-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162519.7136-1-sashal@kernel.org>
References: <20190903162519.7136-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit a9b0a2a7c19316588421b94946c8e2e5a84ac14e ]

Add information about new compatible for S5PV210

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../devicetree/bindings/iio/adc/samsung,exynos-adc.txt        | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
index 6c49db7f8ad25..a10c1f89037de 100644
--- a/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/samsung,exynos-adc.txt
@@ -11,7 +11,7 @@ New driver handles the following
 
 Required properties:
 - compatible:		Must be "samsung,exynos-adc-v1"
-				for exynos4412/5250 and s5pv210 controllers.
+				for exynos4412/5250 controllers.
 			Must be "samsung,exynos-adc-v2" for
 				future controllers.
 			Must be "samsung,exynos3250-adc" for
@@ -28,6 +28,8 @@ Required properties:
 				the ADC in s3c2443 and compatibles
 			Must be "samsung,s3c6410-adc" for
 				the ADC in s3c6410 and compatibles
+			Must be "samsung,s5pv210-adc" for
+				the ADC in s5pv210 and compatibles
 - reg:			List of ADC register address range
 			- The base address and range of ADC register
 			- The base address and range of ADC_PHY register (every
-- 
2.20.1

