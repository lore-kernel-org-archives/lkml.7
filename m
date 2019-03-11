Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E6A2196E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 13:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbfCKN3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 09:29:53 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:35377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727533AbfCKNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 09:19:32 -0400
Received: from orion.localdomain ([95.115.159.19]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M4bA0-1h1gwf1Imc-001i6H for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019
 14:19:31 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH 028/114] arch: alpha: Kconfig: pedantic formatting
Date:   Mon, 11 Mar 2019 14:17:40 +0100
Message-Id: <1552310346-7629-29-git-send-email-info@metux.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1552310346-7629-1-git-send-email-info@metux.net>
References: <1552310346-7629-1-git-send-email-info@metux.net>
X-Provags-ID: V03:K1:kKaOopG5JARMiaHEbO3gTXA8X2Gvm2s/J+hqTcEafsbKR9O4C8Y
 ymYXEeV+iosrGVPgs0Fvn3M9BALKNF5zB6qxr0jdncPS+/4cnfoyitmzDLvN04MsEXlbmfD
 VOqwsDvtYZ5hqwQH9cRGKWw/HGF8ZDHC0YiKR8hXLPimD6jkouFF9WZtmlGDEYqfbhOJNtV
 02sSPVO4lYArpBsn/eAxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RbG3q+EqOAQ=:HYIQhP9bVUWw20WVx3aOyH
 py5n9e14n3zboGqU7BLFb5WX5ZlGtWJrPgqwsxjoCyHQ22vJ1AUyepMlg6RS7uP6IoI4JPgLp
 MEfkRugrtbcCQDVqnICZfgTdT7Jnnz1P/UGb6FoXkW/2Dtor3DITchHg0DhvzUJAklzL3N2sa
 jyj9EZhDKoyDcVi4aj5m5bawoPIdQB/Yjr/rEv/sHL9P8UdBqApguDoO+Gdjyw+rCvGSiHGu0
 sdbVA/otKenUwbXE4y4yDWHo2eB6XTN0nh6ehZEaKUAWK3zcWeASkiSY74MF9N+9SOKNH60iK
 JxJyDUrwu0dakp/8OGfwb2l65ZkCIE9OXJRkD3oBTbVG2spiP8vpTXZOD3BbRqDg6aY+eS+9+
 sClAGiI6fsxZzDbJ3oF1oThM+1D31SXTZQ5qjMgvwN4LQs/oQ1tza+S84O3wb1QD9/cUjuMuX
 R/lTuH//5tR+5Wxl92gTvMMwqpr9/qngRUy4JzVQ4mqmy46GoCKWwbkmi1obby7nEi2Y4zK56
 BnaAyKZck/ubuE7CECiP4rqnBCI7BvyJrUcmKN322FHaEZtK30fNDysftXzYA5f+/3oJOrVlz
 qvi163zmE+H1BnuNN/xqi9zvrSsUCd/eSNYPEKttwSZJhWk+7RMb40Oimx0XL1ChsaonyNwau
 1jDyyipqjVT5Kemnwpm/CkbGiei3lMQ6ZQZ/dyoSAqZzkj6TP0TocNPPiktwSF3Snw03hjWlp
 foIpZySl6ED4I9JWxA4YHqZQKzMIeQukwGuPlw==
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

