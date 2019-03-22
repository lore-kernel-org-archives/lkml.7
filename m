Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83303C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4082183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfCVPq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:57 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:52233 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfCVPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:54 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N1whr-1h0jYs2B7R-012LGN; Fri, 22 Mar 2019 16:46:39 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Russell King <rmk+kernel@arm.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jiong Wu <lohengrin1024@gmail.com>,
        Martin Hicks <mort@bork.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 08/25] mmc: core: shut up "voltage-ranges unspecified" pr_info()
Date:   Fri, 22 Mar 2019 16:43:59 +0100
Message-Id: <20190322154425.3852517-9-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xKzkjcZ9sdwnDMJpHCbZubw9iVQy1Q+3iwt6jMNhxhxj57MfM1U
 KRwERkSOzuQyLrMuc4JjyBHg6PY1SETZcdz+006q7Dc70RQE1RiwoOtEQGGXuDaAfz7mky2
 mZeRU+KuQZel2C+oRNwwEdzxN/C5X0WLsn63h3lX6tvI+A43BgcHGqEoaPimxWyspzoS/x9
 jYrL+tBnVbxtFEYisI4Xg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8UOTv7lvoss=:sYhAnRI77z0j8XUghrTEtS
 LJz3BkBZP4wJHmpsn4c0dIw7NeC4IKcR/UzN86DL9VkqWHu+seWOfst8bslpwRsD23LcWx3f/
 NBZATyxs9JP9mdJp8G3dGa98HbopsnUlz6cjpEHarLKpyPJLWwMxv6NStlTkSdm/N9pnqwiSL
 oTVGmbfHgKTNWZvTRgIKSriRrMSBMLtH07NllhK/3lFXermaL+5E7gGp/Iexc4YDVeJaLSqnC
 bG+qztu94rEqhtDdVfnCxaPmozC77OHkOBlWKPYKdnLyRThlSz2zdBPPdRkJ9JwRDSvCNhtqP
 w38LeYAQHiX/fvztDnwA6GV9Q9d7apT4py6dURXQuX6AIX+8/MGSSgNjUO9UzS5TiRlS59yEt
 i/u4/L1vmQXKxeXwNy3VH9ANbMdrvMAQygA5NZHr1lh3OHgIqyQli6oWQbEnPLcC0gVmw0MvI
 VgTZ1AAcYbg+/uwFmChajj5evzLDVfNHRhz6t9V+Gc6D/WOwQglH2RGpRj5hDNBBffKA869gb
 JbYKJ6XS3nMyqgyEdyBos66HAdBPCiQ7EGq3lQNw5b811FRHpqmcfSk0W/knzaEXyPs3exvbi
 8XmnaDq5vlfHK4gmJDJr3OLfmfYQoz/LI4QrF7Za6el4Hz2Ta/j3lZZAlZpRRc80iIpIvvg6u
 8Ds6gcbpemgYDltBjj2U07LAZVD9LArwXGgqdspyUvTWn8quxi6Rkk5llHqGgchDwVZzWfN2v
 1NibpG3Z0TF80gjUSH8itOi0UFeloxhliU3k/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@arm.linux.org.uk>

Each time a driver such as sdhci-esdhc-imx is probed, we get a info
printk complaining that the DT voltage-ranges property has not been
specified.

However, the DT binding specifically says that the voltage-ranges
property is optional.  That means we should not be complaining that
DT hasn't specified this property: by indicating that it's optional,
it is valid not to have the property in DT.

Silence the warning if the property is missing.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 10a16a01d8f72e80f4780e40cf3122f4caffa411)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index e2e927d1f7e4..df074f8c7cb7 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1220,8 +1220,12 @@ int mmc_of_parse_voltage(struct device_node *np, u32 *mask)
 
 	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
 	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-	if (!voltage_ranges || !num_ranges) {
-		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
+	if (!voltage_ranges) {
+		pr_debug("%s: voltage-ranges unspecified\n", np->full_name);
+		return -EINVAL;
+	}
+	if (!num_ranges) {
+		pr_err("%s: voltage-ranges empty\n", np->full_name);
 		return -EINVAL;
 	}
 
-- 
2.20.0

