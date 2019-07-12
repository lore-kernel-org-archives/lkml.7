Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F27C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8338221670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934303;
	bh=Ewvu7yBZJuIvAVOWtuvGiUggubBsAHhQ5bcCtB13j7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pLA7QHLdibAkUvJ1MgBgnwCO7qdCDA+t3Z6dNx9T7/d2JUnJQiPkrfAmK6VEm3hXJ
	 iroB74oZdZIze8etLoVYGhw22e5wELqy895KX7+llvm3Fq2Z287R2HgbItXJWpZS4O
	 P2d12III3rPzw8Xe9leyPC55PuWo/DMcDCqUsenI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfGLMZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:25:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfGLMY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:24:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E741E21019;
        Fri, 12 Jul 2019 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934298;
        bh=Ewvu7yBZJuIvAVOWtuvGiUggubBsAHhQ5bcCtB13j7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w9Hj+7HRZWLY7g6eMnaIN9sg391ASjo+EP3RrQpk2ok0KGpy1EafWjE3SnTlClCBA
         SjrHVZYYZl5m0qVoolgiU+6ecrVVqRiuyBp5Ij4RQeit5g2TjiZ+67EK4+q/19h81Q
         RXLdKcWbb6JxDkKytB0tLBftogNlYf4FicSMdM2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 010/138] Input: elantech - enable middle button support on 2 ThinkPads
Date:   Fri, 12 Jul 2019 14:17:54 +0200
Message-Id: <20190712121629.108971528@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121628.731888964@linuxfoundation.org>
References: <20190712121628.731888964@linuxfoundation.org>
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
index a7f8b1614559..530142b5a115 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1189,6 +1189,8 @@ static const char * const middle_button_pnp_ids[] = {
 	"LEN2132", /* ThinkPad P52 */
 	"LEN2133", /* ThinkPad P72 w/ NFC */
 	"LEN2134", /* ThinkPad P72 */
+	"LEN0407",
+	"LEN0408",
 	NULL
 };
 
-- 
2.20.1



