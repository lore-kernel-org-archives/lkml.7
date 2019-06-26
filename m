Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDBC48BD6
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74874204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561551846;
	bh=TX9fp6FPEHmYXEfZqFW3UamcSez0vVNTqkJ5g3BSnAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mYK2QRPL8dlUYF/YRl105zogv0MhM6bil073mlPkoTVD6JSc5nugbujBHUO4r5Zww
	 cB5XOApTnU5uJOcYsfbPqsIL/oboCbisLx6tCrCFcoqCcaTtCRHT87+7hL+LU5yX8U
	 0uiyq/4DB53iz4+C6OKWV3+gCV25xftqt++a9ct0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfFZMYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 08:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZMYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 08:24:04 -0400
Received: from localhost (unknown [116.247.127.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46D26204FD;
        Wed, 26 Jun 2019 12:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561551844;
        bh=TX9fp6FPEHmYXEfZqFW3UamcSez0vVNTqkJ5g3BSnAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkN/M7ig48ojH1kUEr5RdZWojRiscQIp0hsbe6n3VNRF0omWY/vgTw15F04jxcweE
         hNfbwgZu5+B9auEWgVnZ6DWRNyK4ZKSaP9l/hBnr/jqTUOZ/pvWqN4gSqLqPui0XKX
         X0OFPV0IMlVmzJtkAMSmwGMML8wL3ip5iE+122L4=
Date:   Wed, 26 Jun 2019 20:22:07 +0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3] gpio: mockup: no need to check return value of
 debugfs_create functions
Message-ID: <20190626122207.GB30972@kroah.com>
References: <20190626084557.11847-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626084557.11847-1-brgl@bgdev.pl>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 10:45:57AM +0200, Bartosz Golaszewski wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Cc: Bamvor Jian Zhang <bamv2005@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [Bartosz: removed one more check for debugfs return value]

THank you for making this change.  I'm on the road all this week and
have had very limited time for email and doing any work like this.

Your change looks good to me!

greg k-h
