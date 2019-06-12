Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9753EC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7861A2080A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 10:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438134AbfFLK7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 06:59:54 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48004 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438119AbfFLK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 06:59:52 -0400
X-Greylist: delayed 1164 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jun 2019 06:59:51 EDT
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hb0fz-0004eM-FG; Wed, 12 Jun 2019 12:40:19 +0200
Date:   Wed, 12 Jun 2019 12:40:19 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Colin King <colin.king@canonical.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xfrm: fix missing break on AF_INET6 case
Message-ID: <20190612104019.2f6x72wa2qdxw5p3@breakpoint.cc>
References: <20190612103624.27246-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612103624.27246-1-colin.king@canonical.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It appears that there is a missing break statement for the AF_INET6 case
> that falls through to the default WARN_ONCE case. I don't think that is
> intentional. Fix this by adding in the missing break.

Yes, I sent same patch a few minutes ago:

https://patchwork.ozlabs.org/patch/1114377/

I don't mind which one gets applied.
