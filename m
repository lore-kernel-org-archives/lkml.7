Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D159C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623C9224FC
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257174;
	bh=YhYeclBfcRAmQRKEfK1UPHgzQsEwwbB0zzIWoJvZqI0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OrowAtFRmysTts9aWiipkZqVpNby+tk+2r0UjDLEQqOXr4KZdueI874lj/DSJJfOg
	 6SDZU1t2q6eHvs1s8Nmuwbc2If2SbvfQA0dUESDOrqOiPKKHQYl9k2dPK/qxB8D0Y/
	 UC/kHGKfsoa44+N2uK/TcVvcLE9BvM8h3xHy1ihc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbfKTNjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728541AbfKTNj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:39:29 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EED3B224FA;
        Wed, 20 Nov 2019 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257169;
        bh=YhYeclBfcRAmQRKEfK1UPHgzQsEwwbB0zzIWoJvZqI0=;
        h=From:To:Cc:Subject:Date:From;
        b=wJk2StoOjc+BeWfmw2WdeZn48fkLo9n6eHL1g95WZq0jKf+UHvFMrdwopSulLlcwb
         /Rm2NvkQHogA71WaWOH2JIwhCMLTdf9LPronRGRKIK0fx6PH3x0Zl6SfY1/sYEaRVz
         o6h7jtqcjNqgBvYayTOGbO4Y1ci/zC7IlxNrNMok=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] soc: qcom: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:39:25 +0800
Message-Id: <20191120133925.13712-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/soc/qcom/Kconfig | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 79d826553ac8..d0a73e76d563 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -45,13 +45,13 @@ config QCOM_GLINK_SSR
 	  neighboring subsystems going up or down.
 
 config QCOM_GSBI
-        tristate "QCOM General Serial Bus Interface"
-        depends on ARCH_QCOM || COMPILE_TEST
-        select MFD_SYSCON
-        help
-          Say y here to enable GSBI support.  The GSBI provides control
-          functions for connecting the underlying serial UART, SPI, and I2C
-          devices to the output pins.
+	tristate "QCOM General Serial Bus Interface"
+	depends on ARCH_QCOM || COMPILE_TEST
+	select MFD_SYSCON
+	help
+	  Say y here to enable GSBI support.  The GSBI provides control
+	  functions for connecting the underlying serial UART, SPI, and I2C
+	  devices to the output pins.
 
 config QCOM_LLCC
 	tristate "Qualcomm Technologies, Inc. LLCC driver"
@@ -71,10 +71,10 @@ config QCOM_OCMEM
 	depends on ARCH_QCOM
 	select QCOM_SCM
 	help
-          The On Chip Memory (OCMEM) allocator allows various clients to
-          allocate memory from OCMEM based on performance, latency and power
-          requirements. This is typically used by the GPU, camera/video, and
-          audio components on some Snapdragon SoCs.
+	  The On Chip Memory (OCMEM) allocator allows various clients to
+	  allocate memory from OCMEM based on performance, latency and power
+	  requirements. This is typically used by the GPU, camera/video, and
+	  audio components on some Snapdragon SoCs.
 
 config QCOM_PM
 	bool "Qualcomm Power Management"
@@ -198,8 +198,8 @@ config QCOM_APR
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on RPMSG
 	help
-          Enable APR IPC protocol support between
-          application processor and QDSP6. APR is
-          used by audio driver to configure QDSP6
-          ASM, ADM and AFE modules.
+	  Enable APR IPC protocol support between
+	  application processor and QDSP6. APR is
+	  used by audio driver to configure QDSP6
+	  ASM, ADM and AFE modules.
 endmenu
-- 
2.17.1

