Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D757C43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B7A320836
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552157394;
	bh=dIqFnsf4jlvhrMKK6iq8yWO3ePmn8xkvFBtrvDr6P+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=I9BJRpfToe1YUeRBUaPc/cPSJxrsDMmsioN9p619sZNHgg8MldvswGvNIMcf7woEZ
	 wmQeNzmxOFNPvbG/Q0muliIjvYdPgN3NwiYjJc5uKHaFghxrXvP2ohBKKrw3P08jZ7
	 STFZvCSBbGyXt2Hd8iqsRxbT7fBUHzFd07rN3+pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfCIStx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 13:49:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbfCIStw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 13:49:52 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53AF20657;
        Sat,  9 Mar 2019 18:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552157392;
        bh=dIqFnsf4jlvhrMKK6iq8yWO3ePmn8xkvFBtrvDr6P+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mW2ThlYv63hmMoGb+VqWNoT0BYFx18LHjQDjAjP85Sljjd6Gcj4bL20oz/FFjGtim
         vIV55iNX8pTAoLZxFrOKbsS99aQ9cj2hj9Z5Xt+UGQC4sBNQormvQWf1FC67llFDvN
         Qb4XQoL2T3LcQ0wngw802cJGZd6FNrznCrGTn6WQ=
Date:   Sat, 9 Mar 2019 18:49:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anderson Reis <andersonreisrosa@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Anderson Reis <anderson.reis.rosa@usp.com>,
        Lucas Oshiro <lucasseikioshiro@gmail.com>
Subject: Re: [PATCH v2 4/4] iio:potentiostat:lmp91000: change dev_err
 message
Message-ID: <20190309184946.35c5446d@archlinux>
In-Reply-To: <20190308194655.5983-5-anderson.reis.rosa@usp.com>
References: <20190308194655.5983-1-anderson.reis.rosa@usp.com>
        <20190308194655.5983-5-anderson.reis.rosa@usp.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  8 Mar 2019 16:46:55 -0300
Anderson Reis <andersonreisrosa@gmail.com> wrote:

> Change dev_err message on line 215 in order to inform that
> tia-gain-ohm is not defined and an external resistor is not
> specified.
> 
> Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Applied.

Thanks,

Jonathan

> ---
>  drivers/iio/potentiostat/lmp91000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
> index 1de17924e154..5ed9752008a5 100644
> --- a/drivers/iio/potentiostat/lmp91000.c
> +++ b/drivers/iio/potentiostat/lmp91000.c
> @@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
>  	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
>  	if (ret) {
>  		if (!of_property_read_bool(np, "ti,external-tia-resistor"))
> -			dev_err(dev, "no ti,tia-gain-ohm defined");
> +			dev_err(dev, "no ti,tia-gain-ohm defined and external resistor not specified\n");
>  			return ret;
>  		}
>  		val = 0;

