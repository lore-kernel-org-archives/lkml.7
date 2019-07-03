Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A722C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E035218A6
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 09:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562144960;
	bh=9QMeqw5Cf+AavIXFQMWll5DbRTM0/Irk37zP2C60mxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jbteMhftm4ZnNV0w5PT4UcQGSDT0ifyDmx9Zl/VzVBKBg/tqaaZ/nrsWpGXGTbhHn
	 5T878C3uMFO3h6HUbzV4sFzE11fj5azaW0k3PzFsyGXnfuPJxgZv8JLzDhAUwrc4eV
	 BsOlgoHfIllas3cUvBVTtjFHtRuadgzOXXU4d4Fs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbfGCJJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 05:09:19 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43012 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727121AbfGCJJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 05:09:18 -0400
Received: by mail-oi1-f193.google.com with SMTP id w79so1442360oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 02:09:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9ocQ0y5CtxyEHOYV99/bjcmmQ1fzb/ctPNDmnSi3/0=;
        b=AVj1pn6UP9O9GNaYYdDTyBxmTCJ62T2/w86+67e0a2dD6KeqGkITGknvMi0X+JJFvJ
         mkqwJEMX0g57lbn9b6VAFzTyeC55ei7EBDjAg+lagYcmRT+BpkDXhU2PYunEPd4iHog4
         CMzQk2uL1XtjlEq88ewVnLV8hHAdPIS4CyvpCqt2I+ArZfbyOXA9qxth2NIvws7biaxP
         +1liIPetCAcOmV03MewRmVxO8qXrncom2EB9uQL84/TthC8alI8tJVQiaPvLssusfwpl
         A0RRecYLvF/RZxb07mZ0l1r1sO8TTo5oQjUbvaQwWi96+mOLzrDbyYaOyiM8bzULtRoP
         Mb/Q==
X-Gm-Message-State: APjAAAU3K2TvuVAq6NS9HDKQXdh+ZpeUxvpjqcWUyUj5dd4BSH4CCHmX
        liR+aKtvnDuFklOdTa5GDoc7XJLQQVM4gz7Z14g=
X-Google-Smtp-Source: APXvYqyuBh1YTQk6z2MikBTMYfpl53EmGyvIRqlL614akb0XGpV2n0PuR40tHFZvP0UelhZNve4TXfYLCBdDAhDfODY=
X-Received: by 2002:aca:5a41:: with SMTP id o62mr6055425oib.110.1562144958083;
 Wed, 03 Jul 2019 02:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190703071653.2799-1-gregkh@linuxfoundation.org>
In-Reply-To: <20190703071653.2799-1-gregkh@linuxfoundation.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Jul 2019 11:09:06 +0200
Message-ID: <CAJZ5v0hA_su=eR5tosY-MMz0CggQ5UG8CvYRp2nmWN=c0OT6=g@mail.gmail.com>
Subject: Re: [PATCH 1/2] debugfs: provide pr_fmt() macro
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 3, 2019 at 9:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Use a common "debugfs: " prefix for all pr_* calls in a single place.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  fs/debugfs/inode.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> index acef14ad53db..f04c8475d9a1 100644
> --- a/fs/debugfs/inode.c
> +++ b/fs/debugfs/inode.c
> @@ -9,6 +9,8 @@
>   *  See ./Documentation/core-api/kernel-api.rst for more details.
>   */
>
> +#define pr_fmt(fmt)    "debugfs: " fmt
> +
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/mount.h>
> @@ -285,7 +287,7 @@ static struct dentry *start_creating(const char *name, struct dentry *parent)
>         struct dentry *dentry;
>         int error;
>
> -       pr_debug("debugfs: creating file '%s'\n",name);
> +       pr_debug("creating file '%s'\n", name);
>
>         if (IS_ERR(parent))
>                 return parent;
> --
> 2.22.0
>
