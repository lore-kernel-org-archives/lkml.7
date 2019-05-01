Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4FAC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA7A20866
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 19:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SZaUrBqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfEATtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 15:49:03 -0400
Received: from mout.gmx.net ([212.227.15.18]:57667 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbfEATtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 15:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556740137;
        bh=21zQ6hHqrFQ3g2iUdFoiowCPHS6/TQd1VUg3wwhis9o=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=SZaUrBqtcwq1X7pXBzbBrTtBS+Jr9vgtIzZi7foz9VwTlN6p9xEvnOkNUakE6pga2
         gvL/8RHzmTz0K+pqPxi+DArA5pcgrfjoQeE8TVyxwp7kXEGIoSjt8pv5pT0eCayv7K
         gEdZZW1fOC5PWaQRy1WiOWwY2W+IbEykUOolMwRo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.111]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MAxyW-1hVn6z3AP6-009zm4; Wed, 01 May 2019 21:48:57 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] MAINTAINERS: Update Stefan Wahren email address
Date:   Wed,  1 May 2019 21:47:35 +0200
Message-Id: <1556740055-4962-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:f+rwKC3ASZA5zARUzjT+aTKfFX/7Q7fJ1bIFmoxL+HAxUDFYoR8
 4H4+NgGEvqIJ/4u7ig7sA6sT5KK/jox8bEbj7z6wQ5F3eTUnmxJLGnFKI0HQrdIR7o9LNu6
 gQz5mL+4ON8Z5UyQuk84AUQJ0PMI4Un2uQoy3NYCFnqLKtV5ZziRb84WTbvsvV655CzTAdV
 zzbxJOjVu2Q/fhqBgy+BA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0w6+BajR9i8=:fTwrj/p6wwBuGwdA0a7fn+
 7U5HXEnj4BKaQMGwJxDP65dFWTkEA6TMKvg2cN7PO251fO0wrbzxmRv+xf+fqKvY2J3NqyRmL
 wu3IDdHB4g0o2plLCZYfOA9a4fQOxBtpySZ78FuzrxlFc7bZumiUsrOesom/OvtL+i7d+xP95
 CcgUkpoHo0eE94jNZ9rqiJygMlP4VV+m57oDumsLtKQw4Kri67XQ7JLMD4xXFvBVz6ubmNJJY
 qwAuK7pBXrgEq3VlrRCSrX2wLRSrpuXdsjkNgciHpuZ5tqGVfYWGR7H79swIs+hdi3mMUEb9w
 o/whKNyf7dwy/bainOeIFUM+7vtGwEXrleZr/xPHt+p8z8KC1eYyU6aMmmGPj32V/6cPzFjw7
 8khAXeKRRC37jJ8wS2wsI59EDZ6zftf9FOGYYdyMUKbzNFFMZgaRi+NTD3C47CwjfxwxeSzrs
 Z1bitLLQ0ulMIZagL7rhdi937FGcQrtmiVrFeR7rUSs8p3FUxmNEHdaPMRdjltkKQRzhx8tc7
 QnotSf8//75DB+Zfc5f2enqoG+CjngoV6MkgFzLXazIU5+/sDJfEDgdHgvMbQ6Uj2h08uuiTY
 VmcXP87OA5TNoj6bAT88oUkuusdUkqJ41km9v2O7OObJLnz/25Ih0bTOksC67/ezaMkWezA6P
 62DpzbT8UbAAmPAzIcrxJS6LU7ThkDZSg31LR3qoPI0a/jprOTAaFzuDcdQ4ECCHPFXLsZBjt
 jFfonXyAaf+CgBBHQIaRc6NG3hgYPJa9sW7p1vrEAfnJP8V82Yf4VT27F1pphvXUuuV0BQVgX
 bjpeSe4t42laKfhNylpWIf0zWhFjPv0bDDobIMaJ+e4MXZVlqQHY2CC9RMjbfcpbY3F1nfkpQ
 kj4FWeFT0CAd3Kx2yndB3Ph1wCjjcdeFMsglO5oylyYFMxvsJs9OiAMS5g+lpi
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2SE has been acquired, so i decided to use my private address now.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c7d4e1..75a7876 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3068,7 +3068,7 @@ F:	arch/arm/mach-bcm/

 BROADCOM BCM2835 ARM ARCHITECTURE
 M:	Eric Anholt <eric@anholt.net>
-M:	Stefan Wahren <stefan.wahren@i2se.com>
+M:	Stefan Wahren <wahrenst@gmx.net>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/anholt/linux
=2D-
2.7.4

