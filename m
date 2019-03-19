Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F44CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0416B213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553002170;
	bh=BmIY8nwFZrno0c3raZCzHcXzz91roVj6lVpQL8CutuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cLLoIUUnIUQ2Nfts9eG83XnksXG3DNnm9VD4jNTNFmg8Vm4SP0CHWSsdl2WERvcjF
	 uvSRwSs+Ux7+GJ0vOcfugtYTOaTkmIV7eEnMOygR9LYV5dqU58kdSinshn/DqHMn8b
	 RAGCQaYA/t14dYB7pTyixswnZxZfey400goUl+r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCSN32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 09:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfCSN32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 09:29:28 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E064206BA;
        Tue, 19 Mar 2019 13:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553002167;
        bh=BmIY8nwFZrno0c3raZCzHcXzz91roVj6lVpQL8CutuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F0RgIAimRt9PlaTfXBZ/wCsdXmIi4WLVQPKjtRKOdmKvoicSIIL6peo6m09Gx7dU8
         uvSkam9TbvbOxcHPnXcnehiZwK2whjDPnrNp23Qu5VVF8IGhEtUq4dWoMTzLlVXvJI
         lN1MoZNSLezdDFr9cPrHao18svxiK+zcOWZEAnD0=
Date:   Tue, 19 Mar 2019 14:29:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Colin King <colin.king@canonical.com>, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH] staging: ks7010: remove redundant auth_type check
Message-ID: <20190319132924.GA29424@kroah.com>
References: <20190318105749.20098-1-colin.king@canonical.com>
 <20190318213259.GC5362@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318213259.GC5362@azazel.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 09:32:59PM +0000, Jeremy Sowden wrote:
> On 2019-03-18, at 10:57:49 +0000, Colin King wrote:
> > The range check on auth_type is redundant as there is a prior
> > check on the auth_type values and the only way the block is entered
> > is if auth_type is one of TYPE_PMK1, TYPE_GMK1 and TYPE_GMK1.
> 
> "... and TYPE_GMK2."

I'll go edit that, thanks.

greg k-h
