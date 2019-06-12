Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5DCC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC512063F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 07:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408389AbfFLHpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 03:45:02 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:38333 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406575AbfFLHpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 03:45:01 -0400
Received: by mail-io1-f45.google.com with SMTP id k13so12148149iop.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 00:45:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l36l6rgXJjBp7WT8DoKnKddflMVkAl9NPX+tIDTsP7M=;
        b=LCxaiEicvK++Msy9vjxFeK36MnBlMzdM7v8FxciipFp7OnvPOBT4Njwn1C2JyQKbCU
         cD9afUkWmGcNfnAcHTK75iNA68gXG7fh6ybgQZWJMOM5Bj7U2jm/1xoaCwwFEAQUbxc2
         4jJavOFaaNNgrhA/VnbVC60BM4FKdM1neX5O8FwgR4+cAQG//wZ6TUwzCfXbpjbF3cRK
         cJk4mVRS3jESCRBfxxfZEpUWFmcaLUFi2k4Bbn0gM2j9UbN2OaVGGZovhR/WSnPVCJeK
         obapZBDesv09V4UxbQgNF/m6DiExeO3OpTg3a97EPCaobu7kZa0zjkrRHCLqXVvXUX+A
         tDEg==
X-Gm-Message-State: APjAAAWt7JRJLdclE/qs+LZuknqG+OavUc4Ou1uIpMhZn5/6jI1n4Kw7
        jrhz0Q8CogZ4RFLfhtnaHED4sELgfJuk91GTgAGtzSK9
X-Google-Smtp-Source: APXvYqwwaZWfePLYFsCiLtb7oYBD6kiahVJodU8/jNzkVTzP70DSAzO+zjV8pQUTTo5nxDK+A4PLeeWqYL2eCMCE8sI=
X-Received: by 2002:a6b:ed01:: with SMTP id n1mr17892965iog.255.1560325500724;
 Wed, 12 Jun 2019 00:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <876aefd0-808a-bb4b-0897-191f0a8d9e12@eikelenboom.it>
 <CAJfpegvRBm3M8fUJ1Le1dPd0QSJgAWAYJGLCQKa6YLTE+4oucw@mail.gmail.com> <20190611202738.GA22556@deco.navytux.spb.ru>
In-Reply-To: <20190611202738.GA22556@deco.navytux.spb.ru>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 12 Jun 2019 09:44:49 +0200
Message-ID: <CAOssrKfj-MDujX0_t_fgobL_KwpuG2fxFmT=4nURuJA=sUvYYg@mail.gmail.com>
Subject: Re: Linux 5.2-RC regression bisected, mounting glusterfs volumes
 fails after commit: fuse: require /dev/fuse reads to have enough buffer capacity
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Sander Eikelenboom <linux@eikelenboom.it>,
        Miklos Szeredi <miklos@szeredi.hu>, gluster-devel@gluster.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 10:28 PM Kirill Smelkov <kirr@nexedi.com> wrote:

> Miklos, would 4K -> `sizeof(fuse_in_header) + sizeof(fuse_write_in)` for
> header room change be accepted?

Yes, next cycle.   For 4.2 I'll just push the revert.

Thanks,
Miklos
