Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C2CC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A224220637
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 14:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575988646;
	bh=gMt0MJMPcnvZT7IleGpJK3i5zXBiA2d/3jIWzlO2IpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U+aO4SbGV8Dh6cJ0j8t1wFxNnRLoKUfFbGp13Z4A8KjiERdPKAVHLAWygqQ6kmh97
	 sdhUMuTWLdPpnRoHWqJdgcumaxarP9iFWvcpBgc51QDN/oxT5BoF6sTdbD2t1FE5W7
	 jwvurK0N+4bW3lYKR4IeWvdNYhhrxb4QU3385yU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfLJOhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 09:37:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:52196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbfLJOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 09:37:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61DA020637;
        Tue, 10 Dec 2019 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575988642;
        bh=gMt0MJMPcnvZT7IleGpJK3i5zXBiA2d/3jIWzlO2IpM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vv2Q5BqmoVSNgj/LtK82yiDsEjAy0+aXRgpaYvTMqmN/J0wzqQD0+5h3BdYuqXZd8
         H3kQp7Po4dE7y/KJFVYdIp30gN2EaWVNb2v7rNbNUWRCkvkIMJT0L7lT+Em/1nznED
         CTLZFYoGgc9ixGj4C5PWfyrK2rfuDIHqiaVVgh3U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Hyunki Koo <kkoos00@naver.com>,
        HYUN-KI KOO <hyunki00.koo@samsung.com>,
        Shinbeom Choi <sbeom.choi@samsung.com>,
        Jiri Slaby <jslaby@suse.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] tty: serial: samsung.h: fix up minor comment issues
Date:   Tue, 10 Dec 2019 15:36:59 +0100
Message-Id: <20191210143706.3928480-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
References: <20191210143706.3928480-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch found some minor issues with comments in samsung.h, so fix
that up.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hyunki Koo <kkoos00@naver.com>
Cc: HYUN-KI KOO <hyunki00.koo@samsung.com>
Cc: Shinbeom Choi <sbeom.choi@samsung.com>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.h b/drivers/tty/serial/samsung.h
index f93022113f59..cdfd53acead3 100644
--- a/drivers/tty/serial/samsung.h
+++ b/drivers/tty/serial/samsung.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __SAMSUNG_H
 #define __SAMSUNG_H
 
@@ -7,7 +7,7 @@
  *
  * Ben Dooks, Copyright (c) 2003-2008 Simtec Electronics
  *	http://armlinux.simtec.co.uk/
-*/
+ */
 
 #include <linux/dmaengine.h>
 
-- 
2.24.0

