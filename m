Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1916DC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E477C2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfCVPpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:45:07 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:45359 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:45:06 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M2w8Y-1h8TLT0ncK-003KEI; Fri, 22 Mar 2019 16:44:59 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, Arnd Bergmann <arnd@arndb.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 01/25] mmc: pwrseq: constify mmc_pwrseq_ops structures
Date:   Fri, 22 Mar 2019 16:43:52 +0100
Message-Id: <20190322154425.3852517-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:oe8376lywJ1RlgN89xWJQlf+8ZN8YDWsg4NYJjq+An/jq+TA3OO
 iRU3TJcxTNCk2RPXuCFKIGL03nBVIEj79YFJiDLmz1HJZhgoAroXmEqJjWtOS8rjBwBABhY
 IWwRX0wx8cMrHa1cZE6u1U9/XXHYduegiEDbHGGRXfwewHHR0nZdYOGyZo1bJxrkm++SImw
 H0m9QaPU7eMWkeR79GdVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W4KUOBxIZrU=:yV+7BtWADOH09wsWx39kaZ
 wHIZrDycVFQIt7W3f2Pdi4h5KFryWkZWTFjBkkANQXkdqErAZgiFsf4vdTyGCjzw+sxfeNPrj
 4wssvVI9T1x9Pkb1MuE9+qI3FhzdqfaBhSRzqzz68qtjz74VjzONMZO9VmlhA378jrSxv/ipX
 CWjeQ45empv1htdOXAmjM4DNn/CtXw6aIVBizPH6nWqihoglMVbt/H0i9ZhxRKoJUMdYOMwq6
 V+shWTBgqwMuTcFMkR8B+B89yi7QaJsfJKEidra36l7lH7kMH70fyF33xdJusJl3x20rZyMX0
 WlAYYCb5nDBi3dY0U7iNbufDdRIbd+46gy1zClKr2DdnWgeoDG92FuO5p0fcGn8SBmjpIQPB2
 1GAGQuAm8kfUO8tiepI090EpKmX4qbV23kcQxFH14uCiZCSJeqZ7Pz8lfAolVaOakcbhtFrte
 u5xEmuhQab+OJYeXrHWjbkr9TNXaeInF3/w8MjllwayfX9P/87Hd0pow/gnhR+XvgCWCGgkbQ
 wg44V6CnYv5UFAE7mB60set1WbYe6o0Ziu6qOACWRewly+hxSKt7ozDnATQjqQY3Tb+ws8/Uf
 9du26OULb4lXQaQRbunR3X/fFksm/gqxgjv30JlFmJCjzYkP8+bM4DZAPI2zUfWw7nB5Eq303
 qArUwlLDqYMBfiCDTMQZC5VtBnDU7086Am6DsJF6xXhBuByFotzII8Jf+NISofo8knykflgvW
 g2Hh3O6gyq6tpAdlDuFQA0XnGK9OwD+g1UNP/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

The mmc_pwrseq_ops structures are never modified, so declare them as const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit ffedbd2210f2f4cba490a9205adc11fd1b89a852)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/pwrseq.h        | 2 +-
 drivers/mmc/core/pwrseq_emmc.c   | 2 +-
 drivers/mmc/core/pwrseq_simple.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index 096da48c6a7e..133de0426687 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -16,7 +16,7 @@ struct mmc_pwrseq_ops {
 };
 
 struct mmc_pwrseq {
-	struct mmc_pwrseq_ops *ops;
+	const struct mmc_pwrseq_ops *ops;
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
index ad4f94ec7e8d..4a82bc77fe49 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -51,7 +51,7 @@ static void mmc_pwrseq_emmc_free(struct mmc_host *host)
 	kfree(pwrseq);
 }
 
-static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
+static const struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
 	.post_power_on = mmc_pwrseq_emmc_reset,
 	.free = mmc_pwrseq_emmc_free,
 };
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index d10538bb5e07..2b16263458af 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -87,7 +87,7 @@ static void mmc_pwrseq_simple_free(struct mmc_host *host)
 	kfree(pwrseq);
 }
 
-static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
+static const struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
 	.pre_power_on = mmc_pwrseq_simple_pre_power_on,
 	.post_power_on = mmc_pwrseq_simple_post_power_on,
 	.power_off = mmc_pwrseq_simple_power_off,
-- 
2.20.0

