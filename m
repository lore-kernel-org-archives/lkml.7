Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D51C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B74622CE3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 14:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731197AbfIDO7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 10:59:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:34707 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729919AbfIDO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 10:59:02 -0400
Received: by mail-io1-f72.google.com with SMTP id m25so2693670ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 07:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=OHAiKKAdXY9jCvbhzEA9HqiANItDsq2H4xiUo40Eykw=;
        b=fcjBKsH8BLedJc2UopnEijGa6uRLo0OYILxNkrryww8YPi0J65ZHkEE0PENGk8ZsP4
         FKe87H8h3hULFPOlhBC6yJ24uSXrtaNY65eauha86sx6WEjA7T14Z8yY4jf7Layw6nRK
         6b3qKXqtWeXuh8txTqf2ggpy698/40qKHwaPhq0MRRFaFQn9de56H4KGC2Ghl683U7CV
         mBe8RMQ7SuohLuk4xKlQ2qQMh7iGl56qgbJmLyBdK29nb/K8Ln+7At17f/URIGIo3M3e
         q09+bR96BQprdNNK3uo2/OxN8QIAvnNUGfoJ/3e1HWwpQ8y71xFXtrjZP8yC+nArfiAj
         H2qQ==
X-Gm-Message-State: APjAAAXqJ6VUcNzLfC/5eW3YVHPIF3mpisEzQ0pcvaivdLrT757vfDur
        s0+OlibLlTZnUKwZUhJbFWaoSwxhWoBR9azo0eu94DkMdRZD
X-Google-Smtp-Source: APXvYqzGwMPp56tk6BDX0OXjwrYJWZDn39d0IuhDaGmvGQ0JDxlhCVa7F6Ad6gEt28kGtkUHEiAVjKFC6SJJA5SwDkwzDWdFSQOG
MIME-Version: 1.0
X-Received: by 2002:a5d:8353:: with SMTP id q19mr1548312ior.59.1567609141323;
 Wed, 04 Sep 2019 07:59:01 -0700 (PDT)
Date:   Wed, 04 Sep 2019 07:59:01 -0700
In-Reply-To: <Pine.LNX.4.44L0.1909041038340.1722-100000@iolanthe.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000003f6410591bb7223@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in usb_reset_and_verify_device
From:   syzbot <syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, andreyknvl@google.com,
        dianders@chromium.org, gregkh@linuxfoundation.org,
        jflat@chromium.org, kai.heng.feng@canonical.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        malat@debian.org, mathias.nyman@linux.intel.com,
        nsaenzjulienne@suse.de, stern@rowland.harvard.edu,
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
syzbot+35f4d916c623118d576e@syzkaller.appspotmail.com

Tested on:

commit:         eea39f24 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0c62209eedfd54e
dashboard link: https://syzkaller.appspot.com/bug?extid=35f4d916c623118d576e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11d694d6600000

Note: testing is done by a robot and is best-effort only.
