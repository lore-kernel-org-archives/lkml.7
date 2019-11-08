Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B0FC6194
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B740D222C5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 11:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573213516;
	bh=dkRw0NLgbZfCKxHUgfLgac8iE4OQLyV4NXNb7ARPpdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fuFr07WXOydgo/YMvh2EqTdByU0tN1Gh50KsZd5Xc4I3KQWfq55isXl7FBB1bL5jc
	 /s/77gflwLbz7GvkW8qcEdZo8VPfa4yv0MFsyaO1Wb8I4iTnN42YWeXg5OcCtCOaNP
	 5bwqcS27FHnQ80tSYklJjE2J3wsmL6SCaQTsK60I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391065AbfKHLpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 06:45:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:60320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391036AbfKHLpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 06:45:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C027822459;
        Fri,  8 Nov 2019 11:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573213508;
        bh=dkRw0NLgbZfCKxHUgfLgac8iE4OQLyV4NXNb7ARPpdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KDvqE5xyLWGylC4bxHy1qSRHksMQVuZAoV5xjHE03ur+0UoquFJb6eLk7XBv72j2L
         22gQGdmtBTk5uWLWIV6opCtfJsyiXFS5c4ecfmYCOy7sgTLPsTOa6vji8YqFfKk7Xw
         JR9vBVKKiD0uouklvmUUyDJirafsAt0yVil7btnQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>, Da Xue <da@lessconfused.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 082/103] arm64: dts: meson: libretech: update board model
Date:   Fri,  8 Nov 2019 06:42:47 -0500
Message-Id: <20191108114310.14363-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108114310.14363-1-sashal@kernel.org>
References: <20191108114310.14363-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit b7eb0e26cc4a212fde09144cd49d4103170d2b9e ]

There is actually several different libretech board with the CC suffix
so the model name is not appropriate here. Update to something more
specific

Reported-by: Da Xue <da@lessconfused.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index d71cbf596d1f7..0814b6b29b86a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -14,7 +14,7 @@
 
 / {
 	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
-	model = "Libre Technology CC";
+	model = "Libre Computer Board AML-S905X-CC";
 
 	aliases {
 		serial0 = &uart_AO;
-- 
2.20.1

