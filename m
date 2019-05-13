Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD0CC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CD321473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557778375;
	bh=hfkOxiyFGI7k7znQCUsj782Lg8QsyaKplKP4qu05XEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXQgpleKUP3Om3IE/kTT1nup14yYAW3G2cixGLsxYM04D0NYMDO+QzxHUohYH51Sz
	 vwC2BCEdh7qgk1iEqqmznWofpdsCOOEM93AQHehthB49HgDy2m++59ypemn5s+O/ed
	 RA82TuKLjS1r1sU0FB8V+ekjvM+Krx/LuLSsg/gc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfEMUMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 16:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:38118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfEMUMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 16:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085EA2085A;
        Mon, 13 May 2019 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557778372;
        bh=hfkOxiyFGI7k7znQCUsj782Lg8QsyaKplKP4qu05XEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sdrrUmYefGMHM5gD5o/9eruq+0zP7B8LB4OxYAmDlsDTHrg3C73R/1ImcFEjQsTWV
         8laAsb9MUnegIhhUxd0cWhitvo3nQZrEJPVvrego0KtacMFcaXuRkPKH+Rx+D4J69k
         boLmOkujothfR8kBlRHdfqcWPrw8KqkE44E08Fuw=
Date:   Mon, 13 May 2019 22:12:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     stable@vger.kernel.org, linux-mmc@vger.kernel.org,
        djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [stable/4.14.y PATCH 3/3] mmc: Kill the request if the queuedata
 has been removed
Message-ID: <20190513201248.GC17404@kroah.com>
References: <20190513175521.84955-1-rrangel@chromium.org>
 <20190513175521.84955-4-rrangel@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513175521.84955-4-rrangel@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 11:55:21AM -0600, Raul E Rangel wrote:
> No reason to even try processing the request if the queue is shutting
> down.
> 
> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
>  drivers/mmc/core/queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
