Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A3EC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301BA2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="Dd1rN0sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgAHRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:19:42 -0500
Received: from sonic314-26.consmr.mail.ne1.yahoo.com ([66.163.189.152]:45910
        "EHLO sonic314-26.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729516AbgAHRTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578503980; bh=2eNrGQWjfEokt2BCu2g6eg1jgsmpxJpxKMHtqeMJJP4=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=Dd1rN0sO582uk4L2GUD98jwW/r5wfK8hr931oCSAigCjfRCJauQ/3B3UEgN13nwvUviDLZe74l1YuF4+QzM2oNdRGgg80qApghdu8SVG0A0VkXT+j0n5hHTaWiBJ0SVnMUWmBy5y6/fIdTnVU1mLjJWumsSrArCnBxy3fJcYA8m6fn/ubmqIMTI1AOtjqEm12KSN3wR/admK6hn6Ll95hSMdb4vlktqX2my2fRzZPXvdBpWP0sC3zgzm+tOfUg+5/Dyq2QwPQYy+EF9n3Tmiv+rV8zgRJLbYqYDQ9kusZ/n28DJucsbKDfPYv429loDZZr0ZhtHdtqEYNSb+f+4a/Q==
X-YMail-OSG: ob8EuWwVM1nsIDYAJAkwumRxznWgB_J6vMTC7M2ZzuEB5GthqFJhz8JI8imxxn0
 fs7bStGejWAKtD89d3sEapJxCRHI_wwjivoZNS5SXJCpEgkORvms9VhX8QXkrtDaRvdiioCHzdF0
 5U2cXIAgOmwKA0RM1EwG3x9beL6WaLfgwVwBw1wjocPEaYazj1nUPs0fzR9cFvnzu1lxigW57zU7
 rU0FUmtwFXE570dcUnrK20AoigdDSAbrTY4bVobVmGJgPCn7lS5I2O2te138U0OCb1IVAWnm.MOW
 L6brQ97TNjeGkr8IAHt6vLjprMDAiNi6.jGHBU91.ui8ZzYb.Nqsu.PAQyYUCimmf6VC9n8UVoo5
 meMwmIdhvmrhKngWNGLubeyTXG7Wn4p_VnLkVPLQALZ_wVLy3ah8QKKAMc_9HnpF7xiMbTdv0HOr
 Q2DyCleHSJBgUGlqKFIJQVpUgy1aIcTFnHYyfX1wvwRLScbTH07XqNJ70rThbJuf4oBpFTT0E.84
 kxfVrxDMTOp.svTApMFJdFe.hxQ_.cp1Ue23ZjjrGqkF.wk23XNJBsA0NvyMtrGrw8SxLOTCO1lS
 cXuk2SGdOQ2oYthSm0ax0zt9SmT7vaqbvLMyNVSENzK0.kJ_6SwhUZJ_ynHKbD6vVKCIWHPIAyBT
 RYFGLMtnqIRXGeiugPmVFcNaBGDvGqKm5mKi6EUCOn7zymJMdNw1JBsETgjKiIz5WCg4Jnihl3jp
 swu99QHj7KPe29RmtkIAw8cRp_fQ_woleXuWGVMLB_39B8N3UJq7T9J9XpiOpxhWrr2PliA5upYv
 EsuozVZQ1KW57bGkpLNQST3LjK7q3LHZOosWjn42lR8EqFQi0txKJQC7XhbSCRrT6MAcaV3gpgw_
 .qoiBVP.g6Sx_065aM9Z.17FgaflqaAm0efNO_t_S02U7L.Wa_ng5bbDyBlMTNMLCQY32i4SXPTa
 0eCbtIRL2LIfPWSrDG.qvPBbHRJ3.25AnxLrj4VhIx83BGsNzqvgpAf4KV_SFblDBmsDfOsAuvMU
 v5RFEdK7.WNjmIqIwb5Cv2czpGfUIoBdYjBspHWX9pZi.n6y8fnCYv5lrEoNVXSDsZf.wLexP5tn
 kD8vtypMFRPzTAXt2NEtwmXjYMUEED.siM2hnYRF09SCSp27t414KPPM2.NpIi3kXrsn4zhJagRk
 pR5uaYHSRuQKwuzhvvYzx1EmvdVulp7mREIwyKqsEy4vl.KMgIpft28CrVxcZVfcbQxsRxgRDkan
 j27lX1NjDqP3Vbf7XbUbQvnw1PuKfplz00WeOxI24F6MkGq0W1Ti_Ol3A9nnjhAYpkJ0cIYLGY2V
 uKo9Vvdyho.fhnpl9IYvguXgnYADCpFT8Ad3ghJWnmluzZGbFxIdgTucr0rsbBj7jI0j0fNsTTmq
 Nkg4hR03ST0yQ8iuSAc6BqU7w3_Ge5ziDmmCYqAF98fi6i5rIYjN6h7faFRmt5MTwer6i0Sk1h2W
 _HSPYYcmsO_RWleEYTwAm4YC3xZKbVTW4ouo0CZeTjA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Wed, 8 Jan 2020 17:19:40 +0000
Received: by smtp427.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 31b37889f22c2f7107f5eefec060136d;
          Wed, 08 Jan 2020 17:19:36 +0000 (UTC)
Subject: Re: INFO: rcu detected stall in sys_kill
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+de8d933e7d153aa0c1bb@syzkaller.appspotmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <00000000000036decf0598c8762e@google.com>
 <CACT4Y+YVMUxeLcFMray9n0+cXbVibj5X347LZr8YgvjN5nC8pw@mail.gmail.com>
 <CACT4Y+asdED7tYv462Ui2OhQVKXVUnC+=fumXR3qM1A4d6AvOQ@mail.gmail.com>
 <f7758e0a-a157-56a2-287e-3d4452d72e00@schaufler-ca.com>
 <87a787ekd0.fsf@dja-thinkpad.axtens.net>
 <87h81zax74.fsf@dja-thinkpad.axtens.net>
 <CACT4Y+b+Vx1FeCmhMAYq-g3ObHdMPOsWxouyXXUr7S5OjNiVGQ@mail.gmail.com>
 <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <6d009462-74d9-96e9-ab3f-396842a58011@schaufler-ca.com>
Date:   Wed, 8 Jan 2020 09:19:34 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <0b60c93e-a967-ecac-07e7-67aea1a0208e@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/2020 2:25 AM, Tetsuo Handa wrote:
> On 2020/01/08 15:20, Dmitry Vyukov wrote:
>> I temporarily re-enabled smack instance and it produced another 50
>> stalls all over the kernel, and now keeps spewing a dozen every hour.

Do I have to be using clang to test this? I'm setting up to work on this,=

and don't want to waste time using my current tool chain if the problem
is clang specific.

> Since we can get stall reports rather easily, can we try modifying
> kernel command line (e.g. lsm=3Dsmack) and/or kernel config (e.g. no ka=
san) ?
>
>> I've mailed 3 new samples, you can see them here:
>> https://syzkaller.appspot.com/bug?extid=3Dde8d933e7d153aa0c1bb
>>
>> The config is provided, command line args are here:
>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstr=
eam-smack.cmdline
>> Some non-default sysctls that syzbot sets are here:
>> https://github.com/google/syzkaller/blob/master/dashboard/config/upstr=
eam.sysctl
>> Image can be downloaded from here:
>> https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-d=
oes-not-reproduce
>> syzbot uses GCE VMs with 2 CPUs and 7.5GB memory, but this does not
>> look to be virtualization-related (?) so probably should reproduce in
>> qemu too.
> Is it possible to add instance for linux-next.git that uses these confi=
gs?
> If yes, we could try adding some debug printk() under CONFIG_DEBUG_AID_=
FOR_SYZBOT=3Dy .

