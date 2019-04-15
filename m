Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E518BC10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D922075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QuTwox4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbfDOTUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:20:20 -0400
Received: from smtprelay.synopsys.com ([198.182.60.111]:57328 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbfDOTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:20:18 -0400
Received: from mailhost1.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 5E8AA10C10A5;
        Mon, 15 Apr 2019 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1555356018; bh=HRXqFmPCXEH7TTVf3uZt+wISGcBLOQ+X33KGrRmTZYo=;
        h=From:To:Cc:Subject:Date:From;
        b=QuTwox4fImyg10VuN2qmFVPzfB/7glcjeHNogLyaMZqWZFMIwQ302pJLoqWkROn8i
         j786ZXD1IDL/cNYpLd9m5kjvKEoPaX9fOtIOWDhZ7NjvXO9GRpo4VP8Elyi7FesauT
         /gcAg0oxndbUVjjic9g2iD4EM5D3D6fe+H0nwyiPvZVKUqzgu9DewZaFomxYbKU6yp
         BkTmqrAUWYwHv4P6mSijDiCEBbgQ0nE9SqUL+ul9ZC30NoNqApIPatDjFlMYc9QO1u
         Y43WzRG9fHXjTaPWTVlGof6jmC26ufY1/OF1zroNOiJhx9YBmYNKIgoEh3qGwPQhIK
         V4mnuHYnxYqfw==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost1.synopsys.com (Postfix) with ESMTP id CF2CD5467;
        Mon, 15 Apr 2019 12:19:43 -0700 (PDT)
From:   Vitor Soares <vitor.soares@synopsys.com>
To:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de,
        jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com, Vitor Soares <vitor.soares@synopsys.com>
Subject: [PATCH 0/3] Add ST lsm6dso i3c suppport
Date:   Mon, 15 Apr 2019 21:19:38 +0200
Message-Id: <cover.1555354268.git.vitor.soares@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitor Soares (3):
  remap: Add i3c bus support
  i3c: Add i3c_get_device_id helper
  iio: imu: st_lsm6dsx: Add i3c basic support

 drivers/base/regmap/Kconfig                 |  6 ++-
 drivers/base/regmap/Makefile                |  1 +
 drivers/base/regmap/regmap-i3c.c            | 62 ++++++++++++++++++++++++++
 drivers/i3c/device.c                        |  8 ++++
 drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
 drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
 include/linux/i3c/device.h                  |  1 +
 include/linux/regmap.h                      | 20 +++++++++
 9 files changed, 172 insertions(+), 2 deletions(-)
 create mode 100644 drivers/base/regmap/regmap-i3c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c

-- 
2.7.4

