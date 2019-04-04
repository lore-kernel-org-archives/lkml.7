Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9799AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 606602064A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 04:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfDDEK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 00:10:58 -0400
Received: from smtp.infotech.no ([82.134.31.41]:53735 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDDEK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 00:10:58 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Apr 2019 00:10:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D57E82041D7;
        Thu,  4 Apr 2019 06:04:31 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KXCNP5mLNELi; Thu,  4 Apr 2019 06:04:30 +0200 (CEST)
Received: from [192.168.48.23] (host-45-58-224-183.dyn.295.ca [45.58.224.183])
        by smtp.infotech.no (Postfix) with ESMTPA id 7B747204197;
        Thu,  4 Apr 2019 06:04:29 +0200 (CEST)
Reply-To: dgilbert@interlog.com
Subject: Re: correcting incorrect peripheral device type 0x0
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc:     Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        SCSI <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ab8d589f-db76-9a95-1b55-3e906ad89487@free.fr>
 <yq1zhp6satq.fsf@oracle.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <ed1cb693-6335-f891-6905-1dda1c5ef5c3@interlog.com>
Date:   Thu, 4 Apr 2019 00:04:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <yq1zhp6satq.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-04-03 11:34 p.m., Martin K. Petersen wrote:
> 
> Marc,
> 
>> scsi 0:0:0:49488: scsi_add_lun: correcting incorrect peripheral device type 0x0 for W-LUN 0x            c150hN
> 
>               ^^^^^ Where do these crazy LUN numbers come from? That
>               looks like something which needs fixing...
> 

sam6r04.pdf  chapter 4.7.7.5.1  followed by Linux trying to show a byte string
as an integer. But you knew that, didn't you ??
