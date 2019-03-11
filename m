Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C16CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6790D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfCKNV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:21:58 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35969 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbfCKNTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:44 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4z2Y-1gtTUA2lc4-010vmx for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:42 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 113/114] drivers: rpmsg: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:19:05 +0100
Message-Id: <1552310346-7629-114-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:r0K3dMdYCgx4++w0sDlVTcIRSXSXi1Eu7UG4kHA/pXOCk2JdnKK
 XS+VFkDmZ3P1RuYmlgMrwXMnWOYbdYh3et9ahOc4Vyy+tPWEC5eZxXzULy+VTa91Jceoj8b
 aKbmDxmviZh/FqiV2Ci3CdgftN5cLaZ2oL+SIsw5BqYDORWZ4fOSitv5rrF2bE8XucpyAGh
 PSN0Xn5kBhE7ZJfeXNYww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRj0T1BJbwg=:DEpMjbUAQHYzb3CE1PMdM4
 wgbpw9WkkiIyLMP8U6L7P/Vck1cyw4bj7GdT5bTn9WBIHufahrrEsAw0L0cjMZz23m+HzfZxV
 nX2stc/hxFqVHYrmf1hz9sV/j6Bc5WBKeoOeDvqf/MMNgEquAGjQfI4EkEahLaB1D/xx6FUl5
 ElkX+cdmFsAcDOOF5hyOtbBc+/4SVuz/BpK1EEMrvo7VpspYyuxMy356C+hmzKVWufEna1/ju
 vglLy3qk//HOfWerFqtd+2MlLuOoL2cgj90bZELlBDlJjw4ATDfSeQrxVwJYar33eFUyjks0H
 m0fDKES7ud/FGxK2lzVnjcHWPkpo6EQDwBSNGVrv2m7SjJDe9NKImAPzlVtfvQkfaV65KoyrZ
 16/L+VYql7iw4Dd8KCQXK0DzEV4WBiqhkL86me7uK519JINlElReXVgY4n51ocd/EAD/ptNdO
 kNTLDoyjD67tZlEU29XNqhGZaLx6mq1EaveprqEu+RpyahVS7Xxb1Bn4qlZojzDV71C6O+P+X
 +TFWfNOfzDeHyTECD+1m1XrU6j3Q1vA5Wuc3i62KO1aTjL68PabtbUAL07yyiFHYfgvW2dP5f
 4DZchBsA3jTaLIyoZ9Zhzoi6oOApADKU2CXnPdl1yFg8K4djZvh5oUGeloDWBNbBzVLMhqDc2
 1rpQC7iLUtZGIoFuRT2yv58RqzeEOH+AmgXEHCJjZstQoT1DHqwrcgi+oJo7d6wga5DbTSjxm
 D5iAIWmFYneKT2b9yEKnloLfPuFi50JhOP92+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/rpmsg/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rpmsg/Kconfig b/drivers/rpmsg/Kconfig
index d0322b4..7092765 100644
--- a/drivers/rpmsg/Kconfig
+++ b/drivers/rpmsg/Kconfig
@@ -21,7 +21,7 @@ config RPMSG_QCOM_GLINK_NATIVE
 
 config RPMSG_QCOM_GLINK_RPM
 	tristate "Qualcomm RPM Glink driver"
-        select RPMSG_QCOM_GLINK_NATIVE
+	select RPMSG_QCOM_GLINK_NATIVE
 	depends on HAS_IOMEM
 	depends on MAILBOX
 	help
-- 
1.9.1

