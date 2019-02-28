Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A7F2171F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731718AbfB1Maz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:30:55 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57183 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfB1May (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:30:54 -0500
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1SCUZsc092362;
        Thu, 28 Feb 2019 21:30:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp);
 Thu, 28 Feb 2019 21:30:35 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav303.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x1SCUVoL092336
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Thu, 28 Feb 2019 21:30:35 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: kernel panic: MAC Initialization failed.
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+e1b8084e532b6ee7afab@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <0000000000001c63c80582e32294@google.com>
 <8d94063c-e10c-c470-8ce0-1f86c517b1b4@i-love.sakura.ne.jp>
 <CACT4Y+ZqjoXftDAby9s-YUrOv8txBFqKukRcxP6ty3LLKz_+Hw@mail.gmail.com>
 <722a3390-3112-0067-282c-b94a8be53aa0@i-love.sakura.ne.jp>
 <CACT4Y+aXA4fh9Z=vKKVi-vids4O_npkUDqccD1eUS+gNV7WyGA@mail.gmail.com>
 <ebfd7dae-d90a-059c-8ace-643c2228e7d0@i-love.sakura.ne.jp>
Message-ID: <780b399b-3afe-3d3e-b32e-050e849735e3@i-love.sakura.ne.jp>
Date:   Thu, 28 Feb 2019 21:30:30 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <ebfd7dae-d90a-059c-8ace-643c2228e7d0@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/02/28 19:58, Tetsuo Handa wrote:
> But the problem is that since syzbot is automated, there is no chance to
> edit the content of security/tomoyo/policy/ directory when building the
> kernels.

Thinking again, I realized that it would be possible to automatically
generate the content of security/tomoyo/policy/ directory specialized
for fuzzing tests using some kernel config option, for syzbot can enable
some kernel config option. I'll try it.
