Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CF2C32751
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55BC121BF2
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 14:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbfHGO6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 10:58:02 -0400
Received: from mail-ot1-f69.google.com ([209.85.210.69]:44776 "EHLO
        mail-ot1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388297AbfHGO6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 10:58:01 -0400
Received: by mail-ot1-f69.google.com with SMTP id q16so55275957otn.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2019 07:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WeWUyZi7VCNLtsnaaTiz91GIAA++Rddp6QtWItBqJfk=;
        b=STf/JmifxAbxJHnFDJkPlGCji0tso1oUJW8DOh84IKXEJcaVYSYucC5Li3kT7E/D1N
         aSaD/0RzebWW161PS5Uv8+onXiRu9pmsu8Sa2xtLQnjhLxIwsXJo0PnJzyvOvpSREIoA
         TpYG9RoyEhH5ZBjKq+pqaHeOY9TjdHDxClVssLYF47b14HqMs7bpCOFCaTcvFupnD+au
         Zfi5Cq7VyNKjS/rMTvkL4QQcZIbGavq7mmnZ3CMp2JFZOGGJnOQ6JaznjorNPqkaz72Q
         YRK5KxOWH2U334FVaHaMVBgk+HnOYb6OLeWGXcewgaKkilZZtDvSSkJt+OkvPDSofvSQ
         1EJg==
X-Gm-Message-State: APjAAAUPglNawq74NzIrz0G1q4EFYctblZ5hVHQpQ6fvYzB4gE64mzZM
        f/0mH4Yuf8FW8UI0j81A/df1QCNr8RbDsag0PRQTMSa4h6sM
X-Google-Smtp-Source: APXvYqw99ZvGdJtrUfS8mJEwMciCjDs8w83xYn0jXYpAXZuw/cI0KvMd7vubohbBpqBJpfJV+utLREol6sQoZxVKwDY/RnvUoBr+
MIME-Version: 1.0
X-Received: by 2002:a5d:994b:: with SMTP id v11mr9744404ios.165.1565189881077;
 Wed, 07 Aug 2019 07:58:01 -0700 (PDT)
Date:   Wed, 07 Aug 2019 07:58:01 -0700
In-Reply-To: <1565187539.15973.6.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de260b058f882ae7@google.com>
Subject: Re: WARNING in zd_mac_clear
From:   syzbot <syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, davem@davemloft.net, dsd@gentoo.org,
        kune@deine-taler.de, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        oneukum@suse.com, stern@rowland.harvard.edu,
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
syzbot+74c65761783d66a9c97c@syzkaller.appspotmail.com

Tested on:

commit:         9a33b369 usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=23e37f59d94ddd15
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d8c03c600000

Note: testing is done by a robot and is best-effort only.
