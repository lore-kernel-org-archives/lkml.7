Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7D3C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1229920880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 13:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="SNT6xNHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfDANgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 09:36:14 -0400
Received: from vps.xff.cz ([195.181.215.36]:58888 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfDANgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 09:36:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1554125771; bh=XvlpdAQWdLnYNv2ACJX4lDmwD7jXIn9BkbFivjmaU1E=;
        h=From:To:Cc:Subject:Date:From;
        b=SNT6xNHbi/xWpOsxEmTY59Oy2ZGiiaGbUVzi6PsCmonyabRRNWQVuRw+HhH3lOyPf
         VtaMeyoiWv/oG8ywP8nR+9cf9PSmkzK30ax0iUUHiLc8rQadlFKVPPayWtCOY3Top/
         MAmrTvxsVLIuHtcTsgw/qtP7wUiuN+oLsRIlc2Sw=
From:   megous@megous.com
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] ARM: dts: sun8i: a83t: Add missing cooling device properties for CPUs
Date:   Mon,  1 Apr 2019 15:36:09 +0200
Message-Id: <20190401133610.17916-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

(Part of the series was already applied, so this only contains the
remaining patch.)

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
Changes for v3:
- removed already applied patch
- re-ordered clock properties
- removed clock-names (not needed and not documented)

Ondrej Jirman (1):
  ARM: dts: sun8i: a83t: Add missing CPU clock references

 arch/arm/boot/dts/sun8i-a83t.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.21.0

