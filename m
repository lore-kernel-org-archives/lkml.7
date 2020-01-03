Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49443C2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27B9E2085B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgACMrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 07:47:55 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:31890 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727508AbgACMrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 07:47:55 -0500
X-IronPort-AV: E=Sophos;i="5.69,390,1571695200"; 
   d="scan'208";a="429787611"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 13:47:49 +0100
Date:   Fri, 3 Jan 2020 13:47:49 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org
Subject: Re: [PATCH 0/4] use mmgrab
In-Reply-To: <20200103123059.GI3911@kadam>
Message-ID: <alpine.DEB.2.21.2001031344480.2982@hadrien>
References: <1577634178-22530-1-git-send-email-Julia.Lawall@inria.fr> <20200103123059.GI3911@kadam>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Jan 2020, Dan Carpenter wrote:

> On Sun, Dec 29, 2019 at 04:42:54PM +0100, Julia Lawall wrote:
> > Mmgrab was introduced in commit f1f1007644ff ("mm: add new mmgrab()
> > helper") and most of the kernel was updated to use it. Update a few
> > remaining files.
>
> I wonder if there is an automatic way to generate these kind of
> Coccinelle scripts which use inlines instead of open coding.  Like maybe
> make a list of one line functions, and then auto generate a recipe.  Or
> the mmgrab() function could have multiple lines if the first few were
> just sanity checks for NULL or something...

I tried this at one point (10 years ago!):

https://pages.lip6.fr/Julia.Lawall/acp4is09-lawall.pdf

Perhaps it is worth reviving.

julia
