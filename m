Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE7BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21E09206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfCEACW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:02:22 -0500
Received: from anholt.net ([50.246.234.109]:56892 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbfCEACW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:02:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 61E1B10A2DEF;
        Mon,  4 Mar 2019 16:02:21 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id dMUnKTnjLPIR; Mon,  4 Mar 2019 16:02:20 -0800 (PST)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id EB09B10A2DEE;
        Mon,  4 Mar 2019 16:02:19 -0800 (PST)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 817482FE464E; Mon,  4 Mar 2019 16:02:18 -0800 (PST)
From:   Eric Anholt <eric@anholt.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Subject: [GIT PULL 1/2] bcm2835-dt-next-2019-03-04
Date:   Mon,  4 Mar 2019 16:02:17 -0800
Message-Id: <20190305000218.15180-1-eric@anholt.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

The following changes since commit ab1b4ef966af90ad79fa3c4c124e47915cddde10:

  ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-02-01 11:56:32 +0100)

are available in the Git repository at:

  git://github.com/anholt/linux tags/bcm2835-dt-next-2019-03-04

for you to fetch changes up to 544e784188f1dd7c797c70b213385e67d92005b6:

  ARM: dts: bcm283x: Fix hdmi hpd gpio pull (2019-03-04 15:50:10 -0800)

----------------------------------------------------------------
This pull request brings in a fix for detecting HDMI on the Pi B rev 2.

----------------------------------------------------------------
Helen Koike (1):
      ARM: dts: bcm283x: Fix hdmi hpd gpio pull

 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
