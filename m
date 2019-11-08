Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB6EFC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E61BD2245A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213423;
	bh=bQI38G0uBLoRUHG1bRD67xPvAwdXeHP+L7g8f44DKqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E7t288Dv+jKrOtNLpyNQWbtjmlIZU2KMuYNXAs3MFCDOOxt+rvZTQE5Bh4FQGBU7s
	 rKrgsGJlrIJ7xesvs2RczDbu8b7DwyZUcZjyO8pn4xHcN2ouv9elH4Q/gWmC8CWPOI
	 WLnKzEm5+lJ6JXKUrdHUIBo+CapicmhfQMleH0Ls=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388723AbfKHLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:57886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390443AbfKHLn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:43:26 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AE3521D82;
        Fri,  8 Nov 2019 11:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213405;
        bh=bQI38G0uBLoRUHG1bRD67xPvAwdXeHP+L7g8f44DKqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YNgNNCs1+QseJn0New/+fTmRHCAQUudt/09UPrueUjdgzKXz6ItLeJbpXxIT7yY2U
         swSvZVU/CU2Qrv3JEDzVZhCuELXtvuV62RZrKb5I2XDN0pifjLNv3GQEoOPFqUgBRh
         stoYTTCu1dWqolUhf99J/2LdMdgBx1ut15CHjEDU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <sashal@kernel.org>, linux-rtc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 010/103] rtc: rv8803: fix the rv8803 id in the OF table
Date:   Fri,  8 Nov 2019 06:41:35 -0500
Message-Id: <20191108114310.14363-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit c856618d20662695fcdb47bf4d560dc457662aec ]

The ID for RV8803 must be rv_8803

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-rv8803.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rv8803.c b/drivers/rtc/rtc-rv8803.c
index aae2576741a61..6e06fb3b0b928 100644
--- a/drivers/rtc/rtc-rv8803.c
+++ b/drivers/rtc/rtc-rv8803.c
@@ -622,7 +622,7 @@ MODULE_DEVICE_TABLE(i2c, rv8803_id);
 static const struct of_device_id rv8803_of_match[] = {
 	{
 		.compatible = "microcrystal,rv8803",
-		.data = (void *)rx_8900
+		.data = (void *)rv_8803
 	},
 	{
 		.compatible = "epson,rx8900",
-- 
2.20.1

