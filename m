Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527012064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 01:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907801;
	bh=7kzd2CTa3Sj3YVRfYPoYgBS9aWNS30lTiWaKD4/fns0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=De/fZutY1Y0WzM+7BZ1B+cRmERc8CaR4DbcSU0W1OBALwI68E7pkG/RdAA5YpDIAh
	 Lxb2bqFfpGn7ROLsWczBNeW0UNSso0VKsTEcs3qNRGa/AQ9kGWySKlCU7HU9QfzpIm
	 3ZLPW3N6xZ0KifigzsqO4zXkhG/KlJf1rmMRzHio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731707AbfC3AzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbfC3AzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:55:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB5B218D3;
        Sat, 30 Mar 2019 00:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907305;
        bh=7kzd2CTa3Sj3YVRfYPoYgBS9aWNS30lTiWaKD4/fns0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiDMiijWPnjYAIeX2D8NQ4jUFUWhmUXlmWwPHtV2THRr134fPcwS7BFXsb38XdVJH
         pRry7iqbE6CD3bPv2ge5s/USeir1jlS+MisoQKotfNbUM//gODwCTxPofwA/Lhpvk4
         jaLk5nh0i87zfP2ARx0X6gPQXjEHX5G88lKXeMCc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 14/37] thermal/int340x_thermal: Add additional UUIDs
Date:   Fri, 29 Mar 2019 20:54:15 -0400
Message-Id: <20190330005441.27540-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005441.27540-1-sashal@kernel.org>
References: <20190330005441.27540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Garrett <matthewgarrett@google.com>

[ Upstream commit 16fc8eca1975358111dbd7ce65e4ce42d1a848fb ]

Add more supported DPTF policies than the driver currently exposes.

Signed-off-by: Matthew Garrett <mjg59@google.com>
Cc: Nisha Aram <nisha.aram@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/int340x_thermal/int3400_thermal.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/thermal/int340x_thermal/int3400_thermal.c b/drivers/thermal/int340x_thermal/int3400_thermal.c
index 43b90fd577e4..34dc4d6dda66 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -22,6 +22,13 @@ enum int3400_thermal_uuid {
 	INT3400_THERMAL_PASSIVE_1,
 	INT3400_THERMAL_ACTIVE,
 	INT3400_THERMAL_CRITICAL,
+	INT3400_THERMAL_ADAPTIVE_PERFORMANCE,
+	INT3400_THERMAL_EMERGENCY_CALL_MODE,
+	INT3400_THERMAL_PASSIVE_2,
+	INT3400_THERMAL_POWER_BOSS,
+	INT3400_THERMAL_VIRTUAL_SENSOR,
+	INT3400_THERMAL_COOLING_MODE,
+	INT3400_THERMAL_HARDWARE_DUTY_CYCLING,
 	INT3400_THERMAL_MAXIMUM_UUID,
 };
 
@@ -29,6 +36,13 @@ static char *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
 	"42A441D6-AE6A-462b-A84B-4A8CE79027D3",
 	"3A95C389-E4B8-4629-A526-C52C88626BAE",
 	"97C68AE7-15FA-499c-B8C9-5DA81D606E0A",
+	"63BE270F-1C11-48FD-A6F7-3AF253FF3E2D",
+	"5349962F-71E6-431D-9AE8-0A635B710AEE",
+	"9E04115A-AE87-4D1C-9500-0F3E340BFE75",
+	"F5A35014-C209-46A4-993A-EB56DE7530A1",
+	"6ED722A7-9240-48A5-B479-31EEF723D7CF",
+	"16CAF1B7-DD38-40ED-B1C1-1B8A1913D531",
+	"BE84BABF-C4D4-403D-B495-3128FD44dAC1",
 };
 
 struct int3400_thermal_priv {
-- 
2.19.1

