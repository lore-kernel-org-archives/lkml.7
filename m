Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1839C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FAA2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552822774;
	bh=SIyDn0v6T0NLT3+IEiA/kwfoZFi5Ml3Sn125Oob0m6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZQCGz2M40mwIO8C3MQllUkEmKuW48qNL1S50NQwFF0qAhz0EO2oDY58Oyf6jRCnfd
	 SSRJSOGsk0E1wjZzLuiHN6L+YLBHUOQz1vTWyWNkXBPXa55XdcFj9pzViS07pkUJKY
	 nQlpLfa9h8bQT1xLwQ8qoQmGKSbw4KLPihC1L1yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbfCQLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:39:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbfCQLjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:39:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEF712086A;
        Sun, 17 Mar 2019 11:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552822772;
        bh=SIyDn0v6T0NLT3+IEiA/kwfoZFi5Ml3Sn125Oob0m6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfHDIdL+E2HF0XJwh+oHHh6L9N7cYKET+rEOadnEss2mToRAGLxsKgVyNB01/oZBe
         Cn7OYh8SfCpZTOtrEyAJr2qWpshl1verGR+l2h6ZyqRci6Ysx8SN5QXN+OpX6zUTNy
         42/chcWGjCxSkhM61mbaTFlQ4UHoPmZFpYVSJCLA=
Date:   Sun, 17 Mar 2019 12:39:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Staging: rtl8723bs: os_dep: Fix assignment in if
 condition
Message-ID: <20190317113928.GA30922@kroah.com>
References: <20190309183047.10781-1-gui.maeoka@gmail.com>
 <20190309183047.10781-2-gui.maeoka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190309183047.10781-2-gui.maeoka@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2019 at 03:30:43PM -0300, Guilherme Tadashi Maeoka wrote:
> Fix an assignment in if condition.
> 
> Signed-off-by: Guilherme Tadashi Maeoka <gui.maeoka@gmail.com>
> ---
>  drivers/staging/rtl8723bs/os_dep/osdep_service.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Not all of these could be applied.  Please rebase your patch series
against my staging-testing branch and resend the remaining patches.

thanks,

greg k-h
