Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6052FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3105A208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 01:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbfEMB5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 21:57:39 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51732 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727077AbfEMB5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 21:57:39 -0400
Received: from mr4.cc.vt.edu (junk.cc.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x4D1vbj5000581
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 21:57:37 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x4D1vWWR022557
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 21:57:37 -0400
Received: by mail-qt1-f197.google.com with SMTP id 49so6051548qtn.23
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 18:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=pHzOp3Ay/SrPf7ewb9DhGRuDv9xClxp3IgZEpdpook8=;
        b=KsPpi91sf7j6DLl51BjfYrupWykUb9I/kBFIo6QZRiWlH2MSC9N87mTGkref5X4YWw
         QhGXQNT00XqrfYexfyoUOz1+tHRpHI/zEJ+7UhtNBZuptJGSHZrcMth/zypEfFYjOH0w
         o9Qttv7ocrtvJH6oexbJACqy6YWVuhXt4SLPIYk3Yx6Pp27olqddofR46dy5YwYS0YYs
         W4hCviOL7w7gJcLo8t/+2XPMbZOxXVCM7TSjr7iF5PjTQtDbSHCCYj+zs/AtRaaZIcwy
         IKCIEh+Gjmaux7KxMG1839qh2LeFDPDX9XBESBVSVxXqmdJsk9eesFv5l3SGxFflJQi8
         ty7A==
X-Gm-Message-State: APjAAAWuHqjqsUbKM+FV1Og26VYEWA+B1dKNqOxJjRJ4DunMxwyH4lYM
        lkR0ZHQsokO7pFKxNmEp94LBpnORDGcJLdo7fQMZwpaBEF8Qe0ydcUs1Ge1Qoq0kfJkdI+VWQOP
        ncBqbBdDTdpGx4j/dZef56NQymnepyGaT4+c=
X-Received: by 2002:a0c:a361:: with SMTP id u88mr19963345qvu.224.1557712652406;
        Sun, 12 May 2019 18:57:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxXztAajwhAuG/5XAe8ok0yao/Z+QrxXkIUNyenb9DtWvR9Wy4Jev/WXloWyEBjqy2YKFK9Mw==
X-Received: by 2002:a0c:a361:: with SMTP id u88mr19963339qvu.224.1557712652190;
        Sun, 12 May 2019 18:57:32 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:4341::bf6])
        by smtp.gmail.com with ESMTPSA id u26sm4923487qtc.84.2019.05.12.18.57.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 May 2019 18:57:30 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, guro@fb.com,
        oleg@redhat.com, kernel-team@fb.com
Subject: Re: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer" (76f969e)
In-Reply-To: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
References: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1557712649_1872P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 12 May 2019 21:57:29 -0400
Message-ID: <1916.1557712649@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1557712649_1872P
Content-Type: text/plain; charset=us-ascii

On Sun, 12 May 2019 21:20:12 -0400, "Alex Xu (Hello71)" said:

> I bisected this to 76f969e, "cgroup: cgroup v2 freezer". I reverted the
> entire patchset (reverting only that one caused a conflict), which
> resolved the issue. I skimmed the patch and came up with this
> workaround, which also resolves the issue. I am not at all clear on the
> technical workings of the patchset, but it seems to me like a process's
> frozen status is supposed to be "suspended" when a frozen process is
> ptraced, and "unsuspended" when ptracing ends. Therefore, it seems
> suspicious to always "enter frozen" whether or not the cgroup is
> actually frozen. It seems like the code should instead check if the
> cgroup is actually frozen, and if so, restore the frozen status.

Your analysis seems to be more or less correct, especially since your
one-line workaround patch makes things start working again.

> -               cgroup_enter_frozen();
> +               //cgroup_enter_frozen();

However, I'm sure this isn't a proper fix - it needs an if statement guarding
it (or a check inside the function).  If the kernel is ever in a state where it
*should* be frozen, and it doesn't freeze, things will misbehave.

One has to wonder how many things would be different if the ptrace()
system call wasn't such a steaming pile of dingo's kidneys....

--==_Exmh_1557712649_1872P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXNjPCAdmEQWDXROgAQLxKA//dKkuY44x6J4v/bHl3puTl2AowsWUWKIJ
+wgMpolNqAUHSoVhRA613pSljTbADI7OL6ozUWtoZ6bzqEdSWptSldelCFeW//wq
6TBOmDMV5moZH7QikyjmIkO2CliDsGyPSxZzWfVMAtlGim6OClKqNxVsAPkOyLCi
qTVtvN1hMhCzISvDQGEEhUFKnRt5dmkDQrn1RDVAZba4rP9+rKK0X4X5O10dXGKJ
rYVXJlPoX/0GfbcnCj8aY1On0N8Lcq9QqQH7CCXrckiWK39SE1iCszPx2vORabws
nNIxZDa67tBuvyVIG0jk9He2t9bBycXMEocOR7viLtmxtxXJ3OmXZ0AS4cA+DvAr
Lbk4oqoTi6g3pI73CGm5C4t9ewSQB77G30N+uL4sHoEGwzBFA6Ry4hHlFqM7d05Z
LMDkMd3ffPDiJDpnzwblBlA2KS0TBHBDn2ZPw/3hiF+rOpxdaHokKiF8xSoKgfQa
RiJVuGpHJ6FDyekFVa9CKePyp24QRKkjFSLnCRmlar+R7Rxq0yNHc6NFv/CpR1pM
4V+AyQy3A/WxX1yhcHXEubZVrtafuRDCbL1lDQFHd/620Rhy5qxY6q+LB2pdtM5O
jPccNn/yM3bKZxpiwTmOgLGf8Iof5gb0vtOIJwcBK5D2kwuK9hXFvMOTElaIVHMh
4RdIO1/df8s=
=vj9r
-----END PGP SIGNATURE-----

--==_Exmh_1557712649_1872P--
