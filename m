Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0C9C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D140217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610847;
	bh=l918xrfDzjeUIfFFf9zlL1S4EHflc7aq0DdxCFxYMQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXMV9Z3p4nUcQnpSRFTj9YAldKDBt81rjv3OIqnI5fqsISGDxk9deoEYZNv/WoiZH
	 Ag6Y6MoOorXHIn79sT6LiZZ5Q/tRcUa9dGvHc4wLB82/NCSAJkkchKzq/3AXDcNTMo
	 YwbyRRUXwdO0vn70y8ByF+2xmt3rzK6XO9HWO+8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403813AbfDRSHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391599AbfDRSHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:07:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63A52206B6;
        Thu, 18 Apr 2019 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610836;
        bh=l918xrfDzjeUIfFFf9zlL1S4EHflc7aq0DdxCFxYMQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=axjSed0dDgw+1vs9aAMJD3tgB+4dyNpavgEllylTKTHZqJ9DU8lBBVXeJ1E8vTZSA
         HImuUCxDIHFAl1CD3coDEF3XM3eXNjF/hvo5FEtSUw9X3u2ZZtJJqYy2mXyYs8EQa+
         sKDzj4Sgrc0JeYb4V+/IqATz4F1hmtxM5bNfZwJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 10/50] thermal/int340x_thermal: Add additional UUIDs
Date:   Thu, 18 Apr 2019 19:57:21 +0200
Message-Id: <20190418160424.051766693@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160422.455656724@linuxfoundation.org>
References: <20190418160422.455656724@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 5836e5554433..0beed2899163 100644
--- a/drivers/thermal/int340x_thermal/int3400_thermal.c
+++ b/drivers/thermal/int340x_thermal/int3400_thermal.c
@@ -20,6 +20,13 @@ enum int3400_thermal_uuid {
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
 
@@ -27,6 +34,13 @@ static u8 *int3400_thermal_uuids[INT3400_THERMAL_MAXIMUM_UUID] = {
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



