Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03D4C2D0C2
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97459217F4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578134723;
	bh=9kEzjz7G7kcU0ezglC0FnWVstJxkGI+zLbZInwwqYB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p7R6YM1BMKypbaqJN38X88ZgMHVoPcWVA7h/UzL276jXAlUnRZAu3dNX83fixb2vz
	 Qn9wYOhJL50RwOoRrQbtyNYV8NrYtsdpuIQW2AvWuzmX7inJWVr5xvAPAT85pafsAv
	 leAwHMh8cMK/G0X6F4Kk7A3HFl1Nla4fsf22KLSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgADKpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 05:45:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgADKpF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 05:45:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 865C2217F4;
        Sat,  4 Jan 2020 10:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578134705;
        bh=9kEzjz7G7kcU0ezglC0FnWVstJxkGI+zLbZInwwqYB4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLm+oS6GFmjywKXZzj1+Oafj/8yJOaoh9b9TksR68u/7a1Styufa7IFtpzrbsk0Qz
         TnMGeOLeaLAGzw5Cl/2AxFy6OarDJVDcXRQjYAFPvJNGEaiFBk0eN8xDfJ90DYHWj2
         glt2AXYDXN5WgxG4aUh6+5fXtW0OQW1LKl6xXkaE=
Date:   Sat, 4 Jan 2020 11:45:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap-i2c: constify regmap_bus structures
Message-ID: <20200104104502.GA1285988@kroah.com>
References: <d05ad8998ac476aafe471d723856b16df8eec97f.1578133241.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d05ad8998ac476aafe471d723856b16df8eec97f.1578133241.git.mirq-linux@rere.qmqm.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2020 at 11:32:56AM +0100, Michał Mirosław wrote:
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/base/regmap/regmap-i2c.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

I can not take patches without any changelog text at all, sorry :(
