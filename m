Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F82C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79BFA208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 15:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbfHLPGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 11:06:02 -0400
Received: from mail-ot1-f71.google.com ([209.85.210.71]:50949 "EHLO
        mail-ot1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbfHLPGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 11:06:02 -0400
Received: by mail-ot1-f71.google.com with SMTP id t26so550235otp.17
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 08:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UdT6wUZ/D8ky7HtPCj9VpMdye4p6v52eVLFOfN7WQts=;
        b=D56T+3AeXqkoOHhdj6xNG5dzJQAqhpDocWgt4pJCcbt/cdYiYQulPsEH80I2ppRO8z
         hodmAdylf0Isosz/DW9VUJStiNJvAdheFEzdSp/46B8rq/9ayixcwpIZWOrPJEmqxcB1
         di7/cSYpWfI7C8KLgEy9Roo+QdzxQS2VamRapDJiCWCOFp1wAKe95LY0EBPJvfHGjDV9
         9cPi+4FltQs6jf7g/eZ4j/nlIUG6iNl74JQDr9a6fjkCl0+h/kUIUWCi13yj7H/tnfhj
         x372Duh0weltdGC3RrVaNh21tnPYm+t7YLVpnE7vEQ5WkiGRd7jQF/nzFuO3K/wTCfAr
         MJ6Q==
X-Gm-Message-State: APjAAAXviYsAuukJ128vIUFmJoasnJUUNIdLs3JDOhqdwDF/lJqmCbEL
        yC4LY4y22akDTNwuzRk2L8EK+nBFUApd2WHi5rTBChJXMoL4
X-Google-Smtp-Source: APXvYqwxLBlryY9AUKUQMeg0vCZyhR/BAXzcWCPEWAR/D5r2dVoCbvnxs4b2xafrrXxYy2E7KpBMgX++6+Ns9fTe7IJHLPoTqUBj
MIME-Version: 1.0
X-Received: by 2002:a6b:bcc7:: with SMTP id m190mr24368313iof.107.1565622361221;
 Mon, 12 Aug 2019 08:06:01 -0700 (PDT)
Date:   Mon, 12 Aug 2019 08:06:01 -0700
In-Reply-To: <20190812144720.1980-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b1729e058fecdcee@google.com>
Subject: Re: general protection fault in __pm_runtime_resume
From:   syzbot <syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, hdanton@sina.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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
syzbot+3cbe5cd105d2ad56a1df@syzkaller.appspotmail.com

Tested on:

commit:         7f7867ff usb-fuzzer: main usb gadget fuzzer driver
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=792eb47789f57810
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=177252d2600000

Note: testing is done by a robot and is best-effort only.
