Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FDBEC004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 20:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383F206DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 20:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEEUFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 16:05:09 -0400
Received: from smtp.infotech.no ([82.134.31.41]:43751 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727615AbfEEUFI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 16:05:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 4051120423D;
        Sun,  5 May 2019 22:05:06 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fv7CIxAIjNDX; Sun,  5 May 2019 22:04:59 +0200 (CEST)
Received: from [192.168.10.165] (c56B33E56.static.as2116.net [86.62.179.86])
        by smtp.infotech.no (Postfix) with ESMTPA id E8A17204152;
        Sun,  5 May 2019 22:04:58 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH 21/24] sg: switch to SPDX tags
To:     Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Hannes Reinecke <hare@suse.de>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>, Willem Riede <osst@riede.org>,
        Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?Q?Kai_M=c3=a4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-scsi@vger.kernel.org, open-iscsi@googlegroups.com,
        osst-users@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20190501161417.32592-1-hch@lst.de>
 <20190501161417.32592-22-hch@lst.de>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <4285486a-b30c-300c-e794-e74999b15fb2@interlog.com>
Date:   Sun, 5 May 2019 22:04:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190501161417.32592-22-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-05-01 6:14 p.m., Christoph Hellwig wrote:
> Use the the GPLv2+ SPDX tag instead of verbose boilerplate text.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This scripts/checkpatch.pl noise seems to be related to the patch below:

$ scripts/checkpatch.pl /tmp/t.patch
Traceback (most recent call last):
   File "scripts/spdxcheck.py", line 6, in <module>
     from ply import lex, yacc
ImportError: No module named ply
total: 0 errors, 0 warnings, 98 lines checked

That happens both in the mkp/scsi/5.2/scsi-queue and the latest linux-stable
trees.


BTW Are C++ comments (as used in this patch) now permitted in lk code?

Doug Gilbert

> ---
>   drivers/scsi/sg.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
> index d3f15319b9b3..bcdc28e5ede7 100644
> --- a/drivers/scsi/sg.c
> +++ b/drivers/scsi/sg.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>   /*
>    *  History:
>    *  Started: Aug 9 by Lawrence Foard (entropy@world.std.com),
> @@ -8,12 +9,6 @@
>    *        Copyright (C) 1992 Lawrence Foard
>    * Version 2 and 3 extensions to driver:
>    *        Copyright (C) 1998 - 2014 Douglas Gilbert
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2, or (at your option)
> - * any later version.
> - *
>    */
>   
>   static int sg_version_num = 30536;	/* 2 digits for each component */
> 

