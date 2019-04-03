Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF93C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65F42084B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 09:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbfDCJrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:47:22 -0400
Received: from www.osadl.org ([62.245.132.105]:46333 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbfDCJrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 05:47:21 -0400
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id x339kfBs026880;
        Wed, 3 Apr 2019 11:46:50 +0200
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] staging:iio:accel:adis16240: add SPDX license identifier tag
Date:   Wed,  3 Apr 2019 11:41:29 +0200
Message-Id: <1554284489-5023-2-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
References: <1554284489-5023-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pop in the SPDX tag as the license is clearly indicated
as GPL V2 or later this should also be indicated with a SPDX license
identifier tag.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

chackpatch.pl was warning:
WARNING: Missing or malformed SPDX-License-Identifier tag in line 1

Patch was compile tested with: x86_64_defconfig + SPI=y, IIO=m
STAGING=y, ADIS16240=m

Patch is against 5.1-rc3 (localversion-next is next-20190403)

 drivers/staging/iio/accel/adis16240.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 24e525f..b2d71ae 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * ADIS16240 Programmable Impact Sensor and Recorder driver
  *
-- 
2.1.4

