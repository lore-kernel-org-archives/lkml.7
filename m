Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86C6C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D7C20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 10:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UoGRlg/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfKYKmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 05:42:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33032 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfKYKmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 05:42:09 -0500
Received: by mail-io1-f65.google.com with SMTP id j13so15693984ioe.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 02:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+B/nVdafVBM5/dMhmn3bx+mejZS7Z1pG2S9hER1tbY=;
        b=UoGRlg/aCwPzEcnNH5oLQwU1wHejhiY4zlbMgpRVenqBQYvr0oU3s1HuYXUnBOpGaZ
         jSkG26bpnd7Z+2y621l1kUW4x2gy1WCbGVL34x+sDpMld724Yz/fQsNL/MwH4bIUORuH
         SV2LudJzIm7OVSUNO+c8CxfBRDsByThe02Ibo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+B/nVdafVBM5/dMhmn3bx+mejZS7Z1pG2S9hER1tbY=;
        b=MbXbUx1yMAMqymRE3CjKICMRt8mtHGJgm2YJdM6GMNeBTUANXN33d82m2eHzjrSUMB
         WkQ5J6xCDHcYQ8OwaxA3tikXZR86FP+eKWstO86C28xEDtMU8zE1WJm5sZZi/+F3zcvo
         wolGPDpvNDSinVoc8bmFx4VTmQxor/3dtnNGBpEok//74Rr5uCpLVuo8qr3u+rBPNTX8
         WGxnVJ+XsCVtwZ5kvpkqRZgFsR3bqAHBUuXORRBuh4yS88u0gFVEIClUYfelo+Ex0Y63
         8CyrekzcZ2cgLVpvvPYaOA50IBuMv2ULPmBA8p+O/WD2zBDPIhQc7KyATnNwyaAHBxEd
         dLOA==
X-Gm-Message-State: APjAAAVhIogyt7fJDodVdZQZpe7VjpK9XTXEKaW/PMHpY685NcrqsJX0
        yqd1SMfh7rGOHt4S449hlMuxEVQ9JoQqsc9rEGka6w==
X-Google-Smtp-Source: APXvYqwCxLkdsT8rBQH9Cd/qrlw5KUr81ZdbOyC/YXzhlOlZ5vfdgNrOJPgX7JYFLYBy6AmC+NrP8lZ13cYy8QnYAh8=
X-Received: by 2002:a5d:91da:: with SMTP id k26mr25050284ior.252.1574678528733;
 Mon, 25 Nov 2019 02:42:08 -0800 (PST)
MIME-Version: 1.0
References: <20191120192655.33709-1-dwlsalmeida@gmail.com>
In-Reply-To: <20191120192655.33709-1-dwlsalmeida@gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 11:41:57 +0100
Message-ID: <CAJfpegsxXJN1Z5fGzcv=+sid6gSzyD=KtA2omF2Xsx8dy00tRw@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: filesystems: convert fuse to RST
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 8:34 PM Daniel W. S. Almeida
<dwlsalmeida@gmail.com> wrote:
>
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
>
>
> Converts fuse.txt to reStructuredText format, improving the presentation
> without changing much of the underlying content.

Hmm, most of this document is *not* an admin-guide at all.  The only
sections that really belong in that category are "What is FUSE?" and
"Control filesystem" and maybe some of the definitions as well.   The
mount options for fuse filesystem are not generally usable for
actually performing a mount, most of those are actually internal
details of the filesystem implementation.

So I suggest leaving this file under Documentation/filesystems/ for
now and later work towards splitting out the admin-guide parts into a
separate document.

Thanks,
Miklos
