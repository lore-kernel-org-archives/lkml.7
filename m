Return-Path: <SRS0=HQPa=VE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8897C48BDE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 21:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE91620673
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jul 2019 21:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sleyPRku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfGGVaw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jul 2019 17:30:52 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:34412 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfGGVav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jul 2019 17:30:51 -0400
Received: by mail-io1-f43.google.com with SMTP id k8so30669052iot.1;
        Sun, 07 Jul 2019 14:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rDuKQA9H70ob7BkrooBEjjPJRzJyeCPcykhriQrD2wo=;
        b=sleyPRkuDmUrn9eNZbAmmT0r9XMh9W4PAP9qILmo9i8WMiNX0ccLsTitGcIkfapp/q
         syZN1d1twAnIZqrO6AmVdtL9JLhxZy8JLmPc8LNVuTxORaU9OVwiBCwiy3mCTxhhJZ2p
         Whqyb4kxGBdQJ2/sqs7Mfru8CLoPIs11t0u+eqnkS9WBnYypMFDdg7NHFXOXj4GnHMsk
         kHr0VAk4TqY9WI7ztYOdGDtf5Y5KRikq4oyFlcP/DuaDcF82qaP/j6oi/JZVbc+tWUcL
         +CYTK0LoxGrbVEgtamh/1ktnelvWRUEn1g8Ukp5xEaHVF2SNpgCaKaYxW1b9T3DWUgca
         Cb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rDuKQA9H70ob7BkrooBEjjPJRzJyeCPcykhriQrD2wo=;
        b=cgO8L4MAJzvcG38Enn50xOn5qI/K866kvrhRpJ89xXWC3Eqve9i0FtyaIy1jGip9A+
         8v6x2mA1Fww1XwzWEC0TC2uMsqOhZAFgZFvNvW647MtOzqhwIjK6BqoDdGwV2RSMlFIg
         zKzg6Hcz/avbfObXu/AzVN5mBBsZJB+NpRk7zhijXNQbWGdPfsO5g9Li0PDz0WvLapTv
         NX1BoaMgJNa2lRXHhsYVZY1FMUT0HEjzbWZCVncXZaRzQlbRJPw48Da3S3tu0GP9qVND
         UkYWGSBkF6PQwbb2diqT2/RxjdL3ZglZEQlC6pibVt6NaSaXexX9aNaqXsuesaNH5N3k
         Z0Jg==
X-Gm-Message-State: APjAAAXxY4T1l041qnmc6l9O4tSZYTCzr0Xr4xGPoec1z12KzltJ4jgE
        QwpIVM27kfCD86fxj3wJ5UTXgyFYVHVwwkTyWA==
X-Google-Smtp-Source: APXvYqwXQg51UFBFOq2J20Kdu9asEa1+9YuGv4Owio2WdAM4/Myn/hsJ0J1Bz9RR/RuFhhkF09vUfbxu7oC1/ejMzGo=
X-Received: by 2002:a02:862b:: with SMTP id e40mr18213515jai.7.1562535050403;
 Sun, 07 Jul 2019 14:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190708072858.566aa564@canb.auug.org.au>
In-Reply-To: <20190708072858.566aa564@canb.auug.org.au>
From:   Trond Myklebust <trondmy@gmail.com>
Date:   Sun, 7 Jul 2019 17:30:39 -0400
Message-ID: <CAABAsM7jKzWPNoe63LU33tVfn7a88ZP9yzp4Bb1BN2TDWMxgjQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the nfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jul 2019 at 17:29, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   fe9ad197bd8a ("xprtrdma: Remove the RPCRDMA_REQ_F_PENDING flag")
>   08d720bcd822 ("xprtrdma: Fix occasional transport deadlock")
>   beb843739ea0 ("xprtrdma: Replace use of xdr_stream_pos in rpcrdma_marshal_req")
>
> are missing a Signed-off-by from their committer.
>

Anna?
