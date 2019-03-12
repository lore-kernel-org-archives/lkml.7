Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12404C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52AD206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 20:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfCLUG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 16:06:59 -0400
Received: from anholt.net ([50.246.234.109]:45248 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfCLUG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 16:06:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 0609D10A2E64;
        Tue, 12 Mar 2019 13:06:58 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id jr06HDShOxem; Tue, 12 Mar 2019 13:06:56 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id D248310A0640;
        Tue, 12 Mar 2019 13:06:56 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 440BC2FE4653; Tue, 12 Mar 2019 13:06:56 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL] bcm2835-drivers-next-2019-03-12
Date:   Tue, 12 Mar 2019 13:06:56 -0700
Message-Id: <20190312200656.30759-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

here's an updated PR on top of bcm2835-drivers-next-2019-02-01.

The following changes since commit e1dc2b2e1bef7237fd8fc055fe1ec2a6ff001f91:

  ARM: bcm283x: Switch V3D over to using the PM driver instead of firmware. (2019-02-01 10:34:32 +0100)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-drivers-next-2019-03-12

for you to fetch changes up to 7a9b6be9fe58194d9a349159176e8cc0d8f10ef8:

  arm64: bcm2835: Add missing dependency on MFD_CORE. (2019-03-12 13:01:05 -0700)

----------------------------------------------------------------
This pull request brings in a build fix for arm64 with bcm2835
enabled, and fixes the driver in the presence of -EPROBE_DEFER.

----------------------------------------------------------------
Eric Anholt (3):
      soc: bcm: bcm2835-pm: Fix PM_IMAGE_PERI power domain support.
      soc: bcm: bcm2835-pm: Fix error paths of initialization.
      arm64: bcm2835: Add missing dependency on MFD_CORE.

 arch/arm64/Kconfig.platforms    |  1 +
 drivers/soc/bcm/bcm2835-power.c | 49 +++++++++++++++++++++++++++++++++++------
 2 files changed, 43 insertions(+), 7 deletions(-)
