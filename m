Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2F8C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49EE8206EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 08:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLTImz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:42:55 -0500
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:47232 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727084AbfLTImy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 03:42:54 -0500
Received: from [85.158.142.98] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id AC/2A-19913-B898CFD5; Fri, 20 Dec 2019 08:42:51 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRWlGSWpSXmKPExsVy8IPnUd3uzj+
  xBlcaWS3mnG9hsWhevJ7N4vKuOWwW7z91Mln837OD3YHVY8vKm0wem1Z1snnsn7uG3ePzJrkA
  lijWzLyk/IoE1oz3ez8zFszirOg/85SxgXEWRxcjF4eQwHpGiZvP57B1MXICORUScz90MYLYv
  AIREut6FzCD2JwCZhITDzczQ9SYSsw9/Y8VxGYT0JF4NHM9E4jNIqAq8aZ1ApgtLJAi0bp3Jh
  vIAhGBjYwSB/59AnI4OJiBhnZs5ICYLyhxcuYTFhCbWUBC4uCLF1DztSTOrVkFdoOEgL3E9Pd
  XmUFaJQT0JRqPxUKEDSW+z/rGAmGbS9x8tpxtAqPgLCRTZyGZuoCRaRWjRVJRZnpGSW5iZo6u
  oYGBrqGhsa6hrrGZXmKVbqJeaqlucmpeSVEiUFIvsbxYr7gyNzknRS8vtWQTIzACUgoZVXYwd
  n99q3eIUZKDSUmUN8n/T6wQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd7GNqCcYFFqempFWmYOMB
  ph0hIcPEoivNbtQGne4oLE3OLMdIjUKUZdjp1H5y1iFmLJy89LlRLnXQJSJABSlFGaBzcClhg
  uMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmjQaZwpOZVwK36RXQEUxAR3Bo/gI5oiQRISXV
  wDT5Mcf75sLVFyqMcqwiup68ecG8ftayiskz7VrN87obWuzniLXc+yrn0FdznSvtzY4LIRmNw
  o5MU3rkfwdM7NSd1C4f+y4kb0KB3wu+gzMnir4M3q3rFXxxZtc1zkk1UqGnp36+p5edW7zuel
  iGwEEOv8r3G7z3LxWbeFibx0YmKdh+ovmTFRkBD14nqSUcuN0qYLGAY9/V9X4vFL2yJsy7Jq1
  s+DX2Z+ylJZM3tC6e1NK4/7ogg6F9ZqMEq+n0FfVmVqJnPOxzednv3PjmNvNi0bmy/Ussf1W1
  1dRpcdVxxClm/xV/zJIjestcc+2uJzUncwuPG7HNnfLfNvHa1Yjw5HLzzVVfZLJfZof9U2Ipz
  kg01GIuKk4EAIyxi8GHAwAA
X-Env-Sender: roy.im.opensource@diasemi.com
X-Msg-Ref: server-11.tower-223.messagelabs.com!1576831370!805441!2
X-Originating-IP: [193.240.73.197]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.44.22; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24248 invoked from network); 20 Dec 2019 08:42:51 -0000
Received: from unknown (HELO sw-ex-cashub01.diasemi.com) (193.240.73.197)
  by server-11.tower-223.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 20 Dec 2019 08:42:51 -0000
Received: from swsrvapps-01.diasemi.com (10.20.28.141) by
 SW-EX-CASHUB01.diasemi.com (10.20.16.140) with Microsoft SMTP Server id
 14.3.468.0; Fri, 20 Dec 2019 08:42:43 +0000
Received: by swsrvapps-01.diasemi.com (Postfix, from userid 22266)      id
 AB3BF3FAB1; Fri, 20 Dec 2019 08:42:43 +0000 (GMT)
Message-ID: <e8e5e80682f86636392183a0296107e7ed78df0d.1576830367.git.Roy.Im@diasemi.com>
In-Reply-To: <cover.1576830367.git.Roy.Im@diasemi.com>
References: <cover.1576830367.git.Roy.Im@diasemi.com>
From:   Roy Im <roy.im.opensource@diasemi.com>
Date:   Fri, 20 Dec 2019 17:26:07 +0900
Subject: [RESEND PATCH V8 1/3] MAINTAINERS: da7280 updates to the Dialog
 Semiconductor search terms
To:     "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rob Herring <robh@kernel.org>
CC:     Support Opensource <support.opensource@diasemi.com>,
        <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-ServerInfo: sw-ex-cashub01.diasemi.com, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 20/12/2019 06:45:00
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the da7280 bindings doc and driver to the Dialog
Semiconductor support list.

Signed-off-by: Roy Im <roy.im.opensource@diasemi.com>

---
v8: No changes.
v7: No changes.
v6: No changes.
v5: No changes.
v4: No changes.
v3: No changes.
v2: No changes.


 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d3a5c5..def5e3e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4819,6 +4819,7 @@ S:	Supported
 F:	Documentation/hwmon/da90??.rst
 F:	Documentation/devicetree/bindings/mfd/da90*.txt
 F:	Documentation/devicetree/bindings/input/da90??-onkey.txt
+F:	Documentation/devicetree/bindings/input/dlg,da72??.txt
 F:	Documentation/devicetree/bindings/thermal/da90??-thermal.txt
 F:	Documentation/devicetree/bindings/regulator/da92*.txt
 F:	Documentation/devicetree/bindings/regulator/slg51000.txt
@@ -4828,6 +4829,7 @@ F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
 F:	drivers/input/misc/da90??_onkey.c
+F:	drivers/input/misc/da72??.[ch]
 F:	drivers/input/touchscreen/da9052_tsi.c
 F:	drivers/leds/leds-da90??.c
 F:	drivers/mfd/da903x.c
-- 
end-of-patch for RESEND PATCH V8

