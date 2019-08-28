Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE447C3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D9C217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 10:07:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfH1KH4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 06:07:56 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:36337 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbfH1KH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 06:07:56 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id C07DDFF804;
        Wed, 28 Aug 2019 10:07:52 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, soc@kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] ARM: mvebu: dt for v5.4 (#1)
Date:   Wed, 28 Aug 2019 12:07:52 +0200
Message-ID: <878srdzjpj.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is the first pull request for dt for mvebu for v5.4.

Gregory

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-5.4-1

for you to fetch changes up to 644763224169e9ca2e3010c24bf4b81a6be64959:

  ARM: dts: kirkwood: ts219: disable the SoC's RTC (2019-08-27 17:05:24 +0200)

----------------------------------------------------------------
mvebu dt for 5.4 (part 1)

 - Disable the kirkwood RTC that doesn't work on the ts219 board

----------------------------------------------------------------
Uwe Kleine-König (1):
      ARM: dts: kirkwood: ts219: disable the SoC's RTC

 arch/arm/boot/dts/kirkwood-ts219.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
