Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA302C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B92222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 17:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578071585;
	bh=JcKdUDqAnsO5QdZc7CTmxgabj62q2qR0lsbmqufRSD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TWfrO4M4hOdu5Pjse8grHUylvHDCa1L6P0xFOfAg4QJe9cAUv/K/m1Yj1hFZYkd2v
	 3CzjJGLKPCx+5Rhlu4C5+oR1A00g86dyhlDCZCgGwayRKZxUtWOVgkTVPsE9PV2Bxo
	 pPSomeEFtTXFbLWlcLxqrhFYqZRitAoP3taekSis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgACRNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 12:13:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbgACRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 12:12:58 -0500
Received: from localhost.localdomain (unknown [194.230.155.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B2D824653;
        Fri,  3 Jan 2020 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578071578;
        bh=JcKdUDqAnsO5QdZc7CTmxgabj62q2qR0lsbmqufRSD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjTamj4pLZW8L8uWM94nyo/pz//BCuPO3VQ0hHGMxNSnqq2rziD3v1NVo6sqHPXWR
         XaPt4xR/arignrpcqL55ZL/fpuATOgLDtt/7WMfw0wL/yA+qbKmXcnt11KHumWwKD1
         GLcDRBzGR5DXqtWQLskOwO33vr3WdNt5wEkpNAKg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 17/19] mfd: samsung: Rename Samsung to lowercase
Date:   Fri,  3 Jan 2020 18:11:29 +0100
Message-Id: <20200103171131.9900-18-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200103171131.9900-1-krzk@kernel.org>
References: <20200103171131.9900-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix up inconsistent usage of upper and lowercase letters in "Samsung"
name.

"SAMSUNG" is not an abbreviation but a regular trademarked name.
Therefore it should be written with lowercase letters starting with
capital letter.

Although advertisement materials usually use uppercase "SAMSUNG", the
lowercase version is used in all legal aspects (e.g. on Wikipedia and in
privacy/legal statements on
https://www.samsung.com/semiconductor/privacy-global/).

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 420900852166..1ce6eced7983 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1065,7 +1065,7 @@ config MFD_RN5T618
 	  functionality of the device.
 
 config MFD_SEC_CORE
-	tristate "SAMSUNG Electronics PMIC Series Support"
+	tristate "Samsung Electronics PMIC Series Support"
 	depends on I2C=y
 	select MFD_CORE
 	select REGMAP_I2C
-- 
2.17.1

