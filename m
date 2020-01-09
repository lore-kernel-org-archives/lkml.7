Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CEFC33CA1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5282067D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 17:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="Y8ZuYZsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388016AbgAIROR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:14:17 -0500
Received: from www413.your-server.de ([88.198.28.140]:39498 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388006AbgAIROP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 12:14:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jrus5T6YRl+VuSuoinRzHHZYCg8pYROoDWxPVaqqP8w=; b=Y8ZuYZsX/skFauk93PMEirHXag
        Oq5Kxk+zk2TuUbBuOIqoUMgyo0FKexeN8AvrLOXs89032gR3SMUUq4rACVlxHcpPowEZBHDUp6Kxe
        UbKcMd7h7TsEMiFhKMJX3Ak36T3KasoQufB/r+O/1PQv8MNSNnnPVyYE6az83SlwiIyWZCMWAy1m3
        w1hbRKy4XMnbNms0MukbK1b+/BMDkMDUq2flwwyFVLMhRL6m7wYiOyfWt0vmBvHvmW9KcQPW9V9O+
        9OMqbGPr4ED8IBUTGHlolVL7hffp5x8Y3WtHbRnFrr4RLZSg47MkmWOU7I73Gj0fbiII+DpJ6An6G
        F2mkvV7g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ipbNu-0002VI-1M; Thu, 09 Jan 2020 18:14:14 +0100
Received: from [24.134.37.229] (helo=192-168-0-109.rdsnet.ro)
        by sslproxy02.your-server.de with esmtpsa (TLSv1:ECDHE-RSA-AES256-SHA:256)
        (Exim 4.92)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ipbNt-000EJu-Qg; Thu, 09 Jan 2020 18:14:13 +0100
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: [RFC PATCH 2/4] drm/i915/gvt: remove unused vblank_done completion
Date:   Thu,  9 Jan 2020 19:13:55 +0200
Message-Id: <20200109171357.115936-3-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
 <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25689/Thu Jan  9 10:59:33 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is used nowhere, so remove it.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>

Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
---
 drivers/gpu/drm/i915/gvt/gvt.h   | 2 --
 drivers/gpu/drm/i915/gvt/kvmgt.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gvt.h
index 2604739e5680..8cf292a8d6bd 100644
--- a/drivers/gpu/drm/i915/gvt/gvt.h
+++ b/drivers/gpu/drm/i915/gvt/gvt.h
@@ -203,8 +203,6 @@ struct intel_vgpu {
 	struct mutex dmabuf_lock;
 	struct idr object_idr;
 
-	struct completion vblank_done;
-
 	u32 scan_nonprivbb;
 };
 
diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index d725a4fb94b9..9a435bc1a2f0 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1817,8 +1817,6 @@ static int kvmgt_guest_init(struct mdev_device *mdev)
 	kvmgt_protect_table_init(info);
 	gvt_cache_init(vgpu);
 
-	init_completion(&vgpu->vblank_done);
-
 	info->track_node.track_write = kvmgt_page_track_write;
 	info->track_node.track_flush_slot = kvmgt_page_track_flush_slot;
 	kvm_page_track_register_notifier(kvm, &info->track_node);
-- 
2.24.1

