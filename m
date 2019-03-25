Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720A4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B70120863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfCYORe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:42182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbfCYORe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:17:34 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66C042084D;
        Mon, 25 Mar 2019 14:17:33 +0000 (UTC)
Date:   Mon, 25 Mar 2019 10:17:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Mario.Limonciello@dell.com>
Cc:     <tzanussi@gmail.com>, <pali.rohar@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: dell_smbios KASAN bug
Message-ID: <20190325101731.3558ecda@gandalf.local.home>
In-Reply-To: <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
References: <1553106560.2080.5.camel@gmail.com>
        <20190320144146.08ecd5e4@gandalf.local.home>
        <1553108749.2079.1.camel@gmail.com>
        <20190320151353.1a223c0e@gandalf.local.home>
        <9541737623f942e49e9310aef963ffbf@ausx13mpc120.AMER.DELL.COM>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 13:22:35 +0000
<Mario.Limonciello@dell.com> wrote:

> > diff --git a/drivers/platform/x86/dell-smbios-base.c b/drivers/platform/x86/dell-
> > smbios-base.c
> > index 9dc282ed5a9e..c3825c674522 100644
> > --- a/drivers/platform/x86/dell-smbios-base.c
> > +++ b/drivers/platform/x86/dell-smbios-base.c
> > @@ -619,6 +619,7 @@ static int __init dell_smbios_init(void)
> > 
> >  fail_platform_driver:
> >  	kfree(da_tokens);
> > +	da_num_tokens = 0;
> >  	return ret;
> >  }
> >   
> 
> Steven,
> 
> Since Tom confirmed this works will you send a formal patch to the ML with this fix?

Will do.

Tom,

Is it OK if I add the following tags to that patch?

Reported-by: Tom Zanussi <tzanussi@gmail.com>
Tested-by: Tom Zanussi <tzanussi@gmail.com>

-- Steve
