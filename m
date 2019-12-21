Return-Path: <SRS0=ztpy=2L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4BC2D0C3
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7490206EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Dec 2019 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="Q7N++Ej/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfLURAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Dec 2019 12:00:43 -0500
Received: from mail.nic.cz ([217.31.204.67]:46844 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbfLURAm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Dec 2019 12:00:42 -0500
Received: from localhost (unknown [172.20.6.135])
        by mail.nic.cz (Postfix) with ESMTPSA id C0D6F140E64;
        Sat, 21 Dec 2019 18:00:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1576947640; bh=syvtdT4FCeJPdP11/qcAox6n6e58pSFJbJE5mMlIACM=;
        h=Date:From:To;
        b=Q7N++Ej/AZ47yHBYghFaIyDGfxiOLxQvseo1WJ1IUhmIBcXRnPiiO0o12/cYoaxTa
         +NJ//P+oVPgIc1gerFAVw48Sr29F0N373W+dCGa6unvWGqHPLyM+wOOaXoA8OTSudC
         IMm/NNY3LS/jzxQ8wrrcm93SZJ5A9CZ4o2FzZDdI=
Date:   Sat, 21 Dec 2019 18:00:40 +0100
From:   Marek Behun <marek.behun@nic.cz>
To:     Colin King <colin.king@canonical.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: turris-mox-rwtm: fix indentation issue
Message-ID: <20191221180040.4e22c245@nic.cz>
In-Reply-To: <20191221153623.32564-1-colin.king@canonical.com>
References: <20191221153623.32564-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.101.4 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,
this was sent to mvebu-next, Gregory did not apply it yet but replied
that he is going to.
Marek

On Sat, 21 Dec 2019 15:36:23 +0000
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a statement that is indented one level too deeply, remove
> the extraneous tab.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/firmware/turris-mox-rwtm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/turris-mox-rwtm.c
> index 72be58960e54..e27f68437b56 100644
> --- a/drivers/firmware/turris-mox-rwtm.c
> +++ b/drivers/firmware/turris-mox-rwtm.c
> @@ -197,7 +197,7 @@ static int mox_get_board_info(struct mox_rwtm *rwtm)
>  		rwtm->serial_number = reply->status[1];
>  		rwtm->serial_number <<= 32;
>  		rwtm->serial_number |= reply->status[0];
> -			rwtm->board_version = reply->status[2];
> +		rwtm->board_version = reply->status[2];
>  		rwtm->ram_size = reply->status[3];
>  		reply_to_mac_addr(rwtm->mac_address1, reply->status[4],
>  				  reply->status[5]);

