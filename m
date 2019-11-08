Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8B8C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 449CE20656
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573215248;
	bh=OqJpgqnNucTIjc1sie5sJ+o2au5E86wgHQZUsNmr+LU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aI+mSbIXg6GvfeqAZfH3ZE3tdeVAPz9QhnQ/TbI3h+h8jbyMACU6JH76nGtdhebNm
	 RPZW6G4LLkA+SoIZ5zp4JcsQr3BmFchyrEqUzvESUu2rW/qWfzLX8GWANVuYXt7dtV
	 tjLgW6LtvfYRARBYiZJleq5xNI/cOnVMYtn2L/WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390968AbfKHMOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:14:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732332AbfKHLiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:38:15 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E1D20869;
        Fri,  8 Nov 2019 11:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213094;
        bh=OqJpgqnNucTIjc1sie5sJ+o2au5E86wgHQZUsNmr+LU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xPaEt1KmPrV/x/pY3wv3nG5u7lpcf9qyrWgvM1uRk+nWN/LJk+5IoVOVTedpOFqsH
         loHMPloEmm4s148EJHToNj4mIgcE0CSVQhqHSRcpX3wRK9FSZgJxWiktdhlCc1EhJ1
         Upz4SuBxIN6f2idjurMBZjL5XIMLHrlK+Kg0Cua8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 019/205] remoteproc/davinci: Use %zx for formating size_t
Date:   Fri,  8 Nov 2019 06:34:46 -0500
Message-Id: <20191108113752.12502-19-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108113752.12502-1-sashal@kernel.org>
References: <20191108113752.12502-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Andersson <bjorn.andersson@linaro.org>

[ Upstream commit 1e28dbbeced6152b9ea7c417ff8cef3f7dcf0f19 ]

da8xx_rproc_mem size is of type size_t, so use %zx to format the debug
print of it to avoid a compile warning.

Acked-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/da8xx_remoteproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index e230bef71be1c..d200334577f68 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -226,7 +226,7 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
 				res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
 		drproc->mem[i].size = resource_size(res);
 
-		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
+		dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %p da 0x%x\n",
 			mem_names[i], &drproc->mem[i].bus_addr,
 			drproc->mem[i].size, drproc->mem[i].cpu_addr,
 			drproc->mem[i].dev_addr);
-- 
2.20.1

