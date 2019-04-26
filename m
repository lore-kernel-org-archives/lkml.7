Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E7BC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7349206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556292073;
	bh=T7sa0lWh6EUzJkNmw2qBiClSzhF/afAqQXr/hR4UHqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yGQDI2/PdID25nCvAPI/kPZNd6eLXA/z2aTt3n89AUo/Xlbw8Y9xP19zlRncSIcNl
	 293Q4Ymtc2Fg0Oqu+iTV9UAFPhxh5fCQ7A7YbXaGYsDZ0jWaW+37QLdMUwVPQfuwaA
	 5DNVXJ89fKQkuXkHqxUXpJZbJ+qLq7w4dnqBhW54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfDZPVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725984AbfDZPVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:21:11 -0400
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74B7206BF;
        Fri, 26 Apr 2019 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556292070;
        bh=T7sa0lWh6EUzJkNmw2qBiClSzhF/afAqQXr/hR4UHqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBk4Ki5TLoXdH/mNErItlpqyC2g1/4dJlNTgoCawhvf0uz4sdfkjWgg7rOQs6CdtC
         NGebWV8lvQyqZuKn94FVzVQb8DwO0qvbW08rJBVgG/q/e5nX0GH/iKuFbMBm8Q0cZ1
         rye21ECLdvbM7pMcekGCv2uDcKOpdwPLPfsPphIA=
Date:   Fri, 26 Apr 2019 23:21:02 +0800
From:   Guo Ren <guoren@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <ren_guo@c-sky.com>
Subject: Re: [GIT PULL] csky fixes for v5.1-rc7
Message-ID: <20190426152101.GA10125@guoren-Inspiron-7460>
References: <1556181403-3881-1-git-send-email-guoren@kernel.org>
 <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh8NTGSOerqZNhefEn=AX5kgx27tD+kv=UpOB8u-FeYTA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Thu, Apr 25, 2019 at 09:21:01AM -0700, Linus Torvalds wrote:
> On Thu, Apr 25, 2019 at 1:36 AM <guoren@kernel.org> wrote:
> >
> > Here are the patches which made on 5.1-rc6 and all are tested in our
> > buildroot gitlab CI:
> 
> This really looks like it should come in the next merge window, not during rc7.
> 
> You had absolutely zero csky updates during the merge window, you
> can't then magically come up with "look, here's 1300 lines of fixes"
> during the late rc series.
You are right and I know I've missed 5.1-rc1 merge window.

> Re-send when the merge window opens.
Ok.

Best Regards
 Guo Ren
