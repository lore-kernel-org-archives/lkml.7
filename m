Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640DAC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31FBB2073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 06:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfDPGcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:32:55 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:48308 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDPGcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 02:32:54 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6499A260C42;
        Tue, 16 Apr 2019 07:32:53 +0100 (BST)
Date:   Tue, 16 Apr 2019 08:32:50 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
        knaack.h@gmx.de, jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        bbrezillon@kernel.org, rafael@kernel.org,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com
Subject: Re: [PATCH 0/3] Add ST lsm6dso i3c suppport
Message-ID: <20190416083250.272edfe1@collabora.com>
In-Reply-To: <cover.1555354268.git.vitor.soares@synopsys.com>
References: <cover.1555354268.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitor,

On Mon, 15 Apr 2019 21:19:38 +0200
Vitor Soares <vitor.soares@synopsys.com> wrote:

I like the very detailed description in your cover letter :P.
Anyway, glad to see I3C support added to regmap. Also happy to have a
new driver for an I3C device.

Thanks for working on that.

Boris

> Vitor Soares (3):
>   remap: Add i3c bus support
>   i3c: Add i3c_get_device_id helper
>   iio: imu: st_lsm6dsx: Add i3c basic support
> 
>  drivers/base/regmap/Kconfig                 |  6 ++-
>  drivers/base/regmap/Makefile                |  1 +
>  drivers/base/regmap/regmap-i3c.c            | 62 ++++++++++++++++++++++++++
>  drivers/i3c/device.c                        |  8 ++++
>  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
>  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
>  include/linux/i3c/device.h                  |  1 +
>  include/linux/regmap.h                      | 20 +++++++++
>  9 files changed, 172 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/base/regmap/regmap-i3c.c
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> 

