Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1594CC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A022082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 03:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732646AbfC0DpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 23:45:22 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40562 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfC0DpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 23:45:22 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1h8zV5-0006Kb-F0; Wed, 27 Mar 2019 11:45:15 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1h8zV3-0003sU-Pn; Wed, 27 Mar 2019 11:45:13 +0800
Date:   Wed, 27 Mar 2019 11:45:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc:     NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rhashtable: use bit_spin_locks to protect hash
 bucket.
Message-ID: <20190327034513.x6q6nxcw2hhqfze3@gondor.apana.org.au>
References: <155349021177.1111.15681654355431465791.stgit@noble.brown>
 <155349033961.1111.18247269615646768227.stgit@noble.brown>
 <20190326050320.gwk3tgtqwl5csivt@gondor.apana.org.au>
 <20190326153646.GL4102@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326153646.GL4102@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 08:36:46AM -0700, Paul E. McKenney wrote:
>
> But you are quite right, rcu_assign_pointer() used to just do an
> smp_wmb().  It is now new and improved!  ;-)

Thanks for confirming! I had forgotten about that upgrade :)
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
