Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31681C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01C31205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576013072;
	bh=dC6fjqGh654ZZLwYjdy87ftZ5dG/h1Xx9eEY+r9Uk6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/1rx6KnMTCaFNgx3DCLvM1h93eUIFDJzNm3sOpV9ONoCguA+jV/Qw7dJ/I8LNgN1
	 T66pkDvjg8dF1jMPkZ3wCzDgN8tsUTROE0c21zEVJBax7PFbH28PE07B8/C0VzuDjC
	 65FyHMeL947pMHBWM+iVzrRpECPN2kHYBPvwjVzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfLJVYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:24:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:32886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbfLJVKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:10:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22B3E246AF;
        Tue, 10 Dec 2019 21:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012251;
        bh=dC6fjqGh654ZZLwYjdy87ftZ5dG/h1Xx9eEY+r9Uk6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1CmsVIdVGPBbLbliVtnUKOlLgY6ihmRnVqACPBbdMKv9P7yKDxieqet1UZ0tHniLU
         SU+w8iLDYxIyWrv63iKU+VasR0zrBfD1ceyHSVCrTG1+MHYMvfV5nW+aJKNzVimm3I
         yip71i/qS9alvx1+OrqDgxZgmKddLo8hwDLeYlrY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 198/350] pinctrl: qcom: sc7180: Add missing tile info in SDC_QDSD_PINGROUP/UFS_RESET
Date:   Tue, 10 Dec 2019 16:05:03 -0500
Message-Id: <20191210210735.9077-159-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajendra Nayak <rnayak@codeaurora.org>

[ Upstream commit 81898a44f288607cb3b11a42aed6efb646891c19 ]

The SDC_QDSD_PINGROUP/UFS_RESET macros are missing the .tile info needed to
calculate the right register offsets. Adding them here and also
adjusting the offsets accordingly.

Fixes: f2ae04c45b1a ("pinctrl: qcom: Add SC7180 pinctrl driver")

Reported-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
Link: https://lore.kernel.org/r/20191021141507.24066-1-rnayak@codeaurora.org
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/qcom/pinctrl-sc7180.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-sc7180.c b/drivers/pinctrl/qcom/pinctrl-sc7180.c
index 6399c8a2bc22c..d6cfad7417b1c 100644
--- a/drivers/pinctrl/qcom/pinctrl-sc7180.c
+++ b/drivers/pinctrl/qcom/pinctrl-sc7180.c
@@ -77,6 +77,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
+		.tile = SOUTH,				\
 		.mux_bit = -1,				\
 		.pull_bit = pull,			\
 		.drv_bit = drv,				\
@@ -102,6 +103,7 @@ enum {
 		.intr_cfg_reg = 0,			\
 		.intr_status_reg = 0,			\
 		.intr_target_reg = 0,			\
+		.tile = SOUTH,				\
 		.mux_bit = -1,				\
 		.pull_bit = 3,				\
 		.drv_bit = 0,				\
@@ -1087,14 +1089,14 @@ static const struct msm_pingroup sc7180_groups[] = {
 	[116] = PINGROUP(116, WEST, qup04, qup04, _, _, _, _, _, _, _),
 	[117] = PINGROUP(117, WEST, dp_hot, _, _, _, _, _, _, _, _),
 	[118] = PINGROUP(118, WEST, _, _, _, _, _, _, _, _, _),
-	[119] = UFS_RESET(ufs_reset, 0x97f000),
-	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x97a000, 15, 0),
-	[121] = SDC_QDSD_PINGROUP(sdc1_clk, 0x97a000, 13, 6),
-	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x97a000, 11, 3),
-	[123] = SDC_QDSD_PINGROUP(sdc1_data, 0x97a000, 9, 0),
-	[124] = SDC_QDSD_PINGROUP(sdc2_clk, 0x97b000, 14, 6),
-	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x97b000, 11, 3),
-	[126] = SDC_QDSD_PINGROUP(sdc2_data, 0x97b000, 9, 0),
+	[119] = UFS_RESET(ufs_reset, 0x7f000),
+	[120] = SDC_QDSD_PINGROUP(sdc1_rclk, 0x7a000, 15, 0),
+	[121] = SDC_QDSD_PINGROUP(sdc1_clk, 0x7a000, 13, 6),
+	[122] = SDC_QDSD_PINGROUP(sdc1_cmd, 0x7a000, 11, 3),
+	[123] = SDC_QDSD_PINGROUP(sdc1_data, 0x7a000, 9, 0),
+	[124] = SDC_QDSD_PINGROUP(sdc2_clk, 0x7b000, 14, 6),
+	[125] = SDC_QDSD_PINGROUP(sdc2_cmd, 0x7b000, 11, 3),
+	[126] = SDC_QDSD_PINGROUP(sdc2_data, 0x7b000, 9, 0),
 };
 
 static const struct msm_pinctrl_soc_data sc7180_pinctrl = {
-- 
2.20.1

