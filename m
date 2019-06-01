Return-Path: <SRS0=TpO6=UA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B449C28CC4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADD1261DE
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Jun 2019 20:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bNCcX2B/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfFAULG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Jun 2019 16:11:06 -0400
Received: from mout.gmx.net ([212.227.15.18]:42097 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfFAULG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jun 2019 16:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559419839;
        bh=ICYulOaDDu4Ey1z3HoQ0MCtyYdkzjS3YwLST+w9zPsU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=bNCcX2B//x79pHNtY8cOEAaceA40Cx+193pCmiZXG/MVHAH0VrIqta4/MAqEUQMHI
         XJ3e3FoIg8ZW/h+Dbn4LKYy28Zj9U0929xK4eqWfCMAs8FB0rKvwFrLasgoG/dKTT9
         LpfizzDRK2pJwaNDLfCmfsOYQfwEhECXDEulREWw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([37.4.249.160]) by mail.gmx.com
 (mrgmx002 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M9ra4-1hQakY3UaG-00B59S; Sat, 01 Jun 2019 22:10:38 +0200
From:   Stefan Wahren <wahrenst@gmx.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL 1/1] bcm2835-dt-next-2019-06-01
Date:   Sat,  1 Jun 2019 22:09:16 +0200
Message-Id: <1559419756-5941-1-git-send-email-wahrenst@gmx.net>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:UpB6vwyQzEh9qffJl5eMjGcqLFEdTDWnluw7jib5BIzcUYFCyGy
 OHrdVE6m/vKsFfiB6BEBKhFNczjt3IfyWJPLlK8Vg678EAD4V7reMMCJtMeh0ikLIU7V0tk
 Pkjgy5PbgCf+DAPSeGmFxkfR9aRuHH0ML5POYqjD2DHJFNWUdcF40DL3nbOdSwA1O8nsMH2
 cQexaCt8+CW48XeyCDjsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sv38ZiG8aEE=:wn5L+0PqdgvCjvmFTGhfie
 DekkTuNpCynQ98b9RFgxGCwCupwfeUCPM3z5lFI6mNOK1f4MmqgOyWGrmV4PkVZmbPdSyuee4
 VTgQES0bE8wy2LCk5fpzJrPdmo6pCuJNPIer3fZSNM0VxzH2bZDr4KdiEkvxFT2P+hpJJwPC3
 KMzOg5wXQEpt5AkA6tJrD6YGZwbcVIFWcKFsr4xc/1J/KqiwLQMdtBtzDzhwP5e7Zp1IPuMxh
 uJ9UjQ43tZlZCaI3BVt/d52ich3EpvNP26xwJ4PvpfEkrO/lg3JGUmcqY1xVsNs8Nl6DnTyDs
 MCY8yzX5lci77zsfBAyjm4iQz+U75V2w4LIj5MN8cyjnBm0L7JegBPgAAEXApy5E3tExVF9s0
 n6+w/+h7uWMm746Ns7WS+m/NPi6+4Lx6K99zU4TvduOJA6s/RcCHHczzmTB46w5Zxh2nGShYh
 CiODYJiOsOsd6dutZJKluNi6TRFAaGeaALB6vdW+tTHrrW1T0WLEAwIW3eelOYNtH4bu1G7v/
 54kWLwgL6LqbgzAfejccb/mjNb/oBeyKU1+Kn9YsPNPYXVUBFGDVDkqNfKbU/xqwmjH+pUSsn
 MYxjAqQ+k/afoEgPipPO/71IX99Hpsp/ixTBPLfgQXUdPIxglLEFZS+tPs1RMeHbC1OQXWXBI
 4aFnVz/c38YUq6kxoOY2isqeMlhpBUOAatOzU2cyFITwJX4l1zKv/nL7IjIjZ5ewAlMXMuVlP
 DLaeiIxgSgmE72DXsFPXprn0hoxR/OXH0N/k8GLJhe7jgwn13x+PDBziA3h6H9ig3Olb6zVQJ
 pWYwlKGwaHjknUShLbAiMFSMGL+1/QZL9PN/pZltKAqBDpaQnz7hrQtVFwJzvG7sk+mirk/nt
 hEQFjJZY9MSXwYMKSzvhF1IPXYq2W525v6VfhDHwnTQSuwWXvAcELv0OhdS0FjNlDTWfPu+bZ
 sOE97oVN9DiFN3mkVyOfv0yH3lR38HEY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

the following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-06-01

for you to fetch changes up to 08e3c41585386f5cefc91ede8835005742df4ba9:

  ARM: bcm283x: Enable DMA support for SPI controller (2019-05-25 12:50:18 +0200)

----------------------------------------------------------------
This pull requests enables DMA support for the main SPI controller
on all Raspberry Pis.

----------------------------------------------------------------
Lukas Wunner (1):
      ARM: bcm283x: Enable DMA support for SPI controller

 arch/arm/boot/dts/bcm283x.dtsi | 2 ++
 1 file changed, 2 insertions(+)
