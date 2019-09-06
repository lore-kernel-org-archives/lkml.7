Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0506BC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC60920842
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567761774;
	bh=8zRzOgKBLApr8oEix1IWk40fk2ytXiBJhxyvn7NB6Ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PAbsjmVtDBRg16XGmly2wP4xNMzyfHaS7Shc+PSWAMgafHRqhHjvbxZMJd9dZyGb4
	 iHnUAz7X6bDBOoUrkJTi9UVXnGE0tIDd/BimQjNtudygwBiB39wrPEXf/a2X95DFb9
	 wojO0Mry9FbTimvRy+OX1pZWrxw5jmJlUGlMU9Lk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392886AbfIFJWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 05:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:46732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfIFJWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 05:22:53 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 489262082C;
        Fri,  6 Sep 2019 09:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567761773;
        bh=8zRzOgKBLApr8oEix1IWk40fk2ytXiBJhxyvn7NB6Ck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PK5pNnbzM5cB2Tpvid2oulC6TVGMwM60sVnaFbqEEeZsC70OgEQyThbYjLIknPYlB
         47x8CrJBCXCarK8f7H6Z7T4kaJKQAHTfjzeAbIKf9OQ5m2niidZ71K9q77QhWthoja
         Q9Z1o2vbSjUO/6OaCsDfoWGH5LLRF4qr3oQIZThI=
Date:   Fri, 6 Sep 2019 10:22:47 +0100
From:   Will Deacon <will@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Quentin Perret <quentin.perret@arm.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        catalin.marinas@arm.com, morten.rasmussen@arm.com,
        chris.redpath@arm.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, valentin.schneider@arm.com,
        qais.yousef@arm.com, qperret@qperret.net
Subject: Re: [PATCH] mailmap: Update email address for Quentin Perret
Message-ID: <20190906092246.corlf2mtyb2rajoe@willie-the-truck>
References: <20190902105036.32419-1-quentin.perret@arm.com>
 <20190903145950.xko5fejupxj3f5nx@willie-the-truck>
 <20190904144346.396a77f8@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904144346.396a77f8@lwn.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 02:43:46PM -0600, Jonathan Corbet wrote:
> On Tue, 3 Sep 2019 15:59:50 +0100
> Will Deacon <will@kernel.org> wrote:
> 
> > Since this isn't really an arm64 change (there's no change to MAINTAINERS),
> > I'd rather it went via Andrew or Jon. However, there was some resistance
> > last time this sort of email change happened:
> > 
> >   http://lkml.kernel.org/r/20190806112959.14845da4@lwn.net
> > 
> > so I'm not sure what the current preference is. Jon?
> 
> If there's some value to having an entry in the mailmap file, then
> obviously it should be added.  I didn't resist so much as engage in a
> little muttering under my breath as I applied the patch...

Ok, just wanted to make sure you were ok with it. Would be able to pick
this via your tree then, please? If it helps,

Acked-by: Will Deacon <will@kernel.org>

The original patch is here:

http://lore.kernel.org/r/20190902105036.32419-1-quentin.perret@arm.com

Will
