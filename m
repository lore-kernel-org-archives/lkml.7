Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4433CC18E7C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F39217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 22:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="XaPfBi/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfEUWZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 18:25:36 -0400
Received: from sonic310-31.consmr.mail.ne1.yahoo.com ([66.163.186.212]:35241
        "EHLO sonic310-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725797AbfEUWZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 18:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558477534; bh=mMUfg/kztpyKEMpyvsC7QSWJXiAhVrZGUJ/ifJj4pRw=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=XaPfBi/iEgQ96ARzZorqmhVR509wy8GGiBiBQesClsylXNCog8HQB+a0nblENeVtXoW27sgeGJbiTaSHMufJNYZ9un1yt86kIsVx0efY3TApxBz4sEa1F2Pzeb4wgzev7DxawUzGPiXuD9QxgWjjoPfGdiEiGC8gLfXT3JhS6cwc7wPs2ys4C7F1WMLEjyrmfSoFkSXuna9DeEWCdSAN0OXEytWALcAL+Gpv7CoCz64VYivT5SrtIwgM7E44uPjnRzMVl2T2oQ3qP+2S5DeqHrWP96tQj9+OpZeyzjRVuTFS7EYp2YG/HFZOGFKjr1QDaeUkNlxV/drK5qAR1TZAjg==
X-YMail-OSG: EjuVhvQVM1neN8fIKh2BNfejS4DYtDvzfkGqMnrpZVzT._nQhCTDzTf9uXL4ScO
 rlwQ_zUPt_.smWrqs3EqcerKZ_WAvWuRveu6e01tz7dlQLf6FsmR0Prn0DZcuKSOQHhV7RWCCA89
 0IBXW91zfD63uCEMXJSfyrCKx7q_aoIp4gFyAYz8WSv4C0svnn.2eIgpKu4VPPO1Xi_WApiiO854
 NRw6P9rdYSLF6zBfnVFQWjPvvcwjAi8iUMHOpgX5.0c.q4VL0vtqZrUFk3jhJXzuT7BbuzXoIL9N
 Cz0T.xKzymgALElponuZK4pRIq3sNrHnPWStVWFNvGaw1l.Ha5EuKUxPD9VtpLdtbTTnX9aouwQ1
 WaMFekspf5mSNTwvmUIjLVHZNjhuOUH8fxihPEUzY65WWvbLXVsySmYhstLvUQ77m.dH28ZWq4Tp
 I8T_mssD5FiF74P7UquXyeRJb87vP3ftevemVXFoc70a8fch567aVWO80u86T8csBNCCi2MHnmsD
 ZFNuX90aFXdwdQCMHTOnOtVSheGQSLABD_abrgDcTa84Mh0a189B5qy38cMBNdUQmn4q4dyJdC1a
 Xy3la5xhROlJuChHbJPuUCYo5S5FVcOFXyWy8gtEHg7YvK2SE6et6W9p1ABKj_5pwgi8v.dGztqs
 jkO6J2woajUT6WbhIYypOHVVJ5p_aq6FyZ_4EUEWc29IfieFPV7TH.j5hTnyN.a0STpIcNA7OgWb
 teUlkDhQ2W941OJJnp35Dqur.gKFetr8XQfdq1qaYG7w7gnMPjKghodiBA3emTL9aOkWTsVjA16e
 cIxwHHwJLbnSlvaP_kUJpsRvCCLToZUsUqAEr52g09kbNvStRV1gY1X3HshUwpy6hHwYcpBfrUdY
 FAeFqv8HGEp0hYpAI3pLQhhvsVTdMxw7YwOBzgg6gkQ0Ughkr.GqRG1drtr9e40GR.PThttDMBhI
 RVcetpsA1M9wyUgmg4VgQzyLox1fQW.2KfXb.lznxdP421kO.UXK1HBeG8yvoN62F2t43n.PI7oD
 M_OzNUkhsibcLorXbtK8hLVC6z5MgaanmhYMNAKPxgwYYY7RMwsv_ARQpnn6ChWBAYKTuknFfelb
 Kow9tMtEk3Mufc55_ZkRP6Q31cZu1QONyLfq2nQ2THpC5kZPs.gaQuyTjy3DT.ztNEEQxgkaUh3J
 0NkiJpHIliL6xlB5MLpWuPhSpsVrckpLoeb_0gmX6TRXSvcwlMox7.uKaEU_x8.0.CdnpVOpIn8l
 VNJnbWzdri1zsHSXATAE5HbskDONZ
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 May 2019 22:25:34 +0000
Received: from c-73-223-4-185.hsd1.ca.comcast.net (EHLO [192.168.0.103]) ([73.223.4.185])
          by smtp405.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 555db4704c750d4da09ee360a204ae6c;
          Tue, 21 May 2019 22:25:31 +0000 (UTC)
Subject: Re: [PATCH] Smack: Restore the smackfsdef mount option
To:     LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dhowells@redhat.com
Cc:     jose.bollo@iot.bzh,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>
References: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <4ff60417-ea57-7c6f-e4e1-cab74fd36ebb@schaufler-ca.com>
Date:   Tue, 21 May 2019 15:25:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1ebab7e7-f7ee-b910-9cc8-5d826eee8e97@schaufler-ca.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/2019 3:48 PM, Casey Schaufler wrote:
> The 5.1 mount system rework changed the smackfsdef mount option
> to smackfsdefault. This fixes the regression by making smackfsdef
> treated the same way as smackfsdefault. The change was made in
> commit c3300aaf95fb4 from Al Viro.
>
> Reported-by: Jose Bollo <jose.bollo@iot.bzh>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>

Al, Dave, is this patch in keeping with the intent
of the mount rework? Is there a different way I should
do it? Do you want to take it as a fix for the mount
work, or should I push it?

Thank you.

> ---
> ??security/smack/smack_lsm.c | 2 ++
> ??1 file changed, 2 insertions(+)
>
> diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
> index b9abcdb36a73..915cf598e164 100644
> --- a/security/smack/smack_lsm.c
> +++ b/security/smack/smack_lsm.c
> @@ -68,6 +68,7 @@ static struct {
> ???????? int len;
> ???????? int opt;
> ??} smk_mount_opts[] = {
> +?????? {"smackfsdef", sizeof("smackfsdef") - 1, Opt_fsdefault},
> ???????? A(fsdefault), A(fsfloor), A(fshat), A(fsroot), A(fstransmute)
> ??};
> ??#undef A
> @@ -682,6 +683,7 @@ static int smack_fs_context_dup(struct fs_context 
> *fc,
> ??}
>
> ??static const struct fs_parameter_spec smack_param_specs[] = {
> +?????? fsparam_string("fsdef",?????????????? Opt_fsdefault),
> ???????? fsparam_string("fsdefault",?????? Opt_fsdefault),
> ???????? fsparam_string("fsfloor",?????? Opt_fsfloor),
> ???????? fsparam_string("fshat",?????????????? Opt_fshat),
>
