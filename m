Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB2FC28EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 00:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D484207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 00:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560126484;
	bh=Rt+JLOLIzSPtAmQb1YWUsnFccYzZRTvtsUuEQ3pD+3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MUfmkI2PAQdLctyPiBwRLX6XLrNWLB5b3uSfBbLjEUfPDgJhsx/K89WsOM6ufhN63
	 Hr1axuMZHbzD6AEIEnx2MohKuy2z6BrFxqrG/q5ZhHemyAEez8rG35ag3Ax5KQP1i8
	 T3SBbgg3iIPWJm+eCKaVJGSd3N30tUismOZMNn+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfFJA2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Jun 2019 20:28:01 -0400
Received: from casper.infradead.org ([85.118.1.10]:43356 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfFJA2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jun 2019 20:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oR3ruX4fj29v0IUIiOQXxwa7T9FiLW5WmD1hgvXZ4f0=; b=E/b0LbIaqfk2YB2/hZNyjP73Hy
        4eL1NW8C15AGluMot0IgGSRwjaTTwDNwDfZyzKxAnFxC847eKJN3aFULw7IJe0uvbD7I2L8UvSBav
        PoiCD2KUOKi1IqBLq5RGOMCgKGOGtLmDxFTL+rYu7SkJDDgBDXpPtI9NVF9gPn0c97bLIbs2VXJ7m
        +kjAkLtbBpd6pSYzC0/aVLHB0M/p/hIe/nyWqtRw1Y00oNPomaitZ5NQEC2nKhZ1ZkaBS9Xt0LA0j
        dqkSW5+UK+EYV2Coad6ndSFJ9Psdl/KAc8GJQi920wP/XK+X5E4y1BKXCqzoUHOJRQ691C0xGZ3PU
        k2auB/QA==;
Received: from 179.176.115.133.dynamic.adsl.gvt.net.br ([179.176.115.133] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1ha8AA-0002qB-UX; Mon, 10 Jun 2019 00:27:52 +0000
Date:   Sun, 9 Jun 2019 21:27:45 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 07/33] docs: cpu-freq: convert docs to ReST and
 rename to *.rst
Message-ID: <20190609212745.6257a58f@coco.lan>
In-Reply-To: <CAJZ5v0jfObx72ZSKP+rrErkNTHH6Q1L5_gkHq1SRnHiAtYT1Og@mail.gmail.com>
References: <cover.1560045490.git.mchehab+samsung@kernel.org>
        <e8cb6d826e691a34996b6812851461b6000442e8.1560045490.git.mchehab+samsung@kernel.org>
        <CAJZ5v0jfObx72ZSKP+rrErkNTHH6Q1L5_gkHq1SRnHiAtYT1Og@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, 9 Jun 2019 23:38:32 +0200
"Rafael J. Wysocki" <rafael@kernel.org> escreveu:

> On Sun, Jun 9, 2019 at 4:30 AM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > The conversion is actually:
> >   - add blank lines and identation in order to identify paragraphs;
> >   - fix tables markups;
> >   - add some lists markups;
> >   - mark literal blocks;
> >   - adjust title markups.
> >
> > At its new index.rst, let's add a :orphan: while this is not linked to
> > the main index.rst file, in order to avoid build warnings.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> I have said "no" to this already twice.

I'm really sorry, I forgot to drop it. It is gone now from:

https://git.linuxtv.org/mchehab/experimental.git/log/?h=convert_rst_renames_v4.1&ofs=50

Thanks,
Mauro
