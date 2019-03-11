Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720C0C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B352084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552317679;
	bh=GyN8CIJ5eBdr7RQPXWWiMKwbfzvTOikxhhQpmshZwds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YxNsdebnf4ApFSEmuKqnONkKp3RSXsbZSQ2UnI2qr3AFPGUdodE8jf1xKwuSz6fkJ
	 qD//m9mmOpFh30D9UZPTBF5ykTZLAdIi5cdSUlNC+X3boV+zv/ymHAe3MQHGihYtS+
	 scE+3ojIz7TJNp8vGiHp14ESfN2QB3RauGmFZ0bI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfCKPVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbfCKPVR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:21:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1A85206BA;
        Mon, 11 Mar 2019 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552317677;
        bh=GyN8CIJ5eBdr7RQPXWWiMKwbfzvTOikxhhQpmshZwds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zdOH4ynLudvXY5u+bZM1qCkd3t57ky/BexK0tzCKajQxvA3YQ1W1AJlqAbqgMdqqw
         ceJIqluwIEK9FaBHk2Ci3mv9ItA11cgXlzF27cOn1g9W8ZtQ33b36DGV9ZJjB2xy+c
         BOx1M1O7n+PtHyMXQsXU0Y5HA8xH3ocQjeQ5oOTU=
Date:   Mon, 11 Mar 2019 11:21:14 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 4.20 66/72] mm, memory_hotplug:
 is_mem_section_removable do not pass the end of a zone
Message-ID: <20190311152114.GD158926@sasha-vm>
References: <20190223210422.199966-1-sashal@kernel.org>
 <20190223210422.199966-66-sashal@kernel.org>
 <20190226124649.GH11981@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190226124649.GH11981@rapoport-lnx>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 02:46:49PM +0200, Mike Rapoport wrote:
>On Sat, Feb 23, 2019 at 04:04:16PM -0500, Sasha Levin wrote:
>> From: Michal Hocko <mhocko@suse.com>
>>
>> [ Upstream commit efad4e475c312456edb3c789d0996d12ed744c13 ]
>
>There is a fix for this fix [1].
>
>It's  commit 891cb2a72d821f930a39d5900cb7a3aa752c1d5b ("mm, memory_hotplug:
>fix off-by-one in is_pageblock_removable") in mainline.
>
>[1] https://lore.kernel.org/lkml/20190218181544.14616-1-mhocko@kernel.org/

Queued it up, thank you!

--
Thanks,
Sasha
