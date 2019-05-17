Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3073EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E89204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 10:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfEQKRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 06:17:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:52032 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfEQKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 06:17:03 -0400
Received: by mail-io1-f72.google.com with SMTP id i20so4996764ioo.18
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 03:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=Vpqylf+lkhKMHuiY6aldyjtk4SEZKzONXc7jez0jrVgxl0T5aAGiNzjtv3Ql0QwkVc
         F/S4qvoVwQjYI1i3nstK+/hHjyr4YNWHzcKIAbzTeTFTwnTYsEXMqsnz2hCZdht1ZjH2
         zc/84f2oPdm4pSgxku37Y7zOo9EgifkBmUuNeUG3hEUc8dpMzO2nORvTq1GgYDq/trbh
         jRnr749SQ1rwfme3paHJAMNqotzFWyJkoLjDqS2Vss5gRgi7ISaJNEvQy5Lt/vWno6+2
         yR2zB2ywxMZbADaZ0fJMJWGwqwasb/NpsEifEV6KrbhXAarvEWQq5dtX1Eu2hVme+v9Z
         CE/A==
X-Gm-Message-State: APjAAAV9m4y6mwn1GHcuFjXXMojodMg+wnjSAP8xfQALWIPkYZfwbyxN
        Bcw7hJaOQsocs9z7s5tvrKSkDqSOV5pVpayUbU2RW+15eLL/
X-Google-Smtp-Source: APXvYqw1oALLAqN8e3Fodf0np8lqv+KYYXmmSFcJpfGLY48IypppnFKQuLhi4L+WpUvyZ4V0BGWmjPiSc8Glg/RO/7JGhSptNX8G
MIME-Version: 1.0
X-Received: by 2002:a05:6638:148:: with SMTP id y8mr395593jao.8.1558088222942;
 Fri, 17 May 2019 03:17:02 -0700 (PDT)
Date:   Fri, 17 May 2019 03:17:02 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000eaf23058912af14@google.com>
Subject: Re: BUG: unable to handle kernel paging request in do_mount
From:   syzbot <syzbot+73c7fe4f77776505299b@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sabin.rapan@gmail.com, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
vfs: namespace: error pointer dereference in do_remount()
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
