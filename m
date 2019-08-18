Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3C6C3A589
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C06B2184D
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566155449;
	bh=4NE625COU9vsw1qoCX5e/Z9jrpUNI3ITbMNY3Hg17fo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n5Bv1ncCyKWODSWPgJpCsZX4lmRi5mTbHkTPtbOLjZAaQS7RXD09UvsPP/WWQ8QAB
	 rJ7YYMRIZoc3KgHQDnI8Gf8JkjHDMXxuApbz2/F2L26ZurQhUVzECe+c/hX3s5VWGK
	 b5tx18ni1OFopbXhb6rOCAErmqB2B2sh86ulxtvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfHRTKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Aug 2019 15:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfHRTKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Aug 2019 15:10:48 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05289206C1;
        Sun, 18 Aug 2019 19:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566155447;
        bh=4NE625COU9vsw1qoCX5e/Z9jrpUNI3ITbMNY3Hg17fo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDpSPiEULCoNCp/rJ/3JqpCQf+Er1fUgaRaxaAuvVsTgyQ225aV2DXPhGMha+ptie
         2oDpknCo7NUIhC3yfir88/XsJjPkAS9tW4j89OASO9QUyewqSVLaJzT9cXO8rWo2Z0
         xWWxGeXDB7Re22b0/SuA866k2EDdGt2PcQqn6FOI=
Date:   Sun, 18 Aug 2019 20:10:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: imu: st_lsm6dsx: Add support for LSM9DS1
Message-ID: <20190818201041.6b0bb698@archlinux>
In-Reply-To: <20190813073533.8007-1-martin.kepplinger@puri.sm>
References: <20190813073533.8007-1-martin.kepplinger@puri.sm>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 09:35:30 +0200
Martin Kepplinger <martin.kepplinger@puri.sm> wrote:

> Add basic functionality for LSM9DS1. This has become a trivial addition
> by now.
> 

To me these look fine, but I'd ideally like an Ack or reviewed-by from
Lorenzo.

Thanks,

Jonathan


> revision history
> ----------------
> v4: rebase on top of today's iio testing branch with Lorenzo's recent work
> v3: rebase and add Lorenzo's patches in order to apply to the iio testing brach
> v2: further simplifications based on Lorenzo's feedback
> v1: initial change for adding lsm9ds1 support
> 
> 
> Martin Kepplinger (3):
>   iio: imu: st_lsm6sdx: move register definitions to sensor_settings
>     struct
>   iio: imu: st_lsm6dsx: add support for accel/gyro unit of lsm9sd1
>   dt-bindings: iio: imu: st_lsm6dsx: add lsm9ds1 device bindings
> 
>  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |   8 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 118 ++++++++++++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
>  6 files changed, 129 insertions(+), 10 deletions(-)
> 

