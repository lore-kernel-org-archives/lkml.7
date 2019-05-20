Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD59BC04E87
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96F9206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 17:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfETRrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 13:47:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42501 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfETRrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 13:47:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id 188so13267011ljf.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GyTJpL1BHuLaRSZ/rqTHzZ6DUBpP18SUBBGFoSOcny8=;
        b=AAu3mfThMjLdu3+7Kf+0mdQZGfnrxjzwPw141K1FgEkPZAd0fic4/Y84zZVFIn7MQq
         I26cvB+6xlaHqVhcD8BXx+3DXLDFjbzoZPpkK1RUYP4ul7nO2gj3W/mT8VNu7jEKPfdc
         pFI/85MoOzk1cOM8oLOD820CLZvRYOE6M9yfAJ8OzPh4XH05G8JZcDasB3MTSt5pafqz
         s61cHy41T3gLDU3PaQK3kdo9OjXT6PgZzlKQnSxkcb+RxCx5HGgOhYfkaLdzIJwB6Pj+
         kvLNzLvGFHFny6p/Jc57ltGhvnzm9fmd1KGF6GiwpnrY941aU7v1yPUoefbZdQiFQ24M
         hOdw==
X-Gm-Message-State: APjAAAV0ohqCFH6syD9ezfNeoKWT32bWgIawUbSftl5Lue3myyWMIrRS
        RgryE9d9Qyw8PrddEY+G4LFyMy18oCn5sxEcRq+EjA8p
X-Google-Smtp-Source: APXvYqy3i8sepeeUBj1Jv7zSFSVFg/7+UvwGF5/OmKEWwccotlb1NKSO/wXNPyHb3czO1wZpyt4wnf9VlD16bxAiD00=
X-Received: by 2002:a2e:4701:: with SMTP id u1mr32888626lja.38.1558374423668;
 Mon, 20 May 2019 10:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190518004639.20648-1-mcroce@redhat.com>
In-Reply-To: <20190518004639.20648-1-mcroce@redhat.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 20 May 2019 19:46:27 +0200
Message-ID: <CAGnkfhxt=nq-JV+D5Rrquvn8BVOjHswEJmuVVZE78p9HvAg9qQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] samples/bpf: fix test_lru_dist build
To:     xdp-newbies@vger.kernel.org, bpf@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 18, 2019 at 2:46 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> Fix the following error by removing a duplicate struct definition:
>

Hi all,

I forget to send a cover letter for this series, but basically what I
wanted to say is that while patches 1-3 are very straightforward,
patches 4-5 are a bit rough and I accept suggstions to make a cleaner
work.

Regards,
-- 
Matteo Croce
per aspera ad upstream
