Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409A7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6EB21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732615AbfDXQPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:15:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41800 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732593AbfDXQPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:15:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91A23142C02;
        Wed, 24 Apr 2019 16:14:57 +0000 (UTC)
Received: from treble (ovpn-123-99.rdu2.redhat.com [10.10.123.99])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B376E60C8E;
        Wed, 24 Apr 2019 16:14:53 +0000 (UTC)
Date:   Wed, 24 Apr 2019 11:14:51 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Raphael Gault <Raphael.Gault@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Julien Thierry <Julien.Thierry@arm.com>
Subject: Re: [PATCH 0/6] objtool: Add support for Arm64
Message-ID: <20190424161451.nnldq5do5wtkr7fo@treble>
References: <20190409135243.12424-1-raphael.gault@arm.com>
 <20190423210947.b2qomzj3qb4pzfr5@treble>
 <e256ae12-bba0-fc39-6d14-89cb89d31a25@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e256ae12-bba0-fc39-6d14-89cb89d31a25@arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Apr 2019 16:15:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 04:08:15PM +0000, Raphael Gault wrote:
> > For the next version, please base it on the -tip tree, as that's where
> > all the latest objtool changes are.  Peter refactored some code which
> > has some minor conflicts with yours.
> >
> 
> Thanks for letting me know about this. Just a quick precision, when you
> talk about the -tip tree, are you talking about this tree ?
> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/

Indeed.  The git link I use is:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git

And generally the master branch of that tree seems to be a good one to
use.

-- 
Josh
