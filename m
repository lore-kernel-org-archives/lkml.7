Return-Path: <SRS0=k4ck=W3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7689C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 23:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A926221874
	for <linux-kernel@archiver.kernel.org>; Sat, 31 Aug 2019 23:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfHaX2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 31 Aug 2019 19:28:02 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45751 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfHaX2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Aug 2019 19:28:02 -0400
Received: by mail-io1-f72.google.com with SMTP id k4so13661175iok.12
        for <linux-kernel@vger.kernel.org>; Sat, 31 Aug 2019 16:28:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DF0M02XSKSG9Ky5Dz+j/9n/5tv2umgn8yDW6MUegt08=;
        b=oxQ0umUCAddWBuKcqbXm5s1x6RsqRRolJh7kEigvxSvC4cF9T6/txppEZWfRhRYD5O
         U7aTDE98XTBVKAR9U9IYMIe/WI7LUz25yL1SK4sj7j9sL28zwMeuD2WpKHXsuohFnAnE
         T9ZYvSaWKz4dH2B1mapO9mVC7OZuuZU7z4HvVzLPbBl8xNgfj6W5yrPHI2wTnTYOtO5Z
         DtJuBBDVHVOX5Q2a34JuK+NnJXP1JQpjZ4A/C8ZkZ/cFuQc60RuQbwbdUih1ZGp6WHny
         S5rqxI8djQAKXNsAqlUiYFs0ULmolIQIBQTk3z3NT23+ZSVTpwf9X3Rgjjc1891CJ2zq
         YKUA==
X-Gm-Message-State: APjAAAU5XLY9U+JWt57ftRNbVqrbmYZGKs0gnKNF1BNThCcbXmKgiq74
        agh3sZnBQrtpUq+riuXWcsKFd/yNcHp7xckmiHC3vAmgRHwZ
X-Google-Smtp-Source: APXvYqxE+/QPd0YyE0CRJ7ZUYgbX8l8AKlELMS2qzspSJoXFaK8yVey/1Bn7C0LONcGhXNF7+6dkbIAQ/o2msjszjCFAtAcBAouU
MIME-Version: 1.0
X-Received: by 2002:a5e:c914:: with SMTP id z20mr6545534iol.272.1567294081178;
 Sat, 31 Aug 2019 16:28:01 -0700 (PDT)
Date:   Sat, 31 Aug 2019 16:28:01 -0700
In-Reply-To: <21753.1567081045@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f7a0b3059172166c@google.com>
Subject: Re: KASAN: use-after-free Read in rxrpc_put_peer
From:   syzbot <syzbot+b9be979c55f2bea8ed30@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+b9be979c55f2bea8ed30@syzkaller.appspotmail.com

Tested on:

commit:         48b9e92a rxrpc: Fix lack of conn cleanup when local endpoi..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=230542aa16bfc4b0
dashboard link: https://syzkaller.appspot.com/bug?extid=b9be979c55f2bea8ed30
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
