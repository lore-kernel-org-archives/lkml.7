Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83526C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3482075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 20:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbfD2UwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 16:52:02 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:57729 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728669AbfD2UwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:52:01 -0400
Received: by mail-it1-f200.google.com with SMTP id p23so624836itc.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2019 13:52:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cAm7uQCoto51MF3DbmJ8qiz81JKkTC17o7TMeFgJuaY=;
        b=LmCBFZ6ep+a9c4VEY1OTMpCfPbm/Rn8+yhkgbRX48PANqFAWytmjAxEXsmzcNmHd7W
         pRXBeXrp2UtHZNtFuub/U/Quagv+Pc9zVpRQGQHT1ZVgil7IaCdQgnkRYLxe8ewJzR3+
         SQIiahCi1iS6zzMs7rY4JevIkyZQR82IBR7/m/Fmc0TnsdHWezkJtoVtskMzkCrXQ7eJ
         zw9h5N4HQ7oOgVOZOzN7eKs1C0n9gqi8Us+LlT4/8Ttt+mNwpSApsKWXbItr13mYlxm/
         EfWaQZNcewEpSXLK31JZ9r3/GGzLCklJV6zbA/qfQdjiE6z3fKxAPxy2Jrfcmk3MoO5K
         O3qQ==
X-Gm-Message-State: APjAAAVrM2XeZkSyiRLV7/fexja9hSAjivK2sNUCVIqxXRTTVgAOpo4O
        TLe9kYYJQe/9GlNpDVetnOqRIU3CuXRMZpKdmRmC/lh7iAFL
X-Google-Smtp-Source: APXvYqyg99LXgoRoX1mVoG+8rJWflXeP0VnHXkeYnUb/6Pad7ERsbjPwrPKxbVCLbUsaqJ76+2WrDzCRDW1FhvTF17AK/n1I2Fcz
MIME-Version: 1.0
X-Received: by 2002:a6b:b989:: with SMTP id j131mr27265452iof.131.1556571121028;
 Mon, 29 Apr 2019 13:52:01 -0700 (PDT)
Date:   Mon, 29 Apr 2019 13:52:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1904291604510.1632-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bc95620587b1748e@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in hex_string
From:   syzbot <syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        rafael@kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+a9fefd18c7b240f19c54@syzkaller.appspotmail.com

Tested on:

commit:         43151d6c usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git usb-fuzzer
kernel config:  https://syzkaller.appspot.com/x/.config?x=4183eeef650d1234
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c59788a00000

Note: testing is done by a robot and is best-effort only.
