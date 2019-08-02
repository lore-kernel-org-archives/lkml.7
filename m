Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BDC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9782A20B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 19:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394138AbfHBT4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 15:56:36 -0400
Received: from mail3.marvil07.net ([139.162.190.158]:42044 "EHLO
        mail3.marvil07.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393087AbfHBT4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 15:56:36 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 15:56:35 EDT
Received: from noir.ime.usp.br (unknown [143.107.45.1])
        by mail3.marvil07.net (Postfix) with ESMTPSA id 4105A1EF34;
        Fri,  2 Aug 2019 19:48:09 +0000 (UTC)
From:   Marco Villegas <git@marvil07.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Marco Villegas <git@marvil07.net>
Subject: [PATCH] staging: rtl8712: Add spaces around <<
Date:   Fri,  2 Aug 2019 16:47:37 -0300
Message-Id: <20190802194737.12252-1-git@marvil07.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch error "CHECK: spaces preferred around that '<<'".

Signed-off-by: Marco Villegas <git@marvil07.net>
---
 drivers/staging/rtl8712/rtl871x_xmit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index 4199cb586fb1..c5c55967164b 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -41,7 +41,7 @@ do { \
 	pattrib_iv[0] = txpn._byte_.TSC0;\
 	pattrib_iv[1] = txpn._byte_.TSC1;\
 	pattrib_iv[2] = txpn._byte_.TSC2;\
-	pattrib_iv[3] = ((keyidx & 0x3)<<6);\
+	pattrib_iv[3] = ((keyidx & 0x3) << 6);\
 	txpn.val = (txpn.val == 0xffffff) ? 0 : (txpn.val+1);\
 } while (0)
 
-- 
2.20.1

