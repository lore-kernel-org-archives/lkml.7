Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A634C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA17321773
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 19:27:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfC1T1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 15:27:02 -0400
Received: from mail-it1-f198.google.com ([209.85.166.198]:42975 "EHLO
        mail-it1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfC1T1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 15:27:02 -0400
Received: by mail-it1-f198.google.com with SMTP id r186so4218515ita.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 12:27:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=TgAyHOOs/s2pDMLgFaZZYAyUAcglYWJVoYcKfw1zi9w=;
        b=Mg18hO1mNTZvYH983hGpCa1KN+zajyveznF1a4fx+pXzGriqiz4IxCOFKF3oyeU1i4
         oQOju8IQgKjKsjysk1yFEmy1kq6ReiE+jsVE4JrT2Nl+OswMD9espq0foEIXkSIZWfI5
         ahmmTDopebI6MYq64q0xTGQL9rpvgn8vB5wA0idBkysuRv0kv90mqKYHwlD6t6AwBxt/
         1NqT8ng4l/1fY9uC707j7FjxrvAK78E9+SPEy3YHlLkNpTPKXNf9D9u04PFTAYt9oK+U
         +zMm8tVfhaUzxIvCaGtSvc2YaU/dUA2q6JjOSi/zMo6sqPysdZ9g36m3hp3CkHxR0dgS
         /Y3Q==
X-Gm-Message-State: APjAAAWtr/gtcWZLd4zoLCvIPHXw4codFs1gzh/fJEv0n1vaj2BZBFAL
        ct3NZeu/RBELaB1ZN5ik2AHrNLCaTWGQVfejyGOp2y0nafKI
X-Google-Smtp-Source: APXvYqwaX+/qIKMZNP4DYU1JU/KDXOkby/e6NDjN60YwKfVcJAHCRMTnfHoR4RMCdwkIt9BGsvuqV1vE0Zb5gYHtHwxmE89Yb652
MIME-Version: 1.0
X-Received: by 2002:a05:660c:f8d:: with SMTP id x13mr484049itl.5.1553801221670;
 Thu, 28 Mar 2019 12:27:01 -0700 (PDT)
Date:   Thu, 28 Mar 2019 12:27:01 -0700
In-Reply-To: <CAHRSSEzdN_PyZNg51PMosxR5w1Q6h8hqb4fg-r7uOWngA-eAZA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de91f105852c8924@google.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
From:   syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>
To:     arve@android.com, christian@brauner.io, devel@driverdev.osuosl.org,
        gregkh@linuxfoundation.org, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, maco@android.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com,
        tkjos@google.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

patch is already applied


Tested on:

commit:         0532a1b0 virt: vbox: Implement passing requestor info to t..
git tree:        
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git  
char-misc-linus
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1577678b200000

