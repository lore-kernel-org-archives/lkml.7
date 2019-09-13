Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B84DC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9AB5208C0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568380612;
	bh=TcpwchD6dBf0DR2A9BZK7u2CjChcJJSGqK8BGq6GDjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gH/DNwUWySNqtuQke/XaeieZk67lHBx5xl2b4FHNIpZdpZmO8TiUxsXr0t1RMC+pZ
	 JxxCQtmmDBLTFg7uJTcd63X2ppSrWFoKJpGl9QiVB8acexcv8WO2WOKHvxKz88eqMM
	 ClMMC2lyC+wYiB7uoxwHSkIOXe9PUip0acVcDGUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389943AbfIMNQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389926AbfIMNQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:16:49 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8CEA206BB;
        Fri, 13 Sep 2019 13:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380608;
        bh=TcpwchD6dBf0DR2A9BZK7u2CjChcJJSGqK8BGq6GDjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eT7ww3gHvZXT425mv671VGdGByJumTG7veonQT2NLxEudQzjctyzuHKFjsDzeM2wj
         N1QwYFcx5szwlZ/TNdqOj62/VL5i0HRxRajvnufANjfmcX5+RMuPe8xPiX+CpFADds
         SMJC9a40aW4aG0iLpg9YYGUpYgaP/hqXy38UXKNw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 089/190] dt-bindings: iio: adc: exynos-adc: Add S5PV210 variant
Date:   Fri, 13 Sep 2019 14:05:44 +0100
Message-Id: <20190913130606.713673756@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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



