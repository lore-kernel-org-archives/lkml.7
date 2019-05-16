Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26236C04E53
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6ED120862
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 01:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfEPB4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 21:56:31 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:46275 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEPB4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 21:56:31 -0400
Received: by mail-pl1-f173.google.com with SMTP id r18so745958pls.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 18:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=Zf5kgUF54eJecH+3vr5kLoRlvS4uu5lIJnWNEEHf8Bg=;
        b=rKkJOObitqX26MsgLcQCcwF/uC055yYQNWY3P0Jy15z4uBi2oQAUNwb+1a0Zr/dHDT
         5ypnkovyuXwrGil05XW7eX0IgCzqL2lEjF0YsS0UDX/MiAmyHr+x3+7117tMvdE6yxcd
         0nr2JNJu2C6BvhK8Hz5X1zE3VWHF2bJjeujjlfMcBZmwOF/66ks1igWURCgtdUVICMjr
         gt729VtVTMrs+WNeB16VhK6DAJECJd8W43Daow2ign+G+zKsyNPw2tiyE5QjIrkwecuG
         FTZCipsp2hTeJFmOJI/rmEK99/OvhmjEGPMBNdB8ljzWw9Rdn2S3Wi0cNaWW+LxyrzoY
         Q+BQ==
X-Gm-Message-State: APjAAAVqfOWsEznaCBLLxKrGhUV5HkCtJQLh1Lv3E5FYBVZ13LaL6MFh
        +4/iB8lwknozb3W7XWwRVABzTQ==
X-Google-Smtp-Source: APXvYqw/2OjWMPbouASQFMJV5TfSTXbso5Z2ho9UWCmnVvHKk1SlB5jXN8UeF0v5jU9grFEiysumwQ==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr23883308plb.130.1557971790092;
        Wed, 15 May 2019 18:56:30 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p7sm1051914pgb.92.2019.05.15.18.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 18:56:29 -0700 (PDT)
Date:   Wed, 15 May 2019 18:56:29 -0700 (PDT)
X-Google-Original-Date: Wed, 15 May 2019 18:56:25 PDT (-0700)
Subject:     Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1
In-Reply-To: <CAHk-=wjBRKqBHe5Au=TpDq3B5p=AFKvpaf_7XSU3Mv0MgfGj+A@mail.gmail.com>
CC:     atish.patra@wdc.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-3c75df62-0cf8-4e9d-b2f5-0a141fd244e4@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 18:49:57 PDT (-0700), Linus Torvalds wrote:
> On Wed, May 15, 2019 at 6:43 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Linus: I'm not sure how to tag this PR as a mistake, so I'm going to just send
>> another one.  If this gets merged then I'll handle the follow-on.
>
> Just emailing in the same thread ends up with me hopefully seeing the
> "oops, cancel pull request" before I actually pull, so you did the
> right thing.
>
> To make sure, you _could_ obviously also just force-remove the tag you
> asked me to pull, so that if I miss an email any pull attempt of mine
> would just fail.

Ah, OK, I hadn't thought of that one.

> .., and if were to have ended up pulling before you sent the cancel
> email and/or removed the tag, it's obviously all too late, and then
> we'd have to fix things up after the fact, but at least this time it
> got caught in time.

Ya, that's fine.  It's just an extra 0-length file that doesn't get built
("file." instead of "file.c"), which explains how it went unnoticed.  That
said, it's a bit of an embarassment and I wanted to submit two more patches
anyway so I was going to send another PR.  The rebased patches are sitting on
my for-next now, I'll send them up tomorrow unless someone points something
out.

Thanks for the quick reply!
