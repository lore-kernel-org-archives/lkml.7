Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE86C17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59DDD21928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 12:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388468AbfKEMvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 07:51:02 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:55239 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388635AbfKEMvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:51:01 -0500
Received: by mail-io1-f69.google.com with SMTP id i15so15445419ion.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 04:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/lWajsW87pe+jU9auqaIDGr38Nf06GOlbpdLBf+DWPk=;
        b=BQH2pS39wjV+hJfASKppZTKcVCAlvJLj/UM0vqjNMzkaMucSOUlFiHsypyomykt8Lj
         8ALzs1BrgNAUiIJWj0bTNnVqnkqE5EJt0RmrPqfFPhX32rBYBWBtVJOXfZ0GOxycxVsq
         WtsdmrrqLZxKqyACxxNWbRnHmc7zzEfYKUm4gmLuNE97D1y+EKN1Np6sJWi84fWlRKty
         Z84swvF6Vqy7SgaA1C6H85iKfwuSiekIezit/LVgFINwL2KYUvwp1Ydwr55mC3xq+VBN
         ngZa2MoEm6TU2ArU7Tn0o55G74kJKI3yGhg/USRbnI2sB8JCYoOQwFNkRE+9vuqF9dC2
         Cf7w==
X-Gm-Message-State: APjAAAVkCCCjhBDcbDERzzf2JOumeWZrj4fujlQQBPagXwiS7JsnuyOb
        NQo4G/TiK89VwCbpjM6eM8Wzq3U69JLdKAhxQt/TbtSDJ0iQ
X-Google-Smtp-Source: APXvYqzaWIg1tdrmzLbrJ+5MbJ3oMtwvvbO3F0xFNyd06idM/Zc7zKv0xAb30Rx4+qrlCabNIqwresbUOQGkA4+PyMw3U30e2QZG
MIME-Version: 1.0
X-Received: by 2002:a5d:9856:: with SMTP id p22mr15367560ios.29.1572958261043;
 Tue, 05 Nov 2019 04:51:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 04:51:01 -0800
In-Reply-To: <1572952316.2921.3.camel@suse.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065678d059698e26c@google.com>
Subject: Re: KMSAN: uninit-value in cdc_ncm_set_dgram_size
From:   syzbot <syzbot+0631d878823ce2411636@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, oneukum@suse.com,
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
syzbot+0631d878823ce2411636@syzkaller.appspotmail.com

Tested on:

commit:         96c6c319 net: kasan: kmsan: support CONFIG_GENERIC_CSUM on..
git tree:       https://github.com/google/kmsan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=9e324dfe9c7b0360
dashboard link: https://syzkaller.appspot.com/bug?extid=0631d878823ce2411636
compiler:       clang version 9.0.0 (/home/glider/llvm/clang  
80fee25776c2fb61e74c1ecb1a523375c2500b69)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16b798dce00000

Note: testing is done by a robot and is best-effort only.
