Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FD3C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 17:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6CDB207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 17:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="cGgTkaLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfKXRt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 12:49:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:57973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbfKXRt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 12:49:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1574617754;
        bh=jQma2DMj2OUi4IPrSs74a2mg2cXB6B2ePPUkQZc5R8Y=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=cGgTkaLv91MXn8FFV24WZNykVu73qFhAgjua3LvWKj2Ujq4B4iArjaHS4K0BGWtAP
         +3Ke83aaB8Ilmaoe127yfU66sttBmYL+8aQnCxqAMggxjZsH4tFIW8H/LNMnYOxzS3
         vtgnxSvZ8KvWf/7tVmQKF53VOrfFszHPU9C/DwMs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.139]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBm1U-1iggJa0Xm8-00CDLe; Sun, 24 Nov 2019 18:49:14 +0100
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH] MAINTAINERS: Make Nicolas Saenz Julienne the new bcm2835 maintainer
Date:   Sun, 24 Nov 2019 18:48:53 +0100
Message-Id: <1574617733-18151-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:yxP93BJoRRCg5PQKqyRpoYwf8+5viy9m3Zo5KM0CcYx+07oZVOK
 1g2KmEWyKVOmdpQELfS2LTL3jU7/ORWc+GpxjNFyK+pJ+5eahWzLy24rwNxsnFVqoha3mvJ
 1Ez6ZV40QvzGr9mDLViRKYlNxpxjXE+FjwxTFtqy7veIhNZZddsnn/fPYHvKb3NGHF2bmxv
 9FSbU7jQO3zqIEcpBJhzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UYCg+ruJbMk=:CJ3HuR8QCyD2yvloLZTove
 jR5gbpG/yUe8IHyByPQR/y7BN8CHZ2OjPIcUupbZwZS9yB88iWg+K0/K3yQxLkuXhUzKUo1mK
 4wgLAcIQ/H88KuRbZm/hiAxxpbzVchU+i/UWwLhKoo3rUQeVUBHsc2tuIKtXtOR4FsrjI+TWE
 aHF2TxUWcXehn3uBE+xPas4cHi3GARiZM6S8eTYcN1oSA0fREerhXgH90l1gniP/cr0n6CCWD
 +6V4kSGbGq1mXmKLj64Dmsy1n+1I1j5cThXketnRX2XA56Un3ryDH2ezbo7UBD5khFz1lw676
 WxnZnXBiT+YaMofXlOZBAwpuB4ucG4taC4Xm7E9+AOSkRXVJQLiextByzb52BXYCnXQZEKqCJ
 jb22K4TL9AvawifYEU9N/CKDtLlkHDTuxhZRSJMZdJyn97e5uGKBtCxLUbIE6RQpe8KY2eQTD
 L7KrP4AySohGn4+xkPxp8dmSUvHsqQ/grBKj7ayL/8ajRP0WfyjSE5n2uZPUUb8XuQM+SJODF
 eLUSDxGQvrBP8EkQyykQnQpGKqxO+rNADUKQnBqA9RdMrcpGJquSBKg7ZuhhBYH5Mc63VxtWa
 67p6kjRgZlISEotq3rsiTjgafwyPMa9Q+8gA6PNmXR3HirCfzfstbBrWRfKOcsQ9OASCEp913
 PyugfFvqJU5EGVpv0ZmougjjEbs22kmlZ4Gkm0DS4AZnP4purwycJtfHButrRtVg4Q0zsyqDG
 jvsKSC9sBKgHTS1TmvVqZXbzOR1v4ru3mFzMsX9XoXYm2m+l/zrn8oEFdSzD7GfiiYL1Ff64H
 JX2gIf13PPbQuqYin1yVur76wPxRb/IIP1csxOrGj2TXv+3xFmbbByscwsMDprY5DjEzHK3OJ
 WRSVD0hbqVyQAQAN0bIBJENd7dWv0U6iACFDNCyF9Y+Z+gOgOE5pk2s9jVMAuCtlRt4B2npDn
 CSAADWAFRxvgRsLoIWPLaMDQQnqRu20S5DUO8hRydg4T2qTmC6p/flWm+TinAgNbqwc5nzTUL
 7dho9pbXettZ8F08/x0zR+bNDF9mQttiNmNuNhMFvq5eBZaZls/NnU4udwU4tn2ykYD6YiHSM
 r0P5WeAAUWco7Y9KIzQk4XRJWo5HaWRjkYAgUQrdOjHhPb7gJ0G8SP3sf2QfRvLlrHZcc7966
 oJbWGqqTvi7pMlqMEygoLD1qIyDzSGGHX4rASrvMqlcaMIQMonmIIGWNcfcPDc5EbF3IHVrbP
 eLYWkdNuyfHGylvmoKK121FmAwNHKKRgMoOhAbg==
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eric isn't active any more and i don't have the necessary free time.
Nicolas already made contributions to bcm2835 and is pleased to take
over the maintainership. My thanks go to both of them.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 512e527..4285190 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3224,8 +3224,7 @@ N:	kona
 F:	arch/arm/mach-bcm/

 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
-M:	Eric Anholt <eric@anholt.net>
-M:	Stefan Wahren <wahrenst@gmx.net>
+M:	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
 L:	bcm-kernel-feedback-list@broadcom.com
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
=2D-
2.7.4

