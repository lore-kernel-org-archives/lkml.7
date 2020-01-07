Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF4C282DD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5F520656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 19:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgAGT2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 14:28:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:45594 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728534AbgAGT2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 14:28:02 -0500
Received: by mail-il1-f200.google.com with SMTP id w6so355547ill.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 11:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=79KzdtzPC2ftmJR3OkbetmHCYKG8m61PMKxmCIe48cs=;
        b=qo+1Mtdba5OeZmKuq9outrl+OVH1BS5Lt11JC0t1XJHahN/maIv6xbTplDUgDoA37x
         J+Yw2oHBtxMUi8kIvwfv/NWlmP9cXBQQihV+UpW+p9qPxCcIs3+FRI8Hyaq8JF86K1H5
         bPQyEuqX4+0RoWv2bgb0ElrN4UCKNQUHLxW1Yyfgc68DiIbJW/TIutLx0Qyhf1RZT/yI
         8g7Nr8pHTQ47KcSctIWq/RsXBeqgJPLdahb3OG83VoTW50cSL7h3xTddIrqQVPYv4ppS
         AmQ6YFqjwWo1FCsBtahK9ExytzlXHQmXTZhmhBCL7VE6A2bCt2SaTdg86IdmF4HiM0gF
         7cdg==
X-Gm-Message-State: APjAAAUEaITpdY6huZ4XGPilM2vMwWISuxpvsTrCjkVyxQw5h4H0d7dB
        zigJSE+/VNMjBBBrZQoKSuej3by5aBMq/+vnQC5SOmbVSSQ2
X-Google-Smtp-Source: APXvYqyyKvEVeTDh1DwxjBqTTDT9FQjHY67le+tdBbUTugoVyy+y8PIpydM0+CBLAlUYtUUAbLWWX2WDzQ5QTOuv8K/yt2mUKEf0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr613853ils.248.1578425281837;
 Tue, 07 Jan 2020 11:28:01 -0800 (PST)
Date:   Tue, 07 Jan 2020 11:28:01 -0800
In-Reply-To: <Pine.LNX.4.44L0.2001071407350.1567-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a83be059b91c6e4@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (2)
From:   syzbot <syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, ingrassia@epigenesys.com,
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
syzbot+10e5f68920f13587ab12@syzkaller.appspotmail.com

Tested on:

commit:         ecdf2214 usb: gadget: add raw-gadget interface
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=b06a019075333661
dashboard link: https://syzkaller.appspot.com/bug?extid=10e5f68920f13587ab12
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11543656e00000

Note: testing is done by a robot and is best-effort only.
