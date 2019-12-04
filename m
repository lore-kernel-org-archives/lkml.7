Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82ECDC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F494205ED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483855;
	bh=mlnS5nKgQeE0EmKI8jD9Saduf4a8Oq79MP2wohsVeco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PlGVNOWgiW/33z0TSouQ5EIVqZ4OugdFSJ01R1BK+/JI3BvielZvArLdC7s6IBHVZ
	 gqsUi0O57S+9AiJn8HM+0J2xxRHDxwTMJ4+luy7FsIn9OVUZ8EeHUklc2wDUC0idYY
	 qEDp5GwHTX8MsmA5m/WzzSZA/Ijp4rTZ2qg3PK9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfLDSYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:24:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:45552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729939AbfLDSCv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:02:51 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4F1620659;
        Wed,  4 Dec 2019 18:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575482571;
        bh=mlnS5nKgQeE0EmKI8jD9Saduf4a8Oq79MP2wohsVeco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pxqC/SHAhrON5O4TtlmoqCG/d2soPOINljKIYwnznYZKeSP/jNMBkYbXCdZn44yAt
         Y3QYAt1MTS2g0SrBpocb7gp05SJqYA/fmf1JDQRwEPADII3orL3jPct6ofDP3Wdhkg
         2mVUQ4QwpiA/ppGlM6GF0s9PFCIUJoICPiz2Fni4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 007/209] reset: fix reset_control_ops kerneldoc comment
Date:   Wed,  4 Dec 2019 18:53:39 +0100
Message-Id: <20191204175322.114143124@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175321.609072813@linuxfoundation.org>
References: <20191204175321.609072813@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit f430c7ed8bc22992ed528b518da465b060b9223f ]

Add a missing short description to the reset_control_ops documentation.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
[p.zabel@pengutronix.de: rebased and updated commit message]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/reset-controller.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/reset-controller.h b/include/linux/reset-controller.h
index adb88f8cefbcd..576caaf0c9af5 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -7,7 +7,7 @@
 struct reset_controller_dev;
 
 /**
- * struct reset_control_ops
+ * struct reset_control_ops - reset controller driver callbacks
  *
  * @reset: for self-deasserting resets, does all necessary
  *         things to reset the device
-- 
2.20.1



