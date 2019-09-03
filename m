Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 114D9C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D442343A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567528042;
	bh=CObjYhzcgxIymlgK/8BKotmVimCoec0fpoJRSZ6T+HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TK/0yrfcwLIDc0nESPBGETGDlCznEeDHDXMvfudqult4JlVa8yA76EqsP4EcIZZha
	 fHlvPNYIJUjwlvaDD7qzwCRtjLlA+P/XxAgse8S3O6VDqwh8tjHRkClA4YSNF7T87F
	 tC1HuMOHxCSfUF+LD5Zx75m1wk1RGPmWWKWLNHY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730844AbfICQ1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:27:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730823AbfICQ1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:27:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6474C238C5;
        Tue,  3 Sep 2019 16:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567528038;
        bh=CObjYhzcgxIymlgK/8BKotmVimCoec0fpoJRSZ6T+HA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GI4iiMOmVy2LMOyKb43eQ12KMrcFkq2HaJn/ow1TohvJQKitY6nlhYlnlCd8ZqKKe
         OF6keEVK7jSDSBFcwaZ0dqWVLKWzHQSFNBCxcgkj5sHabq9Qgy6EtQOnG/gy34fMsO
         5lGnXBVDkbMGgj/4kYlsbtf+mir6PrhgTtN6TPLE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 066/167] iio: adc: exynos-adc: Add S5PV210 variant
Date:   Tue,  3 Sep 2019 12:23:38 -0400
Message-Id: <20190903162519.7136-66-sashal@kernel.org>
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

[ Upstream commit 882bf52fdeab47dbe991cc0e564b0b51c571d0a3 ]

S5PV210's ADC variant is almost the same as v1 except that it has 10
channels and doesn't require the pmu register

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/exynos_adc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
index 4be29ed447559..41da522fc6735 100644
--- a/drivers/iio/adc/exynos_adc.c
+++ b/drivers/iio/adc/exynos_adc.c
@@ -115,6 +115,7 @@
 #define MAX_ADC_V2_CHANNELS		10
 #define MAX_ADC_V1_CHANNELS		8
 #define MAX_EXYNOS3250_ADC_CHANNELS	2
+#define MAX_S5PV210_ADC_CHANNELS	10
 
 /* Bit definitions common for ADC_V1 and ADC_V2 */
 #define ADC_CON_EN_START	(1u << 0)
@@ -282,6 +283,16 @@ static const struct exynos_adc_data exynos_adc_v1_data = {
 	.start_conv	= exynos_adc_v1_start_conv,
 };
 
+static const struct exynos_adc_data exynos_adc_s5pv210_data = {
+	.num_channels	= MAX_S5PV210_ADC_CHANNELS,
+	.mask		= ADC_DATX_MASK,	/* 12 bit ADC resolution */
+
+	.init_hw	= exynos_adc_v1_init_hw,
+	.exit_hw	= exynos_adc_v1_exit_hw,
+	.clear_irq	= exynos_adc_v1_clear_irq,
+	.start_conv	= exynos_adc_v1_start_conv,
+};
+
 static void exynos_adc_s3c2416_start_conv(struct exynos_adc *info,
 					  unsigned long addr)
 {
@@ -478,6 +489,9 @@ static const struct of_device_id exynos_adc_match[] = {
 	}, {
 		.compatible = "samsung,s3c6410-adc",
 		.data = &exynos_adc_s3c64xx_data,
+	}, {
+		.compatible = "samsung,s5pv210-adc",
+		.data = &exynos_adc_s5pv210_data,
 	}, {
 		.compatible = "samsung,exynos-adc-v1",
 		.data = &exynos_adc_v1_data,
-- 
2.20.1

