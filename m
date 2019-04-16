Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8B2C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FA2075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbfDPGUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:20:21 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:49421 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfDPGUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:20:11 -0400
Received: from [85.158.142.104] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id B4/F7-24683-81475BC5; Tue, 16 Apr 2019 06:20:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsVy8MN7XV3xkq0
  xBhPnG1pMffiEzWL+kXOsFk3fVzNbfLvSwWRxedccNoul1y8yWbTuPcLuwO6xZt4aRo+ds+6y
  e2xa1cnm8XmTXABLFGtmXlJ+RQJrxtpbn1kKtnBWdF5dxNLAeJiji5GLQ0hgLaNEY28HSxcjJ
  5BTIbGtoYexi5GDg1cgXeLECQWQMKeAq8TlY01MECUuEjfOXwOz2QRMJDYd2cMIYrMIqEr0Hu
  4CGyMsEC9xurEJLC4ikC1xd9lJdpBdzAJbGCV2bZjIBpLgFRCUODnzCVgDs4CExMEXL5ghFuh
  JdE+exwpiSwjYS0x/f5UZwtaXePl1IxOEbSjxfdY3FgjbXOLf+1+MELa1xPUPs9gmMArNQrJi
  FpIVCxiZVjFaJhVlpmeU5CZm5ugaGhjoGhoa6xrpGpqb6SVW6SbqpZbqJqfmlRQlAmX1EsuL9
  Yorc5NzUvTyUks2MQIjJqWQacMOxmcL0w8xSnIwKYny5oVujRHiS8pPqcxILM6ILyrNSS0+xC
  jDwaEkwWtQCJQTLEpNT61Iy8wBxi5MWoKDR0mE928RUJq3uCAxtzgzHSJ1itGY4+D3h3OZOWb
  cfzaXWYglLz8vVUqcdwpIqQBIaUZpHtwgWEq5xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmY
  txlkCk9mXgncvldApzABnTJFZzXIKSWJCCmpBkalW594c7de/t+xSf74h6PTPws1nlbJfz3J1
  Ln3Z3WPWe7OiqcKF28U9B6bvm3xsSYzvilb3lW2CucoPuliMovNDcrh6Tilsjz/4ArjQ4sWLf
  zltuy2LOellzap8zxDstLP7jdN2FjHObn/yxThNQdqL3DcOPgmMy7m0r9zP7J2lJmtvF26WTF
  UiaU4I9FQi7moOBEA+U1GiCQDAAA=
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-18.tower-229.messagelabs.com!1555395606!4413668!3
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 21182 invoked from network); 16 Apr 2019 06:20:07 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-18.tower-229.messagelabs.com with AES128-SHA256 encrypted SMTP; 16 Apr 2019 06:20:07 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Tue, 16 Apr 2019 08:20:06 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 1EED55F7FB; Tue, 16 Apr 2019 15:20:05 +0900 (KST)
Message-ID: <60d306ce39a78df0d00f7be72d83d1e646592b6c.1555389447.git.eric.jeong.opensource@diasemi.com>
In-Reply-To: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
References: <cover.1555389447.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Tue, 16 Apr 2019 13:37:26 +0900
Subject: [PATCH V1 1/3] MAINTAINERS: slg51000 updates to the Dialog
 Semiconductor search terms
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     DEVICETREE <devicetree@vger.kernel.org>,
        LINUX-KERNEL <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Support Opensource <support.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: NB-EX-CASHUB01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 16.04.2019 01:43:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Jeong <eric.jeong.opensource@diasemi.com>

This patch adds the slg51000 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>

---

 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 002d564..9783eba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4632,6 +4632,7 @@ F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
+F:	Documentation/devicetree/bindings/regulator/slg51000.txt
 F:	Documentation/devicetree/bindings/watchdog/da90??-wdt.txt
 F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	drivers/gpio/gpio-da90??.c
@@ -4647,6 +4648,7 @@ F:	drivers/power/supply/da9052-battery.c
 F:	drivers/power/supply/da91??-*.c
 F:	drivers/regulator/da903x.c
 F:	drivers/regulator/da9???-regulator.[ch]
+F:	drivers/regulator/slg51000-regulator.[ch]
 F:	drivers/thermal/da90??-thermal.c
 F:	drivers/rtc/rtc-da90??.c
 F:	drivers/video/backlight/da90??_bl.c
-- 
end-of-patch for PATCH V1

