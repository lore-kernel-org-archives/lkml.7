Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725E3C3A59B
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 490532084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 18:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZKwCb7GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfHOSen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 14:34:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:35169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732731AbfHOSel (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 14:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565894066;
        bh=oUegn+OzzqrlGQ58We8pXrOWyGGRz5WOSepueZRR5DE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZKwCb7GTHVfyn52jUflQssEZbYOYkYMe+r7AyH//cQ0gIivV+8OrsRDQ+SX1fD9EI
         D/UzzkAfF1h1iWJv7fRxLgkEgkm5MljRyooGWt+2sHpc2m6f2QjvX3qgyKacyUtzR6
         4lfbkosYQSi4K/9uNJbJWoE4dcQkKi0wARGv8LKg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.106]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MG9g4-1i3okQ0UJg-00GW9g; Thu, 15 Aug 2019 20:34:26 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/3] bcm2835-dt-next-2019-08-15
Date:   Thu, 15 Aug 2019 20:34:01 +0200
Message-Id: <1565894043-5249-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:RvoNJciCciw+BH2y7lrTfNZLSc2nmRjVwvWGSPVn24kWoufePuA
 Voc3A92Wwatp4m0PEWYnvhRg07YpZT6p9q7ktWEc4dsiIl8Qudifu5zaqJ9WBNHmo88dXWl
 q8ZxGm8ig7B6qRf3Ub32E5we2xEo9Q3HseIirD1AH84BFsPe0wM8lfhsflh69s5QPbaelsy
 E23UsZk0NU5aBPx1WABjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:X+5paVtZqY0=:xjZa8BcP1d/9n1T8srkcbn
 L4tGraW3wKTTDiyOUq/J60nBusFRHYXqV4jsQgZem9GURAfPukCsBBoQyBMaIhjyPZ4I3oeGj
 Hu71JdRyaxzh8Nz0h9hwdwsWoqHWO+VmzYvMgPimq5Cxgiu06q7K0b8FDzWRR3mOP3E1NNkxu
 p2r5C9VdV2pP9MAQGx+Js9/j97Es4+LuwetLWd0/1+U/TlWfJLdW3Kno4NErIJHD0P2V1eBnF
 RoTSyIhjcLovlcZ6lHS239X4ifSHV0UuxENLuZ664Dbb1ij9DSOnwFWuh44UbmTBFv99wVUJi
 1LvkVOoROSnMLE7MnL74loN7AdVX97ZiD3aoyo+tqF1EWFDtS4RaNR8iN9/y8Uq6dtCi6UTQS
 FmqANq9YkZY68hcaYewAmYsob34tamK3NEjIx9cPLv25Qt0oZNbau+hZ/RwXb/ka7zgZtnslN
 UsQFBzXh6AGExMaPNMaXj0VQnwHsdgLPhSzmN2cCbBEKrSxC2Pc+We0bqM0A8FT4W4OMzXLww
 p+dZKcdi10n898JckcYC3nHVzUqqzP4SYJMw096BMJl6/pWtndKqrHbJ8wxdVU0TksTlzG+6M
 V5ooc1mpi8X2ChdXorNJ/61c0E47i7G6nnHm3rO/3od8AjkQXalqyDO42HK3BKtlCPfbR9BUV
 yS/EZLsovFGteRPEtWR/UeJPVqmP/B4j1d+DhPKkn8pd03Rfwndz3bt1XwEdFJI5aYibNyNpQ
 RX4Ngk1GLq8CFie77SS1rlh3GNLrb166a4dfmf6zHZDeTv7RN5DJtwy3C6CQtQAHhOIT2vJLV
 en7xwk+0JHkbcT8MVYM/qqG3FKu/KGGKqpliIa3aDCmFOt2Es/1TCiFWwu6FRgw46QwGBAzqc
 36oKUkiNbob9tysHrmLtTv+z8UhIL82aO+jn0TyC2HEHMTyTmnEThEgqG8M7Vf8V+6LK0yXIy
 sLZ/cwtqzLTPVPXd9IrI70ZV6v7G1IHLQ8TBkhl1mwJ5h1Qwmtm+VLAOXUpl4UYXanCOcoBh8
 UTKYM9VrulAlpSU3FjrnyxZgWOIh7TyGY18m+jXhysmH6kQCpdu9yFsvwWne2F2wyZQR0O0T1
 8C4iI7i1UTaOBsG44KQXijy2uHMzQzA/XwgbjlJzLNzWgC+VIdGaxAqKQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-08-15

for you to fetch changes up to 60c833d5664e1b3f71c4471233469790adf505ca:

  ARM: dts: bcm283x: Enable HDMI at board level (2019-08-15 19:35:15 +0200)

----------------------------------------------------------------
This pull request prepares the BCM2835 DTS files for the introduction
of the new SoC BCM2711.

----------------------------------------------------------------
Stefan Wahren (4):
      ARM: bcm283x: Reduce register ranges for UART, SPI and I2C
      ARM: dts: bcm283x: Define MMC interfaces at board level
      ARM: dts: bcm283x: Define memory at board level
      ARM: dts: bcm283x: Enable HDMI at board level

 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts   | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-a.dts        | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts   | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts   | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-b.dts        | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-cm1-io1.dts  |  9 +++++++++
 arch/arm/boot/dts/bcm2835-rpi-cm1.dtsi     |  5 +++++
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts   | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts     | 14 ++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi         | 23 -----------------------
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts      | 10 ++++++++++
 arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts |  3 +++
 arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts |  3 +++
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts      |  3 +++
 arch/arm/boot/dts/bcm2837-rpi-cm3-io3.dts  |  9 +++++++++
 arch/arm/boot/dts/bcm2837-rpi-cm3.dtsi     |  1 +
 arch/arm/boot/dts/bcm283x.dtsi             |  6 +++---
 17 files changed, 144 insertions(+), 26 deletions(-)
