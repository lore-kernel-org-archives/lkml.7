Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DD9C10F14
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:15:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71C32089C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 06:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfJLGPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 02:15:42 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:49248 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728171AbfJLGPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:15:41 -0400
Received: from localhost (unknown [192.168.167.179])
        by lucky1.263xmail.com (Postfix) with ESMTP id BF6F85DF2F;
        Sat, 12 Oct 2019 14:15:31 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P29138T140316474734336S1570860929974413_;
        Sat, 12 Oct 2019 14:15:31 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <490435b1c1e84515702e585a29fd9190>
X-RL-SENDER: jay.xu@rock-chips.com
X-SENDER: xjq@rock-chips.com
X-LOGIN-NAME: jay.xu@rock-chips.com
X-FST-TO: linus.walleij@linaro.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From:   Jianqun Xu <jay.xu@rock-chips.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jianqun Xu <jay.xu@rock-chips.com>
Subject: [PATCH 0/2] pinctrl: rockchip: support rk3308 SoC
Date:   Sat, 12 Oct 2019 14:15:26 +0800
Message-Id: <20191012061528.27821-1-jay.xu@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for rk3308 SoC from rockchip.

Jianqun Xu (2):
  dt-bindings: pinctrl: rockchip: add rk3308 SoC support
  pinctrl: rockchip: add rk3308 SoC support

 .../bindings/pinctrl/rockchip,pinctrl.txt     |   1 +
 drivers/pinctrl/pinctrl-rockchip.c            | 377 ++++++++++++++++++
 2 files changed, 378 insertions(+)

-- 
2.17.1



