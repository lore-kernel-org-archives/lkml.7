Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B91C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258A22133D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfFGLbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:31:22 -0400
Received: from laurent.telenet-ops.be ([195.130.137.89]:52686 "EHLO
        laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfFGLbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:31:22 -0400
Received: from ramsan ([84.194.111.163])
        by laurent.telenet-ops.be with bizsmtp
        id MnXK2000E3XaVaC01nXKXn; Fri, 07 Jun 2019 13:31:20 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD5b-0004FW-EB; Fri, 07 Jun 2019 13:31:19 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1hZD5b-0003ow-CU; Fri, 07 Jun 2019 13:31:19 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jiri Kosina <trivial@kernel.org>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH trivial] drm/i915: Grammar s/the its/its/
Date:   Fri,  7 Jun 2019 13:31:18 +0200
Message-Id: <20190607113118.14645-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/i915/intel_dpll_mgr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_dpll_mgr.h b/drivers/gpu/drm/i915/intel_dpll_mgr.h
index 8835dd20f1d27e05..79a53c5439a8e6db 100644
--- a/drivers/gpu/drm/i915/intel_dpll_mgr.h
+++ b/drivers/gpu/drm/i915/intel_dpll_mgr.h
@@ -293,7 +293,7 @@ struct intel_shared_dpll {
 	/**
 	 * @state:
 	 *
-	 * Store the state for the pll, including the its hw state
+	 * Store the state for the pll, including its hw state
 	 * and CRTCs using it.
 	 */
 	struct intel_shared_dpll_state state;
-- 
2.17.1

