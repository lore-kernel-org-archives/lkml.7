Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6088EC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397D421721
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 11:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563276032;
	bh=bnpXBU4Yq9kKluhQK3Hp1VvBLpzztc6o65vObC/VtAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L3zGJIlDE38oFuALi6CtGWkYcthOqW7l7GOTMXSAvCVO/8+swF6lh4g667q+JT0g6
	 zLJrgKeN6KWPr6m4dVeEpEVkUbXjhGHauLhXwkS1AtUAKNa0F+OBNcKjEkhE/OQixp
	 GkfOEMoD4FVGjRo5G9n5Z8A7O6seEV3/NkQ7DhoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387669AbfGPLUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 07:20:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733200AbfGPLUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:20:30 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A894E2145D;
        Tue, 16 Jul 2019 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563276029;
        bh=bnpXBU4Yq9kKluhQK3Hp1VvBLpzztc6o65vObC/VtAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOnVscWaXeYhdQZNolzlwB3m9fuV9CTAUc9padYnC7oeFAKDS8N3quknwdXmu4o8g
         lKIH/EzwHKG8vKcD2TRsc033SI/vWUWOmX0guE/hH4qwOE9OerXUzz5dINK4z0dTuZ
         gwc2ZQT3pWwrHtFiD2jbM5mhVN0wfkDZTouFyfT8=
Date:   Tue, 16 Jul 2019 07:20:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the hyperv-fixes tree
Message-ID: <20190716112028.GC1943@sasha-vm>
References: <20190714225534.1dc093ad@canb.auug.org.au>
 <44b7e61d-438d-e906-57fd-b1182bf6f6c6@infradead.org>
 <20190715080159.318b4edf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190715080159.318b4edf@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 08:01:59AM +1000, Stephen Rothwell wrote:
>Hi Randy,
>
>On Sun, 14 Jul 2019 08:02:11 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> > Please do not split Fixes tags over more than one line.  Also do not
>> > include blank lines among the tag lines.
>>
>> Hm, so you are saying that the Fixes: line should not be separated from the
>> other tag lines?  That's news to me...
>
>see "git interpret-trailers".

Stephen,

Thanks for pointing it out, I've fixed it up. And thanks for pointing
out git-interpret-trailers, I wasn't familiar with that.

--
Thanks,
Sasha
