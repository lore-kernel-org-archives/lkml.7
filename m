Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0277ECE587
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA0621855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 14:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbfJAOXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 10:23:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53553 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389006AbfJAOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 10:22:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MF418-1iLthw2cqO-00FRsG; Tue, 01 Oct 2019 16:22:56 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Evgeniy Polyakov <zbr@ioremap.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Thomas Bogendoerfer <tbogendoerfer@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] w1: ds2505: select CRC16
Date:   Tue,  1 Oct 2019 16:22:44 +0200
Message-Id: <20191001142255.1245989-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2wTcfLAihyLHj4j+fM8o3d07tIhT4eM5C4mQ+VyTh56oe4qPJvi
 k/RgP6fvxJHWyHsKPXoePy03smAmfB+7ptZYlV7S1t0nFAgY/WrSTCmlzut3E1+Q5UL0Qx5
 TFPRCAE/imQlncFtdmnNQ9MtFMEh5pxUAuAsyoJ5g/v+yf49cQENfpMWxOo2bRQMR+lDj+B
 YYoh/jgXkzjO36ZzfS6WQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B5dB2AhTFQ8=:bjVe/aYWvOzQB5DIHq4p/G
 4xwi9VJ2sF0SZ3NoEFk0/hpqdPgc52+OfY618vpzPEhkwove5dCZIdA3d2/VAa5pltnbzsK3N
 0Ru4VNET8u/0AZxoOLgDziT+KP0d7v1Xx4KgvZlIvpQHCWjtOKPthPOIro4icabOl/PrqwFYZ
 bjpi1Jjl5ZVDaXReTKqs3ohy5fDcUu0gr50WmH/YRxdCyeezz228MhCGpUf1mmtu8eYaYriMD
 hyhDYPbayA9JeVP1tMDmyRjrrcTYwzuZ3/ylXix12LppuNTGaNPAsO37W1gHHMmevFHm7F8iq
 9Ew0KZa2m7FwffjM1rOCk3RYztdNxaWXszabktbZAAE/aPSOZwE9aVahF62gurDKOBZDzEN7e
 BMTTwE0PdK0EAplRsKHpVhpH3685vozyqScH6kqpeV5S+pAQB1iVTQHQW67dFsYteyJPPYAOr
 5Gk8D9sI2X8Csp+0Ss8ajvQsFCesfBDyuYzjZF9MioAWEF8q8IpfFoMkgQ6PwVZvxLjJj3Dmj
 L+Evqr4mbjMWurSdtVoefcHWYISBYFcKgQ1pcgm1B0xjA8MaCFXM2vaSY4OXuwYLQcujHmWbQ
 QrcdIX506qTfGzHzys+uIqS7aEmz3qkw4krPdclNRSgPmIsloWB5o7vW8jWcZ5sYGrSjN1Yk4
 fqyHveOQOf+zeUr68WteAhTFxAGt4JXvN+b37R0oZKla/ItNv96yXjUjC/bfQaLtziPDkFhlE
 wshDLzXSzbkfOUDYXKNnDnG1WxSGFsH17zQrzBy0+bjPftcj/4d54N/cYu/ilFtjEZyaclKVe
 74yaxOPfO9EA7VJRD4vjzLvzyBi0mp4AwP1gvNxuaI+ZwHUqKciDNXodJk+X4El9hwgoW9WfQ
 SneKpJEqqY+mKFeef+lQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/w1/slaves/w1_ds250x.o: In function `w1_ds2505_read_page':
w1_ds250x.c:(.text+0xed4): undefined reference to `crc16'

Fixes: 25ec8710d9c2 ("w1: add DS2501, DS2502, DS2505 EPROM device driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/w1/slaves/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/w1/slaves/Kconfig b/drivers/w1/slaves/Kconfig
index ebed495b9e69..b7847636501d 100644
--- a/drivers/w1/slaves/Kconfig
+++ b/drivers/w1/slaves/Kconfig
@@ -103,6 +103,7 @@ config W1_SLAVE_DS2438
 
 config W1_SLAVE_DS250X
 	tristate "512b/1kb/16kb EPROM family support"
+	select CRC16
 	help
 	  Say Y here if you want to use a 1-wire
 	  512b/1kb/16kb EPROM family device (DS250x).
-- 
2.20.0

