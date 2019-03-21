Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C4EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9708121929
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfCUWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:20:03 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54196 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbfCUWUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:20:01 -0400
Received: by mail-io1-f69.google.com with SMTP id w11so103660iom.20
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=AKAQL6SN5/2UzB+RkKMFpwf94T/ySCo80NExPKYq0ew=;
        b=CUFx72Qpw24R6IPpuqFv9C7Udt91DS07rSzhmc1zjXwHSD2i8Ntf4V7SSwwEAkrvB+
         Zb7Tvwcj7+NufbE6MN+Op0bFMNtF5f41+RjQ5TRHA68q9X3E90OkDMlboZw2nmXD7jAj
         iaFP8j4XiS49DCsAqPwoX/C1d9vDYxPkbxf6Zn3gMD8ByvtDhHriqdYb+wRoXfYMrHo7
         r6my29EgrGY2o53Hb/qMMCfPQSob7rSeY5EtLsU+uoK2ej47L5tVlagVQBfin6BCV2Ym
         GYT/xNpdBHMHviG0m8Y0TzxRVU74JnPPI9IQqMONT8WvxInFoa91KChQAeKW1cZPOejT
         JQtQ==
X-Gm-Message-State: APjAAAXkoa8p1I1924MhFgYbGUGOqWnDTS9otm/6aGBLgX6ZYNaka/EK
        8vEviu0tS0RHdXQ+4d65M44x85jIJJ53uPhIYNvbqYXktqoj
X-Google-Smtp-Source: APXvYqx3k7GwJRdjT/SMXiOoTuFNSsB39ih2fS0r4d7DVE2vPLBIBHaowktbplgTLyy9kEbtt5LgmB2QMhHXzebmpathnDsb9sfH
MIME-Version: 1.0
X-Received: by 2002:a6b:8f0a:: with SMTP id r10mr4466549iod.22.1553206800656;
 Thu, 21 Mar 2019 15:20:00 -0700 (PDT)
Date:   Thu, 21 Mar 2019 15:20:00 -0700
In-Reply-To: <20190321185835.GC11352@kmo-pixel>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009db4840584a223b9@google.com>
Subject: Re: general protection fault in ebitmap_destroy (2)
From:   syzbot <syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        dave.hansen@intel.com, eparis@parisplace.org,
        kent.overstreet@gmail.com, linux-kernel@vger.kernel.org,
        marcelo.leitner@gmail.com, nhorman@tuxdriver.com,
        paul@paul-moore.com, peter.enderborg@sony.com, pshelar@ovn.org,
        sds@tycho.nsa.gov, selinux@vger.kernel.org, shli@kernel.org,
        syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, vyasevich@gmail.com, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger  
crash:

Reported-and-tested-by:  
syzbot+a57b2aff60832666fc28@syzkaller.appspotmail.com

Tested on:

commit:         9a03b23d selinux: fix calling ebitmap_destroy() on null ptr
git tree:       http://evilpiepirate.org/git/bcachefs.git syzbot-fix
kernel config:  https://syzkaller.appspot.com/x/.config?x=2f8e9856965eaf03
compiler:       gcc (GCC) 9.0.0 20190115 (experimental)

Note: testing is done by a robot and is best-effort only.
