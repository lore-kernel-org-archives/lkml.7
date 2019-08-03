Return-Path: <SRS0=Iotr=V7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382ABC31E40
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E882073D
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Aug 2019 16:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388676AbfHCQer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Aug 2019 12:34:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38783 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388570AbfHCQer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Aug 2019 12:34:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id h28so55003042lfj.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2019 09:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyxZxTomFfPbWiAetqtPgtMLib3xCsrhPFW0Jq8wnRg=;
        b=ByGliOBNf2MJ9nGx9SrHlT9ciAT2kc8o52wCYqX4cALI7L4j0umm8/nBaHqAOTfZhg
         S3w3nC8P+nO4/5KRes5mBvLCWYU3XoYzBkb97/DOnY6mjr5Uykib4b1V86koWvZiVf1E
         MT90sxnNI96IMmUl0jZTEKbxVJZpjDMHzkPykUFUcyaP1IxxUeNUetuetmDROi53aXY9
         FwUTo6ECvJ12oivAYi7xaMBPxej04hanqszuccMOUopfEDlDQq7UNaA9Mm/h6K1m7Oon
         aqtT0XX5YhJsPzV8USo53dp2885CHSZ+SztuBbiMGAc/c+wur7AG/8t/Rg/XLcQgDZ2i
         siag==
X-Gm-Message-State: APjAAAVoHup+W24dFI0so+Cwub0JXzkpPBdEKLIDsMpPvwpq+sbAgowL
        5/FCpmIiso1tua3ZXM0TT9SlieF4RVkLbPHJh8d4MHfU
X-Google-Smtp-Source: APXvYqy2Yn4aNBXqRTmW3Ppvae/bzICtUWoK0tK6vCVVBLGba1dgdveQnO4z/rXVFxBcOKGNWGfaP8kwPA571wDc03U=
X-Received: by 2002:a19:ed07:: with SMTP id y7mr28943779lfy.56.1564850085457;
 Sat, 03 Aug 2019 09:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190723012303.2221-1-mcroce@redhat.com>
In-Reply-To: <20190723012303.2221-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 3 Aug 2019 18:34:09 +0200
Message-ID: <CAGnkfhwen3p9T3mNL3w6dQcLFFDUtfn4g-j=6yoda2o+TpGR5w@mail.gmail.com>
Subject: Re: [PATCH net-next] netfilter: conntrack: use shared sysctl constants
To:     netdev <netdev@vger.kernel.org>, netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 3:23 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Use shared sysctl variables for zero and one constants, as in commit
> eec4844fae7c ("proc/sysctl: add shared variables for range check")
>
> Fixes: 8f14c99c7eda ("netfilter: conntrack: limit sysctl setting for boolean options")
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
>

followup, can anyone review it?

Thanks,
-- 
Matteo Croce
per aspera ad upstream
