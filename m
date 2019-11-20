Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB569C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9194122429
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfKTKnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:43:08 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:61043 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbfKTKnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:43:08 -0500
Received: from fsav403.sakura.ne.jp (fsav403.sakura.ne.jp [133.242.250.102])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id xAKAh5Es046030;
        Wed, 20 Nov 2019 19:43:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav403.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp);
 Wed, 20 Nov 2019 19:43:05 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav403.sakura.ne.jp)
Received: from [192.168.1.9] (softbank126040052248.bbtec.net [126.40.52.248])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id xAKAh4Cc046022
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Wed, 20 Nov 2019 19:43:05 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: WARNING in kernfs_get
To:     Greg KH <gregkh@linuxfoundation.org>,
        syzbot <syzbot+3dcb532381f98c86aeb1@syzkaller.appspotmail.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        torvalds@linux-foundation.org
References: <000000000000f921ae05757f567c@google.com>
 <0000000000001da6b60597c2ce91@google.com>
 <20191120082958.GB2862348@kroah.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <72e04f20-ba99-6bca-a4b3-d36703719df0@i-love.sakura.ne.jp>
Date:   Wed, 20 Nov 2019 19:42:57 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191120082958.GB2862348@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/11/20 17:29, Greg KH wrote:
> Again, I think this should be resolved with ac43432cb1f5 ("driver core:
> Fix use-after-free and double free on glue directory")

Last occurrence was v5.3-rc3 and that patch went to v5.3-rc4. Should be fixed.

#syz fix: driver core: Fix use-after-free and double free on glue directory
