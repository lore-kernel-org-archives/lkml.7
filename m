Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C2CC76192
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3994C21841
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 03:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563419347;
	bh=e7OOxVwa6OkKOW8HJ4U3Fx39M9IRKS8R7teLGKmwh78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=efP2nBUGoau7Bjc6V5kihPT7DrW4SxtTgYywxQmHbwcye2+bohqJKRqh/a/yA6R06
	 +PE1IBMkrijs5F0TDZWygBShwp7vD89JZs41MrgVlPQyEWTV3AZtlo705M1oHIMTvR
	 iLgKgpZw0HpT4C7kYUxTU7sv0wQJeqTYN+D8BEO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390322AbfGRDJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 23:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389445AbfGRDJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 23:09:03 -0400
Received: from localhost (115.42.148.210.bf.2iij.net [210.148.42.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E6812173E;
        Thu, 18 Jul 2019 03:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563419342;
        bh=e7OOxVwa6OkKOW8HJ4U3Fx39M9IRKS8R7teLGKmwh78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2iZmGL8IAwU9NHTl4bAoWbZqOXSi9Cgl5TRere4m/3AeIQORoLwsLYjS8RD1/WQZ
         rGAwWFA/j13d+MFPF0BxJO2W0/58T5b7ZJeAqq+ngorx5V2b1vfJFIF+4MUJoCJOi1
         Zo+llBW82GGZAgNTmRTXLVDDJL4Z/Yz/u1xeepYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 07/80] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Thu, 18 Jul 2019 12:00:58 +0900
Message-Id: <20190718030059.444085336@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190718030058.615992480@linuxfoundation.org>
References: <20190718030058.615992480@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit aa440de3058a3ef530851f9ef373fbb5f694dbc3 ]

Adding 2 new touchpad PNPIDs to enable middle button support.

Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/mouse/elantech.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index fda33fc3ffcc..ab4888d043f0 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1191,6 +1191,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1



