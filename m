Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D3C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C82422506
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257269;
	bh=fK6N4bmS3Tzb3Vf/HY/FY3CiI/zKE/77M0yzIbf4RjE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PoBHpWv9mpDLiUBn09DG86ReIh/OgRXtBot0BDpQI1xaWctrhddd5I62gsVD4/d3R
	 94IUoogR2v6/vtJoV3FkrLGkU8QjOqauUCOgi3L/1sbn2uOY46lGPzl2xMLgFKiQQm
	 EUIoeW2KJtKG4vFxns/vUPV5fSQpJeZ/ca0Yu6Js=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfKTNlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:41:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:48916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbfKTNlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:41:06 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAC93224FC;
        Wed, 20 Nov 2019 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257265;
        bh=fK6N4bmS3Tzb3Vf/HY/FY3CiI/zKE/77M0yzIbf4RjE=;
        h=From:To:Cc:Subject:Date:From;
        b=Xr8VgbTwDLQjMwVz6aWqjyOwN08YfxLZq5L7XBqL328/QlZPUL3t+D8ruupjCcWka
         sCQCYI5t36twzlEX4GWevejh59yIQcodY9BF9eLeciJwceoN+6AI7Gx6P1hjDui7gc
         9nUgAIQ0mKORaJDf8rUXT3Kcn9Jdc53LJWj+CY5A=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Subject: [PATCH] memstick: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:41:01 +0800
Message-Id: <20191120134101.14738-1-krzk@kernel.org>
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
 drivers/memstick/core/Kconfig | 18 +++++++++---------
 drivers/memstick/host/Kconfig |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
index 516f454fde14..08192fd70eb4 100644
--- a/drivers/memstick/core/Kconfig
+++ b/drivers/memstick/core/Kconfig
@@ -6,16 +6,16 @@
 comment "MemoryStick drivers"
 
 config MEMSTICK_UNSAFE_RESUME
-        bool "Allow unsafe resume (DANGEROUS)"
-        help
-          If you say Y here, the MemoryStick layer will assume that all
-          cards stayed in their respective slots during the suspend. The
-          normal behaviour is to remove them at suspend and
-          redetecting them at resume. Breaking this assumption will
-          in most cases result in data corruption.
+	bool "Allow unsafe resume (DANGEROUS)"
+	help
+	  If you say Y here, the MemoryStick layer will assume that all
+	  cards stayed in their respective slots during the suspend. The
+	  normal behaviour is to remove them at suspend and
+	  redetecting them at resume. Breaking this assumption will
+	  in most cases result in data corruption.
 
-          This option is usually just for embedded systems which use
-          a MemoryStick card for rootfs. Most people should say N here.
+	  This option is usually just for embedded systems which use
+	  a MemoryStick card for rootfs. Most people should say N here.
 
 config MSPRO_BLOCK
 	tristate "MemoryStick Pro block device driver"
diff --git a/drivers/memstick/host/Kconfig b/drivers/memstick/host/Kconfig
index 446c93ecef8f..4113343da056 100644
--- a/drivers/memstick/host/Kconfig
+++ b/drivers/memstick/host/Kconfig
@@ -18,7 +18,7 @@ config MEMSTICK_TIFM_MS
 	  'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
 	  (TIFM_7XX1)'.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called tifm_ms.
 
 config MEMSTICK_JMICRON_38X
@@ -29,7 +29,7 @@ config MEMSTICK_JMICRON_38X
 	  Say Y here if you want to be able to access MemoryStick cards with
 	  the JMicron(R) JMB38X MemoryStick card reader.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called jmb38x_ms.
 
 config MEMSTICK_R592
-- 
2.17.1

