Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B31DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E76208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140377;
	bh=7R2Ze6sw33tmhjLrx9V9+eKEeDxxC8P5VNEF4PQztro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CS2lz9sCAbY+NdJRfmHRoi1rzOkkH3gWQTbEHwIoem/Eh0fAnh88bWUKJw/luA9CE
	 RRwXvfaA9HyZXiOBTkXd+ZLvbp73GBI0Fc2B6YxCRiZ+nGBSuZt4NzA0VQFFgWmIEw
	 xziSTpC50Mqn4L6CIqR+zQNh+2uD1FLrl2TbvDqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388473AbfDARjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:39:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729727AbfDARjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:39:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6746A20830;
        Mon,  1 Apr 2019 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140371;
        bh=7R2Ze6sw33tmhjLrx9V9+eKEeDxxC8P5VNEF4PQztro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CoisPMH4gpVb6tg4pjxX8hO/z+4UXllpKSOUrSJA1EdRS7aFekSHhpg/81fOHJXnN
         6MXn4zKhE/C99wD4Ja0QDTg2HiIIVjs3BRcNLwxXg1GUmIRQ427VCG/cZOaXNgWSlB
         LqNjJ6Hk+CHhH8llA8JW/CTQAXt8khGlK8WXiUJk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>,
        Rom Lemarchand <romlem@android.com>,
        John Stultz <john.stultz@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 16/50] staging: ashmem: Add missing include
Date:   Mon,  1 Apr 2019 19:02:59 +0200
Message-Id: <20190401170043.063593318@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 90a2f171383b5ae43b33ab4d9d566b9765622ac7 ]

Include <linux/types.h> into ashmem.h to ensure referenced types
are defined

Cc: Android Kernel Team <kernel-team@android.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Signed-off-by: Rom Lemarchand <romlem@android.com>
[jstultz: Minor commit message tweaks]
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/android/uapi/ashmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/android/uapi/ashmem.h b/drivers/staging/android/uapi/ashmem.h
index ba4743c71d6b..13df42d200b7 100644
--- a/drivers/staging/android/uapi/ashmem.h
+++ b/drivers/staging/android/uapi/ashmem.h
@@ -13,6 +13,7 @@
 #define _UAPI_LINUX_ASHMEM_H
 
 #include <linux/ioctl.h>
+#include <linux/types.h>
 
 #define ASHMEM_NAME_LEN		256
 
-- 
2.19.1



