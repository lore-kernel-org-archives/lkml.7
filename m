Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADB4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BF3021019
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688599;
	bh=DFKWDZiZpGQR4fxL5deNM7MyjhKDQlxssh38Lhc/UPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GE+2rJdpgWvX1uQDgEdmIjWOOLOOlfmjYjNBUPPyFw5cEF9q3f2o8trzVavWgA1Bl
	 oScoTnSyBkYtZcOcagOpufqxykYu1tdqtQn/1ctDNlOKfb/OSmd3e9Hy0BLJ9nXdJl
	 1xv4PalghlrnFdU3To+zKOfPdSUrWjIvnczpTfjE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfCDIgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:36:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbfCDIgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:36:31 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78B6F2146E;
        Mon,  4 Mar 2019 08:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688591;
        bh=DFKWDZiZpGQR4fxL5deNM7MyjhKDQlxssh38Lhc/UPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MKGOzDpGiTdpKUlrgvwm4LTTTFfT7E4dZv4QQsoVCzpYdjdyC1CPCd7dLWgwWNOXM
         F61ym2tVlK2QQib50ph6dCUnuwjsqDHeAgGVWYXGftJnUAMUryfRQeoByGClP5vodh
         lgy9+/mglmJcOVJuXxWxjNguhJKJ+Eqehnbyraw4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 57/88] drm/msm: avoid unused function warning
Date:   Mon,  4 Mar 2019 09:22:40 +0100
Message-Id: <20190304081632.793815392@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a840f690d3c6f2f27425ca7e7bd2d635cdec07d7 ]

drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:368:13: error: 'dpu_plane_danger_signal_ctrl' defined but not used [-Werror=unused-function]

Fixes: 7b2e7adea732 ("drm/msm/dpu: Make dpu_plane_danger_signal_ctrl void")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
index f549daf30fe6d..1d155a7cb08c3 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c
@@ -365,19 +365,6 @@ static void _dpu_plane_set_qos_ctrl(struct drm_plane *plane,
 			&pdpu->pipe_qos_cfg);
 }
 
-static void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
-{
-	struct dpu_plane *pdpu = to_dpu_plane(plane);
-	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
-
-	if (!pdpu->is_rt_pipe)
-		return;
-
-	pm_runtime_get_sync(&dpu_kms->pdev->dev);
-	_dpu_plane_set_qos_ctrl(plane, enable, DPU_PLANE_QOS_PANIC_CTRL);
-	pm_runtime_put_sync(&dpu_kms->pdev->dev);
-}
-
 /**
  * _dpu_plane_set_ot_limit - set OT limit for the given plane
  * @plane:		Pointer to drm plane
@@ -1271,6 +1258,19 @@ static void dpu_plane_reset(struct drm_plane *plane)
 }
 
 #ifdef CONFIG_DEBUG_FS
+static void dpu_plane_danger_signal_ctrl(struct drm_plane *plane, bool enable)
+{
+	struct dpu_plane *pdpu = to_dpu_plane(plane);
+	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
+
+	if (!pdpu->is_rt_pipe)
+		return;
+
+	pm_runtime_get_sync(&dpu_kms->pdev->dev);
+	_dpu_plane_set_qos_ctrl(plane, enable, DPU_PLANE_QOS_PANIC_CTRL);
+	pm_runtime_put_sync(&dpu_kms->pdev->dev);
+}
+
 static ssize_t _dpu_plane_danger_read(struct file *file,
 			char __user *buff, size_t count, loff_t *ppos)
 {
-- 
2.19.1



