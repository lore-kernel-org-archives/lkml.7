Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FDDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDAF20828
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553586815;
	bh=2u2SYVH6cSy8AGlLJu2FtaQDQgl6GiWuIh2WWr/isDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jZRt7ZferguHA3ysKiy6FTCaAIeBCoUPdh4ieCcusIX4o/Fv+Y+7kSPtP0P4q+4q6
	 44IWYtGUwuDyJMC72ibSGdazfUv9gisLjC2S5X/HKt3GW2lz9/Kd564SmkF6n4G8ry
	 arTm3NEzo0NS7y/CXh3rdHgNkzK1xgobYZblTh7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfCZHxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 03:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731298AbfCZHx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 03:53:28 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BF120828;
        Tue, 26 Mar 2019 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553586807;
        bh=2u2SYVH6cSy8AGlLJu2FtaQDQgl6GiWuIh2WWr/isDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U6HSxKoTOiwwyRJPXpMvTONWh10xcw5yN0LiwxkzVj8hINfluXLUpS29R4uojcUdU
         d7EqaFGou9o5PYDoxPxAj7Vzb78wVS7/Xa7XfnQcrZAReHAuUs0BbbNHil64XZwmIz
         /kzURC72u2ydVMNRi3MAYPsNrFt93REjvbSH/VBE=
Date:   Tue, 26 Mar 2019 16:53:24 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes for 5.1 rc2/3
Message-ID: <20190326075324.GA25748@kroah.com>
References: <20190321152816.GA1381@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321152816.GA1381@ogabbay-VM>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 05:28:16PM +0200, Oded Gabbay wrote:
> Hi Greg,
> 
> A couple of important fixes for habanalabs driver:
> 
> - Fix host crash upon resume after suspend
> - Fix MMU related bugs which result in user's jobs getting stuck
> - Fix race between user context cleanup and hard-reset which results in
>   host crash
> - Fix sparse warning
> 
> Thanks,
> Oded
> 
> The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:
> 
>   Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2019-03-21
> 
> for you to fetch changes up to 2198b040b98cfbed62716692a34eb971e0383f93:
> 
>   habanalabs: cast to expected type (2019-03-03 10:23:29 +0200)
> 
> ----------------------------------------------------------------

There is no text at all in your tag :(

You need to put something there, like "here are the fixes that do..." or
some sort of explaination for why this set of patches need to be pulled
in.  That way it shows up in the merge commit properly.

Can you fix this up and resend?

thanks,

greg k-h
