Return-Path: <SRS0=w4Fx=WO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1679AC41514
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D70B521773
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Aug 2019 01:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566092925;
	bh=D7mXtRYDPrQWVbF8zkOvJMvyD0EWZF8MNTf2Z52kA+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YTs3enkyPXmAirwcDViNMDdcmqw5/BarwVKMKr2AC2eZHv82YEEcawT7HNz3WLQoH
	 /Oe/LCEbOf+12ehmvTNRVZSMcXUVwxAR01UpArz9tzdw2fSwLuZrlvdXflhxpJJFOC
	 gm60dBUBqEsPOSp5cmUf4TtsuW1trbfhYsq5+f+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfHRBso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Aug 2019 21:48:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbfHRBsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Aug 2019 21:48:43 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C2972086C;
        Sun, 18 Aug 2019 01:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566092922;
        bh=D7mXtRYDPrQWVbF8zkOvJMvyD0EWZF8MNTf2Z52kA+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=quLKlFFUfoX/ViB18dReTywxQd61z6KUElmS3Mzi0o3mi4Wwfm1zcAZ1roS3slxiL
         a+lGk9HFNSa5wlIZYu1s6MQH3GVvEYlNxRIEjzmGEcq6pgD/AMQusDur6o9lVhpqQS
         /VGYENu3Lfrxu6ppO9MTT0bgq40uzP99LNtN9ifY=
Date:   Sat, 17 Aug 2019 21:48:41 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Wise <pabs3@bonedaddy.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jakub Wilk <jwilk@jwilk.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.2 57/59] coredump: split pipe command
 whitespace before expanding template
Message-ID: <20190818014841.GF1318@sasha-vm>
References: <20190806213319.19203-1-sashal@kernel.org>
 <20190806213319.19203-57-sashal@kernel.org>
 <c835c71b722c3df3d11e7b7f8fd65bbd7da0d482.camel@bonedaddy.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c835c71b722c3df3d11e7b7f8fd65bbd7da0d482.camel@bonedaddy.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:41:46AM +0800, Paul Wise wrote:
>On Tue, 2019-08-06 at 17:33 -0400, Sasha Levin wrote:
>
>> From: Paul Wise <pabs3@bonedaddy.net>
>>
>> [ Upstream commit 315c69261dd3fa12dbc830d4fa00d1fad98d3b03 ]
>
>The patch changes the behaviour of the interface between the Linux
>kernel and userspace core dump handlers. The previous behaviour was
>unlikely to be depended on by any core dump handler but it is still a
>behaviour change, so I think it would be best to keep it out of the
>stable branches and would prefer to have folks encounter the change as
>Linux distros etc roll out 5.3 and later into their dev releases.
>
>We discussed this on #kernelnewbies a while ago and gregkh agreed that
>it should stew a while longer before reaching any stable releases.
>
>In addition if it gets backported to stable releases, my patch for
>core(5) from man-pages will have to get more complicated :)

I'll just drop it and let Greg deal with it then :)

--
Thanks,
Sasha
