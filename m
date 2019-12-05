Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0284C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADD424656
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 10:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfLEKHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 05:07:44 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:53190 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfLEKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:07:40 -0500
Received: by mail-il1-f200.google.com with SMTP id d28so2074921ill.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 02:07:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=SxP9GrkPfQQC4tDhCGJt1wlHuE/aRaP5RHSRZ+Ckw+Q=;
        b=gqBOuUfmVXCjZW/A4pcBVX4+2sf3Z+qehJrf63xUuxnsOIfiws+5FGm80o/8YEf4bL
         Gy1pDWZXXXy08D52tgGGIfCmTvn7vZlL5bC7jIflGBIUlRy2hAMwf146oAdy8C6DT3Ye
         DN546F3oLbiVoz5VScYfHtRCwC0ucSZREP3Ih5/KUMF3b5/s5HzDwwx0tby5Ed+JDkvs
         OvkFLWMt0BdTPplsqBC1PTK4duN8bKwsrXXXXENVhPSmHVRxS0gN0PU2U8/zs0Q1Pun5
         ytI5Xuwa7yMbsrusfqSsvnyujeunDjFzwcHaenbMAaO/uqDAPGYXBuAzxoObMtxxdJpV
         ygkw==
X-Gm-Message-State: APjAAAXehLW47hX1irMFM9Dkyc0prDSXXysNvwqnXJS8uTr5mQZ6PIdD
        2MfRH4dbxDPpNY9WNogtHCcTx3upII8zKqt3HqKuwynPDiHF
X-Google-Smtp-Source: APXvYqyI0qiEIM2Xg+vWurMbSY2pp8AxImwYfz7h/RUYZn94hy0xxFNRpq6QdrU6UoN+iXtZFAJMNmZkUHXbis3elivcxLBHsTXK
MIME-Version: 1.0
X-Received: by 2002:a92:d84d:: with SMTP id h13mr7691097ilq.180.1575540459510;
 Thu, 05 Dec 2019 02:07:39 -0800 (PST)
Date:   Thu, 05 Dec 2019 02:07:39 -0800
In-Reply-To: <CACT4Y+Z-9g59XTwpfW+3fv1_jhbsskkvt8E8fx5F44BjofZ0ow@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006b266b0598f2196c@google.com>
Subject: Re: Re: kernel BUG at fs/btrfs/volumes.c:LINE!
From:   syzbot <syzbot+5b658d997a83984507a6@syzkaller.appspotmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     clm@fb.com, dsterba@suse.com, dvyukov@google.com, jth@kernel.org,
        jthumshirn@suse.de, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Dec 5, 2019 at 11:00 AM Johannes Thumshirn <jthumshirn@suse.de>  
> wrote:

>> On Wed, Dec 04, 2019 at 03:59:01PM +0100, Johannes Thumshirn wrote:
>> > #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git
>> > close_fs_devices

>> Ok this doesn't look like it worked, let's retry w/o line wrapping

>> #syz-test git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git  
>> close_fs_devices

> The correct syntax would be (no dash + colon):

> #syz test: git://git.kernel.org/pub/scm/linux/kernel/git/jth/linux.git

This crash does not have a reproducer. I cannot test it.

> close_fs_devices
