Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_DIGITS,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF83C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06AE20B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:11:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfFSHLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:11:01 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:44067 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSHLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:11:01 -0400
Received: by mail-io1-f71.google.com with SMTP id i133so19651187ioa.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 00:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dA0fKhI3N29hx55QN7yMpshQ+ovUMn3cPeA5Fhie0RE=;
        b=SBQEyM8XUj7IDVjQp4BuKaz034DB92LZ+QcaZixT2aLRdA5kJqE0PBFZ/F0dF24KwZ
         r4YrD2QJyWUeL25LTMzSJOggDDgEHVgGY07fT/x4Gr8mDL9QjMtx39bqw1mSf5o4w+Su
         ZcuBc5CU07lAkodTgPU2jHMOsWlQWKl3xyMCW6mI0bJeTA5pzRLsxibIQ+mH0oslyR9A
         q+FNDkYILI3wzgmdI0Ws1UxUyVRJYkb3maZn2etEtkDyfAdJLK3J8H52gel5XaNGru95
         pkJn4ompdkydewdMZJ9rU6plZC/eAcP/KDRsXjLlYd5/UfNTPNkUxw97PeOgu/EfprHY
         o0TA==
X-Gm-Message-State: APjAAAU10/LkYX2GDx8YAWK55nJHzivf5PctSTLJX/AZWPSiL21OhW4n
        K8NEI5xgGpQN8LSUUNHk/aOR/9hrR45HvpdKAoU/uD+7Rdvw
X-Google-Smtp-Source: APXvYqzkZp+PQ3mAuNYicnp5VPclFiKPKMckf04v2MwIJjKZTDInYOMm5BJwnLwOHlRr8iun7rJpj/mL0PeHTluH7712LhbuVY20
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2248:: with SMTP id o8mr17747825ioo.90.1560928260665;
 Wed, 19 Jun 2019 00:11:00 -0700 (PDT)
Date:   Wed, 19 Jun 2019 00:11:00 -0700
In-Reply-To: <CAOQ4uxh9ZWghUNS3i_waNq5huitwwypEwY9xEWddFo1JHYu88g@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000803cc4058ba7eef7@google.com>
Subject: Re: WARNING in fanotify_handle_event
From:   syzbot <syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com>
To:     amir73il@gmail.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mbobrowski@mbobrowski.org,
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
syzbot+c277e8e2f46414645508@syzkaller.appspotmail.com

Tested on:

commit:         a6a3fd5c fanotify: update connector fsid cache on add mark
git tree:       https://github.com/amir73il/linux.git  
fsnotify-fix-fsid-cache
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9f7e1b6a8bb586
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Note: testing is done by a robot and is best-effort only.
