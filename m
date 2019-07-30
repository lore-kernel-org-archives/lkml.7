Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F8C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070A42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 22:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564525747;
	bh=hCV6A1QlQIa8QFs1unT8GCtIpnQp3cCsPj2K1gcEVoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bjThooU5fv2yrldDTq7gNCI2croy3VUOZugB0Rdc/1pQbbmQPLqPEod5apo8znDJN
	 Sq+mVAVUIr3ggQjB/Lr3JRMG1uMYjOt/IN28yxoW9v8ieer9LzXuGq7W3ddQhcABCJ
	 IaN9xq2A5hPAht/yc5Cb+TVi5tU7aONWwDX00JtE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfG3W3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 18:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfG3W3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 18:29:05 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC4C206E0;
        Tue, 30 Jul 2019 22:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564525744;
        bh=hCV6A1QlQIa8QFs1unT8GCtIpnQp3cCsPj2K1gcEVoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knVmsNh4/LiSiscdgOWy3TIQFqhmgn5/7ssE28fpXD2PyzYmbseVM7BTOnXnn0eoa
         7/F4lwKP634JvLO8fB/6fi6IzyTLJuvwrUf4VolwlUh4NvXo7cjani3GHy96iK5EfF
         9YHBc2ljlyOwtWYtYUOfihxTKep6c9nSdYQLwzg8=
Date:   Tue, 30 Jul 2019 18:29:03 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: Kernel patch commit message and content do differ
Message-ID: <20190730222903.GI29162@sasha-vm>
References: <ca2abaa5-c478-0b9f-cd51-c60aa032835f@gmx.de>
 <20190729204242.GG250418@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729204242.GG250418@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 01:42:42PM -0700, Matthias Kaehlcke wrote:
>Hi,
>
>On Mon, Jul 29, 2019 at 10:20:25PM +0200, Toralf Förster wrote:
>> May I ask you to clarify why
>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/diff/queue-5.2/net-ipv4-fib_trie-avoid-cryptic-ternary-expressions.patch?id=e1b76013997246a0d14b7443acbb393577d2a1e8
>> speaks about a ternary operator, whereas the diff shows a changed
>> #define?
>
>This is a good question, apparently the content of the queued patch is:
>
>commit 4df607cc6fe8e46b258ff2a53d0a60ca3008ffc7
>Author: Nathan Huckleberry <nhuck@google.com>
>Date:   Mon Jun 17 10:28:29 2019 -0700
>
>    kbuild: Remove unnecessary -Wno-unused-value
>
>
>however the commit message is from:
>
>commit 25cec756891e8733433efea63b2254ddc93aa5cc
>Author: Matthias Kaehlcke <mka@chromium.org>
>Date:   Tue Jun 18 14:14:40 2019 -0700
>
>    net/ipv4: fib_trie: Avoid cryptic ternary expressions
>
>
>Other than that the stable port also is missing a Signed-off-by tag
>from Nathan.
>
>Looks like the patch didn't actually make it into -stable yet? If that
>is correct we should be in time to fix it up before it becomes part of
>the git history.

Right, it was an issue with my script which is now fixed. I've also
fixed up the stable tree. Thanks for pointing it out.

--
Thanks,
Sasha
