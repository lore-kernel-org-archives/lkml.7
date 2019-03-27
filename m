Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED494C10F00
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B89932082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 22:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="igZAXwuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbfC0WXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 18:23:11 -0400
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:40556
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727949AbfC0WXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 18:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1553725387; bh=ueiVI00k5m8nsgXBS6wbvjI/In5zeVy+hAOsEd3t680=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=igZAXwuKk93n7Y8HieVo1lNpv/apZYp8Ob8N+3dYi6LnVSEYzJHzaAB7ZBEdoGSW7oKQ6uo7PDX8Cxm+OYNLH/N1zR2mhL6RdG61nTrFfDXiXa/p4CayKI56WVByQGTDRPSbNP70rJH4tHovZXGOkV2vD6d5inaw5rdl90FhCtpP85Iw4S2pT0VF2NWTs5n+qjj2ea3U+vpiqxilnqaysT7aixYixq4EV3524aOYdo9SjuAAgMfuQqozTA4HYEJwjYqko7e/JpFDI3qtbJIMy0I4iq0xdpRWdEQfhtuLLrVdnBmScqbtlmE5pT5P5RM+on3uTcfL4tdrtuBfaZG1tw==
X-YMail-OSG: _Ob_3IMVM1mEBM3nVZsMw6giyYaLx3lIHsYiJDmJnptTy5EUtSUXPZciHF5Wbnx
 SkI4VImMlvKzwv.UiacYVRNnEfEExts_P.7muaa_M1fPvrMlDWuJrI0m8Hwfuz1qBWivEs1MUEmz
 Oc.QJKqmh2RNyliKW8wyCx2DfwAUi_ekcdlIH6WdLEbpGqa1pwu2bnjmwUGWgR8zgMUzcUcKtjhD
 fbcvrBy0oV0LJct04eed9HKUFRyFfIWVn4bEg9mCM4NlBGlsAcC303nkg7C8afBEA8_buHgxSPom
 LR2g79M9bCUx2BN.hEJTFvPHifJ3WCZssl_OZRTUKrZQt7sJ.wLc9pZO2ge4swZUj5PY_Kp92BsS
 WeZGR02Yn0t69PBVvS3rkmouZ5TdJvWGin935ifYc0FgoDfhPqT53GN6QkEUaaEQz9ScCyeJwHy8
 eTCwtEdau1Qja9WxiJJClQw9xO3rfbwUtzzxTV49UC2sPs4LowYq6S58J_HDnOPq8kVA8dbuWHic
 nW.a8Oys9Om8IOhrQ67poE77QqSJpjPyZaS_6xEoElCHYYy05CWnE6FytIvEIze6G0FufGFoPmok
 j0.MoBlPFaTy22V0hyazQsyt36dlasCzYZSH7Qyh98rogHQxUdGqXKyHYg00G16.jp9XhhkeGr.l
 zMCpLA_fvWdh7zoJrnDlByyvku3Ke_aGB1obiTEPWyVVccmLAQ1u.rqnSynMI9bSRVAJ3Pkp4o9W
 9a54U1P9Jr2wCMi_ie4P0o09d7ZwUZ.5T7A6TyamcGTBaiF5hYL4Kb5eOpiZAYeckBCFfVwdQFBM
 DnVZvdEv95STu0Ipl61PxcOC4LQG2lgwG90ub3IbI2OHZtkgWqwKY0_qipf9Y_2cfV9MH7JRKJmd
 VHflAo4E.ZHdY4fAZp4E_XeFIZBEZb297BiuK7uvx2tT7gEx5YspSugPHANu4lhs3yywYjG.aZpW
 wfNSqYXRYuRseSqR1f_FFnWBtmPP71Pxq2ew1DP4f4OVftsKKJ9Thps6lZ1j.aggQbggnH0jZT.S
 DjTyiFCJy.y5oBfAocPvOrSJFT_hDR8L.PYRCYbhhfoTxT1a1gbE.JMPzzf7Ar5YSayBWwa1m_qp
 yWwpr9hb7KA8f7f7.wygjshY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.gq1.yahoo.com with HTTP; Wed, 27 Mar 2019 22:23:07 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([67.169.65.224])
          by smtp403.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b6479920000130207a67c9c69c115433;
          Wed, 27 Mar 2019 22:23:07 +0000 (UTC)
Subject: Re: Linux 5.1-rc2
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
References: <CAHk-=wgg_PRWs3a6u2gnFLQjhxOJcrFkqqWVnLw60eQAwD-DNw@mail.gmail.com>
 <2d4f3bfa-22c7-a18c-3902-fe1b6ac401f7@infradead.org>
 <alpine.LRH.2.21.1903260607500.13529@namei.org>
 <8811b2e4-28e1-2f01-024b-fb7d0196483f@i-love.sakura.ne.jp>
 <CAGXu5jJZ1H1RFMFBxPsoBW+T17ya+50-d7-31Gr9ciRgpCOaDA@mail.gmail.com>
 <98289cd2-095a-f0cd-e405-887ecbba0030@i-love.sakura.ne.jp>
 <CAGXu5jKWECKxksJWPpCkBKG+wB26DhYK=nYBpuuoS+Pv9AsNwQ@mail.gmail.com>
 <e1f6f5a6-9fce-2e95-4593-79f1e836bac5@i-love.sakura.ne.jp>
 <CAGXu5jL0YzgQR_p9otyOX4+00a0i7Tfv9aLqauZFZs4-Kfjakg@mail.gmail.com>
 <ea75aace-a493-b2fa-1fef-d6ae76085c39@i-love.sakura.ne.jp>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <d067619e-8c7f-94ec-a835-fc86d1b449e3@schaufler-ca.com>
Date:   Wed, 27 Mar 2019 15:23:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ea75aace-a493-b2fa-1fef-d6ae76085c39@i-love.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2019 3:05 PM, Tetsuo Handa wrote:
> On 2019/03/28 6:43, Kees Cook wrote:
>>>> I don't see problems for an exclusive LSM user (AA, SELinux, Smack)
>>>> also initializing TOMOYO, though. It should be a no-op. Is there some
>>>> situation where this is not true?
>>> There should be no problem except some TOMOYO messages are printed.
>> Okay, so I should send my latest version of the patch to James? Or do
>> you explicitly want TOMOYO removed from all the CONFIG_LSM default
>> lines except when selected by CONFIG_DEFAULT_SECURITY_TOMOYO? (I worry
>> the latter will lead to less testing of the stacking.)
>>
> My approach is "opt-in" while your approach is "opt-out". And the problem
> here is that people might fail to change CONFIG_LSM from the default value
> to what they need. (And Jakub did not change CONFIG_LSM to reflect
> CONFIG_DEFAULT_SECURITY_APPARMOR from the old config.) Thus, I suggest
> "opt-in" approach; which includes up to only one legacy major LSM and allows
> people to change the default value to include multiple legacy major LSMs.
>
> You can propose your latest version. If SELinux/Smack/AppArmor people
> prefer "opt-out" approach, I'm fine with "opt-out" approach.

In the long haul we want people to use CONFIG_LSM to set their
list of modules. Providing a backward compatible CONFIG_DEFAULT_SECURITY_BLAH
makes some sense, but it's important that we encourage a mindset change.
Maybe with CONFIG_DEFAULT_SECURITY_LIST with a a full list, which uses the
value from CONFIG_LSM, and make it the default?

