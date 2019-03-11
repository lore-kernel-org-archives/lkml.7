Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F446C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188D820857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbfCKNZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:03 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M8QNy-1h7kh00tDE-004RvX for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 081/114] drivers: memstick: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:33 +0100
Message-Id: <1552310346-7629-82-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:aHu8uYDDwmwTeuijkkTPRHvntaD6aet+TGFJ8xnIISNoIM0fJ0V
 EL4wBilETFdjUOP5NdKd4UX2TwRQUITQiMP/W6WoL1eV6BxvySgdn7f1+IqY9jGeKnxdwit
 zHgcfBJuCODI9poI+PI4z1a6eQfgUGCXtSqgpCuAeXgLkiT70YSpIYrepgaRwow6CUvLCEG
 54n5yDBl0pc5WHew7lM3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1t8zP6Vgfm0=:MsUHPJCN+/Q/y1GmECrpLK
 xgsjb+J1VrdivQKVpaUt8BZfHs1GsI5ClbrLGY10uYTzJSXta4BVfKm7dCnJmPxbuBjVCbkxe
 P1nAEb36wM11nUXujWAeWImDKPuQxNG+WSqNR2zF1Exh4QbDEVtolgzts7mxOaCsWisHwkYP7
 bjmS6zF7kJJOblb58wE34IgQSJHXDb0DLk7ZRNXz9FqTKq3Pq5VEZZIS7DqSxJ2SjNqI25Hai
 TWA2Sj0Ov9xOMJYP1mqUMRWnLNWVgt4CDhDvXvV0C1DUwZJWUoM264lwNfSOeKYGRhwE0WSXB
 gv/NKt4XzghVEUt9Tu7Tca5eaqNGSlOxzW5/hudXGkf5gXcXCj34RtMYNtBauS8KkDdzAeXso
 qhD38ey9TIdPnIMOmxz0UciEGvVdgj9B2YC3fxGouqtCf40mu/Ge76aFEXfdi+DiLZNbnII7l
 QLdJIKnEobbpreePurXhAqfnNPR+MVtGt7Dgts07F5r+luuIziVVEP7CIXy7fpXp1lEPDYpoB
 gihcn1PSDC4QkemhznL3IxN763QytujOgdB6ySp1pouG+VgyU0KdM0VQf/hk6b2NBH/jCkvoQ
 j3VXPxSsxbg+/xOQAnm7TpAWEUcX1LUv509uZqcG0V8NGG0ntZilvqBtmcgX5AKx04Gv9fNEt
 /g3invSVXkhhoRxyVYEfx3nQ9LqFgB6lEalBPHCUflVKDJW51fOA0m/8TuZew4tDmk/pep2qE
 O1BEc8S87wbvGsNiEJn8XbY07KueDvDIHMFVtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/memstick/core/Kconfig | 18 +++++++++---------
 drivers/memstick/host/Kconfig |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/memstick/core/Kconfig b/drivers/memstick/core/Kconfig
index 1d38949..219ce91 100644
--- a/drivers/memstick/core/Kconfig
+++ b/drivers/memstick/core/Kconfig
@@ -5,16 +5,16 @@
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
index aa2b078..5810c78 100644
--- a/drivers/memstick/host/Kconfig
+++ b/drivers/memstick/host/Kconfig
@@ -17,7 +17,7 @@ config MEMSTICK_TIFM_MS
 	  'Misc devices: TI Flash Media PCI74xx/PCI76xx host adapter support
 	  (TIFM_7XX1)'.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called tifm_ms.
 
 config MEMSTICK_JMICRON_38X
@@ -28,7 +28,7 @@ config MEMSTICK_JMICRON_38X
 	  Say Y here if you want to be able to access MemoryStick cards with
 	  the JMicron(R) JMB38X MemoryStick card reader.
 
-          To compile this driver as a module, choose M here: the
+	  To compile this driver as a module, choose M here: the
 	  module will be called jmb38x_ms.
 
 config MEMSTICK_R592
-- 
1.9.1

