Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC4C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB0B42186A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 05:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbfHHFAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 01:00:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58726 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbfHHFAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 01:00:08 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvaWz-0002b7-Ul; Thu, 08 Aug 2019 15:00:06 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvaWy-0004V2-Jr; Thu, 08 Aug 2019 15:00:04 +1000
Date:   Thu, 8 Aug 2019 15:00:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chuhong Yuan <hslester96@gmail.com>
Subject: Re: linux-next: build failure after merge of the crypto tree
Message-ID: <20190808050004.GA17267@gondor.apana.org.au>
References: <20190805145736.2d39f95b@canb.auug.org.au>
 <20190808115245.0c88c300@canb.auug.org.au>
 <20190808030156.GA15782@gondor.apana.org.au>
 <20190808131710.7186de0c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808131710.7186de0c@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 01:17:10PM +1000, Stephen Rothwell wrote:
>
> Excellent, thanks.  Should I add the crypto mailing list as a contact
> for problems?  Mostly the emails are just reporting conflicts and only
> very occasionally do I actually send a useful patch.  If so, what is
> its address?

Yes please.  The address is

	linux-crypto@vger.kernel.org

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
