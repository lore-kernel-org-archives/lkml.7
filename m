Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4C5C468C1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AF620859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 05:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560145772;
	bh=fjiRRpbxLq2qPQtWG06fEsCH3kBCZr5EYWbVtHgja/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2L2x2byi0r1A+6GjCkclZW+3OTNPuKuy4TmColb6NuFOyZXyhQ8+EF3byk37S2/4J
	 QRstu8XEoGED5qBQ/PgeuKpQ8ns5dtLlYp2QGst2jyZf50VhcvakkHMK7fMmZ2Ib47
	 c7Aw+YDQgvZIHTtqE2NfJRpI0IwanP+oDB95pnzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387695AbfFJFtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 01:49:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387464AbfFJFta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 01:49:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA0D820820;
        Mon, 10 Jun 2019 05:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560145770;
        bh=fjiRRpbxLq2qPQtWG06fEsCH3kBCZr5EYWbVtHgja/0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fugCxTYIH3V+theQWGMZxGl62Pbid6Uo522QH9KPxAe0MLoWEkl7iw+My6mtxf3e+
         zmhu0SLEgOilqXl3zt/oueA/Zmd5VepTrNPr1CSntCmzPqSP42JO+v5nKn9/icyOmS
         sCaNSPtSX5BiYKZUSPGhCGqbpHYzlVQHxuXqoyMk=
Date:   Mon, 10 Jun 2019 07:49:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, hardiksingh.k@gmail.com,
        linux-kernel@vger.kernel.org, benniciemanuel78@gmail.com
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: Remove unused
 variables
Message-ID: <20190610054927.GA13124@kroah.com>
References: <20190607071123.28193-1-nishkadg.linux@gmail.com>
 <20190609110206.GD30671@kroah.com>
 <74fd5a83-0f60-baae-a65f-bbc0cd9f4ad0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74fd5a83-0f60-baae-a65f-bbc0cd9f4ad0@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:08:21AM +0530, Nishka Dasgupta wrote:
> On 09/06/19 4:32 PM, Greg KH wrote:
> > On Fri, Jun 07, 2019 at 12:41:23PM +0530, Nishka Dasgupta wrote:
> > > Remove variables that are declared and assigned values but not otherwise
> > > used.
> > > Issue found with Coccinelle.
> > > 
> > > Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> > > ---
> > >   drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ---------
> > >   1 file changed, 9 deletions(-)
> > 
> > You sent me 8 patches for this driver, yet only 2 were ordered in a
> > series.  I have no idea what order to apply these in :(
> > 
> > Please resend them _all_ in a numbered patch series so I have a chance
> > to get this correct.
> 
> Yes, I can do that. Who do I send the patch series to in that case? The
> maintainers list is slightly different for each file, and most of the
> patches in this driver are for different and unrelated files (except, I
> think, the two that I did send as a patch series). Do I combine the
> maintainers lists and send the entire patch series to everyone listed as a
> maintainer for any one of the patches in it?

The maintainer and mailing list is the same for all of the files in a
single driver.  If not, then something is wrong.

And yes, you can combine the list of people if you wish but be sure you
are not just randomly including people who happened to touch the driver
"last".

greg k-h
