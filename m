Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02CD5C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8BBB206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 16:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbfG2Q2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 12:28:38 -0400
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:32781 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727814AbfG2Q2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 12:28:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id B58A818224D97;
        Mon, 29 Jul 2019 16:28:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stove18_681e57aab8a60
X-Filterd-Recvd-Size: 2302
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Mon, 29 Jul 2019 16:28:35 +0000 (UTC)
Message-ID: <0b6936cb34ca0dcd76b155b9b38366e82b1376f0.camel@perches.com>
Subject: Re: [Fwd: [PATCH 1/2] string: Add stracpy and stracpy_pad
 mechanisms]
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@lip6.fr>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        cocci <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 29 Jul 2019 09:28:34 -0700
In-Reply-To: <alpine.DEB.2.21.1907291004220.2686@hadrien>
References: <7ab8957eaf9b0931a59eff6e2bd8c5169f2f6c41.1563841972.git.joe@perches.com>
            <66fcdbf607d7d0bea41edb39e5579d63b62b7d84.camel@perches.com>
            <alpine.DEB.2.21.1907231546090.2551@hadrien>
            <0f3ba090dfc956f5651e6c7c430abdba94ddcb8b.camel@perches.com>
         <alpine.DEB.2.21.1907232252260.2539@hadrien>
            <d5993902fd44ce89915fab94f4db03f5081c3c8e.camel@perches.com>
            <alpine.DEB.2.21.1907232326360.2539@hadrien>
            <f909b4b31f123c7d88535db397a04421077ed0ab.camel@perches.com>
            <563222fbfdbb44daa98078db9d404972@AcuMS.aculab.com>
         <d2b2b528b9f296dfeb1d92554be024245abd678e.camel@perches.com>
           <alpine.DEB.2.21.1907242040490.10108@hadrien>
          <a0e892c3522f4df2991119a2a30cd62ec14c76cc.camel@perches.com>
          <alpine.DEB.2.21.1907250856450.2555@hadrien>
         <eaef283741c0a6a718040f99a17bdb9882bde665.camel@perches.com>
         <alpine.DEB.2.21.1907291004220.2686@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-07-29 at 10:07 -0400, Julia Lawall wrote:
> I see that stracpy is now in linux-next.  Would it be reasonable to send
> patches adding uses now?

My preference would be to have:

o A provably correct script  If a small subset of
  possible conversions are skipped, that's fine.
o As piecemeal patches cause a lot of churn, work
  for individual maintainers, and also are not
  universally applied, have that script run
  kernel-wide after an rc1 and applied all-at-once.



