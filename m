Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA0FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56526207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 09:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408758AbfFLJ06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 05:26:58 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:32940 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408650AbfFLJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 05:26:58 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so9644921qkc.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 02:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xeo9d2N1hWRckWYqXOphjPdppgRAC+OLZIyxn8W5pHI=;
        b=fZXGr+gbCXbtK/3Hguf4kj4dX0DjuErZGqvPn5ICA7ISi/6JreICr3grxNaHKNqzIi
         4sB7zPkWkj/FLV+XH+8iv0sbuzOt8Cqhac04DKlYsMz4qizEuJ8JyTrOHhS6Hiv1kZy3
         9fs4w0t1WLIWg4015WKozIqKIkMr2ymjSnCUJy3XjtvQENclq+K5bxFYUoNpcsudg3Dw
         gJsg/tKAmrn7jZ1CxqgP5kkFwDXp1HatDi9YYmUGej9qkHMymeIV6FB70qbl2CwLxqnZ
         JkvUWuR4y6Nmw9QPnJrPdrToUW/R6OVGvHH/Ty2oN7smFNRHJHZzqn9tCiiVmHJfQM0J
         EW2w==
X-Gm-Message-State: APjAAAXhx+ZDHWHx6wYVBVPcKMK2h75llNUqJHXs6YCp1eer09gdYUVl
        2mbHfXDVoEKral+4RuxKaFqgOxn3UrsGTNCNp3c=
X-Google-Smtp-Source: APXvYqx9MC+m4cJ+Di7eurv73JJcvCokdM6C1y31ZWxpbikgUv7cq3G8GlizVNkLgZ4BzXR68fXDvMBPT2DoHTfGKrE=
X-Received: by 2002:a37:6ac3:: with SMTP id f186mr47898318qkc.281.1560331617021;
 Wed, 12 Jun 2019 02:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190611184323.GA2329@kroah.com>
In-Reply-To: <20190611184323.GA2329@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 12 Jun 2019 11:26:40 +0200
Message-ID: <CAK8P3a1-gZwNCfGYTAnzr8YcRtWJ6WDLGcbB+eSbqin9ZzjAhg@mail.gmail.com>
Subject: Re: [PATCH] mic: no need to check return value of debugfs_create functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 8:43 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
