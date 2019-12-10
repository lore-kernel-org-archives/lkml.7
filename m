Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AB0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE8120726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 03:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575947894;
	bh=Yi+uEAMqEX2wwys1zvPN5FbbS5xieRzYGdZ8gaLfpF0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=bEXOOLVXbVzjCXDDAO2KnredEmlqh1F0fpAChPtwvZLPQJBKKJqOJw/JYPDUkwYWe
	 6nJilA4i4uE8Z7CZ0l2ZXHk5mFWgjszkhmUqEhQBE+wBH0M6bqAywBqDD9JhNEFYn6
	 pL5ayq2j3ZyAyQ81SVME19DjoOd/0E7svlsi+Nqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLJDSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 22:18:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfLJDSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:18:12 -0500
Received: from paulmck-ThinkPad-P72.home (199-192-87-166.static.wiline.com [199.192.87.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9305D20726;
        Tue, 10 Dec 2019 03:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575947891;
        bh=Yi+uEAMqEX2wwys1zvPN5FbbS5xieRzYGdZ8gaLfpF0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LMWwzcP7Ra0w+L9p6LFpSutRzWZsFpG5WGu72pALiovvu5fpMARwD0yKGyU2HXkEp
         3DpFFwav/MrPYWwim8+QMprataxDv1DKMrx+jKTpUPxc8EdCZOToASUZ9jKA6TSAg4
         wWPUlQOde3ykYbjCntZkfTTMBJPB6rcxXDiJ+HQo=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7BE9A3522768; Mon,  9 Dec 2019 19:18:10 -0800 (PST)
Date:   Mon, 9 Dec 2019 19:18:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2019.12.08a 37/105] net/tipc/crypto.c:261:39: error:
 implicit declaration of function 'lockdep_is_held'; did you mean
 'lockdep_rtnl_is_held'?
Message-ID: <20191210031810.GR2889@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <201912100911.1F4xx4U8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201912100911.1F4xx4U8%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 09:38:21AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2019.12.08a
> head:   27628657c4a5dc4ed361a933fd368059d1653ac2
> commit: 60a637364607f8086690fe03d31ca2f255c6e79e [37/105] rcu: Remove rcu_swap_protected()
> config: c6x-allyesconfig (attached as .config)
> compiler: c6x-elf-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 60a637364607f8086690fe03d31ca2f255c6e79e
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=c6x 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):

Another use slipped in about a month ago!  I have queued a patch
with your Reported-by fixing it, thank you!

							Thanx, Paul

>    net/tipc/crypto.c: In function 'tipc_crypto_key_try_align':
>    net/tipc/crypto.c:261:2: error: implicit declaration of function 'rcu_swap_protected'; did you mean 'rcu_sync_enter'? [-Werror=implicit-function-declaration]
>      rcu_swap_protected((rcu_ptr), (ptr), lockdep_is_held(lock))
>      ^
>    net/tipc/crypto.c:1192:3: note: in expansion of macro 'tipc_aead_rcu_swap'
>       tipc_aead_rcu_swap(rx->aead[key.passive], tmp2, &rx->lock);
>       ^~~~~~~~~~~~~~~~~~
> >> net/tipc/crypto.c:261:39: error: implicit declaration of function 'lockdep_is_held'; did you mean 'lockdep_rtnl_is_held'? [-Werror=implicit-function-declaration]
>      rcu_swap_protected((rcu_ptr), (ptr), lockdep_is_held(lock))
>                                           ^
>    net/tipc/crypto.c:1192:3: note: in expansion of macro 'tipc_aead_rcu_swap'
>       tipc_aead_rcu_swap(rx->aead[key.passive], tmp2, &rx->lock);
>       ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +261 net/tipc/crypto.c
> 
> fc1b6d6de22087 Tuong Lien 2019-11-08  256  
> fc1b6d6de22087 Tuong Lien 2019-11-08  257  #define tipc_aead_rcu_ptr(rcu_ptr, lock)				\
> fc1b6d6de22087 Tuong Lien 2019-11-08  258  	rcu_dereference_protected((rcu_ptr), lockdep_is_held(lock))
> fc1b6d6de22087 Tuong Lien 2019-11-08  259  
> fc1b6d6de22087 Tuong Lien 2019-11-08  260  #define tipc_aead_rcu_swap(rcu_ptr, ptr, lock)				\
> fc1b6d6de22087 Tuong Lien 2019-11-08 @261  	rcu_swap_protected((rcu_ptr), (ptr), lockdep_is_held(lock))
> fc1b6d6de22087 Tuong Lien 2019-11-08  262  
> 
> :::::: The code at line 261 was first introduced by commit
> :::::: fc1b6d6de2208774efd2a20bf0daddb02d18b1e0 tipc: introduce TIPC encryption & authentication
> 
> :::::: TO: Tuong Lien <tuong.t.lien@dektech.com.au>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation


