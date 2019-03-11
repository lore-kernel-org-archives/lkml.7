Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D27222EB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfCKNbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:31:14 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49835 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727440AbfCKNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:29 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MryKp-1ggdbJ1HlN-00nv5C for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:28 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 006/114] drivers: uio: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:18 +0100
Message-Id: <1552310346-7629-7-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:HKid9Lkm6EmEHRoHapAFwp/C4T+Tymd1NGRAqABFhUYSJX+SD00
 zFwLi+KJE+5KDuzSKwquekGSDHCxA5RCl+mpNonL7H8K959cp7xmuVnMw9Op2kLUz/PGbLw
 Y9IsgO1v+Gqnn+YpZjPWTvUB2fCKiJ0h5PVS/Yv6Nq8+ZYcu6Ghbic0L/A14ZPwy1K3zVbY
 rMdPjgfqCqVWW15Cs2gwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i26b43x2fm8=:xxobDOf4yl8r+po9uUUgGI
 tizG3jRSadnt1Vy4Z8UGWBDEXOHePxMV+3RzxnLJjK+0fDeKJDMiOS46/5aGxCXsD7frvF4Zm
 4dJN9h28+upgAee0VgUN0xpAcp0ODLtwq6ehQ1W+mOi5bY7ZMFLIT0KGGVtvw0a4w5LEfqSoG
 MXo8SsQurxsRyCkxrLOtz1VjRxGHB7y9RubgXeXHk65uGd285FqCp5+g4dcP5UWxmZIjK0Xje
 kq6Wx2g+akr0xT2/wgrV2vodvxXOyY740IqPshX/U8zSHxfYm+sQizy84nZn2Tk56ac9dzgUx
 6Ts6eZnO3BQ1DbE0DUETRmnFmmsaOUd0Ji3I0YG2oekiEuJYwC1AZiywzOGCKepQEx2Sizh2T
 5yhLda7WycOwl4hEXnbMN5673rGoGf3sD6o4wNcq0A05HFy60m5QE0UOY3EK3XzENTQiW5f3U
 QCozuEKAZmQlauZ9FYCaHFzyinq24rSje8ml6AR2MPlgsudSiIqOnflT2lstXKZYQMuX1EBdR
 +3ac9qXNMm02/5XSvsmprNfR1qKd5x1fr292TN90LIW/s+TmdIqFYXXKuhvVyomRcdpLRLekj
 S3SbUB7RiubOgs4IUk8+Zug8K8jWzhzX7HkMzvF9LxGyNrUNA4soavBxgWrlks8it+GC6cjPN
 O4z9MOCPNTWSSKd+QwG9s/nP8hxScf8jWLv7T5FpNoisNTFbsIpKASMQmpaE1OJu0UhSVH4g5
 2uUqLHKzbemlI9RNBntlbdLtIUPV91lQo0+s8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/uio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 7e8dc78..4286b73 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -17,7 +17,7 @@ config UIO_CIF
 	depends on PCI
 	help
 	  Driver for Hilscher CIF DeviceNet and Profibus cards.  This
-  	  driver requires a userspace component called cif that handles
+	  driver requires a userspace component called cif that handles
 	  all of the heavy lifting and can be found at:
 	        <http://www.osadl.org/projects/downloads/UIO/user/>
 
-- 
1.9.1

