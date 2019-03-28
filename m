Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD38221773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cQ4FB25F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kQ/llJGM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfC1Ga7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:30:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49080 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbfC1Ga6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:30:58 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 079FD60790; Thu, 28 Mar 2019 06:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754658;
        bh=XNrwfj4js3hNj0/1Rvw08U1jFfT9acua8siOhZZR3NM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=cQ4FB25FDmj6jlSxUa8OVRRjxMA5du7iZefrfvHKvBCOQ0fFgEh3PqRTbGOXo8tl+
         tFO+kGvRFxNDysCekDw1B1J2cqOgKPcO3MiEYgPaZIhf9vukjmduBqSWvurlo0RNNR
         kd8I6VPllpJWNFVFpM3USLUOzDIxDQvuVERkS93Y=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 37D7560364;
        Thu, 28 Mar 2019 06:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553754657;
        bh=XNrwfj4js3hNj0/1Rvw08U1jFfT9acua8siOhZZR3NM=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=kQ/llJGMMOAt8QEWFAy2KrPNFnuKmnHyNfzGqvTuDadTWu8UgsDNmKrW8LVGghsIO
         8mlwp8F2EBk3S6KICxWlKRG7uOV0Ggn+9LiQqMgiKSWHG/RdnoXCRLAZD6S7QWS9Fz
         KoZ2bhwXQhiluy1XtmBWC25hH9I5yAs8cg9ZwJiQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37D7560364
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH v2] tty:serial_core: Spelling mistake
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190328031733.GA13375@hari-Inspiron-1545>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <1112ab41-9b2e-453b-aefe-d3282492beeb@codeaurora.org>
Date:   Thu, 28 Mar 2019 12:00:53 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328031733.GA13375@hari-Inspiron-1545>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 8:47 AM, Hariprasad Kelam wrote:
> fix spelling mistake "overriden" -> "overridden"
>
> This fix resolves warning reported by checkpatch tool.
>
> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh
> ---
> Changes in V2:
>                -Make commit message more clear
> ---
>   drivers/tty/serial/serial_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 351843f..69f4871 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1514,7 +1514,7 @@ static void uart_set_termios(struct tty_struct *tty,
> 	}
>
> 	uart_change_speed(tty, state, old_termios);
> -	/* reload cflag from termios; port driver may have overriden flags */
> +	/* reload cflag from termios; port driver may have overridden flags */
> 	cflag = tty->termios.c_cflag;
>
> 	/* Handle transition to B0 status */
