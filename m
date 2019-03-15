Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B11FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A7620449
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfCOO7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:59:15 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:41824 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727013AbfCOO7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:59:14 -0400
Received: from localhost.localdomain (85-171-63-107.rev.numericable.fr [85.171.63.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aballier)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 0D13F335C97;
        Fri, 15 Mar 2019 14:59:11 +0000 (UTC)
From:   Alexis Ballier <aballier@gentoo.org>
Cc:     Alexis Ballier <aballier@gentoo.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Small improvements/bugfixes to the rk3399-opi dt
Date:   Fri, 15 Mar 2019 15:58:15 +0100
Message-Id: <20190315145818.23610-1-aballier@gentoo.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on the rockchip/v5.2-armsoc/dts64 branch and
fixes a few mistakes in the rk3399-orangepi.dts I sent a couple weeks ago.

Alexis Ballier (3):
  arm64: dts: rockchip: rk3399-orangepi: Fix clock names and add missing
    supplies for bluetooth
  arm64: dts: rockchip: rk3399-orangepi: Specify vid supply for the
    compass (AK09911)
  arm64: dts: rockchip: rk3399-orangepi: Add the fusb typec manager

 .../boot/dts/rockchip/rk3399-orangepi.dts     | 31 +++++++++++++++----
 1 file changed, 25 insertions(+), 6 deletions(-)

Cc: devicetree@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

-- 
2.21.0

