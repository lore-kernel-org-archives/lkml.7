Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EA9C3A59B
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC852086C
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566092749;
	bh=kccxG/mB4GvXNVjNuurZTDd2pbdhYO8DJzrsZ8bh8iA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iCXfKfgEZlt3xt5ZNHbW2AflG0yrpDCQo82fgHQKfmrlBnS8WMQWdXfWP9XGGHJbQ
	 gIVPCEbbD9OKC0Q4zDGsvwVel59xiRHZOs5ia/LjjYCzyoJMAhheM2+y+eK6ZyHCCe
	 lzbCjgo3rJdPy6fsDFYMABLPcZAtP9wu255jXkpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbfHRBp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:45:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfHRBp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:45:28 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 923072086C;
        Sun, 18 Aug 2019 01:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566092727;
        bh=kccxG/mB4GvXNVjNuurZTDd2pbdhYO8DJzrsZ8bh8iA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJnsiVZcGZ3piWBxkg3dm05i+1wcgv7SKqp6wK/X0TNHGRojAbp2PeQNfc5bqnvHo
         FKqt8xd3WPvQt41+cbaHpshKySjpkm6LE1J79l6DEaqzlv7X2UYjP3w6C5nKeKSX88
         KuuuVQDQaMZg8g8CFQBtk7vkwMfIRHHI6ii87wcs=
Date:   Sat, 17 Aug 2019 21:45:26 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Rob Clark <robdclark@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH AUTOSEL 5.2 37/59] drm/vgem: fix cache synchronization on
 arm/arm64
Message-ID: <20190818014526.GD1318@sasha-vm>
References: <20190806213319.19203-1-sashal@kernel.org>
 <20190806213319.19203-37-sashal@kernel.org>
 <CAJs_Fx5rj45yJ5kh5vLHRMWLYi=qmnMJ919LKdX8icTnvLwgoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAJs_Fx5rj45yJ5kh5vLHRMWLYi=qmnMJ919LKdX8icTnvLwgoA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 06, 2019 at 03:45:48PM -0700, Rob Clark wrote:
>please don't queue this one for stable branches.. it was causing
>problems in intel CI

Now dropped, thank you.

--
Thanks,
Sasha
