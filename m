Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D52C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E4D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 14:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfDOO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 10:29:26 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45666 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfDOO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 10:29:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 69C9F2787E2
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Cc:     kernel@collabora.com, linux-pm@vger.kernel.org
Subject: [PATCH] power: supply: core: fix typo in function to get current charge control limit
Date:   Mon, 15 Apr 2019 16:29:18 +0200
Message-Id: <20190415142918.4383-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in ps_get_cur_charge_cntl_limit function so
replace 'chrage' for 'charge'.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/power/supply/power_supply_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c917a8b43b2b..ef2aecfe2cd2 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -899,7 +899,7 @@ static int ps_get_max_charge_cntl_limit(struct thermal_cooling_device *tcd,
 	return ret;
 }
 
-static int ps_get_cur_chrage_cntl_limit(struct thermal_cooling_device *tcd,
+static int ps_get_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 					unsigned long *state)
 {
 	struct power_supply *psy;
@@ -934,7 +934,7 @@ static int ps_set_cur_charge_cntl_limit(struct thermal_cooling_device *tcd,
 
 static const struct thermal_cooling_device_ops psy_tcd_ops = {
 	.get_max_state = ps_get_max_charge_cntl_limit,
-	.get_cur_state = ps_get_cur_chrage_cntl_limit,
+	.get_cur_state = ps_get_cur_charge_cntl_limit,
 	.set_cur_state = ps_set_cur_charge_cntl_limit,
 };
 
-- 
2.20.1

