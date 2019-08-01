Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C3BC41514
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E4A3206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564641499;
	bh=LO4m7/IlFInRA3rHLgS6MES1MKgAaPMEi+6uNhNyD00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y4SB+D1X56apFVQC/2fC0FzBUPA1b0Mz2ni9a8V7sWaDsnlbRT8WjefZkatwB5Mje
	 gSSh0kuaSMU38ryM8obLSCZ7bElLNeEBY+EXc/x8MisBl5JI61P23etLYq7tavd0n6
	 tzXqbxGDPe93YE6maKjO43AIyK6mwSRKCRVWdiWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730082AbfHAGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 02:38:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:43068 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbfHAGiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 02:38:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 531F4AD1E;
        Thu,  1 Aug 2019 06:38:17 +0000 (UTC)
Date:   Thu, 1 Aug 2019 08:38:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>
Subject: Re: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20190801063814.GC11627@dhcp22.suse.cz>
References: <20190731161151.26ef081e@canb.auug.org.au>
 <1564554484.28000.3.camel@mtkswgap22>
 <20190801155130.29a07b1b@canb.auug.org.au>
 <20190801061527.GB11627@dhcp22.suse.cz>
 <1564641003.25219.7.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564641003.25219.7.camel@mtkswgap22>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-08-19 14:30:03, Miles Chen wrote:
[...]
> It's the first time that I receive a build warning after the patch has
> been merged to -mm tree. The build warning had been fixed by Qian,
> should I send another change for this?
 
No need. Andrew has already picked up the fix for mmotm tree and it
should show up in linux-next soon.

Thanks!
-- 
Michal Hocko
SUSE Labs
