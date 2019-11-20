Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DB1C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 918F722524
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256808;
	bh=crDJnPjOlOMnMpToasc/QNgCCxnojz7Gt+oJifbABfA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Q1PPVdV/aORNKD2eiGrDfozSA4+az2JEyK3GsmI9GH6P9ugIwonpp4ONzoZHD9ywV
	 H1ApuCAgWl4mBkrpw9GGNtes1S2uMOaL2RFbiPV1R7Y+pAjE4KlFLzjx9dXnKPGVWk
	 MVfWAscvlfKNCUMUGvvDt33fEJzsM21qVoeVjsFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfKTNd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:33:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfKTNd1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:33:27 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB73C22521;
        Wed, 20 Nov 2019 13:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256806;
        bh=crDJnPjOlOMnMpToasc/QNgCCxnojz7Gt+oJifbABfA=;
        h=From:To:Cc:Subject:Date:From;
        b=IFtJmZwVGAu+M1OiaNeJ8nii6218nM+iENEqrLh3wAGGxJJgDi4onqPhYQP15NAQJ
         RdSR3FehinLGwknGIHrJ7zgUL20ZJB8KqINs4tX7tlmfkFq/qOs2CyylENRqIInqDS
         ylBgk5+xHCkbooit8zRWuURusc9DeFUUI4wBNo+g=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: qcom: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:33:07 +0800
Message-Id: <20191120133307.6421-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/interconnect/qcom/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index c49afbea3458..b6735f11438c 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -11,8 +11,8 @@ config INTERCONNECT_QCOM_MSM8974
        depends on QCOM_SMD_RPM
        select INTERCONNECT_QCOM_SMD_RPM
        help
-         This is a driver for the Qualcomm Network-on-Chip on msm8974-based
-         platforms.
+	 This is a driver for the Qualcomm Network-on-Chip on msm8974-based
+	 platforms.
 
 config INTERCONNECT_QCOM_QCS404
 	tristate "Qualcomm QCS404 interconnect driver"
-- 
2.17.1

