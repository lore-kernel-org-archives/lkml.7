Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA31CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:37:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553F620656
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbfJUOg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:36:56 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:7201 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729093AbfJUOgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:36:55 -0400
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Oct 2019 20:00:44 +0530
IronPort-SDR: zrqY6U8uaxAGnilZKL3X1+tzMf/ZVbuSH4VCq+yr8hz8lOlLK1osE9z11j5dvhdRv069y9wOlw
 TZT+HQWyLZBqd5UuLtLa2zUO57yOEj3qhAbFgz/D15vamOBhQiqrYAuDA0vSIxGY2+pR6Jweom
 RXTUuVEflCejBKPoVU+XLLf17daefWYIW4i/fisY2OdlTNbtuMCn8gENs6BoGYzXjUUCxfKwL6
 QJtYbOW2khR+32sSK96gUZfgdqodvrFkM/NPUNm1NAUTcadYU6DvVsbdVhQ2+FtxMYwq2sjWdj
 JEEvTYg0e5jzfwhPU7TdcC+S
Received: from rampraka-linux.qualcomm.com ([10.206.25.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 21 Oct 2019 20:00:44 +0530
Received: by rampraka-linux.qualcomm.com (Postfix, from userid 2305851)
        id E357B35FA; Mon, 21 Oct 2019 20:00:42 +0530 (IST)
From:   Ram Prakash Gupta <rampraka@codeaurora.org>
To:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        sayalil@codeaurora.org, rampraka@codeaurora.org,
        vbadigan@codeaurora.org, cang@codeaurora.org, ppvk@codeaurora.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Sujit Reddy Thumma <sthumma@codeaurora.org>,
        Talel Shenhar <tatias@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        "Bao D. Nguyen" <nguyenb@codeaurora.org>
Subject: [RFC 5/6] mmc: sdhci-msm: Add capability in platform host
Date:   Mon, 21 Oct 2019 19:59:36 +0530
Message-Id: <1571668177-3766-6-git-send-email-rampraka@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
Signed-off-by: Talel Shenhar <tatias@codeaurora.org>
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Can Guo <cang@codeaurora.org>
Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
Co-Developed-by: Ram Prakash Gupta <rampraka@codeaurora.org>
Signed-off-by: Ram Prakash Gupta <rampraka@codeaurora.org>
---
 drivers/mmc/host/sdhci-msm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index b75c82d..67accf6 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -1934,6 +1934,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	msm_host->mmc->caps2 |= MMC_CAP2_CLK_SCALE;
+
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
1.9.1

