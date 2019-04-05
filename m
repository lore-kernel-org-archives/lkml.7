Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDE2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81603217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 10:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfDEKPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:15:04 -0400
Received: from mail-it1-f199.google.com ([209.85.166.199]:57789 "EHLO
        mail-it1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730400AbfDEKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 06:15:03 -0400
Received: by mail-it1-f199.google.com with SMTP id p23so5077547itc.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 03:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ksZiUycHQUU5gaMM+swJiiJAczcg7RX7RdnQSdhRCek=;
        b=s5Y6Bhf7/evO2bR7Am+iCxc7yVf2YGxN1iyajTvyVSV3AyCmSUvTNN6OeRJtglKoh5
         16SfgQ7NJS/2TyZHJxJJ/PNY+i9YXHjwFXnsMWOGBnMTEJVuvHyoz0lID0Nv8gXSG2L2
         wXQ1XnnOAg+HZ3aP5GegfBuNR6XkXEMXDVqqwDdOGFzku9IvGPuuUF16Rt4QxeA0mVy0
         nwbFBDW89KrKrDVr3bCLWMX7MT4pckZln1KlkUAEF+3fEinNPhmT+sdIAG5W0eNKnZ4y
         cQO3ZIN8Um9BmRtqyDBksi2OBXioAL1fwZ1d6q1P3LIZoFRMTdGDq4gduQ1XXULudVFG
         mM2g==
X-Gm-Message-State: APjAAAVAx36MAlhKWdmsYUOEH68e7QTmbB4wqR/uKe/KOCRRxPFBT6w6
        6IeyIZo05cYq4rq6Kpdm42qi3e5wrxOIOE63SWT03qSY41OJ
X-Google-Smtp-Source: APXvYqy5cSOnRHcflHN7+8rU5FXeZlmlZLqxvPzx7P+okYeI52teYBHiEtt04Uff9LnIRuBxPPp47m1fxI5ulLR/02ft+HkUbkS5
MIME-Version: 1.0
X-Received: by 2002:a5e:a904:: with SMTP id c4mr2146043iod.19.1554459303215;
 Fri, 05 Apr 2019 03:15:03 -0700 (PDT)
Date:   Fri, 05 Apr 2019 03:15:03 -0700
In-Reply-To: <00000000000014285d05765bf72a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009606d20585c5c240@google.com>
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
