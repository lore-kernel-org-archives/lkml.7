Return-Path: <SRS0=/o37=YT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAF6CA9EBD
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 04:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA9A21D81
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Oct 2019 04:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfJZEns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Oct 2019 00:43:48 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:8059 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfJZEns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Oct 2019 00:43:48 -0400
X-IronPort-AV: E=Sophos;i="5.68,230,1569276000"; 
   d="scan'208";a="408354430"
Received: from ip-121.net-89-2-166.rev.numericable.fr (HELO hadrien) ([89.2.166.121])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Oct 2019 06:43:46 +0200
Date:   Sat, 26 Oct 2019 06:43:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Cristiane Naves <cristianenavescardoso09@gmail.com>
cc:     outreachy-kernel@googlegroups.com,
        Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: gasket: Fix lines
 ending with a '('
In-Reply-To: <20191025232935.GA813@cristiane-Inspiron-5420>
Message-ID: <alpine.DEB.2.21.1910260642250.2559@hadrien>
References: <20191025232935.GA813@cristiane-Inspiron-5420>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Oct 2019, Cristiane Naves wrote:

> Fix lines ending with a '('. Issue found by checkpatch.

You sent another patch on this file (the one I acked) and they are notin a
series, so Greg won't know how to apply them.  Please collect the whole
thing again, and either put both changes in the same patch, or send a
series with the different changes on this file.  You could put v2, so that
Greg knows to ignore your other changes on the file.

julia

>
> Signed-off-by: Cristiane Naves <cristianenavescardoso09@gmail.com>
> ---
>  drivers/staging/gasket/gasket_ioctl.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/gasket/gasket_ioctl.c b/drivers/staging/gasket/gasket_ioctl.c
> index d1b3e9a..e3047d3 100644
> --- a/drivers/staging/gasket/gasket_ioctl.c
> +++ b/drivers/staging/gasket/gasket_ioctl.c
> @@ -54,9 +54,9 @@ static int gasket_read_page_table_size(struct gasket_dev *gasket_dev,
>  	ibuf.size = gasket_page_table_num_entries(
>  		gasket_dev->page_table[ibuf.page_table_index]);
>
> -	trace_gasket_ioctl_page_table_data(
> -		ibuf.page_table_index, ibuf.size, ibuf.host_address,
> -		ibuf.device_address);
> +	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
> +					   ibuf.host_address,
> +					   ibuf.device_address);
>
>  	if (copy_to_user(argp, &ibuf, sizeof(ibuf)))
>  		return -EFAULT;
> @@ -101,9 +101,9 @@ static int gasket_partition_page_table(struct gasket_dev *gasket_dev,
>  	if (copy_from_user(&ibuf, argp, sizeof(struct gasket_page_table_ioctl)))
>  		return -EFAULT;
>
> -	trace_gasket_ioctl_page_table_data(
> -		ibuf.page_table_index, ibuf.size, ibuf.host_address,
> -		ibuf.device_address);
> +	trace_gasket_ioctl_page_table_data(ibuf.page_table_index, ibuf.size,
> +					   ibuf.host_address,
> +					   ibuf.device_address);
>
>  	if (ibuf.page_table_index >= gasket_dev->num_page_tables)
>  		return -EFAULT;
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20191025232935.GA813%40cristiane-Inspiron-5420.
>
