Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D2FEC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 380642081B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfLDPHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:07:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:41554 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfLDPHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:07:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E1A5EAEF9;
        Wed,  4 Dec 2019 15:07:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 89D7EDA98E; Wed,  4 Dec 2019 16:07:33 +0100 (CET)
Date:   Wed, 4 Dec 2019 16:07:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Enlist running kernel modules information
Message-ID: <20191204150728.GD2734@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Masahiro Yamada <masahiroy@kernel.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20191203094845.610692-1-unixbhaskar@gmail.com>
 <CAK7LNASyrYv+pufwe4CfiNvd7NtriLw=FRdLOtu7CrbmZDSVHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASyrYv+pufwe4CfiNvd7NtriLw=FRdLOtu7CrbmZDSVHg@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 12:10:25PM +0900, Masahiro Yamada wrote:
> On Tue, Dec 3, 2019 at 6:49 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
> > +awk '{print $1}' "/proc/modules" | xargs modinfo | awk '/^(filename|desc|depends)/'
> 
> I want to see a good reason (e.g. useful for other developers) for upstreaming.
> This script looks like your custom script, which you can maintain locally.

I think the verbosity should be added to either lsmod or modinfo, not
some script in kernel git.
