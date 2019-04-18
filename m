Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709ACC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 398AD20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612095;
	bh=k4Hd1HgeDmBHLzemX9xP7r78x1nypYSadH9J8St+7F8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bvGw//bh+gFzMEKLI8u7zpjI5AHfyyt1HT4ouPJJUSJLCShPbxqyatFWo5+Mm1o81
	 SMaIdNFavTeUI8qXi/oh+Bp9f0u0TVGzX/CnH/uVCFzYg7YdFcskWaquVoVaZMjHv9
	 EAzpvs47pr7Kxt8pGLWUkoIjJzSWXvBsf8OXXjLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390201AbfDRSD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390185AbfDRSDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:03:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C131E218AE;
        Thu, 18 Apr 2019 18:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610603;
        bh=k4Hd1HgeDmBHLzemX9xP7r78x1nypYSadH9J8St+7F8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=esjxZmOXaLIJkmTXeFGvJNbxW3O/Z9gmk/mtLalj1+Nf1ZpTFPztfYnRgTWRSg2vo
         GbTQkMThHEKSrlbo14mxvcWseG5RhYjp3Tt3jMiyiPer+uLi3AFeWYNL9KfcniMDB5
         9VfEiw4POJm9PVDeSz+Zc3sRSyFbOgRjJxh/850E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Nisha Aram <nisha.aram@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 14/92] thermal/int340x_thermal: Add additional UUIDs
Date:   Thu, 18 Apr 2019 19:56:32 +0200
Message-Id: <20190418160431.606919328@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
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



