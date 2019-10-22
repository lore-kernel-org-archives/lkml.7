Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9A8CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7DF2084B
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571765694;
	bh=m2ceQ24cU2Ny8XVPqf8V/b4tcg86uWeGt+qw0B2EyH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bx954eMDO73J9xM9GFdT8rzAdBh4gnMEO0QEtaBvsqvXe9mDJVggeb6e+ll9vHSGN
	 m3rdgg7yA1yW1lAIAYly9dues0CnbWowFt/ILt6IhcEnyP73IWhITnWifyWXrf+nfc
	 bCBjcCbTU+Cg0LjUbZ4Sv260KXS24J3rGLULJMYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732047AbfJVRex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 13:34:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbfJVRew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 13:34:52 -0400
Received: from localhost (mobile-166-172-186-56.mycingular.net [166.172.186.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 891F020700;
        Tue, 22 Oct 2019 17:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571765692;
        bh=m2ceQ24cU2Ny8XVPqf8V/b4tcg86uWeGt+qw0B2EyH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQFVvk6KpgKSjnndDwrDS7Sjhhl/rNCGTW95iQDwQihz6UQOoKf+uSZUXSeNnvevL
         3fL7OiPetbnvn27r7vOhhhuF5yiHRR8JzNynfIiER9KjHo3RRim7D4Bk7IN374vMZv
         1SUlL+zaZ64/JPgekjdqKuW6cTtDB/aXHDhtNOU0=
Date:   Tue, 22 Oct 2019 13:34:49 -0400
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@lists.codethink.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu-topology: declare parse_acpi_topology in
 <linux/arch_topology.h>
Message-ID: <20191022173449.GC230934@kroah.com>
References: <20191022084323.13594-1-ben.dooks@codethink.co.uk>
 <20191022084721.GA17984@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022084721.GA17984@bogus>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 09:47:21AM +0100, Sudeep Holla wrote:
> On Tue, Oct 22, 2019 at 09:43:23AM +0100, Ben Dooks (Codethink) wrote:
> > The parse_acpi_topology() is not declared anywhere which
> > causes the following sparse warning:
> >
> > drivers/base/arch_topology.c:522:19: warning: symbol 'parse_acpi_topology' was not declared. Should it be static?
> >
> > Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> > ---
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Hi Greg,
> 
> Can you pick this up ? Thanks.

Ok, I'll add it to the queue, give me a week to get to it, thanks.

greg k-h
