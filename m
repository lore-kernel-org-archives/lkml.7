Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676D7C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA8C20854
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 17:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZZ3IiUFi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbfJORQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 13:16:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:41431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726277AbfJORQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 13:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571159776;
        bh=9dMNkXc7Wl6IG0uHi4EqAl9fkyGnM68M4ko1GOKDM+I=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZZ3IiUFiORG790kdmW8tkTi49moxiVzWxRq0FKc2vGxyQ84M3f4HDw/fjVX8Q5i5Z
         Jmmj10zFvk0r+z57OmgbDxYpce1ajN37GW/Bm97Z+p1OhWUvdwHmK07+Yr2hbY/MFL
         MMuq/U184GuDcaahG3xRgqeavRXyGwXW/hCwUGik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.112]) by mail.gmx.com
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYvcA-1iXVIW1mVs-00Usl4; Tue, 15 Oct 2019 19:16:16 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 2/3] bcm2835-soc-next-2019-10-15
Date:   Tue, 15 Oct 2019 19:15:24 +0200
Message-Id: <1571159725-5090-2-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
References: <1571159725-5090-1-git-send-email-wahrenst@gmx.net>
X-Provags-ID: V03:K1:nxJbL6YJbzjWpvCCYQa4+np4ND3HWUDVXG+oRmnro60b6X65y+E
 iPBlS10N/nV+ZA7FMhV+labQl7VKSPy45aPwvpd9yT0LaE+477SNHYMMa8UJcBCjwGpNeC1
 6aFgoDYF3RrUPU6x8svorm1+OB3TrIKBxiYfCGMIcgjIKPNRa01vtdTa9O4ayWlNCeiqxU1
 jzhe/6tlnLj/+IvIdIYSw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AFMnkk/tSf4=:n3CX8JjmqmhsNCpz9jNnZ4
 bZr7DgFOVNdFwf2OKcvysqCyhlTSARbJe1GwdvLIgXptqj71FZLva0eEp3KIB3+VE79Z29xa7
 /UNi2sjh517LVOGGrVuqBNWHQyh2VpHGBkNCQaE+3fsUQbRbcJSCifI03PxibQ0a/FDcp80Kd
 zqTaE5XN7LLLL7lP4WN4WFtXLBIqe5kxQSA1T3Kc9XpIOOiKPTDQD15XPS///wuWZXAv40ISR
 eTurFPBEww/wPwACQeB1I5qIJOKnbwipdWyvfQX9bdBc4YGE9C5KJBxOq/MjZUkAT7r2K3sKP
 ZawS4PhpFN4bfVocaQl+lueK9fM1LJdOzs+nxUxo4r5o+bpjER1cCP39R/dC7DuGDETF0bY1k
 zreFpWGgQp4r/WJs9Qzu1gZxZe5LCE6tiSwTfoWb/2+BL8pzL/liB7/Lfyk+imBs50hyTYlTw
 ElmruR5zcb3+Mp/iXQ61Frq1594orJvaLbUqjpuVw8OM9bi2vX10TWi6eonJJvqAtgX46BwrH
 wFEbx/9L/BC0jzGkkWCjMz42i+rXjJY23ORj3zmDCIg9snqS6ExQzN9mjHmNaB3quGkmqdBmz
 lXKR5WaKoDqYBl4rR0qTf2WQBwImx5Xv6JRQYr96t8zGQBS6NNRAzipu3Skv1257DfYmyrIFi
 Ap4/E2byNc1g0JEgz1qOqUAKE6lJy9RwJnJ83tbgsQoMG9+Ta39kdXOLOc2ZzEqSZu5sNXCmA
 Xc7P2qFB9gnipm0qqy11mGGP8rBUTaBMfP8thtBgxAPSoUw/l/R7DgovckInt77u202DGMXvK
 HRVIBtiC6ujMinl7bQOkZbo1ztavKcZIP3QvxRzza7JLuJnrV/mM3hIs7Nc+XYqurjjTae2WB
 1sSAjohBXQTw4ljqq1bhD12+kafuGhQwxgyCxJ3hNSEJRCGNsSb2V/0oLSPtosIqqvjfV0wbV
 WSWd1X75Yh8mie7seSu2DYGmVLluiJaen8DM8wyfn/k7kGF8Rg+QLKB6Nt5/sA/+bOJ3j4czN
 UfLg+6A2dGPOyM4AVcyX7i0nZ/Ytt62cGfuiorkENvKxuwfOX2ICb3e1HHuT8bjESbKIyvU7Y
 rN3uQiomeJ3/c7hZDg+CdOMuEGWNo9CReERkpAItddmv6epcXKjj6/P+awAZak3xUx4Ixzm1n
 6FQZNwXIwLnxsaH4xWI7nlck0WoVsS/shYJ6CozFX+7etrXn1iAfyIYRWs0NS4bIcGyyHUwNF
 aLCGD8c7dmowGiDEnoNgOgGpjDe/PvSPjJpm1aQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-soc-next-2019-10-15

for you to fetch changes up to 781fa0a954240c8487683ddf837fb2c4ede8e7ca:

  ARM: bcm: Add support for BCM2711 SoC (2019-10-10 19:21:03 +0200)

----------------------------------------------------------------
This pull request introduces the machine board code for the BCM2711,
which is placed on the Raspberry Pi 4.

----------------------------------------------------------------
Stefan Wahren (1):
      ARM: bcm: Add support for BCM2711 SoC

 arch/arm/mach-bcm/Kconfig    |  4 +++-
 arch/arm/mach-bcm/Makefile   |  3 ++-
 arch/arm/mach-bcm/bcm2711.c  | 24 ++++++++++++++++++++++++
 arch/arm64/Kconfig.platforms |  5 +++--
 4 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-bcm/bcm2711.c
