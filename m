Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68EC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC52206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfLPMad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:30:33 -0500
Received: from sauhun.de ([88.99.104.3]:39770 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727634AbfLPM3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:29:48 -0500
Received: from localhost (p54B33297.dip0.t-ipconnect.de [84.179.50.151])
        by pokefinder.org (Postfix) with ESMTPSA id 6D1362C2D79;
        Mon, 16 Dec 2019 13:29:46 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 0/5] media: replace i2c_new_probed_device with an ERR_PTR variant
Date:   Mon, 16 Dec 2019 13:29:40 +0100
Message-Id: <20191216122946.3495-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the on-going mission to let i2c_new_* calls return an ERR_PTR instead of
NULL, here is a series for this subsystem converting i2c_new_probed_device() to
the newly introduced i2c_new_scanned_device(). Based on v5.5-rc1 and build tested.
Please apply via your tree.

Thanks,

   Wolfram

Changes since RFC:
* changed commit message of cx88 patch to match the change
  (Thanks Hans!)
* added acks (Thanks Hans and Sean!)
* rebased to v5.5-rc1

Wolfram Sang (5):
  media: pci: cx23885: convert to i2c_new_scanned_device
  media: pci: cx88: convert to i2c_new_scanned_device
  media: pci: bt8xx: convert to i2c_new_scanned_device
  media: pci: cx18: convert to i2c_new_scanned_device
  media: pci: ivtv: convert to i2c_new_scanned_device

 drivers/media/pci/bt8xx/bttv-input.c    | 6 +++---
 drivers/media/pci/cx18/cx18-i2c.c       | 2 +-
 drivers/media/pci/cx23885/cx23885-i2c.c | 4 ++--
 drivers/media/pci/cx88/cx88-input.c     | 2 +-
 drivers/media/pci/ivtv/ivtv-i2c.c       | 6 +++---
 drivers/media/pci/ivtv/ivtv-i2c.h       | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.20.1

