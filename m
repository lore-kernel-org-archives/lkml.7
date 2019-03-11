Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E2AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFF6920657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfCKNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:55 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1McY0J-1gVfFI1MTt-00cxnC for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 103/114] drivers: iommu: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:55 +0100
Message-Id: <1552310346-7629-104-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:7rR9jmSav72urUlkdsOd5qTiR2VllzSnG3yEPN9JjyC4T38FdWW
 ulNOv2HeEA7/WXzmsQHq4PhbsMWLrvhf6Ox0ZUKXlc+o1dfuZHvZHqKdVPwgmLdE0e6V/7p
 eGbtB5TLF1g2U9rgsxeeb+BS5I5loLmlbSppGBzc8n4tNspxTH3dmNoiZaDqVJDAwfogoxD
 ZE+gHNytlH9PLbzmuym6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YaxYJlUyYkc=:b0bhMCOLHqgQX1R99syGw0
 Sq5WLfff5o3+SqiYcZLe73ut3XC472Nnx/7kYjTATCGaZbI2NBHX4KZ5TW0ygppWm1teKKkUU
 r2vPZUKSQ/lTPVIaCnHT/sU1OJq+RZezcq5aeKyV3xtQnUBGgDGNBvthdxHe1pcfhQnkarNkj
 aH/7qHVghjPeknIzDwHPPsFmZJNjl/+AF2vvANZEoBo375QwpSWU99LxC/+b5lABqnOKO/HTa
 gGO5ZZ/TsVBkP6wnwAZ8kMGPioZ3oICZwXcBiTe8k7HvgBwG0YJ8UGz+BsP3qXSgi6RH+fM0g
 wney8v1w8CFnN0WYrTYpFldfpBQHu74W/isvwxZkEOTtSTjiDIS8xrdv6wgyakTco8Ib8PdMT
 AtCs6jyQ7kakrhdmhooXe0dWbIWunQryZNfojX96PrQJlg3bzeyMrS0C39qTojNQu0eYMaejP
 7fKDnee+t9wKALqjthksNKooyBx7rSthBLlXeJN87RrT3szAvuoHvLcefEYoYqu4c2PE0ZAQs
 r6wJEwCx9G71DtoDC+UeiOhM5l3NIcdAGYFf/vVgc8prErKw4c+C1KWm+q3j+FETe+SgWKQNQ
 jeFXxc5lPc5ruiT8ehCTJ6zCTRD1AJdQ5HNMqhoZPBz0oARNMdjUgquTDyz8LsYeM/a0WSuo5
 WaHLE1Q3Dbz5/udSHXqfwqfOKUCgfT7Xh5+ix/rFMV26PjNpfXY1mcve5NeT1qUmBkwfADWYa
 5W8eqpdqMsfBMHObC6v2jCKaJpouwuWObAaSpA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/iommu/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 6f07f3b..1103239 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -77,7 +77,7 @@ config IOMMU_DEBUGFS
 config IOMMU_DEFAULT_PASSTHROUGH
 	bool "IOMMU passthrough by default"
 	depends on IOMMU_API
-        help
+	help
 	  Enable passthrough by default, removing the need to pass in
 	  iommu.passthrough=on or iommu=pt through command line. If this
 	  is enabled, you can still disable with iommu.passthrough=off
@@ -86,8 +86,8 @@ config IOMMU_DEFAULT_PASSTHROUGH
 	  If unsure, say N here.
 
 config OF_IOMMU
-       def_bool y
-       depends on OF && IOMMU_API
+	def_bool y
+	depends on OF && IOMMU_API
 
 # IOMMU-agnostic DMA-mapping layer
 config IOMMU_DMA
-- 
1.9.1

