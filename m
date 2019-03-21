Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A1AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00667218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 02:11:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="pwqwqSak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfCUCLY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 22:11:24 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:41874 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCUCLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 22:11:23 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x2L2BJRi012936
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 11:11:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x2L2BJRi012936
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1553134280;
        bh=n1rv2xsdNz8v8zR/rE2FxS0nsVLuLmXHO1sKuMlXfIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pwqwqSakxHaHa5MOl+rKw0I5EGjVbZl+aDJnDrel2VsIgsIPoT5cyhMuT5hGMtPbS
         K/6misveFPTSTAt5cXH5O0kfVQOe6MjERYN6d41HxBpJ89FUehOslmROWc4eV5d163
         5ZfL3pQM2Ds3z8+qYCzMsCCJBNDdMipGZYgBm19g3Jk/41pbx85916mHjh0hAvzl/G
         /ZBhaH4HM1NF+/UogL3KGuBjCH3B/9zUmVcmSYLyRNy7GVUEPZp3YlXp4Na0CTNxxG
         2m4VvC1ZMIyQRij06F3gAJsQhx6RGcZ0523JIIaCd95t6Y1UzO79Rq9dTtxvWvafzt
         G/eqd79admJxA==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id i207so2794238vsd.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 19:11:19 -0700 (PDT)
X-Gm-Message-State: APjAAAXDvgGA9Y6EdRkbxerH9EMs56E+oao/K4XgxboruLwhtwmKOFix
        JTMKL3vqY0zI2GbollzskM8vLb6FAlNCpJcrHvQ=
X-Google-Smtp-Source: APXvYqzPkV0+0QI1nmuWCPcyYJLC1xqdBKrG8V3fM0pVzR6My0i5YEzRA1hAt8S8PxDHrJPmbWuu+15pU6Hfa6NvIcM=
X-Received: by 2002:a67:7a43:: with SMTP id v64mr555047vsc.54.1553134278765;
 Wed, 20 Mar 2019 19:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <1552310346-7629-1-git-send-email-info@metux.net> <1552310346-7629-51-git-send-email-info@metux.net>
In-Reply-To: <1552310346-7629-51-git-send-email-info@metux.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 21 Mar 2019 11:10:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNASwK+rPka-Fo6FcnByxpiOp4eLdDVchowiu7Sx8c=Lggw@mail.gmail.com>
Message-ID: <CAK7LNASwK+rPka-Fo6FcnByxpiOp4eLdDVchowiu7Sx8c=Lggw@mail.gmail.com>
Subject: Re: [PATCH 050/114] net: Kconfig: pedantic formatting
To:     "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 10:26 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
>
> Formatting of Kconfig files doesn't look so pretty, so let the
> Great White Handkerchief come around and clean it up.
>
> Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> ---
>  net/Kconfig                 |  14 +--
>  net/batman-adv/Kconfig      |  10 +-
>  net/bluetooth/Kconfig       |   2 +-
>  net/ife/Kconfig             |   2 +-
>  net/ipv4/Kconfig            | 231 ++++++++++++++++++++++----------------------
>  net/ipv4/netfilter/Kconfig  |   4 +-
>  net/ipv6/netfilter/Kconfig  |  26 ++---
>  net/mpls/Kconfig            |  10 +-
>  net/netfilter/Kconfig       |  10 +-
>  net/netfilter/ipset/Kconfig |   2 +-
>  net/netfilter/ipvs/Kconfig  |  68 ++++++-------
>  net/nfc/hci/Kconfig         |  14 +--
>  net/rds/Kconfig             |   4 +-
>  net/sched/Kconfig           | 130 ++++++++++++-------------
>  net/wireless/Kconfig        |  38 ++++----
>  net/xfrm/Kconfig            |  10 +-
>  16 files changed, 287 insertions(+), 288 deletions(-)
>

>
>  config TCP_CONG_NV
> -       tristate "TCP NV"
> -       default n
> -       ---help---
> -       TCP NV is a follow up to TCP Vegas. It has been modified to deal with
> -       10G networks, measurement noise introduced by LRO, GRO and interrupt
> -       coalescence. In addition, it will decrease its cwnd multiplicatively
> -       instead of linearly.
> +       tristate "TCP NV"
> +       default n
> +       ---help---

You are touching this line,
so i want you to replace it to 'help' to fix checkpatch.pl warning.


WARNING: prefer 'help' over '---help---' for new help texts
#560: FILE: net/ipv4/Kconfig:560:
+config TCP_CONG_NV



> +         TCP NV is a follow up to TCP Vegas. It has been modified to deal with
> +         10G networks, measurement noise introduced by LRO, GRO and interrupt
> +         coalescence. In addition, it will decrease its cwnd multiplicatively
> +         instead of linearly.
>
> -       Note that in general congestion avoidance (cwnd decreased when # packets
> -       queued grows) cannot coexist with congestion control (cwnd decreased only
> -       when there is packet loss) due to fairness issues. One scenario when they
> -       can coexist safely is when the CA flows have RTTs << CC flows RTTs.
> +         Note that in general congestion avoidance (cwnd decreased when # packets
> +         queued grows) cannot coexist with congestion control (cwnd decreased only
> +         when there is packet loss) due to fairness issues. One scenario when they
> +         can coexist safely is when the CA flows have RTTs << CC flows RTTs.
>
> -       For further details see http://www.brakmo.org/networking/tcp-nv/
> +         For further details see http://www.brakmo.org/networking/tcp-nv/
>




-- 
Best Regards
Masahiro Yamada
