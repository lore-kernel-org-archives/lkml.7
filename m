Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D6C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7542089E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:05:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbfEBGFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:05:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:34988 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725780AbfEBGFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:05:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D62BAF8F;
        Thu,  2 May 2019 06:05:38 +0000 (UTC)
Subject: Re: [PATCH 20/24] ses: switch to SPDX tags
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Willem Riede <osst@riede.org>,
        Doug Gilbert <dgilbert@interlog.com>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-21-hch@lst.de>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <84efdea2-1dec-41f6-717a-97415b2c8822@suse.de>
Date:   Thu, 2 May 2019 08:05:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-21-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/19 6:14 PM, Christoph Hellwig wrote:
> Use the the GPLv2 SPDX tag instead of verbose boilerplate text.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/scsi/ses.c | 20 ++------------------
>   1 file changed, 2 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/scsi/ses.c b/drivers/scsi/ses.c
> index 0fc39224ce1e..8afea5a1d3f0 100644
> --- a/drivers/scsi/ses.c
> +++ b/drivers/scsi/ses.c
> @@ -1,25 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>   /*
>    * SCSI Enclosure Services
>    *
>    * Copyright (C) 2008 James Bottomley <James.Bottomley@HansenPartnership.com>
> - *
> -**-----------------------------------------------------------------------------
> -**
> -**  This program is free software; you can redistribute it and/or
> -**  modify it under the terms of the GNU General Public License
> -**  version 2 as published by the Free Software Foundation.
> -**
> -**  This program is distributed in the hope that it will be useful,
> -**  but WITHOUT ANY WARRANTY; without even the implied warranty of
> -**  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> -**  GNU General Public License for more details.
> -**
> -**  You should have received a copy of the GNU General Public License
> -**  along with this program; if not, write to the Free Software
> -**  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> -**
> -**-----------------------------------------------------------------------------
> -*/
> + */
>   
>   #include <linux/slab.h>
>   #include <linux/module.h>
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
