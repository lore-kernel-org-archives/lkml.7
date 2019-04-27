Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E6DC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5ED20873
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 01:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556329181;
	bh=SiNG6+PoDJ3qhMYdDsp7ShNq7iRhdmgc4nm+1Yu9oLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I4OaMCGnezp9lTafT3LoSbCdn4nkxtDwMbIZ3eGtwBVbp+nwppXknKW//iVG4BVIE
	 vfY/lwqVre6Px/Y+EG3KoX5pyvFowboPyRIBZFdp4/TvWTCqqEfKuMvSguGfYi2EJb
	 AY0tB8LCnqlKzv5ZdBKvZ9dNBMNNgtRQhJ5T68I4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbfD0Bjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 21:39:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:42800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727676AbfD0Bjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 21:39:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EA8321537;
        Sat, 27 Apr 2019 01:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556329176;
        bh=SiNG6+PoDJ3qhMYdDsp7ShNq7iRhdmgc4nm+1Yu9oLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKiUrCt3uMTim/IDiFgAzwODNxiIXsCG//auLdPVjpkaJrrlN8xOeGbPd9QKr9r5l
         WJrvp7PuNAWMvK/ZVof0LFa2YaCHI8Fs7RJiQ9TB6nTGwCDmIUKqhVHrIGl1EDq3qT
         JhvekCm78QJuSkgRoVU5N8GVvzoM59mNwjHS43ow=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.0 38/79] drm/amdkfd: Add picasso pci id
Date:   Fri, 26 Apr 2019 21:37:57 -0400
Message-Id: <20190427013838.6596-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit e7ad88553aa1d48e950ca9a4934d246c1bee4be4 ]

Picasso is a new raven variant.

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 8be9677c0c07..cf9a49f49d3a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -320,6 +320,7 @@ static const struct kfd_deviceid supported_devices[] = {
 	{ 0x9876, &carrizo_device_info },	/* Carrizo */
 	{ 0x9877, &carrizo_device_info },	/* Carrizo */
 	{ 0x15DD, &raven_device_info },		/* Raven */
+	{ 0x15D8, &raven_device_info },		/* Raven */
 #endif
 	{ 0x67A0, &hawaii_device_info },	/* Hawaii */
 	{ 0x67A1, &hawaii_device_info },	/* Hawaii */
-- 
2.19.1

