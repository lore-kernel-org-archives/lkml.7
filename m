Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7567C3A5A2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76DEF2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179535;
	bh=Das1zxPJh8NGGhzUtOWS3C9EoRTDQpOlYXIBY9sFkxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bvB5kZF/PQqklHcWwVJgptiTBf5egNQa7D1QanlVXEBgzg4f+ZBPsbezGOm9ROEoM
	 sF5+TF1uEQ0ekLY0589JJRHMYsoBadTBXHP0z6yvhR7YO3wCu+B2fsPmXrE+vVgf1O
	 6o9q7+nOn6+6fwLFarEtxkLJouPM1qgER0uceYn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438740AbfIVS6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438655AbfIVS5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:57:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D506621D6C;
        Sun, 22 Sep 2019 18:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178667;
        bh=Das1zxPJh8NGGhzUtOWS3C9EoRTDQpOlYXIBY9sFkxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HT9GqTwigXcdvPG36cGu2l3yCDQ6DIB6VAEl66J6pNRJHbWCaOown7D2JtOlAUOLZ
         2NUmQ5BjLQEzEapJnnfApsS56K/iFacu7uJwFEJd+sFBpcZEPINp27YpcEcGD+viQr
         6qBLmDmhWjyh9CaPXis9ITHnDUgcz0K7u6nN5duE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 19/89] base: soc: Export soc_device_register/unregister APIs
Date:   Sun, 22 Sep 2019 14:56:07 -0400
Message-Id: <20190922185717.3412-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185717.3412-1-sashal@kernel.org>
References: <20190922185717.3412-1-sashal@kernel.org>
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
index 909dedae4c4e1..1242b2d2e01a2 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -155,6 +155,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -164,6 +165,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 	device_unregister(&soc_dev->dev);
 	early_soc_dev_attr = NULL;
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.20.1

