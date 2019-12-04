Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C46C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD952084B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 18:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575483066;
	bh=6gBP4j6U7yeNBj0eNTpRBUArgZTCEi7eTGuf8x+3BP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1DnE1l77H+JBF2aDm1YXF3R4h+72wFH+u/Y5Xyn8QRouNEjSD9Eo0nLT4pS4Uc++Y
	 O3CArtkqeRaIbnMItfwFpCSr+6WQ3XQ6Xbq9VzB8mdijBxO1E/Xy+CrMN3zTn8XbyB
	 EIvh/Yy5whCH23+KIh0s5Bez4tlDrxm1y0NqYShk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfLDSLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731362AbfLDSLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:11:00 -0500
Received: from localhost (unknown [217.68.49.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EB482084B;
        Wed,  4 Dec 2019 18:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575483060;
        bh=6gBP4j6U7yeNBj0eNTpRBUArgZTCEi7eTGuf8x+3BP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQdhwcH4OUh+xPKeauQuhTC/dfVvMm46Cq6lgIJv6cLvkd9cBBUPpxTubbifaC9Zg
         PCPlo7U7E51ONyVVUqSutNoBETixLFCpFBgRqHboVnYuMa7IwAODFVqwJupO621d3u
         0rtYTaPge8SUvjYXZ89h20AGQKCI0AZ4jG6kTodU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 004/125] reset: fix reset_control_ops kerneldoc comment
Date:   Wed,  4 Dec 2019 18:55:09 +0100
Message-Id: <20191204175310.486489838@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204175308.377746305@linuxfoundation.org>
References: <20191204175308.377746305@linuxfoundation.org>
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
index db1fe6772ad50..b5542aff192cd 100644
--- a/include/linux/reset-controller.h
+++ b/include/linux/reset-controller.h
@@ -6,7 +6,7 @@
 struct reset_controller_dev;
 
 /**
- * struct reset_control_ops
+ * struct reset_control_ops - reset controller driver callbacks
  *
  * @reset: for self-deasserting resets, does all necessary
  *         things to reset the device
-- 
2.20.1



