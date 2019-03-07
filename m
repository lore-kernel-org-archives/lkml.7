Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94345C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F8620661
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:53:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfCGRxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:53:03 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38696 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:53:02 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C51D927F510
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        bleung@chromium.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] mfd: cros_ec: instantiate CrOS FP and TP devices
Date:   Thu,  7 Mar 2019 18:52:51 +0100
Message-Id: <20190307175253.14785-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds support to instantiate two special CrOS EC devices, one
is fingerprint and another one is a touchpad. This patchset depends on
the following patches to apply cleanly and build.

- mfd: cros: Update EC protocol to match current EC code
  - https://lore.kernel.org/patchwork/patch/1046363

- mfd: cros_ec: instantiate properly CrOS ISH MCU device
  - https://lore.kernel.org/patchwork/patch/1047022

Best regards,
 Enric

Vincent Palatin (1):
  mfd: cros_ec: instantiate properly CrOS FP MCU device

Wei-Ning Huang (1):
  mfd: cros_ec: instantiate properly CrOS Touchpad MCU device

 drivers/mfd/cros_ec_dev.c   | 20 ++++++++++++++++++++
 include/linux/mfd/cros_ec.h |  2 ++
 2 files changed, 22 insertions(+)

-- 
2.20.1

