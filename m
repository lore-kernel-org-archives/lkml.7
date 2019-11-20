Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D517CC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC79422529
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257344;
	bh=+eCAHDWvaNuOH0t5py/dwIIAgOEWzjEuW1S3XNVtgTo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G3+DaVwDQ4+D4PfgjbyWyXMA9PJqhxVNs3ppRF0Ckrihe8nd2Q3q3yqH9VMTNIgiq
	 gMsNC4XOH8cJd6NZjOfzhSsU+524e/SPhZQ1kWc0HM+UYk1qq2OB6i+7GVldWXE/29
	 pzWAiMJLtgrpof03HbG8D90o7J2JfRIXOREXrSVc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731406AbfKTNmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:42:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:50098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730507AbfKTNmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:42:21 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5DE224FA;
        Wed, 20 Nov 2019 13:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257340;
        bh=+eCAHDWvaNuOH0t5py/dwIIAgOEWzjEuW1S3XNVtgTo=;
        h=From:To:Cc:Subject:Date:From;
        b=wLfaioBxhp59D+I7bod/1U5No5ftRjkZLfniIM9UVv7TlwYDaQOONXkLXRzMnSrfM
         42vf4ZjcwgwPnM2iI9xsLqyc0F346XPqH2GY+AqYLl2IJFf1bIDtEZrRr2XdbA9ku5
         7Ifn5Ycp0T5mrfbaq/4bj61Joi6rfV0LwlP6iGgE=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org
Subject: [PATCH] devfreq: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:42:16 +0800
Message-Id: <20191120134216.15713-1-krzk@kernel.org>
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
 drivers/devfreq/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 066e6c4efaa2..59027d7ddf2a 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -119,9 +119,9 @@ config ARM_RK3399_DMC_DEVFREQ
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	select PM_DEVFREQ_EVENT
 	help
-          This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
-          It sets the frequency for the memory controller and reads the usage counts
-          from hardware.
+	  This adds the DEVFREQ driver for the RK3399 DMC(Dynamic Memory Controller).
+	  It sets the frequency for the memory controller and reads the usage counts
+	  from hardware.
 
 source "drivers/devfreq/event/Kconfig"
 
-- 
2.17.1

