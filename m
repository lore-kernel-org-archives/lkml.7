Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C46AC10F14
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 342A82133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570355450;
	bh=IEIOaPM0gWMqpc0zX16Dpknqo7eoR6bXroNx94NIjbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dxzy/z96ceM4S/I0YTDoSynlTscQ+DZgzEYMgZHWwDqUVsfhM2Hk/2X492HZt8wDz
	 krBZKRC+I8hJ4m+7uowSaEXEf4HqlrL99eFyWemEq75G6+taG8ZTxIjxfZKlcX0lpM
	 4Ht0UXIf81MI/boV1QqwznX4FvCQpZTDoteOpRSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbfJFJuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:50:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbfJFJuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:50:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C62A20867;
        Sun,  6 Oct 2019 09:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570355444;
        bh=IEIOaPM0gWMqpc0zX16Dpknqo7eoR6bXroNx94NIjbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDoRXRDUAh3f/Wl8m8Vf/KnM7I7dINcMPAD41WRI3EoYkS1D+NMGcmB+k9CX7T2PK
         YOne+95KYCGaaeOr69HmTnV84fF9HvNyvZgp8P2J5UAb3spb29Ecs9IvXfWJ9wxrv7
         gLk7BTpwXrYWdzyS2zRz5WHW2PRUyH63LCHWwe8o=
Date:   Sun, 6 Oct 2019 11:50:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, johan@kernel.org,
        elder@kernel.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add blank line after declarations
Message-ID: <20191006095042.GA2918514@kroah.com>
References: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191005210046.27224-1-gabrielabittencourt00@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 05, 2019 at 06:00:46PM -0300, Gabriela Bittencourt wrote:
> Fix CHECK: add blank line after declarations
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> ---
>  drivers/staging/greybus/control.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/greybus/control.h b/drivers/staging/greybus/control.h
> index 3a29ec05f631..5a45d55349a1 100644
> --- a/drivers/staging/greybus/control.h
> +++ b/drivers/staging/greybus/control.h
> @@ -24,6 +24,7 @@ struct gb_control {
>  	char *vendor_string;
>  	char *product_string;
>  };
> +
>  #define to_gb_control(d) container_of(d, struct gb_control, dev)

No, the original code is "better" here, it's a common pattern despite
what checkpatch.pl tells you, sorry.

thanks,

greg k-h
