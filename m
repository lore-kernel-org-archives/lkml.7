Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF8EC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EEA20684
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfCHKbp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:31:45 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:56443 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfCHKbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:31:44 -0500
Received: from fsav110.sakura.ne.jp (fsav110.sakura.ne.jp [27.133.134.237])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x28AVghG005911;
        Fri, 8 Mar 2019 19:31:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav110.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp);
 Fri, 08 Mar 2019 19:31:42 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav110.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x28AVcLG005896
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 8 Mar 2019 19:31:42 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: WARNING in __flush_work (2)
To:     syzbot <syzbot+03bd8ee354763fad396d@syzkaller.appspotmail.com>,
        daniel@ffwll.ch, syzkaller-bugs@googlegroups.com
References: <000000000000581fa9058389a78d@google.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        gustavo.padovan@collabora.com, hamohammed.sa@gmail.com,
        linux-kernel@vger.kernel.org, mahesh1.kumar@intel.com,
        rodrigosiqueiramelo@gmail.com, seanpaul@chromium.org
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <a9289d15-fdb3-bb3c-9018-eb7e3ed43777@I-love.SAKURA.ne.jp>
Date:   Fri, 8 Mar 2019 19:31:39 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <000000000000581fa9058389a78d@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b30b61ff6b1dc37f in linux-next.git did not get in time for closing
previous report. I assume that a pull request will be sent shortly from
Daniel Vetter.

#syz fix: drm/vkms: Fix flush_work() without INIT_WORK().

