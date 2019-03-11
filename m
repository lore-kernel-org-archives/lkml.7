Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35309C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9E32075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbfCKNmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:42:12 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:48487 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbfCKNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:42:11 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MjjSt-1geynB0d0F-00lBta; Mon, 11 Mar 2019 14:42:10 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-alpha@vger.kernel.org
Subject: [PATCH] arch: alpha: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:42:08 +0100
Message-Id: <1552311728-18973-1-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
X-Provags-ID: V03:K1:BYTe8onhKxs2Ri1I7QxlD37sWNW6QAtL5RBmY9FcLsqlGfBRehO
 SHvEFEm+o3IGgpFsycukApl4grjV9Gry1Aky3GiNfWp+HwWZwrwE9R69nNbcbScXaajHlxu
 flHgu020MacjSUl6l54nZr4/UMkRMkkGoExow2tDE8ogvMl4XOPVnDguB6vd9Nikm+YQu08
 Je49mKWzqoDGGcVkuqqXg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CJZVRY/kAYM=:6f/0hO1jvfZX0N48A2Dmvd
 eRcZU3KqpSNdoldPOxtFjhqEds8gQRjTAUs0YXcSBDbCWvzglyVvYQUCcee7gcI2okzcoBOsz
 zhHxQEYpq3YhrGtqJK1AjLoDSi0KXHzngJfajwu2aglBFsEYt2Jg7KI9v9FHo+712D3YFtoGI
 6IdKKKnUE00bvBGh3U3dQYLm3S9WEUQ3Sv6L6SqaC2VGpFCT7i7hSi7tj5wHDsn6a4j+LVLyw
 Va+6NbHQZL9PLhsGYY1AkH9Ap5K2pCxZNYtKlfx+QMVdgNcf2Fc+DHjpmhrnC/kFt6fruSmHv
 kapVQmG+++ljaAoTZeGeXMWHCoNAPCyC4N1VHaOtAM8GBbN7I9UF/FZLK9ol0lE5+jZDeHgru
 X9uP9YWjAwfneVqPf97PysQ36JaGydGYBPeuNANnzvOmhGniGqMgpUFdVj0xcS04xfMzTEs4W
 +fOguei7uhOtudvQrGWg049UCQwZsLAJll+oA1bpoXAFRop3fnQuOTYygNfS1nSLRmxxfALwV
 2+QQRJZJzDs2qwrWYIQEmHMOeXUpcY+M3UtLPD6uvFu5iFFlEqueTkOrlGJsomoIJkZce30jH
 hUg+N3dBpbu6ULX9v+m0sYqp5PXVdsBf//o2pe2yCDLAFRxWiWDUHVOw8vPlTMv6TKFcue2IH
 QH64R+HGDgYYVZp/90Gabzvwo/Cxlcae55RbpeHt0wQjtxkUevM40yG5E4SBSHCTYsB/hvL8G
 RRXnJ+ABNK/CmVr+vQGeesHn0NvkgtupGGSSdQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Formatting of Kconfig files doesn't look so pretty, so let the
Great White Handkerchief come around and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/alpha/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
index 584a6e1..ca70946 100644
--- a/arch/alpha/Kconfig
+++ b/arch/alpha/Kconfig
@@ -550,7 +550,7 @@ config NR_CPUS
 	default "4" if !ALPHA_GENERIC && !ALPHA_MARVEL
 	help
 	  MARVEL support can handle a maximum of 32 CPUs, all the others
-          with working support have a maximum of 4 CPUs.
+	  with working support have a maximum of 4 CPUs.
 
 config ARCH_DISCONTIGMEM_ENABLE
 	bool "Discontiguous Memory Support"
@@ -662,7 +662,7 @@ choice
 endchoice
 
 config HZ
-	int 
+	int
 	default 32 if HZ_32
 	default 64 if HZ_64
 	default 128 if HZ_128
-- 
1.9.1

