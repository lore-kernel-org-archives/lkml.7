Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7867C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8BA206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 05:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730872AbfB1Fnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 00:43:55 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:44939 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfB1Fnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 00:43:55 -0500
Received: by mail-ot1-f48.google.com with SMTP id g1so16591349otj.11;
        Wed, 27 Feb 2019 21:43:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tvyYzX9zjXUqiu00qxbB23+rkUhRrv8soLIy1AyDzDo=;
        b=c+LiZUS9Yc/7MUh46vXJrH0JLIOhEiiQn/NGAht8h3Oo35RWANsBGUSDCi7TulsAD5
         rdxxSDDHY2C76K3FZuJUV2Lfn9hkZpNo4bmC1Obez151NwRg3ywQsHm/jGNrWU4ypG4w
         t9kSxHtAWj/MAe8pspLcZFpe5nLBzYmvE/Hu15gPtvHLbjBVtAZamJBw63+0OsHh32wx
         uZk4c2nw9qD4dE9H1O8T3DzgLBd4gBozwvHYm/suX+DSo3bClRxg4lx9O72KRZUK8ceC
         Cf5fdI5LbTfn1robsa2W34KkVaP/Gz4g8tZ0GSXigopL9kf4Pg9litm1m6hWgY551kvq
         XmeQ==
X-Gm-Message-State: AHQUAubPkBRRjbHJhcXE8hlk24lCQ8Z4z+Tw2hAio/y+cDIyVTi8H+2h
        FcLbwt0YT6fctJc5mxAMRd0T0y77BYNRcuXYMpk=
X-Google-Smtp-Source: AHgI3IaKvyZ/XJ0zTdXLz6IvXxGtcxi2K+rAGMj4W36eD4BmFxx5+2sviF5sdXWRLFnVwZsWxLm2FlckmUdmbYtK2ws=
X-Received: by 2002:a9d:7347:: with SMTP id l7mr4530336otk.321.1551332634701;
 Wed, 27 Feb 2019 21:43:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFcVEC+8P25MKWhizUUEuamikaZYUOjpppV=59=W3POTEfQqXw@mail.gmail.com>
 <20190227104028.707a75e2@shemminger-XPS-13-9360>
In-Reply-To: <20190227104028.707a75e2@shemminger-XPS-13-9360>
From:   Harini Katakam <harinik@xilinx.com>
Date:   Thu, 28 Feb 2019 11:13:44 +0530
Message-ID: <CAFcVEC+TsEh-MFBi4AdMM7V-tZ-710xojN8b4aTvA=VELMqswA@mail.gmail.com>
Subject: Re: Request for suggestion on net device re-naming/re-ordering based
 on DT alias
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        David Miller <davem@davemloft.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 12:10 AM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Wed, 27 Feb 2019 17:24:03 +0530
> Harini Katakam <harinik@xilinx.com> wrote:
>
<snip>
>
> Device naming is a hard problem, and there is no perfect solution.
>
> Device tree should be providing hints to userspace policy for naming, not
> trying to do it in the kernel.
> See: https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/

Thanks Stephen - I'll try this.

Regards,
Harini
