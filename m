Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D57C4CEC7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A8A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 13:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568381558;
	bh=tlurUDQpLrxIRuvo7CF7EwGJyLs1m4wtRyGj3x1MzW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YKMkfsZ3+q5DDXxDcRepaUoUOFN1G4CC9BCB1PtTgU/B1mawy4BRyY/vbVDZeJJXe
	 kgwHXGbFRR3eLqUs7lEg7hddfQZdvIvp3KaUWiQtTvx1bLgfUseRaitNCr52ZrFwLJ
	 0MnXi6I1haCrqb8I4V9wyzwtJ5B86Gheutp+HS/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbfIMNMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 09:12:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389181AbfIMNMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 09:12:37 -0400
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14729214AE;
        Fri, 13 Sep 2019 13:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568380356;
        bh=tlurUDQpLrxIRuvo7CF7EwGJyLs1m4wtRyGj3x1MzW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5VuzAhpf/8lk0GQIGm0WTvZOgBJjJc5eo1APzyI5BYLuyDvtx4LY9Vo9UTGYJkNg
         iIUy1kcoLUeOgEMtIw/wSnj4DyR1gWOtqAg9R03lSPmIZtSb8g1XckQafFQDhsQkr8
         W7vQwdqmTC0BNrE/G/Ah1h4zUtT/o0MTMDdePf0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Feifei Xu <Feifei.Xu@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/190] drm/amdgpu/gfx9: Update gfx9 golden settings.
Date:   Fri, 13 Sep 2019 14:04:53 +0100
Message-Id: <20190913130602.749716900@linuxfoundation.org>
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

[ Upstream commit 54d682d9a5b357eb711994fa94ef1bc44d7ce9d9 ]

Update the goldensettings for vega20.

Signed-off-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 46568497ef181..f040ec10eecf6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -82,7 +82,7 @@ MODULE_FIRMWARE("amdgpu/raven_rlc.bin");
 
 static const struct soc15_reg_golden golden_settings_gc_9_0[] =
 {
-	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xf00fffff, 0x00000420),
+	SOC15_REG_GOLDEN_VALUE(GC, 0, mmDB_DEBUG2, 0xf00fffff, 0x00000400),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmGB_GPU_ID, 0x0000000f, 0x00000000),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_BINNER_EVENT_CNTL_3, 0x00000003, 0x82400024),
 	SOC15_REG_GOLDEN_VALUE(GC, 0, mmPA_SC_ENHANCE, 0x3fffffff, 0x00000001),
-- 
2.20.1



