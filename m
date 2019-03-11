Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5F5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7A20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbfCKNUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:20:05 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:56865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727633AbfCKNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:40 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mn2eH-1gbfmn4331-00k5KG for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:39 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 086/114] drivers: cpufreq: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:38 +0100
Message-Id: <1552310346-7629-87-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:JLDu0FwZfLY/fQvIVytUqqi8pl7gVvvAEC6X1N3xdvnJ/m2Oqsy
 woI3KGki0R9FriPATORaihn9hrGiI/qAT15cV0WBI/MqR06CpsjXCy4rFmpvlPV+g+/JLyo
 DRlICM5Dk1bss6cwazwT8QA4xcoNthoDt7sbS6tSBpyWdX35yC/4FQ75G0YqXOBoUeNXNNS
 ukqEq7YnkecxlNGGNw5NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4H/W7OOjowk=:hHR86Wozn5zKmjODBXSUI9
 tyLQOV124SdDecKw371ZFO21bHd/SWZr9m5KlmNLHy+MAniTJRb6eGT1ml0omtc3tPwW1/lCV
 d0O8qGtsGiIg6uUfWotVmILG3rQDHA3Oop8xzXZl4LG8VDVbDdJusmnavFK/JT6urLttJ0tbp
 nWwAlJaWYhe+ZewLIVzR6MOGntZip7Uy3hLr6ZAZQCo6NuNjkfI3EaFJu0vusmIMDFxaXx0ze
 ab2U6+EY632uUMm5gw9Z1PPIXLswwDcQlsh+rABsRjUwedOkKpZaqfCbf8HsVqPrib2WIdkZw
 QDJN3mISOlI11yNoMNW41bPbnOE9sr1hZ50rsrsumnJBZEex0BJkgAbKJ6AdreMjsYST+zNNb
 WjhPi9CkpdinuLVmoCZBHNMvOm7Fr7ZQManYkJ0Y2rXnrGXq8lDFQVvwFwnzC0pEtcDcHzWl2
 Yvs6m9sqv35VlgW8U3V0WViHD9J6vGtALVy+q+yxgj/WL22Th07+ZyVmUNXeRDx/hDGuKNlvA
 6mWEVSM79YVsuwOsYHikPGC7q00qp/cIOR/4EjMvkeDsldyQDj4RiZtfWXZoomI42MfXAqoGh
 IiAjSmBZpasJlqDDZVVVJBug9Pm+8NaHmHcxS544ulYpvDH3YF0ODxD25P0KRi43FTtN8+EVo
 8aXL23NBZH2UGMFwZhlQw12BlkR6mhua+GDOdmHtZLZjSpgwRJK6Ap3GktKsYr754hFBkzVUX
 OkMoTnu11e4OZ/THF61Jj7IUXj1sabPB6SEjhw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/cpufreq/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index b22e6bb..b453330 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -4,8 +4,8 @@ config CPU_FREQ
 	bool "CPU Frequency scaling"
 	select SRCU
 	help
-	  CPU Frequency scaling allows you to change the clock speed of 
-	  CPUs on the fly. This is a nice method to save power, because 
+	  CPU Frequency scaling allows you to change the clock speed of
+	  CPUs on the fly. This is a nice method to save power, because
 	  the lower the CPU clock speed, the less power the CPU consumes.
 
 	  Note that this driver doesn't automatically change the CPU
@@ -66,7 +66,7 @@ config CPU_FREQ_DEFAULT_GOV_USERSPACE
 	select CPU_FREQ_GOV_USERSPACE
 	help
 	  Use the CPUFreq governor 'userspace' as default. This allows
-	  you to set the CPU frequency manually or when a userspace 
+	  you to set the CPU frequency manually or when a userspace
 	  program shall be able to set the CPU dynamically without having
 	  to enable the userspace governor manually.
 
@@ -133,7 +133,7 @@ config CPU_FREQ_GOV_USERSPACE
 	help
 	  Enable this cpufreq governor when you either want to set the
 	  CPU frequency manually or when a userspace program shall
-	  be able to set the CPU dynamically, like on LART 
+	  be able to set the CPU dynamically, like on LART
 	  <http://www.lartmaker.nl/>.
 
 	  To compile this driver as a module, choose M here: the
@@ -148,11 +148,11 @@ config CPU_FREQ_GOV_ONDEMAND
 	select CPU_FREQ_GOV_COMMON
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
-	  The governor does a periodic polling and 
+	  The governor does a periodic polling and
 	  changes frequency based on the CPU utilization.
 	  The support for this governor depends on CPU capability to
 	  do fast frequency switching (i.e, very low latency frequency
-	  transitions). 
+	  transitions).
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called cpufreq_ondemand.
-- 
1.9.1

