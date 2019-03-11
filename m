Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E46AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2808B206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfCKN0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:26:40 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:59833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727596AbfCKNTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:37 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MlNgx-1geQfl0FED-00ljDa for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:36 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 064/114] drivers: parisc: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:18:16 +0100
Message-Id: <1552310346-7629-65-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:/WTjnEj6WeSSSVmqDSDNepCjdQhyazbvXeB3elvPZ2MAYS1xEi9
 5Y59aX+41ob6xg9/phrDnVwBn2GoNsAmdnmOYuM+jtcwyZylCCZBt0sk//EkWHHfciuBX+v
 yRzPXK2znMl/0aYfPp+0XrN4KXwB83b1AYFDZLL82NuUuYWeG4c6UULuV1ckUBQtl0wzS5s
 TlkbJ9cOxNwpK2j0HWGQw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gXuaaiFspXI=:dua3spkMdTYecwuI7SD3p/
 pS/QR3TEPveYhEleyHWDoFH0fPOcKG4G8sHP1g7qlWtWp9csfAlVi85uHX0frsU4jLBCnJyhK
 +T4izRj4ull+jAO1j7C5qZ7vr7RG7XQ+xhjiLYg8Of/UWXZYoCbUmehj5emb9WbutYF4jDdzE
 ss6FnBlOPN1Yonlm4N3uoZje399cay35BTPhWOcELvtKu5WYCLVsU4xVhm3/wvo04GVxnFwxp
 MahzGBFWQu6uU6oI6KrNG/abfDp8eOsv90y+x9eu3FEYtq3wa+8U9GfSE5aSbBrbm04ojezjU
 oCghbtHjeWTzET5TDlpMQG7MbsKIGSnTiPa3EZTtfRBGWjI0RmjUtXee2WF+ptf3slXinkNN5
 6bhyMb0MuGAcSe0eBdFu3a+FG9lOb2OgNOz9C60UfBOWj5it+xDy8pQL06CyN/luG4AtDgKjt
 GDGjaqxrS1T0G5RfJ4y2T4LcrhUzQ09Kn+QbLBghWCcxXA1oPJMa06DJ0mnAHWP668Ks04QO0
 A4KQQcX6575CiYIEG1TArfbWG/crgvyfnOK1jf9FDV2CpiJ+SyzIX6Xe+rV7z80U3WtJ7aJ9O
 62S2eq3y7Eq5vEnjb+M9UuB41SyMHnAR7WqC0CbHCT2bRuerjSIcZnzf4sVB0EWA9/n1FHzoN
 9dZaY0wwO6KXy1XfDK4vWQUx44yu64E+tf1vZdngID6+ORe6QZ0q2blNT9hdLynI7emd3gNZG
 zU/GdxB+EeYqKxzXbI1VF62o6anqd4HjCoZUdA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/parisc/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/parisc/Kconfig b/drivers/parisc/Kconfig
index 74e119a..db697b1 100644
--- a/drivers/parisc/Kconfig
+++ b/drivers/parisc/Kconfig
@@ -123,9 +123,8 @@ config PDC_CHASSIS
 	  shown by the LED/LCD driver.
 	  This driver updates the state panel (LED and/or LCD) upon system
 	  state change (eg: boot, shutdown or panic).
-	  
-	  If unsure, say Y.
 
+	  If unsure, say Y.
 
 config PDC_CHASSIS_WARN
 	bool "PDC chassis warnings support"
-- 
1.9.1

