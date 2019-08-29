Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD47C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF820828
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbfH2LiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:38:20 -0400
Received: from elvis.franken.de ([193.175.24.41]:39763 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726839AbfH2LiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:38:19 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1i3Ikr-0000FK-00; Thu, 29 Aug 2019 13:38:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0A869C2763; Thu, 29 Aug 2019 13:20:52 +0200 (CEST)
Date:   Thu, 29 Aug 2019 13:20:52 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] MIPS: PCI: refactor ioc3 special handling
Message-ID: <20190829112051.GA9113@alpha.franken.de>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
 <20190809103235.16338-5-tbogendoerfer@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809103235.16338-5-tbogendoerfer@suse.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 12:32:26PM +0200, Thomas Bogendoerfer wrote:
> Refactored code to only have one ioc3 special handling for read
> access and one for write access.
> 
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
>  arch/mips/pci/pci-xtalk-bridge.c | 167 +++++++++++++++------------------------
>  1 file changed, 62 insertions(+), 105 deletions(-)
> [..]

Paul,

it looks like this won't make it into the next merge window, but
I want to reduce the number of patches in this series.

Could you take this patch into mips-next ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
