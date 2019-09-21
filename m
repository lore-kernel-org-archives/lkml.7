Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCAEC49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 05:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FE421835
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 05:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569042445;
	bh=Oi+G6QQSYRyQJ3cHgjKZHOmPHM0UIQ5lIi+trckwR/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UmHQZ17xjFNBUBBLSHV7Us9HKjqXBE1jJc6lmvww9z3lXbx3Qhr9edGl7sRfa6wd0
	 F8i9ABAswk/OI7nQ1ihkQo3Z9O39e4LH22WVXtHBkUGY7AT6i9oewqLjuOoNGpQ7il
	 VIJ1C5p9ifiq6Dr5NO0g0kio42K6mvmBDKqfE0fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbfIUFHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 01:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfIUFHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 01:07:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FF242054F;
        Sat, 21 Sep 2019 05:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569042443;
        bh=Oi+G6QQSYRyQJ3cHgjKZHOmPHM0UIQ5lIi+trckwR/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F6xUGkjUTlcGPHcAUGx4HQyZgWcwodqbL3YhXcx1Bdgdr6nlGfdMBDw1/lOQrZNnP
         jTAN/LrMp9EDDfea8lwy1eXfv7ErlpKWr1o7+gUsHy2T5jYrhkCBmqprBV/Si/V0yB
         EFNLTEcYL3+1aTZ6kubmnAMWvBcDs+UBVQ5f0DQY=
Date:   Sat, 21 Sep 2019 07:07:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Will Deacon <will@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [PATCH] MAINTAINERS: kgdb: Add myself as a reviewer for kgdb/kdb
Message-ID: <20190921050721.GA992668@kroah.com>
References: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190920104404.1.I237e68e8825e2d6ac26f8e847f521fe2fcc3705a@changeid>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 10:44:47AM -0700, Douglas Anderson wrote:
> I'm interested in kdb / kgdb and have sent various fixes over the
> years.  I'd like to get CCed on patches so I can be aware of them and
> also help review.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks for this.

There was discussion at Plumbers about just dropping kgdb as some people
didn't think it was being actively maintained or that it even still
worked.  Thanks for refuting that :)

greg k-h
