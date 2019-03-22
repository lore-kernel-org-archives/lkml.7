Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9D5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FEA2183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfCVPqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:54 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:57135 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfCVPqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:53 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Ml6du-1giFMn2xJs-00lUfW; Fri, 22 Mar 2019 16:46:21 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Avri Altman <avri.altman@wdc.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Martin Hicks <mort@bork.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Simon Horman <horms+renesas@verge.net.au>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jiong Wu <lohengrin1024@gmail.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 07/25] mmc: sanitize 'bus width' in debug output
Date:   Fri, 22 Mar 2019 16:43:58 +0100
Message-Id: <20190322154425.3852517-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G768/5n7N+5yTCnRzLr3RNwvzu/HYJiMFqxjs0wDv/J34Szl14D
 ox4n6suF/EFsAqlzN5tGJcDQeBomC44kIT1Opy/9ltW98MuFx8iQOTAdh6V4Y4E8/Q04Vq8
 zKSNVc3eiLey+XUBSjqgbkYVmQG8JrIq4aPEOmdNxWtaewmVNV6EnbbB2XDXz7HSHF+M7zI
 fr9ElsuIRW32OqLNzcnLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7T/GpsWXrRI=:gv5/lMUz3Skxdq2x4iCNw+
 sU6OSLFoZYnZpQt1+S9bwibN8jBoon6VFG1qC2ImbUemPsECYLxT9ZbeHcnAjQZdkVEhLAmuF
 yl46ggRrpiFXEXk6uSO4gq5OUGeQ1nFglHQ38RK90n4tM3NAsnfEeFhT1Lujfm4OkcihFY8/v
 rxKppeDax2KUhokn2BvHVHYJQpTrh4/1mHiMY40D1xYJCbJL8fbwuE6Eqj4gdsnhF8NGCB/qR
 SG9Q4yYlCCWQ9WeY7DrxIf7NCm1RKKVjjMWckSuBFAXmj50m2tqem0nz4feDAt1Ymnh0sfbQ9
 fM6X5f83+xxb5+8rpctpxiQqkIr26l4cFuX75SjGXKJ65WwiLomgjrx4LNABekiTAkKWS9ovr
 Ql5EUUAXC7eg9Ed8I9KHRPDWQiVDrjXbx94uxmrfRFENYG9r07lP97FfIP/yY4hZtYAGn0zPc
 0n5aUm4jRlvdjwcGK0unpI07ivx+bdwpva4c2z5oBMxmTcaTSD3epFj1sgS94HIJGfr8mZpz3
 ROwJRE+OqtgyL0rystPgFaybsfXd7Qnxp2JqQiTemf3C2btIakaa5188Ze44Bt7S+6uugRv6+
 tWqxYxLQ2CBPxKIF5UhKlWlZ1XwZTUmo2uoq/1J+jypGgaV1YNHXyprhh/ozWzeveqkC9pwmA
 CvUw2pAabo/BSaXurlWmOUr3f5Yp66f0tarxnxo+W4cYj/karKv8VoSg3JVYFDKB2g52CUpWT
 IqJIqwl7naZsgWNi/FJgQ1vTRKxiz9OirC7rwA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The bus width is sometimes the actual bus width, and sometimes indices
to different arrays encoding the bus width. In my debugging case "2"
could mean 8-bit as well as 4-bit, which was extremly confusing. Let's
use the human-readable actual bus width in all places.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit ed9feec72fc1fa194ebfdb79e14561b35decce63)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/core.c | 2 +-
 drivers/mmc/core/mmc.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 299a83f1ad38..e2e927d1f7e4 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1039,7 +1039,7 @@ static inline void mmc_set_ios(struct mmc_host *host)
 		"width %u timing %u\n",
 		 mmc_hostname(host), ios->clock, ios->bus_mode,
 		 ios->power_mode, ios->chip_select, ios->vdd,
-		 ios->bus_width, ios->timing);
+		 1 << ios->bus_width, ios->timing);
 
 	host->ops->set_ios(host, ios);
 }
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index adc3291e9d6a..7286d0d324e1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -952,7 +952,7 @@ static int mmc_select_bus_width(struct mmc_card *card)
 			break;
 		} else {
 			pr_warn("%s: switch to bus width %d failed\n",
-				mmc_hostname(host), ext_csd_bits[idx]);
+				mmc_hostname(host), 1 << bus_width);
 		}
 	}
 
-- 
2.20.0

