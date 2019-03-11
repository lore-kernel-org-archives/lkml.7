Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE880C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AD720857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfCKNZR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:25:17 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54839 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbfCKNTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:39 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MeCxd-1gSuMP1b8B-00bJts for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:38 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 082/114] drivers: pwm: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:34 +0100
Message-Id: <1552310346-7629-83-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:zDFlJq4+jvslwgWqmgybuUzQxME175YeIxWsbYKkXUAOr5HeaVb
 fXETcwLNq1sdFuIeGIhwKx4yQ1WG+OaYBmd0inhKmYpN610Z+9J074UqgZ8kzuINKgEaWLt
 owG9t4pKXcyIWWdcyyGleXvchJS1V8Yx3kOqtu50Y8EXJD4gJ1rM0rLBaRRiaQcZ1yr9tX9
 lwV+fIvzX//SX+AQxdsXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9SYNq3eSWc=:39SFNp81xRJ+XYyVM97ksD
 4V0sEQ1HPm6qNdr0yr5ygZlXZbsrYHx0s+/ocV9ccOQQsh/3P5brBcmeVUgevxGH7ktAk/Vo8
 iI3eJkD17BT0kHKvjW7rE15KLD77d/y5fU0fWEXXk2ua/3sglb8zYjZxvFKRh+xeNyGrG9EtS
 vD74NE4x2eEmpnWHyYI2Fz05Qg7l0QfXh0mX94PtrRJu4m4Of8EHwJqueJAQRbTWHCAHC7d+v
 kuQIJor//aeLA8XK5nkkhwgvQEzeJavlMV0A9i4LBhyNgJ8syUP2/+UtdUwxZPHSH20IoG5CN
 oMRW0AegmJ53URecx1el9kGQkBbVkAnu1q31b4UahDn8VwdQmAOZ+6zjj6+nCk/xAYJnsagt1
 uDia0UcyF09y9fSeUpqPwbp0OT7jReSFaG+mMVTX9QEHwFEVfT9b8MUhvX4+CkcQnt6PkoOWU
 xWVzTc0ZnCbbS4Aop6Grj4epT6J/BWEpj+c7YyscLcDwUS4A7HSQ8oIZgIGQr5048pm1fkv1q
 2sYFRXPjBZd5vLvXwkfF/kTXL+7vefpC1CJRwc3+aWWmwYLNeXUh5LSv2EEOhbvQAU9CWS5uL
 EAx48HveFf4IVvLpff/1yGO8gw6dUQhQDgeBFfjdJ+AcGWATT00d1gP9o3/DgyrloO/CkYvdK
 OhGI1c2OZ79vwzCgBWfXSkCOaAy45H6ej4rLRWFYbROvUsH6R1XeX5HHER5LzQNux0Iiz4KRp
 IG4n38Vq+u+MZczYqBisD5CSLR8Miu11LMhXmA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/pwm/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a8f47df..3a5c20f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -447,7 +447,7 @@ config PWM_TEGRA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tegra.
 
-config  PWM_TIECAP
+config PWM_TIECAP
 	tristate "ECAP PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX || ARCH_KEYSTONE || ARCH_K3
 	help
@@ -456,7 +456,7 @@ config  PWM_TIECAP
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiecap.
 
-config  PWM_TIEHRPWM
+config PWM_TIEHRPWM
 	tristate "EHRPWM PWM support"
 	depends on ARCH_OMAP2PLUS || ARCH_DAVINCI_DA8XX
 	help
@@ -466,7 +466,7 @@ config  PWM_TIEHRPWM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-tiehrpwm.
 
-config  PWM_TIPWMSS
+config PWM_TIPWMSS
 	bool
 	default y if (ARCH_OMAP2PLUS) && (PWM_TIECAP || PWM_TIEHRPWM)
 	help
-- 
1.9.1

