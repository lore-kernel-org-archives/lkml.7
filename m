Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B235C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C93320B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 19:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfHIT3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 15:29:11 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:55446 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725904AbfHIT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 15:29:10 -0400
Received: (qmail 5241 invoked by uid 2102); 9 Aug 2019 15:29:08 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Aug 2019 15:29:08 -0400
Date:   Fri, 9 Aug 2019 15:29:08 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     Colin King <colin.king@canonical.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>,
        <usb-storage@lists.one-eyed-alien.net>,
        <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: storage: isd200: remove redundant assignment to
 variable sendToTransport
In-Reply-To: <20190809173314.4623-1-colin.king@canonical.com>
Message-ID: <Pine.LNX.4.44L0.1908091528040.1630-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2019, Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> The variable sendToTransport is being initialized with a value that is
> never read and is being re-assigned a little later on. The assignment
> is redundant and hence can be removed.
> 
> Addresses-Coverity: ("Unused value")

Of what use is that tag to general kernel developers?

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/usb/storage/isd200.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/isd200.c b/drivers/usb/storage/isd200.c
> index 2b474d60b4db..28e1128d53a4 100644
> --- a/drivers/usb/storage/isd200.c
> +++ b/drivers/usb/storage/isd200.c
> @@ -1511,7 +1511,7 @@ static int isd200_Initialization(struct us_data *us)
>  
>  static void isd200_ata_command(struct scsi_cmnd *srb, struct us_data *us)
>  {
> -	int sendToTransport = 1, orig_bufflen;
> +	int sendToTransport, orig_bufflen;
>  	union ata_cdb ataCdb;
>  
>  	/* Make sure driver was initialized */

Otherwise:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern

