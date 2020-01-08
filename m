Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6B3C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331C42067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 18:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgAHSq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:46:26 -0500
Received: from verein.lst.de ([213.95.11.211]:50726 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729226AbgAHSqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 13:46:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8420B68CEC; Wed,  8 Jan 2020 19:46:16 +0100 (CET)
Date:   Wed, 8 Jan 2020 19:46:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
Subject: Re: [v8 08/13] exfat: add exfat cache
Message-ID: <20200108184616.GA15429@lst.de>
References: <CAKYAXd8Ed18OYYrEgwpDZooNdmsKwFqakGhTyLUgjgfQK39NpQ@mail.gmail.com> <f253ed6a-3aae-b8df-04cf-7d5c0b3039f2@web.de> <20200108180819.3gt6ihm4w2haustn@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200108180819.3gt6ihm4w2haustn@pali>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2020 at 07:08:19PM +0100, Pali Rohár wrote:
> On Thursday 02 January 2020 11:19:26 Markus Elfring wrote:
> > > I am planning to change to share stuff included cache with fat after
> > > exfat upstream.
> > 
> > Can unwanted code duplication be avoided before?
> 
> +1 Could it be possible?

Let's defer that until we have the code upstream.  Getting rid
of the staging version and having proper upstream exfat support
should be a priority for now, especially as sharing will involve
coordination with multiple maintainers.  If it works out nicely
I'm all for it, though!
