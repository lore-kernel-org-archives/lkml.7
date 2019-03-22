Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6384CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1D218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfCVPqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:46:38 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:39051 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfCVPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:46:34 -0400
Received: from wuerfel.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M1Hi8-1hA7Fs3q1K-002mWu; Fri, 22 Mar 2019 16:46:07 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        hongjiefang <hongjiefang@asrmicro.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Jennifer Dahm <jennifer.dahm@ni.com>,
        Yinbo Zhu <yinbo.zhu@nxp.com>,
        Avri Altman <avri.altman@wdc.com>,
        Kyle Roeschley <kyle.roeschley@ni.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [BACKPORT 4.4.y 06/25] mmc: make MAN_BKOPS_EN message a debug
Date:   Fri, 22 Mar 2019 16:43:57 +0100
Message-Id: <20190322154425.3852517-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190322154425.3852517-1-arnd@arndb.de>
References: <20190322154425.3852517-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RWCkPDa1RfODQ0CZQuzMTOyyy2eIm16NST7+OZno7XSgnPYCTH4
 /y/qoDARhKGdcdXUcBB4gtsDxCKATndrYjVgnud2zIa+wI3TUMYa1jKjZXOOctVijd/vINm
 cY1kv17brk0/njzjWlJdCJMo2RTliVmdF15KW8BkgZKGk81Bzo42F/6GkMIp1ufgmyrgOSU
 1Z4jmvQdJrKbgjk8xMz1g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YgBfrG/uq1c=:I4UntfcZItaVU6X37yNOeT
 dywgzQnJK7DWuALu/7Mq0b4nDZRwmHqmWMvtbM5g9zG6RzdOd72CrO7W6A7FNqDniazvCfhYu
 1mvkBe0gIMRUT2+WVM89yxmZC7YWK/wcAN1ugXXa02CwA19EiHV0AcLBsd/tEKZlPaBbfahhB
 rNUXoW0pKvQNPsBf5+kuMMHRBdsF+sEOCCTg5S2YSnhWg8rPX1ReAtOTbAJA3y0zIZos0CyNt
 gM2Zo5kevM8l9CkWsBU88mZzskgjuO02MsjXu8MA6CgJOPvdax+NPVlib3ZX9hVPs8j4qAsVD
 M6w987t8L4+17ECIexEWIrRrtdJ8cAA7NvEJ201sM7faZ+VkZ+8QloGmj4jRCYj6QRMslffcI
 GfXp1DEUs+mfkZ2QT8PCfORkJTZvNvUWuUVWazE8N+YSK8t7aKLrq5bjYeAB1j1ZzJ7VkiH1D
 f+IEszEdJMMuRZYOMPrGV2NWVU+BFFJi0f8qg9GSlYTKEILMlNmVs932F3d4gJ24Vgvk4S2iI
 wISMmt2bz87uVEIZKgUCE19VA9QMAG7uQNUpi4bywERe2kqubghIQSMXBzCnP35a+5UgQgdGM
 SnqVOXGZTeBNldMqiQSWRYcmYlAhi1icivNYN/BmTDBsNz8yQMgJXyT+gyl9JmfK7dFmG13D5
 vEjV7T1Z70sPPZOySMfDvxm4R/p5l0vQxpy9NIsux4rUylT50rAAC6wjPegoyGaPS4ORgnTPa
 +BdjwTWxlsyi/mzDtyf4T4KiwRJRL6fI1vbT4w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

IMO this info is only useful for developers. Most users won't need this
information, since there is not much they can do about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
(cherry picked from commit 4ec96b4cbde8d5714a4477b5a2562c3dd40bc5fa)
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index a31789be0840..adc3291e9d6a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -508,7 +508,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 			card->ext_csd.raw_bkops_status =
 				ext_csd[EXT_CSD_BKOPS_STATUS];
 			if (!card->ext_csd.man_bkops_en)
-				pr_info("%s: MAN_BKOPS_EN bit is not set\n",
+				pr_debug("%s: MAN_BKOPS_EN bit is not set\n",
 					mmc_hostname(card->host));
 		}
 
-- 
2.20.0

