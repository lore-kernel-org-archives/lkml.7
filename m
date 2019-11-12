Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668ECC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A40621783
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 22:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbfKLW76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 17:59:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:40138 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbfKLW75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 17:59:57 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4DF681A0A61;
        Tue, 12 Nov 2019 23:59:56 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 14F9E1A07FB;
        Tue, 12 Nov 2019 23:59:56 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 5646840CB6;
        Tue, 12 Nov 2019 15:59:55 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     arm@kernel.org, soc@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org
Subject: [GIT PULL] updates to soc/fsl drivers for next(v5.5)
Date:   Tue, 12 Nov 2019 16:59:55 -0600
Message-Id: <1573599595-31411-1-git-send-email-leoyang.li@nxp.com>
X-Mailer: git-send-email 1.9.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc maintainers,

Please find the pull request for a new NXP/FSL SoC driver to support system
wakeup with RCPM IP.

Regards,
Leo

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/leo/linux.git tags/soc-fsl-next-v5.5

for you to fetch changes up to 3b8db0348c503823fb09b5f304b196c3362754ea:

  soc: fsl: add RCPM driver (2019-11-12 15:26:05 -0600)

----------------------------------------------------------------
NXP/FSL SoC driver updates for v5.5

RCPM driver for ARM SoCs
- add RCPM driver to manage the wakeup devices for QorIQ ARM SoCs (HW low
power states are supported in PSCI firmware)
- add API to PM wakeup framework to retrieve wakeup sources

----------------------------------------------------------------
Ran Wang (3):
      PM: wakeup: Add routine to help fetch wakeup source object.
      dt-bindings: fsl: rcpm: Add 'little-endian' and update Chassis definition
      soc: fsl: add RCPM driver

 Documentation/devicetree/bindings/soc/fsl/rcpm.txt |  14 +-
 drivers/base/power/wakeup.c                        |  54 ++++++++
 drivers/soc/fsl/Kconfig                            |  10 ++
 drivers/soc/fsl/Makefile                           |   1 +
 drivers/soc/fsl/rcpm.c                             | 151 +++++++++++++++++++++
 include/linux/pm_wakeup.h                          |   9 ++
 6 files changed, 235 insertions(+), 4 deletions(-)
 create mode 100644 drivers/soc/fsl/rcpm.c
