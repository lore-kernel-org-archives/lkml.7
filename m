Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C06AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89BC2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 07:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="QBxjZ6/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfD2HyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 03:54:06 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34007 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfD2HyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 03:54:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id j6so10935809qtq.1;
        Mon, 29 Apr 2019 00:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWgCkKPfgLe0gODXDRVabcCo8RdveLj5EodL4BepQwo=;
        b=QBxjZ6/oxpq6tExNEmdlt5qqmHZSVRrvHDTc+7z7QFME9MlAxao2y0Mf3fgL3QOvUn
         3ojdnuE2FRclx7G+rgsgtX3VxxZKTU8/OUyHqQ7s87OLiGU3feI17TVpZJSZHtNF6M/Y
         OPlvuHIJCVasxqLTvKkkAhRm+bN9gyfTk/0hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWgCkKPfgLe0gODXDRVabcCo8RdveLj5EodL4BepQwo=;
        b=Jf+jmkLp4pqTDnsTfuwx18ayUZtZZpjtC52hyTFCcAHe19et5UEY3ewyuNXRuZO1+E
         kQvqlkcVTERvCm6cmInOpVyHysaqwHhH4IY4JsdFZ4fxJz6Sm1/a/7ZlG9LeoUKSDcrD
         3sL4dReBPjPfwIyhQivcqO4jLhG6orDQ81fEYcf5cPjltrb6kYYASazdK2ghdktCr8o5
         2JHF5DpAO4v0yYvCMHXaD6NWqaz9hJoL8roGLfbtcdfuihRLm7ZibADaV3D1G30W/3RW
         59WwKbkZt+M7OrxwUPDJ4G66ZzomFnR+5qlFY5GUf4Iko1DtL+hsVXPtoX6f76eHNqbn
         5Q/A==
X-Gm-Message-State: APjAAAVZSLkj/ifAXQGMH+FwHDiZRTK4Ov8UJbewt1c8RVljd1ZFJLYS
        ceeuFMx14yb6MT6mzou19OhYbke1ZHUS5EHPZ0E=
X-Google-Smtp-Source: APXvYqzuweVqEIbGAUxpYzmfY5Jlihfnu2PP5Rq/2cEC87hGr9WIb/S7SiEJVR+p6CHs6sv5l0jiC6+WCcgT8ud376E=
X-Received: by 2002:ac8:2565:: with SMTP id 34mr49117430qtn.37.1556524445302;
 Mon, 29 Apr 2019 00:54:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190425194853.140617-1-venture@google.com>
In-Reply-To: <20190425194853.140617-1-venture@google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 29 Apr 2019 07:53:53 +0000
Message-ID: <CACPK8XchRsfJkB_p07g6LOyakaq8XH9yM3ve9annfNTTkGY4rg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: Add aspeed-p2a-ctrl node
To:     Patrick Venture <venture@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 19:48, Patrick Venture <venture@google.com> wrote:
>
> Add a node for the aspeed-p2a-ctrl module.  This node, when enabled will
> disable the PCI-to-AHB bridge and then allow control of this bridge via
> ioctls, and access via mmap.
>
> Signed-off-by: Patrick Venture <venture@google.com>

Applied to the aspeed SoC tree.

Cheers,

Joel
