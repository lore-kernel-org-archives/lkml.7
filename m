Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E80BC04AB1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07472084A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557736943;
	bh=FFP9OUTbN2hRuzOJDuWvb9U2VH7dyQ34YtSfiVB6ju0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pqHuwLhE8Yz1esDw/RlFNouoFJ/h53UGcAFIJwzNOVUG7mGlVhYr+6y3ruTS/cemE
	 l4J97ONG0wumOrxjuxZc9VLrMu+9uK6TRPmInQW4kasB2cbCRS6n9DIkucA1bmRcX9
	 XDWEphBOTq9ThYhGzNep0xFC4yWwjU87qGbW27J4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbfEMImV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 04:42:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727589AbfEMImV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 04:42:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3420E20879;
        Mon, 13 May 2019 08:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557736940;
        bh=FFP9OUTbN2hRuzOJDuWvb9U2VH7dyQ34YtSfiVB6ju0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yy3S0V1T++ier/Q6FNf8TmwiTQrKwEpHUDClIPmhoTs+mHeV+DG4h+7Hre2RrHwtu
         YM4qyzBz4xVy/3TtVpIW+9Wjsoupp1U/pN32v+qH2THdIx2Yd1wH5lXOJe22KbAt+g
         biZvbGvY8xPh5RJMoPM/hgphRsAe47n2xP3E50+E=
Date:   Mon, 13 May 2019 10:42:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vandana BN <bnvandana@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH v2 2/8] Staging: kpc2000: kpc_dma: Resolve coding style
 errors reported by checkpatch.
Message-ID: <20190513084217.GA17959@kroah.com>
References: <20190510193833.1051-1-bnvandana@gmail.com>
 <20190512234000.16555-1-bnvandana@gmail.com>
 <20190512234000.16555-2-bnvandana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190512234000.16555-2-bnvandana@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 05:09:54AM +0530, Vandana BN wrote:
> This patch resolves below errors reported by checkpatch
> ERROR: "(foo*)" should be "(foo *)"
> ERROR: "foo * bar" should be "foo *bar"
> ERROR: "foo __init  bar" should be "foo __init bar"
> ERROR: "foo __exit  bar" should be "foo __exit bar"
> 
> Signed-off-by: Vandana BN <bnvandana@gmail.com>

Better...

But your subject lines are almost all the same, with some being
identical to others, yet you are doing different things in each of the
patch.

So please provide a better subject line saying, in a unique way, exactly
what you are doing here.

thanks,

greg k-h
