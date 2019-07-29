Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62698C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D222070D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfG2OHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:07:35 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:22396 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727569AbfG2OHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:07:33 -0400
X-IronPort-AV: E=Sophos;i="5.64,322,1559512800"; 
   d="scan'208";a="393742892"
Received: from 71-219-88-14.chvl.qwest.net (HELO hadrien.PK5001Z) ([71.219.88.14])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2019 16:07:30 +0200
Date:   Mon, 29 Jul 2019 10:07:29 -0400 (EDT)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     David Laight <David.Laight@ACULAB.COM>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
In-Reply-To: <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
Message-ID: <alpine.DEB.2.21.1907291004220.2686@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>    <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>    <alpine.DEB.2.21.1907231546090.2551@hadrien>    <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
  <alpine.DEB.2.21.1907232252260.2539@hadrien>    <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>    <alpine.DEB.2.21.1907232326360.2539@hadrien>    <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>    <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
  <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>   <alpine.DEB.2.21.1907242040490.10108@hadrien>  <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>  <alpine.DEB.2.21.1907250856450.2555@hadrien>
 <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see that stracpy is now in linux-next.  Would it be reasonable to send
patches adding uses now?  Are there any rules for adding calls to
stracpy_pad?

julia
