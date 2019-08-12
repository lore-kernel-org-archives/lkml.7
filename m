Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1187DC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF6721744
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 12:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfHLMbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 08:31:01 -0400
Received: from mail-ot1-f72.google.com ([209.85.210.72]:35155 "EHLO
        mail-ot1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfHLMbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 08:31:01 -0400
Received: by mail-ot1-f72.google.com with SMTP id d14so44381625otf.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 05:31:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uTu/C5kEoXRr3czNQDVPHfrZDcI2hFsg6TBFRhIIG1U=;
        b=A/Ta3qcSC34TCqV2fjAhctMPMDK4KsmyaDVz2QpYvyYnRtwkSHa66rtHIecA9dlQRG
         oyuB0+898CsnjCvw1cRDC1eUVN9Ux9IjuNQefM3iwX9FZnx1k24Epf6Oc/tpo4wsxriU
         lQtw+zUabpcVtkC9phPAiX6cKGwvw4T3l+vpKTJLZFnbfeN/V3R7rIM0N3qwDI68UsF7
         BA2mq8W5ZtFNLNSYOg2Lb9wtgNZIsHvwP/yeWnwYyw5/6ZN8SAcCcFR3bjNYQ/hFhugw
         lmZKB0JDbJMtdVHqskR9tss5bUt9qDOT+3WfjK2fKjP4ete8imDJzY735gla6MJw/cV7
         xRsw==
X-Gm-Message-State: APjAAAXWjqDcM3cSFay5K3MC96w61lwmFN5GZotajpNz1hqyOeoM7kMq
        pwAveRZv8VB2Ol0thZGov+7ql+B0QpEOasyhQqHilS81zdSi
X-Google-Smtp-Source: APXvYqw/6HtWEBrsF6QXzaiwhcykXVdkAZLMzV8QABcMryQlBavKHtHvOvwHYYvMX1cWcDA4JpW0SWpCnxo7meykgzHSvTS2TVUx
MIME-Version: 1.0
X-Received: by 2002:a5e:d507:: with SMTP id e7mr21142454iom.284.1565613060687;
 Mon, 12 Aug 2019 05:31:00 -0700 (PDT)
Date:   Mon, 12 Aug 2019 05:31:00 -0700
In-Reply-To: <CAAeHK+wh=oQo4rorPuKR6dKGbwx4pNL8Of8mDUqbpV-G0kt6_w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000569062058feab2e2@google.com>
Subject: Re: possible deadlock in usb_deregister_dev
From:   syzbot <syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        oneukum@suse.de, stern@rowland.harvard.edu,
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
syzbot+a64a382964bf6c71a9c0@syzkaller.appspotmail.com

Tested on:

commit:         e96407b4 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfa2c18fb6a8068e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16a8a38c600000

Note: testing is done by a robot and is best-effort only.
