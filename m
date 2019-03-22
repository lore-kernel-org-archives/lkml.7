Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F150C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 044F4218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 10:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfCVKOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:14:05 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:37127 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727934AbfCVKOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 06:14:04 -0400
Received: by mail-it1-f197.google.com with SMTP id m70so1660402ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 03:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=H3hjNJvs6FXnanWbmrLoXpnfgDa9y8TTCYcVGagibuovrJd/ffHEtxSoX6xYq/qhc0
         o4Jwrn1UQKfWHE70xMr/W3OyhvxXH1QLXsQziYj73Pkyuhj8ESMS34MvpZpdc4E4xjWh
         glSqg8FSdPyabIpPP+rY4p0zVR4cA+ZIAZyvHtVvKD7rh8QFHNYod/0YznsU6CQIvHgd
         76fcOiIqbFYpNyP1F2/zXFPxw1Jx0C4PVSjEm7GjPQ1YIMc6MLz2qdK+1USFwCz9ivJc
         dQwRO15nmVwDoUeOlGXPQi/G5ULLAbzF/ln487Gn/f33FhFNFVdRhD7Rort1isp0tbjD
         QEkg==
X-Gm-Message-State: APjAAAWKA262RROeK5ktx2ubU2JyUSOl013ay0q3H5tJ+h+gkFaGvEFX
        oNfDH0cxD4VcHgmnQxqxFJzFHKG7ZE/4dkHofXkUNLvcunEB
X-Google-Smtp-Source: APXvYqwjdCpYsf4ANUyARkuXAdKDIOBaGclO4crEojN4EicIk0CMqppI2XHFMl3MbCNJb5DgqWdOZhHQlVrd7eR65iGs2Qx4tduq
MIME-Version: 1.0
X-Received: by 2002:a24:298b:: with SMTP id p133mr773074itp.43.1553249644208;
 Fri, 22 Mar 2019 03:14:04 -0700 (PDT)
Date:   Fri, 22 Mar 2019 03:14:04 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004a794b0584ac1d9c@google.com>
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
