Return-Path: <SRS0=QEJJ=XC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E45C43331
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5BB21907
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Sep 2019 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567878157;
	bh=GHJAVT2/iebWv8cgiLcaT3iJsHValcnDCOHaDLgxd3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vILacs0CloLeHzG02CEDsByTDjhYOcnMgEDKM6Eg80KWxylGE2Eu+x0sAjeGt0rsC
	 qhsEA8K1FnMRGLLjBuIRXLNw4j5GyMv2L7KbFz2R4SdNaCh5k6cVB+nA9rfDfqy/b1
	 QzA9XO9kQlB/5reJTTRa5P1yF2vZp/3z0AuhLzNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406268AbfIGRmg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Sep 2019 13:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728507AbfIGRmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Sep 2019 13:42:35 -0400
Received: from localhost (unknown [80.251.162.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97BAF218AE;
        Sat,  7 Sep 2019 17:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567878155;
        bh=GHJAVT2/iebWv8cgiLcaT3iJsHValcnDCOHaDLgxd3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YegHihmOrO7HqZ8bbVS3tGIm+iTrMZL4wtxB3E9/+Q1wZcSR8euLNe94MGe7MNf40
         6do0qipds9FaHV9diRE/V8AXcgsINqBopWBfhEuPMo5cn3kmDafSCK4Cp1F2f/jJ5/
         A60rHL6eAzIF7SOOfAsEvG10E8lDZgWJCYnX5Olg=
Date:   Sat, 7 Sep 2019 18:42:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sandro Volery <sandro@volery.com>
Cc:     linux-kernel@vger.kernel.org, jslaby@suse.com
Subject: Re: [PATCH] Fixed most indent issues in tty_io.c
Message-ID: <20190907174232.GA20070@kroah.com>
References: <20190907172944.GB18166@kroah.com>
 <B45E122D-2B8B-43DA-8658-889E30CB2F0F@volery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B45E122D-2B8B-43DA-8658-889E30CB2F0F@volery.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 07, 2019 at 07:35:42PM +0200, Sandro Volery wrote:
> 
> 
> >>> On 7 Sep 2019, at 19:29, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> ﻿On Sat, Sep 07, 2019 at 07:23:59PM +0200, Sandro Volery wrote:
> >> Dear Greg,
> >> I am pretty sure the issue was, that I did too many things at once. However, all the things I did are related to spaces / tabs, maybe that still works?
> > 
> > <snip>
> > 
> > For some reason you sent this only to me, which is a bit rude to
> > everyone else on the mailing list.  I'll be glad to respond if you
> > resend it to everyone.
> 
> I'm sorry, newbie here. I thought it'd be better to not annoy everyone with responses but learning things everyday I guess :)

No problem, but you should also line-wrap your emails :)

> I am pretty sure the issue with my patch was that there was too many changes, however all of them were spaces and tabs related, so I think this could be fine?

As the bot said, break it out into "one patch per logical change", and
"fix all whitespace issues" is not "one logical change".

thanks,

greg k-h
