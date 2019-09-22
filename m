Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E273AC3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0CFA206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569178890;
	bh=nr9hoKbScMqg1mc7m9e/Fq+wOO542/kklUkiHIoAWZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9VFDL7ZvuhD8fVUKQVYGFU0pKrxM69qgOlQRjk+ldKpDYydgDEqASN43YEc67XCs
	 pGhlx+poK6yksmt0WhrTNKczlRkh+zD7vxDvK2G9nVPBuO0HBIH9vvqNSFklsrbr6A
	 uCZ+Aw85q30aGvNHuWRT0Eo0KxZ0ssPb88JGVXIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbfIVTB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:01:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438522AbfIVTBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 15:01:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D474206C2;
        Sun, 22 Sep 2019 19:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178883;
        bh=nr9hoKbScMqg1mc7m9e/Fq+wOO542/kklUkiHIoAWZw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2lE/3N+wz2cmaUGti4+p9/Y/r4R+zJ4yg309QmqHIsTMcB3XDPGUISfDBUCEAjSFL
         wywEF4zwWj5Sbbwk6RTDPRLKMxl4IX9v0awR7Owwdo9WNvAGYW6SHUDlh3pG6NVo++
         EKs9zqeMRxd9CG5rLAWWZSyWJ2KPnd7BUriQ6pcM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/44] base: soc: Export soc_device_register/unregister APIs
Date:   Sun, 22 Sep 2019 15:00:32 -0400
Message-Id: <20190922190103.4906-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922190103.4906-1-sashal@kernel.org>
References: <20190922190103.4906-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

[ Upstream commit f7ccc7a397cf2ef64aebb2f726970b93203858d2 ]

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Tested-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 75b98aad6fafd..84242e6b2897f 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -146,6 +146,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -154,6 +155,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 
 	device_unregister(&soc_dev->dev);
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.20.1

