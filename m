Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C322C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8246208C2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEMWDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:03:42 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:53085 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbfEMWDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:03:41 -0400
Received: from fsav102.sakura.ne.jp (fsav102.sakura.ne.jp [27.133.134.229])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4DM3Yok075530;
        Tue, 14 May 2019 07:03:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav102.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp);
 Tue, 14 May 2019 07:03:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav102.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126012062002.bbtec.net [126.12.62.2])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4DM3Yuw075527
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Tue, 14 May 2019 07:03:34 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: bpf-next boot error: WARNING: workqueue cpumask: online intersect
 > possible intersect
To:     syzbot <syzbot+9e532f90f6ca82f39854@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <00000000000054d5650588cb2c27@google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <3307c238-83d2-2561-013b-ce3159eef044@I-love.SAKURA.ne.jp>
Date:   Tue, 14 May 2019 07:03:34 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <00000000000054d5650588cb2c27@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore

  net-next boot error: WARNING: workqueue cpumask: online intersect > possible intersect
  bpf-next boot error: WARNING: workqueue cpumask: online intersect > possible intersect
  bpf boot error: WARNING: workqueue cpumask: online intersect > possible intersect
  net boot error: WARNING: workqueue cpumask: online intersect > possible intersect

reports. These are caused by
https://github.com/google/syzkaller/commit/aa8482aa8acbe261c9413fd4179e8163069b7605 and
we need to wait until CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING gets propagated.

