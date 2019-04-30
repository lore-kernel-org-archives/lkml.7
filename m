Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86703C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601092075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfD3KDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:03:00 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:35186 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726012AbfD3KDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:03:00 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hLPbE-000587-GJ; Tue, 30 Apr 2019 12:02:56 +0200
Date:   Tue, 30 Apr 2019 12:02:56 +0200
From:   Florian Westphal <fw@strlen.de>
To:     shuah <shuah@kernel.org>
Cc:     Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>,
        pablo@netfilter.org, Florian Westphal <fw@strlen.de>,
        linu-kselftest@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests : netfilter: Wrote a error and exit code for a
 command which needed veth kernel module.
Message-ID: <20190430100256.mfgerggoccagi2hc@breakpoint.cc>
References: <20190405163126.7278-1-jeffrin@rajagiritech.edu.in>
 <20190405164746.pfc6wxj4nrynjma4@breakpoint.cc>
 <CAG=yYwnN37OoL1DSN8qPeKWhzVJOcUFtR-7Q9fVT5AULk5S54w@mail.gmail.com>
 <c4660969-1287-0697-13c0-e598327551fb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4660969-1287-0697-13c0-e598327551fb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shuah <shuah@kernel.org> wrote:
> Would you like me to take this patch through ksleftest tree?

Please do, this patch is neither in nf nor nf-next and it looks fine to
me.
