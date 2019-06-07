Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913CEC28EBB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E4520B7C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 00:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559867068;
	bh=/JAzBqFy3SXtb7a5Gpv8iuNYJP18hnVQYOVV9nk078o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BNz2y2hdVFjF6mQLgKLNdlSXMVHt2aOUT3k7gOj28hqWXnv5enseQY79dJFN0i5vU
	 01z3u7kr16AncFYfCiVdEm4WccTDawqwCFaMvKkP1KBnBZj4hU0QxCiGTIUEaIuiud
	 RVZJVWBwvKzgkKWIQj4nL9E/SAD1EJ0rtcyCFEBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfFGAY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 20:24:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbfFGAY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 20:24:27 -0400
Received: from dragon (li1264-180.members.linode.com [45.79.165.180])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B49206DF;
        Fri,  7 Jun 2019 00:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559867066;
        bh=/JAzBqFy3SXtb7a5Gpv8iuNYJP18hnVQYOVV9nk078o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XQITSzJaKYh2jRSUJLHAvMFiTSY7mDuVBUb42yYODcuHYG9Pb2XlrLx3YcKUY5Rzx
         sA/xnOf1q02lTG4PLQ8a0vlZXqKJJIG7vd8s0gjLVqA/U4eTBm1L1CWPRd/SfqO6cj
         v5FHE7zzDqZ9HToPdlXts97NcqPqn147/4uJN+0I=
Date:   Fri, 7 Jun 2019 08:24:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20190607002407.GY29853@dragon>
References: <20190607074652.4b3d0c97@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190607074652.4b3d0c97@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2019 at 07:46:52AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   f6a8ff82ce68 ("clk: imx: imx8mm: correct audio_pll2_clk to audio_pll2_out")
> 
> Fixes tag
> 
>   Fixes: ba5625c3e27 ("clk: imx: Add clock driver support for imx8mm")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

Hi Stephen,

Thanks for reporting.  I just got it fixed, will be more careful about
that in the future.

@Peng, please check your git configuration as suggested above, thanks.

Shawn
