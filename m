Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66281C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C496214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 06:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbfDRGlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 02:41:32 -0400
Received: from mail1.bemta25.messagelabs.com ([195.245.230.130]:49501 "EHLO
        mail1.bemta25.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729497AbfDRGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 02:41:31 -0400
Received: from [46.226.53.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-2.bemta.az-c.eu-west-1.aws.symcld.net id 86/8E-23848-81C18BC5; Thu, 18 Apr 2019 06:41:28 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleJIrShJLcpLzFFi42I5+OG9rq6EzI4
  Yg0M3mSymPnzCZjH/yDlWi6bvq5ktvl3pYLK4vGsOm8XS6xeZLFr3HmF3YPdYM28No8fOWXfZ
  PTat6mTz+LxJLoAlijUzLym/IoE1Y8LJZ2wF/ZwVy+69ZW1gnM/RxcjFISSwllFiVec01i5GT
  iCnQuLbkkOMIDavQLrE0kfzweKcAq4Sj25dg6pxkfj86ARYDZuAicSmI3uAbA4OFgFViRNvmU
  BMYYF4iZM7ikAqRASyJe4uO8kOsopZYAujxK4NE9kgxgtKnJz5hAXEZhaQkDj44gUzxHg9ie7
  J88BWSQjYS0x/f5UZwtaXePl1IxOEbSjxfdY3FgjbXGLmnztQNdYS1z/MYpvAKDQLyYpZSFYs
  YGRaxWieVJSZnlGSm5iZo2toYKBraGika2RgpGtuqZdYpZusl1qqW55aXKJrqJdYXqxXXJmbn
  JOil5dasokRGCspBaf8dzA+70o/xCjJwaQkylsiuiNGiC8pP6UyI7E4I76oNCe1+BCjDAeHkg
  RvtxRQTrAoNT21Ii0zBxi1MGkJDh4lEd55IGne4oLE3OLMdIjUKUZjjoPfH85l5phx/9lcZiG
  WvPy8VClx3s0gpQIgpRmleXCDYMnkEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3kMgU3gy
  80rg9r0COoUJ6JQpOqtBTilJREhJNTCG8FqcilN3CpJrUVadNqWsLu7t3VPSRrM+sX+ZzTTbJ
  vPt8bOcvH6aAh0/X01k+rWv97eU1ktjX/X16zVFTp3Qf5L8ulaxw+H/W2GTRz/NnzTyr8/ctM
  puUcviZZ5vZs2YtfYhv5CW+f7ybZJeOyMCPcz+39ri9XzbQZ5/XIZJGw6rrcsvq5mtxFKckWi
  oxVxUnAgARFE86CEDAAA=
X-Env-Sender: eric.jeong.opensource@diasemi.com
X-Msg-Ref: server-19.tower-302.messagelabs.com!1555569687!6616895!2
X-Originating-IP: [193.240.239.45]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28263 invoked from network); 18 Apr 2019 06:41:28 -0000
Received: from unknown (HELO NB-EX-CASHUB01.diasemi.com) (193.240.239.45)
  by server-19.tower-302.messagelabs.com with AES128-SHA256 encrypted SMTP; 18 Apr 2019 06:41:28 -0000
Received: from krsrvapps-01.diasemi.com (10.95.17.50) by
 NB-EX-CASHUB01.diasemi.com (10.1.16.140) with Microsoft SMTP Server id
 14.3.408.0; Thu, 18 Apr 2019 08:41:26 +0200
Received: by krsrvapps-01.diasemi.com (Postfix, from userid 22095)      id
 BD6DD5F7FB; Thu, 18 Apr 2019 15:41:24 +0900 (KST)
Message-ID: <878724615d6edf4d1d8960fd4aa9058aaedab026.1555567784.git.eric.jeong.opensource@diasemi.com>
In-Reply-To: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
References: <cover.1555567784.git.eric.jeong.opensource@diasemi.com>
From:   Eric Jeong <eric.jeong.opensource@diasemi.com>
Date:   Thu, 18 Apr 2019 15:09:43 +0900
Subject: [PATCH V2 1/3] MAINTAINERS: slg51000 updates to the Dialog
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
X-KSE-Antivirus-Info: Clean, bases: 18.04.2019 02:42:00
X-EXCLAIMER-MD-CONFIG: 8d172408-bd6a-42b1-8e53-daaedf35a5af
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This patch adds the slg51000 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Eric Jeong <eric.jeong.opensource@diasemi.com>

---
v2: No changes.


 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 349e5d8..ae6b6f9 100644
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
end-of-patch for PATCH V2

