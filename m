Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE8E5C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8F821848
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568744203;
	bh=wmKhsm10Gq2gbdPLt1vTkKmrtEBJgttx9YRtdFprYww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BakLdu9tBVIwU79LVlH8nV0kBHq4Kg4/RK94d1nduSecxqbNkUqzGFFY8JH2hUxOu
	 syjztSvdev5t3HKLh+i8Wkr6eFKq9ChI/UM99DZgLin9Xo2R9SEv1EfdaAlf5P1ClO
	 rukOM1gyTxbwaHgS4qYr1guHHZ90+J9I8hEzk7Pw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfIQSQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 14:16:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfIQSQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 14:16:42 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BF7D21670;
        Tue, 17 Sep 2019 18:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568744201;
        bh=wmKhsm10Gq2gbdPLt1vTkKmrtEBJgttx9YRtdFprYww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RKXyzlXaSA7KMXAoA+UmpYsQNBXvlcYrMDgfkB4pIXNqXzMbEsZG+3/v3NQhKbFHs
         FKEfFTjC6rJGv0+cl5apwf75DGC6dzRiI5JTNX1VfABTPAq1kV8eQbqZ3THcnk1KQ/
         G8Z9Z7KiG+5BZs4ltvzJaIfU+9GQ7jL5tumqAJ4U=
Date:   Tue, 17 Sep 2019 19:16:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthias Maennich <maennich@google.com>,
        gregkh@linuxfoundation.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Kbuild updates for v5.4-rc1
Message-ID: <20190917181636.7sngz5lrldx34rth@willie-the-truck>
References: <CAK7LNARsoed86dY75b_HNXXkCXRAKdMUGaEWUUca4BuGaZCwcg@mail.gmail.com>
 <20190917150902.GA4116@linux-8ccs>
 <CAK7LNAR_8atC3M9gGQ=DBwzFG52PVuNaFVAzAr32TKxTwDCLug@mail.gmail.com>
 <20190917180136.GA10376@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917180136.GA10376@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

On Tue, Sep 17, 2019 at 08:01:36PM +0200, Jessica Yu wrote:
> Yikes, I did not catch Stephen Rothwell's email about pausing the
> linux-next releases from Sept 5 until Sept 30
> (https://lore.kernel.org/linux-next/20190904233443.3f73c46b@canb.auug.org.au/).
> 
> The modules-next namespace patches have been in since last Tuesday,
> and my original plan was for them to catch at least a week of
> linux-next time before sending the pull request. :-/ But that did not
> happen due to the above.
> 
> So Linus, in light of the above realization, I'd say at this time - I
> will still formally send a pull request with the merge conflicts
> resolved with either solution #2 or #3, but merge at your own
> discretion, it's fine to delay to the following release if you're
> uncomfortable.

FWIW, when I've run into unexpected merge conflicts with other trees in the
past, I've found that it's usually sufficient just to include the resolution
as an inline diff in the pull request, rather than try to munge the tree
with merges or rebases.  Linus is pretty good at figuring it out, and with a
resolution to compare with, the damage is limited. The downside of the merge
is that it's fiddly to extract the changes and see what's actually being
pulled.

Also, it's not like the kbuild stuff has been in -next for ages, so this
would've been a late and messy conflict regardless.

Will
