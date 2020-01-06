Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD704C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A95207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="I4w6IiIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgAFOaH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 09:30:07 -0500
Received: from www413.your-server.de ([88.198.28.140]:34446 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgAFOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 09:30:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=aaBtVC0Us40ssWYB7DAu2B2iqmVHPNCqv0s44Q63vmQ=; b=I4w6IiIcmzrgMGYcIMABjQ+XpE
        VVyVo3oHrAkyznUnIRjWilfGVgL22Ry/4t3ePzDBLcIvh7ANHg+nwBscd3nO+eVY1z7CkBOJoF3d3
        GNqY5EOqHX/R9B9qamydg2oCNxQfl9SxXYluvZwNF4idHvlOxGl3jREllRmprePrKNQPTsDsQ0T4/
        dycGyFeJxJD3jzDTJHLna2tel82t/g6EZ1TkSAAE7D0WXEvV85A0NMjwVnbLZSEKXbnBmvavhCOmC
        +3/SgXzQD9i5a+GBtAS4igZnadWbRhwvzuCeI3imT982dsOE9nX2JfGf1Z9RFGg93GNckBpUEvCdL
        UTQoOoqQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ioT1k-0008I1-Je; Mon, 06 Jan 2020 15:06:40 +0100
Received: from [188.25.180.214] (helo=192-168-0-109.rdsnet.ro)
        by sslproxy06.your-server.de with esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.89)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1ioT1k-0000mX-AJ; Mon, 06 Jan 2020 15:06:40 +0100
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     intel-gvt-dev@lists.freedesktop.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Julian Stecklina <julian.stecklina@cyberus-technology.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>, zhiyuan.lv@intel.com,
        hang.yuan@intel.com
Subject: [PATCH 3/3] drm/i915/gvt: remove unused vblank_done completion
Date:   Mon,  6 Jan 2020 16:06:22 +0200
Message-Id: <20200106140622.14393-3-julian.stecklina@cyberus-technology.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
References: <20200106140622.14393-1-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.101.4/25686/Mon Jan  6 10:55:07 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable is used nowhere, so remove it.

Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: zhiyuan.lv@intel.com
Cc: hang.yuan@intel.com

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

