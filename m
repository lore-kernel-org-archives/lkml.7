Return-Path: <SRS0=gj9M=VG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D721C73C47
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB82620861
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jul 2019 12:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfGIM74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 08:59:56 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42494 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfGIM7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 08:59:55 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:42dd:dd1c:19ee:7c60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 70FE328AC6C;
        Tue,  9 Jul 2019 13:59:53 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 0/1] counter: cros_ec: Add sync sensor driver
Date:   Tue,  9 Jul 2019 14:59:41 +0200
Message-Id: <cover.1562676020.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chromebook EC provides a counter to get all vsync coming from the back
camera.
This series introduces a patch coming from chromebook kernel 4.4 designed as an
IIO counter. As IIO counter will be deprecated in favor of counter, I rebase the
original patch and support the new counter API.

The serie need to be merged after https://lkml.org/lkml/2019/7/9/305

Gwendal Grignou (1):
  counter: cros_ec: Add synchronization sensor

 drivers/counter/Kconfig                       |   9 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/cros_ec_sensors_sync.c        | 200 ++++++++++++++++++
 .../cros_ec_sensors/cros_ec_sensors_core.c    |   1 +
 drivers/mfd/cros_ec_dev.c                     |   3 +
 5 files changed, 214 insertions(+)
 create mode 100644 drivers/counter/cros_ec_sensors_sync.c

-- 
2.19.2

