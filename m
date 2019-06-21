Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D0C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C6721530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561123055;
	bh=261r6uVQZqRD/KvN8ivfHajwNi38MxHfYzJVQIpaJ00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bIjbuZmIOEwd3IonxOVfmwqrwrEuQwUG/A2NV3EYJCC9PVetyhwHYGYOoYqcf/my1
	 Xox4T2M4OD7Kl2ucvnzgiZQFfZmsH4CEld6IZoQn/7350xKZspz5qXNfPsRvAQAbMO
	 QZu9a4DO4ZCMCRPoNm8YbRmmVEQPl9yLN8+/rAgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFUNRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 09:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfFUNRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 09:17:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1AC20673;
        Fri, 21 Jun 2019 13:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561123052;
        bh=261r6uVQZqRD/KvN8ivfHajwNi38MxHfYzJVQIpaJ00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ErxUbrVJ0CFz+sPx1YEPlxAoOcxPV1cnoDhjVL8PR1ri1bmH1Hzci34eIO6NZzMR1
         3IL9M03DQ5BtnrkeGR65h/GkDz1+rGrS9ixjOff7xHSSdg9pGEsCotobJrN/DyUDru
         vffTZDIL7EjHoRIMGcz7ZhAPgMeCRLiJqJB4xMKg=
Date:   Fri, 21 Jun 2019 15:17:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "sudheer.v" <open.sudheer@gmail.com>
Cc:     jslaby@suse.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, robh+dt@kernel.org, mark.rutland@arm.com,
        shivahshankar.shankarnarayanrao@aspeedtech.com,
        shivahshankar@gmail.com, sudheer.veliseti@aspeedtech.com,
        sudheer veliseti <sudheer.open@gmail.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Subject: Re: [patch 0/5] *** DMA based UART driver for AST2500 ***
Message-ID: <20190621131729.GA9997@kroah.com>
References: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561115855-4186-1-git-send-email-open.sudheer@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2019 at 04:47:30PM +0530, sudheer.v wrote:
> From: sudheer veliseti <sudheer.open@gmail.com>
> 
> Hi,
> AST2500 has dedicated Uart DMA controller which has 12 sets of
> Tx and RX channels connected to UART controller directly.
> Since the DMA controller have dedicated buffers and registers,
> there would be little benifit in adding DMA framework overhead.
> So the software for DMA controller is included within the UART driver itself.
> 
> Thanks and Regards
> Sudheer.V

Is this a v2 of this patch series?

You always have to version your patches and say what changed from the
previous one, like the documentation says to do.

Please fix this up and resend.

thanks,

greg k-h
