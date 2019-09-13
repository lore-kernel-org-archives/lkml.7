Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F1C4CEC5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 367D720717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381555;
	bh=Dg5xxp6XDyUNhywFnjd4CywNXen2+N6sfss7jCc7eNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ddQAz2lWKMEt9z3WeZK2SwJ8oHxaFnrc7CJ12Tb5mqGiv62IBHHMf7xb1K7IBSlMG
	 yz57/GYP/QXsenqbYeDB33wI1O+Y5dnyw8MCttGAmacJ3yNOzBbWTxbMFGunltLba0
	 6FKEnN2AeNBw6flfFMa/M7YlOBPXTyozeG4zbFRU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389207AbfIMNMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388580AbfIMNMk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:40 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1220D214AE;
        Fri, 13 Sep 2019 13:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380359;
        bh=Dg5xxp6XDyUNhywFnjd4CywNXen2+N6sfss7jCc7eNE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hFQgKMwQnaAij0Y6GDdV15fHXdaR3zbKmLXxlO8d1kEXUz8g9E0g32PAD6bBdF8Pt
         isldhcLiJlAmK5ToMbzLBePuwFVeEaxSK+8mr7/5mRjNdA1EwB3qjG7XpzF3eLFGKl
         Tggwl+cuPb4eqy4bYWMrs0xtyKB7TbnjicvjE4lg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feifei Xu <Feifei.Xu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 039/190] drm/amdgpu: Update gc_9_0 golden settings.
Date:   Fri, 13 Sep 2019 14:04:54 +0100
Message-Id: <20190913130602.842018619@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913130559.669563815@linuxfoundation.org>
References: <20190913130559.669563815@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c55045adf7210d246a016c961916f078ed31a951 ]

Add mmDB_DEBUG3 settings.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index f040ec10eecf6..7824116498169 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -83,6 +83,7 @@ MODULE_FIRMWARE("amdgpu/raven_rlc.bin");
 static const struct soc15_reg_golden golden_settings_gc_9_0[] =
 {
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xf00fffff, 0x00000400),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG3, 0x80000000, 0x80000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_GPU_ID, 0x0000000f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3, 0x00000003, 0x82400024),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x3fffffff, 0x00000001),
-- 
2.20.1



