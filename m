Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F86C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C18BA22BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 05:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403802AbfGYFcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 01:32:17 -0400
Received: from comms.puri.sm ([159.203.221.185]:59486 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403750AbfGYFcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 01:32:13 -0400
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id DA12CE048D;
        Wed, 24 Jul 2019 22:32:12 -0700 (PDT)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BHbscUMLiBDJ; Wed, 24 Jul 2019 22:32:12 -0700 (PDT)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     lorenzo.bianconi83@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 0/5] iio: imu: st_lsm6dsx: Add support for LSM9DS1
Date:   Thu, 25 Jul 2019 07:31:27 +0200
Message-Id: <20190725053132.9589-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resend 2 of Lorenzo's patches that this builds upon. They have been previously
posted to linux-iio only:
https://lore.kernel.org/linux-iio/cover.1563226641.git.lorenzo@kernel.org/

Then, add support for the LSM9DS1 accel/gyro unit in 3 simple steps. This
is also only a resend and rebase of the v2:
https://lore.kernel.org/linux-iio/20190716093325.7683-1-martin.kepplinger@puri.sm/

So I call this v3 and Lorenzo, I hope that it's fine for you that I just
take your patches here - also since they mention to be intended for supporting
the device.


revision history
----------------
v3: rebase and add Lorenzo's patches in order to apply to the iio testing brach
v2: further simplifications based on Lorenzo's feedback
v1: initial change for adding lsm9ds1 support




Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: move odr_table in st_lsm6dsx_sensor_settings
  iio: imu: st_lsm6dsx: move fs_table in st_lsm6dsx_sensor_settings

Martin Kepplinger (3):
  iio: imu: st_lsm6sdx: move register definitions to sensor_settings
    struct
  iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
  dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig            |   1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  12 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 490 +++++++++++++++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
 6 files changed, 440 insertions(+), 74 deletions(-)

-- 
2.20.1

