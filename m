Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45940C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6162173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 14:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558448239;
	bh=aFgS3FRwlivx+ZhHeFRUtTp70UBdo7+6IUb/uvATLIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jliAUQV3wyiEASmLsc1+OZ0I3Y/2AC9BKsSXPaFsD1UXq68YGrpEWxGIqUKDEior9
	 9Iru59kOSzxYnmTZgr5ayRU4IAt+MacYfbHQiCavsN7FtpJSds8nEPxt0lEo4NioKN
	 Jqin81Ec9pLyiAphHWFQLs7Hee/MNuEJiv9f8118=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfEUORS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 10:17:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfEUORS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 10:17:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0172173C;
        Tue, 21 May 2019 14:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558448237;
        bh=aFgS3FRwlivx+ZhHeFRUtTp70UBdo7+6IUb/uvATLIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U3/HE/2R/J0b4V2AG/ljjYYWi/HKEpZkLJ4WBTYBxoUWacExzlxNcC2yUcUC7/Man
         UKU+v89T6Ph6D5jFRQWju3rQLW5DxBMT1fgdWebTKbarcRnYBpFay3m03Ai43uIuJo
         2H+DF+7CU21t4P9UutVhsnToP/zce7H3obW5gCrg=
Date:   Tue, 21 May 2019 16:17:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Oscar Gomez Fuente <oscargomezf@gmail.com>,
        devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: fieldbus: solve warning incorrect type
 dev_core.c
Message-ID: <20190521141715.GA25603@kroah.com>
References: <1558115396-3244-1-git-send-email-oscargomezf@gmail.com>
 <CAGngYiVNQrr2nKfGCdi8FzS5UnmGaDj_Gu_F0ZeOTMKX6_1Zuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiVNQrr2nKfGCdi8FzS5UnmGaDj_Gu_F0ZeOTMKX6_1Zuw@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 10:13:58AM -0400, Sven Van Asbroeck wrote:
> On Fri, May 17, 2019 at 1:50 PM Oscar Gomez Fuente
> <oscargomezf@gmail.com> wrote:
> >
> > These changes solve a warning realated to an incorrect type inilizer in the function
> > fieldbus_poll.
> >
> > Signed-off-by: Oscar Gomez Fuente <oscargomezf@gmail.com>
> > ---
> 
> I've reviewed your patch and tested it on a live system. Everything looks good.
> However, I believe that your commit message could be improved.
> 
> I am going to re-post this patch as v3 (keeping you as the author) but with
> a (hopefully) improved commit message. If you provide positive feedback,
> and nobody else has any comments, I will tag it with my Reviewed-by,
> which will hopefully be Greg's cue to take the patch.

Greg already took this patch a while ago :)

thanks,

greg k-h
