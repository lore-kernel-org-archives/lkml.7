Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7017C282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FC208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 07:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbfE2H0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 03:26:55 -0400
Received: from verein.lst.de ([213.95.11.211]:52605 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbfE2H0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 03:26:54 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6E18068AFE; Wed, 29 May 2019 09:26:28 +0200 (CEST)
Date:   Wed, 29 May 2019 09:26:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-mips@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm: add a gup_fixup_start_addr hook
Message-ID: <20190529072628.GA4149@lst.de>
References: <20190525133203.25853-1-hch@lst.de> <20190525133203.25853-5-hch@lst.de> <CAHk-=wg-KDU9Gp8NGTAffEO2Vh6F_xA4SE9=PCOMYamnEj0D4w@mail.gmail.com> <2eecb673-cb18-990e-0a61-900ecd056152@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eecb673-cb18-990e-0a61-900ecd056152@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 09:57:25AM -0600, Khalid Aziz wrote:
> Since untagging addresses is a generic need required for far more than
> gup, I prefer the way Andrey wrote it -
> <https://patchwork.kernel.org/patch/10923637/>

Linus, what do you think of picking up that trivial prep patch for
5.2?  That way the arm64 and get_user_pages series can progress
independently for 5.3.
