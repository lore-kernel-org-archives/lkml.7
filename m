Return-Path: <SRS0=Meup=2V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B8C2D0C2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1F1206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Dec 2019 10:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfLaK31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Dec 2019 05:29:27 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:60196 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726674AbfLaK30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Dec 2019 05:29:26 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 31 Dec 2019 12:29:19 +0200
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xBVATJ7X008518;
        Tue, 31 Dec 2019 12:29:19 +0200
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v1 0/9] platform/x86: Mellanox new system classes and new features
Date:   Tue, 31 Dec 2019 10:29:08 +0000
Message-Id: <20191231102917.24181-1-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset adds new features for the existing Mellanox systems
and introduces two new system classes.

Patch #1 adds new attributes.
Patches #2-#3 extend documentation.
Patches #4 contains cosmetic changes.
Patches #5-#6 introduce new system class for the systems equipped with
Spectrum 1 (32x100GbE Ethernet switch) device and Switch-IB/Switch-IB2
devices (36x100Gbe InfiniBand switch).
Patches #7-#8 add support for new group capability register
Patch #9 introduces new system class for the systems equipped
with new switch device Spectrum 3 (32x400GbE/64x200G/128x100G Ethernet
switch).

Vadim Pasternak (9):
  platform/x86: mlx-platform: Add more definitions for system attributes
  Documentation/ABI: Fix attributes for mlxreg-io sysfs interfaces
  Documentation/ABI: Add new attribute for mlxreg-io sysfs interfaces
  platform/x86: mlx-platform: Cosmetic changes
  platform/x86: mlx-platform: Set system mux configuration based on
    system type
  platform/x86: mlx-platform: Add support for new system type
  platform/x86: mlx-platform: Add support for new capability register
  platform/mellanox: mlxreg-hotplug: Add support for new capability
    register
  platform/x86: mlx-platform: Add support for next generation systems

 Documentation/ABI/stable/sysfs-driver-mlxreg-io |  83 +++-
 drivers/platform/mellanox/mlxreg-hotplug.c      |  14 +
 drivers/platform/x86/mlx-platform.c             | 564 +++++++++++++++++++++++-
 include/linux/platform_data/mlxreg.h            |   2 +
 4 files changed, 643 insertions(+), 20 deletions(-)

-- 
2.11.0

