Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A514CC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC862084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726705AbfDCNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:42:09 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:49258 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfDCNmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:42:07 -0400
Received: from sugar.zhang?rock-chips.com (unknown [192.168.167.12])
        by regular1.263xmail.com (Postfix) with ESMTP id C65B61FE;
        Wed,  3 Apr 2019 21:41:51 +0800 (CST)
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P16332T140353604671232S1554298910639057_;
        Wed, 03 Apr 2019 21:41:52 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <7bb30713ff8bcbe5ad130c5536729ab7>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Sugar Zhang <sugar.zhang@rock-chips.com>
To:     heiko@sntech.de, broonie@kernel.org
Cc:     linux-rockchip@lists.infradead.org,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 0/12] Patches to update pdm for rockchip socs
Date:   Wed,  3 Apr 2019 21:40:44 +0800
Message-Id: <1554298856-59028-1-git-send-email-sugar.zhang@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches to add support pdm for rk322x/rk1808/rk3308/px30 socs
and fix some issues.


Sugar Zhang (12):
  ASoC: rockchip: pdm: fix regmap_ops hang issue
  ASoC: rockchip: pdm: using left justified store mode
  ASoC: rockchip: pdm: add default regs
  ASoC: rockchip: pdm: optimize clear logic
  ASoC: rockchip: pdm: change dma burst to 8
  ASoC: rockchip: pdm: fixup pdm fractional div
  dt-bindings: sound: rockchip: add compatible for rk3308/px30
  ASoC: rockchip: pdm: add compatible for rk1808
  dt-bindings: sound: add compatible for rk1808
  ASoC: rockchip: pdm: adjust waterlevel in frame unit
  ASoC: rockchip: pdm: Mark RXFIFO_DATA as volatile and precious
  ASoC: rockchip: pdm: Correct PDM_CTRL0 reg value

 .../devicetree/bindings/sound/rockchip,pdm.txt     |   5 +
 sound/soc/rockchip/rockchip_pdm.c                  | 209 ++++++++++++++++-----
 sound/soc/rockchip/rockchip_pdm.h                  |  12 ++
 3 files changed, 180 insertions(+), 46 deletions(-)

-- 
2.7.4



