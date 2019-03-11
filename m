Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AB7C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D59820657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbfCKNWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:22:49 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:39695 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfCKNTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:42 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M9WqY-1h6elN0etY-005XrD for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:41 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 102/114] drivers: cpuidle: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:54 +0100
Message-Id: <1552310346-7629-103-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:SqGk0NHVI8AQGYGXqMuPyXMEIJ7Bet+D1erWomEiRa5dQjaxgFf
 nWSt0DsMqp6rDBhu3jSbZdB/c7CqTalnV2Ush879hT/myhqoS4WyGwJPf9x8Bk7SezHRFID
 V+GqcGl7JnNRK+fsxKWnf2vOKQ+oE7aMsi+e7DRnCTuZQatxNwxU5Go34t06HBK2DZYnFAJ
 USEwYDNESfyEA7RDvDqJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t1umfU28o2s=:lgZZEXACUUkt6KjaYm+e8P
 Ge9py1FRPp0m/6ULlzzTZiVqiJGhc5f9TKPaKXbDYWqBsD+Enl1/YvybrB0paiiu9E/UAh8I1
 XOiwsCJjyQVr+LXBkn/fAnUCAVwYmuqFxlBKeCYrAgtgkD6yrkalCLjxSjG0qU+dwu/F8b1CF
 xcXJH+BHJK5TCWZQswRKfe5htBcydR9ayYLKDW/Stjsy5BZAh6/ekitR3uNo1h/Hm8aix9uac
 D8KUo3Yag2nlckAQQwFnrnE0bmCD0djYePBkIRz98glqtufCnfFQRL60fLWyUHjYtH1KQ4NOm
 TDT/zaO0n7quQHsThZRGOxqOqEZFNp6csxyaghzXUorjYr70Mm75oSne0OilLmb0g/Ae/nnYJ
 z0y16Zwv6VNXJLkRlL1OvwmdiLRPBE7E53I3DsnrAvtDftFRk1VTSBQtvFvqzSzxp2uDwyi3W
 O/3OFIufspuWcTXk5FWV5dX8ouc+usPia9vZL261zqpEdQ7nB1cTn4ZTGF3r2zAF8o28GFWZE
 GPD2w65FYHgENMVBFNrox1QOR3LMHFg/4K0qaVhQ+JSyAYWBnr4a2d1Sqv7L0k2vsxSJ5wvhn
 2zbAqRsL4BRjeWoXYcJXGvrws8kH4tsaHdNoTcd7OkER4JlXFNU6PRNB8m2sXHCEeNwaq/Hl+
 fAwQCSG9sRGsdylcJs84nppoTa/zFcjJFieCdcuF4xhAM1zdThHDnCJBXB0HFU+Rmp/Wa2qX3
 BwzhhkrtU5n36hhRAdzbbv39ael3AHpGYB78KA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/cpuidle/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 8caccbb..b1e3635 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -15,7 +15,7 @@ config CPU_IDLE
 if CPU_IDLE
 
 config CPU_IDLE_MULTIPLE_DRIVERS
-        bool
+	bool
 
 config CPU_IDLE_GOV_LADDER
 	bool "Ladder governor (for periodic timer tick)"
-- 
1.9.1

