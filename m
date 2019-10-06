Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78381C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E35B20862
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570388920;
	bh=BcvGHiL+p+7ntg/3PF6YfqrRfphYWWCc4jkG1eHl7LA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=up1zH/32abpJZdwzuLZ5hRr0HksRmt8OXsH3cW4lZo74gLOLnH8NY16ee06PbCknK
	 reWSsUG7fxP5WJ8Fkk+wFOs0p6rHrxjbbpxjofbMFeYKW1zFYoC44bbG5a9o+pTSKE
	 Vto0qWlGUGkFSgv5AZ+vEn3fbvArhwJTLBn+IbOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfJFTIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 15:08:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfJFTIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 15:08:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7E832077B;
        Sun,  6 Oct 2019 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570388917;
        bh=BcvGHiL+p+7ntg/3PF6YfqrRfphYWWCc4jkG1eHl7LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIdqH6hHNI9YsfNptiXFPA2D6mlUCPwKaLQIDbXX/aAMAHucmZCLzrnOXpL0T8t+B
         1cDEGP7P9hYsPSWMXkHNSi+DaPaEHFiAfwXW1BwmTz0Wmd9uOyuTEgws/zMg/Frszh
         K5s4fQKTR8zQKCtaWl3RDNvIuvxHfOvuTAEddRS0=
Date:   Sun, 6 Oct 2019 21:08:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     outreachy@googlegroups.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, abbotti@mev.co.uk, olsonse@umich.edu
Subject: Re: [PATCH] staging: comedi: Fix camelcase check warning
Message-ID: <20191006190835.GC237538@kroah.com>
References: <20191006184453.11765-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191006184453.11765-1-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 07:44:53PM +0100, Jules Irenge wrote:
> Capitalize unit_ma to fix camelcase check warning.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/staging/comedi/comedi.h    | 4 ++--
>  drivers/staging/comedi/comedidev.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/comedi/comedi.h b/drivers/staging/comedi/comedi.h
> index 09a940066c0e..df770043b37d 100644
> --- a/drivers/staging/comedi/comedi.h
> +++ b/drivers/staging/comedi/comedi.h
> @@ -674,7 +674,7 @@ struct comedi_rangeinfo {
>   * linear (for the purpose of describing the range), with sample value %0
>   * mapping to @min, and the 'maxdata' sample value mapping to @max.
>   *
> - * The currently defined units are %UNIT_volt (%0), %UNIT_mA (%1), and
> + * The currently defined units are %UNIT_volt (%0), %UNIT_MA (%1), and
>   * %UNIT_none (%2).  The @min and @max values are the physical range multiplied
>   * by 1e6, so a @max value of %1000000 (with %UNIT_volt) represents a maximal
>   * value of 1 volt.
> @@ -909,7 +909,7 @@ struct comedi_bufinfo {
>  #define RF_EXTERNAL		0x100
>  
>  #define UNIT_volt		0
> -#define UNIT_mA			1
> +#define UNIT_MA			1

Sorry, but "mA" is a unit of measurement of power, and needs to stay
as-is.

thanks,

greg k-h
