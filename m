Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44771CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C7E721855
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 17:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572714924;
	bh=wxRXzLZ/VFfodh3uDmLuo2YzllFSRZHuxvgtSo957sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sz65Fc7he2hDOTBs1zAul0q0jIOWPD6CX4fy4o/28C+6wdBhlEaNIbTbgqYqYCK6k
	 cJJyVZ3buZ1JRsm2FbfmCkPsn6zxVq77EPfmVcZAe2MFm/NQNyqnlatl8fofcP8+m2
	 veKJmmkYln2QYkUJxiPXWboyEq3F5EHaWOktenn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfKBRPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 13:15:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfKBRPW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 13:15:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CC6F21855;
        Sat,  2 Nov 2019 17:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572714922;
        bh=wxRXzLZ/VFfodh3uDmLuo2YzllFSRZHuxvgtSo957sw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ay5h2xbytStD1wQfy161oovmVTHde/dqMeRbsu8Pjk7Mlzdq/som9l8KEJqM2UYcU
         xFiv3HAxD/dPku5b0VvyAr94phxc2qm4ypmWXxPPzorVmg9g71HiRJ1eyKhv+nIff+
         B8Qkj2WEDdJFitNUdV4E5quxOMZMCBqlXQSxfghM=
Date:   Sat, 2 Nov 2019 18:15:19 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.4
Message-ID: <20191102171519.GC484428@kroah.com>
References: <f9c1befb-9170-5189-6383-3311773c02f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9c1befb-9170-5189-6383-3311773c02f2@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:08:49PM +0300, Georgi Djakov wrote:
> Hi Greg,
> 
> This is a tiny pull request with interconnect fixes for 5.4-rc. Could you please
> take them into char-misc for the next possible rc.
> 
> Thanks,
> Georgi
> 
> The following changes since commit 4f5cafb5cb8471e54afdc9054d973535614f7675:
> 
>   Linux 5.4-rc3 (2019-10-13 16:37:36 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.4-rc5
> 
> for you to fetch changes up to a8dfe193a60c6db7c54e03e3f1b96e0aa7244990:
> 
>   interconnect: Add locking in icc_set_tag() (2019-10-20 12:14:41 +0300)
> 
> ----------------------------------------------------------------
> interconnect fixes for 5.4
> 
> Two tiny fixes for the current release:
> 
> - Fix memory allocation size in a driver.
> - Add missing mutex.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> 
> ----------------------------------------------------------------
> Georgi Djakov (1):
>       interconnect: Add locking in icc_set_tag()
> 
> Leonard Crestez (1):
>       interconnect: qcom: Fix icc_onecell_data allocation
> 
>  drivers/interconnect/core.c        | 4 ++++
>  drivers/interconnect/qcom/qcs404.c | 3 ++-
>  drivers/interconnect/qcom/sdm845.c | 3 ++-
>  3 files changed, 8 insertions(+), 2 deletions(-)

Sorry for the delay, pulled and pushed out, thanks.

greg k-h
