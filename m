Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA14C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72052089E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfECIeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:34:05 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37303 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfECIeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:34:01 -0400
Received: by mail-ot1-f67.google.com with SMTP id r20so4612329otg.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 01:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkA4rUZid498zuZlBKXewVkWxOql+ECkNVlns8NAUFM=;
        b=G1Jihvabp6Tr4iwnKCEqgELDpP8rr9H+P5mo5u5He9whl8gKRJI5nFIQ5jVqdFddCF
         SiZhfKmClbmsoy1azxadHDyWHpaVphrSH2dAY64TfsRnXcMMmCUa2gDOQjXwUw92BT9Y
         rMHbJnCPciMpbYP/n+Uxu/jtgHBzhsPmeB/V9KZJyBM7MQOokSrG8XDCYvdm0Tz4AgGK
         BVHjqQRjFmPMSE3nMNC1QRSm08kfnnmGnAexZ/zAg+wrCKCTpmkwLLSbgPEo1z+cbU25
         sz141ESOyOiIWZEosGDNElQxcXFhnGQiPwgutqqZE82Nt0nT/qLWOddQOrqSF2vtnd9o
         jESA==
X-Gm-Message-State: APjAAAXEqn+9CgolMQDqxsj2ds3z8nO1MOmA/+70240YzHxqqhOGBEtc
        hsVzXdEZlVlwenGIZZEzpxsp/R5JXR9QT3G6XfBDbNJE
X-Google-Smtp-Source: APXvYqxqFvOYZDyLSgY47TFcZH0BVRefctqjJ3IDvv/aFeXORlTO/ktwgTtKvHzK0w8/WXJ8EgoK2SVU7/XJofFa++Q=
X-Received: by 2002:a9d:19af:: with SMTP id k44mr5500477otk.300.1556872440898;
 Fri, 03 May 2019 01:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <44wNKc0KZFz9sPd@ozlabs.org> <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
In-Reply-To: <cf6948fb8ab8e395e139a3440f3600a6050c1efa.camel@perches.com>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 3 May 2019 10:33:49 +0200
Message-ID: <CA+7wUswrvpt7CmU0m3Di0W4-NVivZMGNqqoWNnHa-vhgMAVq_w@mail.gmail.com>
Subject: Re: [PATCH] powerpc/powernv/ioda2: Add __printf format/argument verification
To:     Joe Perches <joe@perches.com>
Cc:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 10:21 AM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2019-05-03 at 16:59 +1000, Michael Ellerman wrote:
> > On Thu, 2017-03-30 at 10:19:25 UTC, Joe Perches wrote:
> > > Fix fallout too.
> > >
> > > Signed-off-by: Joe Perches <joe@perches.com>
> >
> > Applied to powerpc next, thanks.
> >
> > https://git.kernel.org/powerpc/c/1e496391a8452101308a23b7395cdd49
>
> 2+ years later.
>
>

Can't wait until someone compute stats about largest delta (author
date / committer date)

;)
