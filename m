Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D996CC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0E6A224FA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257368;
	bh=x9PdtJWTi7+JVqhkTZzfttMMYAGgMkp4exsnlD+LpJk=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O0vB4vv7pIyI5CwSFIblnspJqhVnWv843+UtZYmT8evIyDc1M6W/FqUjzW2lZed7S
	 8027nVr+AMldQCgDqJQ63N6kMoQx9tfl0pvXSm9Ngtd9Vcbci0CCUoIHlccyCrxCkz
	 i9RH0+wH0VDHZ92eFujKEyeQjgYD0TKbiDzlsj3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbfKTNms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:50592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730428AbfKTNmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:47 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D60224FA;
        Wed, 20 Nov 2019 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257366;
        bh=x9PdtJWTi7+JVqhkTZzfttMMYAGgMkp4exsnlD+LpJk=;
        h=From:To:Cc:Subject:Date:From;
        b=vm3m4UtI2mxxRe1lNV4Nb9rg17Od+eqB0XeLpUsBR2J49GBYkjOpmyPHdHBMFZuO+
         0V/Z73YhSdyi9kUBz7IQqbaPAy06rOukyRdJ1IyrOv4K+yLArQ1Ln9OwzvL2zn4WQZ
         oFxb5C7K9RRs8mUHKbmkuaaQNXE2+kqMkUkensRY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:41 +0800
Message-Id: <20191120134241.16017-1-krzk@kernel.org>
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
 drivers/clk/Kconfig           |  2 +-
 drivers/clk/mediatek/Kconfig  | 10 +++++-----
 drivers/clk/versatile/Kconfig |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 0530bebfc25a..b8ebf7b93d63 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -27,7 +27,7 @@ config COMMON_CLK_WM831X
 	tristate "Clock driver for WM831x/2x PMICs"
 	depends on MFD_WM831X
 	---help---
-          Supports the clocking subsystem of the WM831x/2x series of
+	  Supports the clocking subsystem of the WM831x/2x series of
 	  PMICs from Wolfson Microelectronics.
 
 source "drivers/clk/versatile/Kconfig"
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 7efc3617bbd5..5ddd813521e7 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -179,31 +179,31 @@ config COMMON_CLK_MT6797
        select COMMON_CLK_MEDIATEK
        default ARCH_MEDIATEK && ARM64
        ---help---
-         This driver supports MediaTek MT6797 basic clocks.
+	 This driver supports MediaTek MT6797 basic clocks.
 
 config COMMON_CLK_MT6797_MMSYS
        bool "Clock driver for MediaTek MT6797 mmsys"
        depends on COMMON_CLK_MT6797
        ---help---
-         This driver supports MediaTek MT6797 mmsys clocks.
+	 This driver supports MediaTek MT6797 mmsys clocks.
 
 config COMMON_CLK_MT6797_IMGSYS
        bool "Clock driver for MediaTek MT6797 imgsys"
        depends on COMMON_CLK_MT6797
        ---help---
-         This driver supports MediaTek MT6797 imgsys clocks.
+	 This driver supports MediaTek MT6797 imgsys clocks.
 
 config COMMON_CLK_MT6797_VDECSYS
        bool "Clock driver for MediaTek MT6797 vdecsys"
        depends on COMMON_CLK_MT6797
        ---help---
-         This driver supports MediaTek MT6797 vdecsys clocks.
+	 This driver supports MediaTek MT6797 vdecsys clocks.
 
 config COMMON_CLK_MT6797_VENCSYS
        bool "Clock driver for MediaTek MT6797 vencsys"
        depends on COMMON_CLK_MT6797
        ---help---
-         This driver supports MediaTek MT6797 vencsys clocks.
+	 This driver supports MediaTek MT6797 vencsys clocks.
 
 config COMMON_CLK_MT7622
 	bool "Clock driver for MediaTek MT7622"
diff --git a/drivers/clk/versatile/Kconfig b/drivers/clk/versatile/Kconfig
index ac766855ba16..c2618f1477a2 100644
--- a/drivers/clk/versatile/Kconfig
+++ b/drivers/clk/versatile/Kconfig
@@ -9,7 +9,7 @@ config COMMON_CLK_VERSATILE
 		COMPILE_TEST
 	select REGMAP_MMIO
 	---help---
-          Supports clocking on ARM Reference designs:
+	  Supports clocking on ARM Reference designs:
 	  - Integrator/AP and Integrator/CP
 	  - RealView PB1176, EB, PB11MP and PBX
 	  - Versatile Express
-- 
2.17.1

