Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B29C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0903D20883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 16:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfE0QhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 12:37:16 -0400
Received: from proxy04.fsdata.se ([89.221.252.227]:50417 "EHLO
        mail-gw01.fsdata.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbfE0QhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 12:37:06 -0400
X-Greylist: delayed 911 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 May 2019 12:37:03 EDT
Received: from localhost (94.234.40.49) by DAG01.HMC.local (192.168.46.11)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 27 May 2019 18:21:47
 +0200
From:   Mattias Jacobsson <2pi@mok.nu>
To:     <dvhart@infradead.org>, <andy@infradead.org>,
        <mario.limonciello@dell.com>, <mjg59@srcf.ucam.org>,
        <pali.rohar@gmail.com>
CC:     <2pi@mok.nu>, <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] platform/x86: wmi: add Xiaomi WMI key driver
Date:   Mon, 27 May 2019 18:21:28 +0200
Message-ID: <cover.1558968964.git.2pi@mok.nu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [94.234.40.49]
X-ClientProxiedBy: PROXY02.HMC.local (192.168.46.52) To DAG01.HMC.local
 (192.168.46.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a WMI key driver for Xiaomi notebooks. To be able to
do this while using the struct wmi_driver a context field has been added
to struct wmi_device_id.

[PATCH 1/3]: Add field to struct wmi_device_id and add a helper function
[PATCH 2/3]: Add new parameter to the probe function
[PATCH 3/3]: Add new driver

Mattias Jacobsson (3):
  platform/x86: wmi: add context pointer field to struct wmi_device_id
  platform/x86: wmi: add context argument to the probe function
  platform/x86: wmi: add Xiaomi WMI key driver

 drivers/platform/x86/Kconfig                 | 10 +++
 drivers/platform/x86/Makefile                |  1 +
 drivers/platform/x86/dell-smbios-wmi.c       |  2 +-
 drivers/platform/x86/dell-wmi-descriptor.c   |  3 +-
 drivers/platform/x86/dell-wmi.c              |  2 +-
 drivers/platform/x86/huawei-wmi.c            |  2 +-
 drivers/platform/x86/intel-wmi-thunderbolt.c |  3 +-
 drivers/platform/x86/wmi-bmof.c              |  2 +-
 drivers/platform/x86/wmi.c                   | 25 +++++-
 drivers/platform/x86/xiaomi-wmi.c            | 94 ++++++++++++++++++++
 include/linux/mod_devicetable.h              |  1 +
 include/linux/wmi.h                          |  2 +-
 12 files changed, 139 insertions(+), 8 deletions(-)
 create mode 100644 drivers/platform/x86/xiaomi-wmi.c

-- 
2.21.0

