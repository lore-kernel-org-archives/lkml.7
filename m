Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1D3C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BC30214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573131692;
	bh=W/dIFA7RW841+yhHN9HyhT5RYn5co+9jS6B4gz+TUCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=B/jnVidr1Bi4z/RrUYsivfSjf+fCQ9ifc5i8B8yo988nx61whhS5THTzPUsT7OBjv
	 FQzRqi8/n6og2MSlhmd+thfAEGGhz1F9ydeco4YbgiB2aSbMclvQmMRpD5RNSXH5Kh
	 eqDsiBZ94sXN8LLbkPQoOTE0+0jtp69hoApkRQX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfKGNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 08:01:31 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:38454 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388542AbfKGNBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 08:01:31 -0500
Received: by mail-ot1-f48.google.com with SMTP id v24so1922580otp.5;
        Thu, 07 Nov 2019 05:01:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/dIFA7RW841+yhHN9HyhT5RYn5co+9jS6B4gz+TUCg=;
        b=fsMCYQIi9FtWrQj80R7tk3J2uWSd5MiVAYM0XTmVnOyYZ8ETU/OxTOd9EA2AOmsV6P
         OnGnPNxTn4PuT1YQ/XSKHZGC8SVoNj3G5qCi0mDZvGhGbx/M0tQecgKQNhgQQCZTlsix
         Yzd8PQeyaaX5oFpBdPI+GZc2+FFC6AYtn0FBAGyDuZ7xFa8Xxna7wkSWv4dE0iI8lF8y
         71sGPkNdFjI8F1bsz6s86UkdP0Wc/Pb10GbYX1j26vTMp2Mi/vk3l1m/mSgBFA/lrKx7
         jpwTTNO+l8m6nJSLO8XmSWZNKicStmhO24K06X0Xdiku3jVLzbEb4txMcZ30AcH3vKRo
         p4JA==
X-Gm-Message-State: APjAAAXTbaAztL3Zdtipletzh1prtCaoFGoUk0ef1rlUJRXIiqabT14F
        E4akgujGSAVxZHxqX7xWNJFYi21J6eEl4dIR7JJ6lQ==
X-Google-Smtp-Source: APXvYqwLRYogYe8gkHkJSvcX1qvU6mjS7u4KYWpPWMy9mqIw5ttxjpVCKPmIbInn6HHLuIWVxAwcCPLXpObR/kSwgk0=
X-Received: by 2002:a9d:7d01:: with SMTP id v1mr2739749otn.167.1573131690285;
 Thu, 07 Nov 2019 05:01:30 -0800 (PST)
MIME-Version: 1.0
References: <49ce5255-a0aa-1c64-90c6-ad80381d333a@linuxfoundation.org>
In-Reply-To: <49ce5255-a0aa-1c64-90c6-ad80381d333a@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Nov 2019 14:01:19 +0100
Message-ID: <CAJZ5v0ibeSe-CjpQ=+ybH8csg2=itm5H0Jkr-Eqk1BOHYfCG1A@mail.gmail.com>
Subject: Re: [GIT PULL] cpupower update for Linux 5.5-rc1
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Renninger <trenn@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 7, 2019 at 2:00 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Hi Rafael,
>
> Please pull the following update for Linux 5.5-rc1.
>
> This cpupower update for Linux 5.5-rc1 consists of bug fixes and
> improvements to make it more accurate by removing the userspace
> to kernel transition and read_msr initiated IPI delays.
>
> diff is attached.

Pulled, thanks!
