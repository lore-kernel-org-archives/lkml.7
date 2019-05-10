Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6486C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8149E20989
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 23:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=att.net header.i=@att.net header.b="xP6YQeYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfEJXAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 19:00:47 -0400
Received: from sonic317-30.consmr.mail.bf2.yahoo.com ([74.6.129.85]:46490 "EHLO
        sonic317-30.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726862AbfEJXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 19:00:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=att.net; s=s1024; t=1557529245; bh=wepY/gS3yMca5RtTmrlwhUMxYb8B5nzbu5WWMJJMoJE=; h=Subject:From:In-Reply-To:Date:Cc:References:To:From:Subject; b=xP6YQeYEojWEfXLZ59KCrpXsglTSnBa/W9ULxCcE9Ex9VxTyt+AGINwB4t/Z0XBWIMMI4xOgYkpBz2nB9fh9xdwjXg/+5w1yvqO4FChXcnHl1WpdtoZkmJWDI5jjvd0g1Gi2+dcn+eP8Yr8SRTqAC8Ds4vLaCuLKU29uIvsIr1A=
X-YMail-OSG: K4CoSg0VM1keuYaffQGn0nX6HU07dmphsUmu2d6eivbDn_.BK.PhM61NRqO0Z1N
 1ZclmEC.ol98u5a_7YNRuNAJGRHc_UfQ95JI500UGYhQVyoDLBAYup1MpfMn6eJazziGTuFQQ1vW
 ZmBTfeioBJHF_drcihY2q3I6Yi1vhzQSzPrDRD.MOGpPbxeWiB2RJ_osuwLvuPtgcOttPjJATe7K
 il0VCizeR9juAvSHM_yMD1684xhKi3Q.x8TnRGzG1X42qOYlKrlw.R8XwYlkyY610dTe3g5FZh03
 upkkY76yGxQVZ80El4R.NeDMsnfMujcbQwC10HWbxdXq4q030smkwB155jSFBPEHc96kJQ27YDiL
 FrEJKotDRc6wDVJR3v.jcLIRL9K402jFpxgjvk5fXv32NOUwTXo.6lBkddAhc8XFWWSK2xl9XBsc
 Q83DIv9KQKFq.PDaQsDF.JWUk1exeVp0pTMrpXiUqSAZXTxvs1hbwTZOGHr0Zm0JNoF2WyjN2WTa
 2.yuFCvueefs0dl3VPrg7v2UL6FQnOJGJqqIypq0sPHU.Fq52YrMJeKHixWAc0Geth4_183g_v0z
 Rtiouz4Qi6y_idNCfbrNY8E_IOASDXaKJABXH3ZuDEHmM5RMDikCMDHpoWosnGHQaHBTeG.scSbY
 SLo90EhX6XQuR7.Uu8qNbhwuN.0vBy7w7zfHbcoEfnIfdqWr.FQ9vL1QvGnnz.jqbqL1mJ5LHLpz
 HEHGQMkfZobhxLDR1gM0QfucTQQw6.CCYn8KEw6i9KSDWUrp9b6qaCXwq7kXNtfFNXHgnCeb01nl
 BtOsG.VPfz09Zx_gP5u.gMn7cnNHTlKCrwC_6PFixhPGDcvHpZOLWivADmSDKTUUzi30v5VhK2_R
 QyRlFCVhmwH6x7yGX7IbTC7jLNNX47RVCHD2zptnCWWHHiNeiTcuiueupB0uXhLeqT3fsxuzmLQC
 wRrOTuGiBmWQhSI8CsufH.sqpzjNydWxduDRBs7rbOxLckKo5Qfz0MPub31DG1V632CsP9E2esN0
 t.v16RMJ7gQoANogFAfx7GDR3VbFHgoEXhQ58RfBeGWo5eiHKjWCqMn__wtvHAQKqb.9sTwMgY5n
 Ga7OtVAADRBLLRI6PZ_C0oUml92eE9N8s.mMJ.g9Y1X14Sqv2EGGLgm6dOSiVr9KjYp44AJ5gRA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Fri, 10 May 2019 23:00:45 +0000
Received: from 76-203-170-160.lightspeed.miamfl.sbcglobal.net (EHLO [192.168.1.66]) ([76.203.170.160])
          by smtp430.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 01de54cdcaf527339859d75695bc30e2;
          Fri, 10 May 2019 23:00:43 +0000 (UTC)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Danish FreeBSD Developer hates jews collectively
From:   Farias Martinez <aaronfarias@att.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <20190511011723.2e25dade@rimwks>
Date:   Fri, 10 May 2019 19:00:32 -0400
Cc:     Steffen Nurpmeso <steffen@sdaoden.eu>, ossobserver@redchan.it,
        linux-kernel@vger.kernel.org, misc@openbsd.org,
        freebsd-current@freebsd.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <6FF7513E-CC99-497E-850A-4761A5AEEBD9@att.net>
References: <49cfcff55fe21d5d01df916e9f9531f1@redchan.it> <20190510073249.73a17721@rimwks> <20190510182231.k24xb%steffen@sdaoden.eu> <20190511011723.2e25dade@rimwks>
To:     Rozhuk Ivan <rozhuk.im@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why don=E2=80=99t you guys just closed the cased. For gods sake. Now they ar=
e investigating the incident.

Sent from my iPhone

> On May 10, 2019, at 6:17 PM, Rozhuk Ivan <rozhuk.im@gmail.com> wrote:
>=20
> On Fri, 10 May 2019 20:22:31 +0200
> Steffen Nurpmeso <steffen@sdaoden.eu> wrote:
>=20
>> |> Background: Apparently a FreeBSD developer, a viking looking
>> fellow, |> has been hiding a secret: just as many of his predecessors
>> in the |> Danish cities during WWII (collaborators); He has a disdain
>> for "the |> jews" collectively.
>> |>  =20
>> |
>> |Who cares!?
>>=20
>> I want to point out one thing.  No, two.  One is that i concur
>> with all left hand side arguments of PHKs blog post that was
>> linked a 100 percent.  But that is my personal opinion.
>=20
> I mean that this is "tech" resource about freebsd.
> Who and what doing outside source tree is irrelivant.
>=20
> ossobserver@redchan.it - idiot.
> CoC - stupid thing.
>=20
>=20
> PS: sorry for offtopic.
> _______________________________________________
> freebsd-current@freebsd.org mailing list
> https://lists.freebsd.org/mailman/listinfo/freebsd-current
> To unsubscribe, send any mail to "freebsd-current-unsubscribe@freebsd.org"=


