Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E03DC04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB74321479
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 09:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbfEHJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 05:20:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42056 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfEHJUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 05:20:05 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 743EC260DB0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: [PATCH v4 0/3] mfd: cros_ec: Instantiate CrOS FP and TP devices
Date:   Wed,  8 May 2019 11:19:53 +0200
Message-Id: <20190508091956.5261-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Sorry for the delay, this is a new version rebased on top of
for-mfd-next tree solvind the conflicts with due the already applied
patches.

The first version depends on:

- mfd: cros: Update EC protocol to match current EC code
  - https://lore.kernel.org/patchwork/patch/1046363

But there were some concerns on how to update this file properly, so
meanwhile we figure out the proper way, let's introduce only the required
fields for this series.

The series adds support to instantiate two special CrOS EC devices, a
fingerprint and a touchpad.

Best regards,
 Enric

Changes in v4:
- Removed the patch to instantiate the ISH device as was already applied.
- Rebased on top of for-mfd-next branch.

Changes in v3:
- Fix Andy Shevchenko email.

Changes in v2:
- Add a patch to introduce the required enums to build.

Enric Balletbo i Serra (3):
  mfd: cros_ec: Update the EC feature codes
  mfd: cros_ec: instantiate properly CrOS FP MCU device
  mfd: cros_ec: instantiate properly CrOS Touchpad MCU device

 drivers/mfd/cros_ec_dev.c            | 20 +++++++++++++++++
 include/linux/mfd/cros_ec.h          |  2 ++
 include/linux/mfd/cros_ec_commands.h | 32 +++++++++++++++++++++++++++-
 3 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.20.1

