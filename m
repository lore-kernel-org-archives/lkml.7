Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13414C2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE82321D7D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576852205;
	bh=/I6+Hsqr6v9xI0xByVoqUjWM2QPpF2hzrFHfe/Pa7ms=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DJEndBkUW86erTLw/j+oPpzsR4vK8u/+ay2+6W0KQaUx10uNtz7ncZ6MIIIJzHpie
	 exzpoXRIwvLYZe4bTJshLRP5pflSfYPjnsDfnF2BKSVeGOxu/tenoo2G9NJa2Eqayi
	 7bZm53SWMh6hos3jfSKnmbzNxsAopWU9KRT6JQss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLTOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:30:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:33264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727483AbfLTOaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791ED206CB;
        Fri, 20 Dec 2019 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576852202;
        bh=/I6+Hsqr6v9xI0xByVoqUjWM2QPpF2hzrFHfe/Pa7ms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zaNIOimS40/0b8fBRbFZibo7n0Lc+K5zrmRf6JieodJVpatnnb6QOkYBUmwl3se/l
         /zxtQmPcFArVEYFOUfD+cC2fDle1F3dLVAYKxV/JSn6Hl9et92H3OBg6nUH40M9MaF
         AGEqiC8ZP3syb4pz31RnFcvyULDvk/9vAFy7tFD0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Evan Quan <evan.quan@amd.com>, Sasha Levin <sashal@kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 05/52] drm/amdgpu: add header line for power profile on Arcturus
Date:   Fri, 20 Dec 2019 09:29:07 -0500
Message-Id: <20191220142954.9500-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220142954.9500-1-sashal@kernel.org>
References: <20191220142954.9500-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit 14891c316ca7e15d81dba78f30fb630e3f9ee2c9 ]

So the output is consistent with other asics.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d493a3f8c07a6..b68bf8dcfa783 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1388,12 +1388,17 @@ static int arcturus_get_power_profile_mode(struct smu_context *smu,
 					"VR",
 					"COMPUTE",
 					"CUSTOM"};
+	static const char *title[] = {
+			"PROFILE_INDEX(NAME)"};
 	uint32_t i, size = 0;
 	int16_t workload_type = 0;
 
 	if (!smu->pm_enabled || !buf)
 		return -EINVAL;
 
+	size += sprintf(buf + size, "%16s\n",
+			title[0]);
+
 	for (i = 0; i <= PP_SMC_POWER_PROFILE_CUSTOM; i++) {
 		/*
 		 * Conv PP_SMC_POWER_PROFILE* to WORKLOAD_PPLIB_*_BIT
-- 
2.20.1

