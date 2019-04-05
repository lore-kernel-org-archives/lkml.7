Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD07C282CE
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E829D20651
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 17:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfDERde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 13:33:34 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35904 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbfDERde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 13:33:34 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 44B34282291
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     lee.jones@linaro.org
Cc:     gwendal@chromium.org, bleung@chromium.org,
        linux-kernel@vger.kernel.org, groeck@chromium.org,
        kernel@collabora.com, dtor@chromium.org,
        rushikesh.s.kadam@intel.com
Subject: [PATCH v2 0/4] mfd: cros_ec: Instantiate CrOS FP, TP and ISH devices
Date:   Fri,  5 Apr 2019 19:33:20 +0200
Message-Id: <20190405173324.22118-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

The reason I'm sending this patch series is to clarify the build
dependencies of the following patches:

[PATCH 1/2] mfd: cros_ec: instantiate properly CrOS FP MCU device
[PATCH 2/2] mfd: cros_ec: instantiate properly CrOS Touchpad MCU device

and I also included this patch in the series:

[v3] mfd: cros_ec: instantiate properly CrOS ISH MCU device

The first version depends on:

- mfd: cros: Update EC protocol to match current EC code
  - https://lore.kernel.org/patchwork/patch/1046363

But there were some concerns on how to update this file properly, so
meanwhile we figure out the proper way, let's introduce only the required
fields for this series.

The series adds support to instantiate three special CrOS EC devices, a
fingerprint, a touchpad and an integrated sensor hub.

Best regards,
 Enric

Changes in v2:
- Add a patch to introduce the required enums to build.
- Add a patch to instantiate the CrOS ISH device to the series.

Enric Balletbo i Serra (3):
  mfd: cros_ec: Update the EC feature codes
  mfd: cros_ec: instantiate properly CrOS FP MCU device
  mfd: cros_ec: instantiate properly CrOS Touchpad MCU device

Rushikesh S Kadam (1):
  mfd: cros_ec: instantiate properly CrOS ISH MCU device

 drivers/mfd/cros_ec_dev.c            | 33 +++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h          |  7 ++++--
 include/linux/mfd/cros_ec_commands.h | 34 +++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 3 deletions(-)

-- 
2.20.1

