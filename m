Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F2AC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BD52173B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 00:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563496762;
	bh=eCiWYiZG0ijNfOfYOEbIo8fg8pTnk26ENs0Aqaz/cgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+ehLf8mCGOJ8lvrYJqLPe4tGt1V4zKgz+vQzFiJcoP+vm7tMq5c6JFY9tTjWFMl7
	 PFn1C4yZ7kGahVfy4l10CP6QPZxQHpDxuQEvTRxWo0arPnLWoKpJroeWgsbTHxNMUe
	 sP0SzcGlZjlQO04ql7uVAPJ9rtmjuFuK8Qnp5DYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbfGSAjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 20:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbfGSAjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 20:39:21 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C53C2184E;
        Fri, 19 Jul 2019 00:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563496760;
        bh=eCiWYiZG0ijNfOfYOEbIo8fg8pTnk26ENs0Aqaz/cgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f6Dg00TfBDLf1gF7NAlB0tOU/aoninJxRB86vg6K1gzl6biVF6I0ogXIw2V8fvr5j
         a2AJ5A5ucibTrJkLgk3rQVoNIXxw3BMXeZbwdymW18rSUauD6E2iKwW31pO6sMiyr6
         +JjNRC1URT4N53iTjmCJ1ZdOn7iQFbKYqqhivgk4=
Date:   Thu, 18 Jul 2019 20:39:19 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     corbet@lwn.net, solar@openwall.com, will@kernel.org,
        peterz@infradead.org, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation/security-bugs: provide more information
 about linux-distros
Message-ID: <20190719003919.GC4240@sasha-vm>
References: <20190717231103.13949-1-sashal@kernel.org>
 <201907181457.D61AC061C@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <201907181457.D61AC061C@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 03:00:55PM -0700, Kees Cook wrote:
>On Wed, Jul 17, 2019 at 07:11:03PM -0400, Sasha Levin wrote:
>> Provide more information about how to interact with the linux-distros
>> mailing list for disclosing security bugs.
>>
>> Reference the linux-distros list policy and clarify that the reporter
>> must read and understand those policies as they differ from
>> security@kernel.org's policy.
>>
>> Suggested-by: Solar Designer <solar@openwall.com>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Sorry, but NACK, see below...
>
>> ---
>>
>> Changes in v2:
>>  - Focus more on pointing to the linux-distros wiki and policies.
>
>I think this is already happening in the text. What specifically do you
>want described differently?

The main issue was that there isn't anything pointing to the
linux-distros policies. The current text outlines a few of them ("add
[vs]", and "there should be an embargo period"), but it effectively just
gives out the linux-distros mailing address and tells the reporter to
contact it.

>>  - Remove explicit linux-distros email.
>
>I don't like this because we had past trouble with notifications going
>to the distros@ list and leaking Linux-only flaws to the BSDs. As there
>isn't a separate linux-distros wiki, the clarification of WHICH list is
>needed.

Why would removing the explicit linux-distros email encourage people to
send reports to it?

I also don't understand what you mean by "there isn't a separate
linux-distros wiki"? There is one, and I want to point the reporter
there.

>>  - Remove various explanations of linux-distros policies.
>
>I don't think there's value in removing the Tue-Thu comment, nor
>providing context for why distros need time. This has been a regular
>thing we've had to explain to researchers that aren't familiar with
>update procedures and publication timing.

To be fair, the Tue-Thu comment is listed in the section describing how
to do coordination with linux-distros, and linux-distros don't have a
Tue-Thu policy. If it's a security@kernel.org policy then let's list it
elsewhere.

If you feel that there is a consensus around Tue-Thu let's just add it
to the linux-distros policy wiki, there's no point in listing random
policies from that wiki.

--
Thanks,
Sasha
