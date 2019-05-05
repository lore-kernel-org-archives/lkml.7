Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4231C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E43B20675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 21:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbfEEVUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 17:20:33 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726905AbfEEVUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 17:20:33 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 45E44452EC636B3761D0;
        Mon,  6 May 2019 05:20:31 +0800 (CST)
Received: from [127.0.0.1] (10.210.168.180) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Mon, 6 May 2019
 05:20:26 +0800
Subject: Re: [PATCH 17/24] libsas: switch remaining files to SPDX tags
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-18-hch@lst.de>
CC:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        <linux-scsi@vger.kernel.org>, <open-iscsi@googlegroups.com>,
        <osst-users@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c049de31-eff4-28b2-f4dc-4db2205895d2@huawei.com>
Date:   Sun, 5 May 2019 22:20:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-18-hch@lst.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.180]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2019 17:14, Christoph Hellwig wrote:
> Use the the GPLv2 SPDX tag instead of verbose boilerplate text.
>

Should we update the Kconfig+Makefile similarly?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/scsi/libsas/sas_discover.c  | 18 +-----------------
>  drivers/scsi/libsas/sas_event.c     | 18 +-----------------
>  drivers/scsi/libsas/sas_expander.c  | 16 +---------------
>  drivers/scsi/libsas/sas_host_smp.c  |  5 +----
>  drivers/scsi/libsas/sas_init.c      | 19 +------------------
>  drivers/scsi/libsas/sas_internal.h  | 19 +------------------
>  drivers/scsi/libsas/sas_phy.c       | 18 +-----------------
>  drivers/scsi/libsas/sas_port.c      | 18 +-----------------
>  drivers/scsi/libsas/sas_scsi_host.c | 19 +------------------
>  include/scsi/libsas.h               | 19 +------------------
>  include/scsi/sas.h                  | 19 +------------------
>  include/scsi/sas_ata.h              | 17 +----------------
>  12 files changed, 12 insertions(+), 193 deletions(-)
>
> diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c

...

>  #include <linux/export.h>
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 83f2fd70ce76..76ea83ddafa7 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Serial Attached SCSI (SAS) Expander discovery and configuration
>   *
> @@ -5,21 +6,6 @@
>   * Copyright (C) 2005 Luben Tuikov <luben_tuikov@adaptec.com>
>   *
>   * This file is licensed under GPLv2.

Was this just missed?

> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of the
> - * License, or (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> - * General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write to the Free Software
> - * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> - *
>   */
>



