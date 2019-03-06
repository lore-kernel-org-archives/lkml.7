Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECECC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F7220684
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbfCFSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:13:47 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:60047 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfCFSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:13:46 -0500
Received: from orion.localdomain ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N4R4i-1gugWM43So-011Tml; Wed, 06 Mar 2019 19:13:45 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] drivers: uio: Kconfig: pedantic cleanups
Date:   Wed,  6 Mar 2019 19:13:43 +0100
Message-Id: <1551896023-14007-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:yvqIiGwMKWcayKI/7FRow/Bxpy1FmrKDTbiKUfIrhS0WKsozQ0q
 UMMuZv4gr3iLcoIh2+vkjy526D+bBMgW2yNmDnKBRr+sXCGaHj2k9CiYVLVzKlSm2za+T0s
 VWbZfcBNpRhrq+pK9Vy4ibIphFQkJc14yUFl3VZB4rTciRof6IJlYTUoWQrlZ7k1q76iMhS
 lU+36Zn4Jxn8/eL5mfC+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hLYsp+cCaJU=:QANfn8AZxPD9/8hfFhaLG0
 15597Y3XddKPOiGDYzzjzTfBR1rwbOc/tBGUsMk76/nLRnlJGQm82KWOaMBW11BehMcuh6igG
 X2bISq22agmj7ySJ/tPinehOz/39DxP2xkFQjToAftWhH9/zD68qKPdynKsfvYz6XWH/RL2c+
 1rWdRZh/wDzvzUkS9+gyH7BDIa5Ug3ac48oGztqQFOVEo2QTaG6LUxxKfUL7Qubd8CvHCiXv6
 dKWd4C3fMmQl9vgH+kPyNDjlN29RnVKzQv4TenAmgZgNgLKwiroDDTYA3TLh7X1YUrUd8s45o
 QW1sSx2Yps/A6gMzFLaUGEmNPGqQc7/qzkhLGV/AgwpqFgNjZOTJBILq3j4evpqHdbXnr+IDx
 VVA8dN68JQnYA1mIQlQP/MRy5Fyyq+9/vRKLVDQH1pLjxYGEOvPPJ1Y1td3T6WV0i844fEMi3
 C8lbUR+vHDgKj6bN/Vu6rP+/9WEkrfL0ewIvuIUtqHQurJ6uiSJaExhym6vWY0aZMPLY8UN4T
 XJlyUYYQDiGhe6QAn7YOqr5wqLU6b4P0GLhgAAKKkNQ+YL2CT2olTnqCgfHDw9Mn9bVEPXuhf
 BM526GbS7H02TkwfTjKDytfGKXbL2bY0KUD7lJYW3CHA+GeV6mPM8XEpujOagAXEm2OUVIO/9
 moKOQfG9VKktu/ei48mJ86MIM60Z6OCRIx6XQa8nvD/BIxDqhWQMKxiR13trfOs8mqNUvWOyv
 x7CfJ9bJy0k+LXXZthRwaJoP6LpWMyvulazi0A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

