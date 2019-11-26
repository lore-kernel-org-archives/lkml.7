Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7341CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB2C2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfKZUVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:21:02 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:35054 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfKZUVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:21:02 -0500
Received: by mail-il1-f198.google.com with SMTP id z10so1925725ilm.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 12:21:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Akqz/I3ZQjzJAvOshpOikoMNQL6Gvzwc2tf/r4zF6dU=;
        b=j5RVFwLsS77GctFchzQv1swOagAI8V5HzpYrZbzGswRNZsGrmEBKCK2CZSpXju1KCN
         BBWklC3W3ati3VayI+Dr2XLE1yWM/Ki1MgR0Lo7ME4Y+zfMWKogkSiv5cnkQFQy8HYd5
         0UrY+9Kkd9k5wQLM1pqMGSJpJYo9Cj8HXdSRW1tnmp3KpeThKbnkVa0cSE1qnwHa0K2+
         ttKjgYyrgoF5y7ohzlm9w9E3KbJTemMhKWDQnw/QcAWWujNgmZhg7eMkfxBNRxWDiqZg
         zo0Ic3YTjjPaP8yku1MlwjDaoZi7w/N9F8gBXRxPmjcvSa3vw8faDoRVZrTJrv4rbank
         YXFw==
X-Gm-Message-State: APjAAAUhdlWjPojHuVrWpcm6vI6BR6/65NOxcTFfb7azgivuAryVPeuk
        BIrNlonKtpcJ5KpPaGrzk2ergeeEMnzb7RSQOXfTWoIvRLQK
X-Google-Smtp-Source: APXvYqxxt+AtVd7wJwjD/XwA+BiQAFWZyeEQ9AZkTAMgW35eXYOdSR6F9M34n0LFgQjt6IDNtDcVbmhTyrwMkTBoVKAOblxNDQnz
MIME-Version: 1.0
X-Received: by 2002:a02:ce51:: with SMTP id y17mr464455jar.1.1574799661213;
 Tue, 26 Nov 2019 12:21:01 -0800 (PST)
Date:   Tue, 26 Nov 2019 12:21:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.1911251622420.1565-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006630680598459e6e@google.com>
Subject: Re: INFO: rcu detected stall in hub_event
From:   syzbot <syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, benjamin.tissoires@redhat.com,
        jikos@kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+ec5f884c4a135aa0dbb9@syzkaller.appspotmail.com

Tested on:

commit:         46178223 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=99c88c44660624e7
dashboard link: https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1177cc0ee00000

Note: testing is done by a robot and is best-effort only.
