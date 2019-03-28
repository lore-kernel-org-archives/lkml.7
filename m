Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B09C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F384E21773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 11:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="gqQfIDAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfC1LcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 07:32:02 -0400
Received: from vps.xff.cz ([195.181.215.36]:46146 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbfC1LcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 07:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1553772720; bh=RL/jh1tqS5hcFdzvhLkmhG1QenqUbcnCKdrKc7yim68=;
        h=From:To:Cc:Subject:Date:From;
        b=gqQfIDAC66dFROEguwigZLQfvCziQqX71mfStOp1HnDS+HzTrVkxn47ra+ktja+qd
         cOMD51anfaPcXATIV7lazWMZyvEH2Ndb+aMcumJge/2CCa89o7wrD0TyIaMPpQ+VOU
         JwY0NoGIyyNLiP26nlrde8Q8sQk9rOcfNavngD0k=
From:   megous@megous.com
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
Date:   Thu, 28 Mar 2019 12:31:57 +0100
Message-Id: <20190328113159.9668-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

This series adds some properties to prepare for passive cooling via
CPU frequency down-regulation, and fixes cpufreq for various CPU hotplug
situations.

#cooling-cells patch is not strictly necessary now, but now that SID
changes are soon to be merged, thermal sensor patches are likely to
follow, and it will be useful in short order, I expect.

Please take a look.

regards,
  Ondrej Jirman


Changes for v2:
- split the former single patch into a series
- reformulated descriptions to accommodate the split

Ondrej Jirman (2):
  ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
  ARM: dts: sun8i: a83t: Add missing CPU clock references

 arch/arm/boot/dts/sun8i-a83t.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.21.0

