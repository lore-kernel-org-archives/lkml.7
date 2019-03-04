Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0F0F206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbfCDUUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 15:20:17 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:38953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfCDUUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 15:20:16 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MA7Om-1gqTvu3VRy-00Bc9J; Mon, 04 Mar 2019 21:20:01 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     Linus Walleij <linusw@kernel.org>, Enrico Weigelt <info@metux.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] x86: apuv2: select LEDS_CLASS
Date:   Mon,  4 Mar 2019 21:19:21 +0100
Message-Id: <20190304201930.1622839-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190304201930.1622839-1-arnd@arndb.de>
References: <20190304201930.1622839-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XxZake0ndRPH2Ze0SqTH+/cZJhpugBiJnivixjyNibLQYQRltrn
 uzh413UijeTtvWABuqQBX3hSKVtrl3R1r1CT9T7bq9inQf+GFBXqE2Fi3wGK8rMl7fNXjWu
 adIZqQRZ11L0Llnxp4jFe7Cg25j9TNakZRPrXY9vWvkU/DqcPx8yTX2Okt5jW5/Cy2UzNHe
 A6FhDrLcgv+TBynHQyduw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C7yVC/s2SHQ=:Uhek1oloFFbUBzhFbH3Pr0
 A0lTJoIgpx5/JL0tU8BZu8YbG7B28e+xuvTXEy8vrFw03X6dfACKpIaQfFfB5XnMuJGBRONPn
 qwoQDCntYZRn9K8jtdloyTEHuBmErt2pBAcGebq9pNyB18+m1fntfI4NtPgXGyEO8dJYDho6J
 I8nap/loWLG1FSjA99lohztkFCAh+RHbojNtJjmXFs1xYtlbit9HXI3v30CaLy6i0Qw/fxL0K
 UUdRz4M04Tl/WgApnViJow/hX4D4EY3ICSihuIl3W+86njaZ578b6yBdDK/ZZhyC9O6rjo+Lt
 3C9fnqZjUWx8rkj11XiFjyRQ7kVE3OAgleQVBIHGWFPM8j5S7jtb2q+cHG9g/YC4Ixv9ipZa8
 QlXBDHowPd1N+D8qzYDvGa/mSTYn0UHEgKijKVVi6nGgsIbovqqck1vrtPh05mvJhXc8ulxvX
 xbHIt5rAOzi1+j9NGIGvg/z8e38rhSi/Kx+BLholSXO0Ysctg0hE+t5l/ysA+RoW9UxFR8Dde
 EBzf7jdwJssDG2XBrimzzGaf+BLkmyfZugbVgGdDcPI9WYowYLlLXXXzYc4ti2zWHHaB+yl26
 P4bZ/hh2+1EA69BzR4AJQEsD+0tH4mpwu6UiCT7RvFErmbRGJ07ChE9fPVibxU0WVntnTdOwo
 7ZkVff0RoCHNSbs4bCW+SyplpA9l9q9uhmPPgRQlkX+02kywOIuNoEdQjEwNIetq6HX4McVIv
 z8qZJe35iWbTCKeXAslOgyZZbickszWYLLNSSA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LEDS_GPIO can only be selected when LEDS_CLASS is already enabled:

WARNING: unmet direct dependencies detected for LEDS_GPIO
  Depends on [m]: NEW_LEDS [=y] && LEDS_CLASS [=m] && (GPIOLIB [=y] || COMPILE_TEST [=y])
  Selected by [y]:
  - PCENGINES_APU2 [=y] && X86 [=y] && X86_PLATFORM_DEVICES [=y] && INPUT_KEYBOARD [=y]

Fixes: f8eb0235f659 ("x86: pcengines apuv2 gpio/leds/keys platform driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/platform/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 4d65d37b0c86..d64529352a9c 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -1308,6 +1308,7 @@ config PCENGINES_APU2
 	depends on INPUT && INPUT_KEYBOARD
 	select GPIO_AMD_FCH
 	select KEYBOARD_GPIO_POLLED
+	select LEDS_CLASS
 	select LEDS_GPIO
 	help
 	  This driver provides support for the front button and LEDs on
-- 
2.20.0

