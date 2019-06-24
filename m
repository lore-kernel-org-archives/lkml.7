Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715DEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48A8320820
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561382477;
	bh=uKlCQRGXXA9YPfkpvOBY9ttO0cZxrzJGnbw1r6VZnMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JpZvP+FTMVI7w6GPZu2g7/8M6TgXXXRKlSTJ06B1Qa8Zh7HVlLyeVBJW9NBEOHF5E
	 uzqqqTetP6/0tBAl1U96uqbPQlLNFEGynH84BvvTNv6V0Ehf6jJaFxGPSGfSxyu68X
	 WayPWqtEjqaabmbQ+fk2nR5KMYiiFaXBFmkes8n4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbfFXNVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:21:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfFXNVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:21:13 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01B9A20820;
        Mon, 24 Jun 2019 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561382472;
        bh=uKlCQRGXXA9YPfkpvOBY9ttO0cZxrzJGnbw1r6VZnMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f5lH0uZvw8BkIHG188VL+ST9jbasC1wQ0K2sJIzFZLneGFIYFvMW3P/GAeLUpQQCn
         NkDhvX8ulbWbYdZFaTG/4uuJVIJro3Ob1NSt9eVJH3OdykWxwNm/8D7xoqVR2yzi/o
         mu5tKbw/US+kMCKfawNd81c+5ga6vt8grmCs6bj4=
Date:   Mon, 24 Jun 2019 21:20:57 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the imx-mxs tree
Message-ID: <20190624132056.GC16146@dragon>
References: <20190624222359.62e92a15@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624222359.62e92a15@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 10:23:59PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commit
> 
>   9b5800c21b4d ("ARM: dts: imx6qdl-kontron-samx6i: add Kontron SMARC SoM Support")
> 
> is missing a Signed-off-by from its author.

Thanks for spotting it, Stephen.

@Michael, would you please give your SoB?  Otherwise, I will have to
back out the patch.

Shawn
