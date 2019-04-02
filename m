Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FEC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40A9920856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 11:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbfDBLum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 07:50:42 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44201 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729228AbfDBLul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 07:50:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id v71so3933090lfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 04:50:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dXh8A/62S8v8OqyYTNmhaya/4qr1ebOSd16oqqPumZI=;
        b=ly8E9yU/qPZ2/vSKXf7ZNItrd7VH8dy5QK/QP29sD5A0JTuZUzh489c674FWcpEmHB
         2EEhngb5fpN83LAn4Cz68sYI6Mk9BlDnOP5b6OAw08aUis9+PDkP7bd4V3JhNrjWwWE5
         6DBatFUj5FNW5k6PBi8BqARm7xjvF/xSUd+WqLhGNRiWSNZqSGD4Rttr/lYK1MSy3yzs
         PQTfNJXeAg82xog4TN2Phw8nm/9jTdHcciRfnoStxu2xd/drSO3ic8HVYEJqmgzpZ4Ro
         MHAwAfDGDYg8n6Y6RjvNbUKEE8gzQbPnobbs1wQGmYXzwqYj5y+5y8n9YMcKvAUWuTfn
         H7Hg==
X-Gm-Message-State: APjAAAXhWKyn8EsjH1tAUNWJBTvWLCvdBA/yLWzUF+XCrskx32poH1Zm
        N0l2Q+MXXwhyU8H2mQmuKNpCPzsaxoN0fPwC7THz4A==
X-Google-Smtp-Source: APXvYqwWnUq+HK+9R4QQaoVTGrzwmYMWL81V0Wpp4eztSnXWgnEPBCHZPnEm3cX43L3yzd62ngbwn0edV5XkImsaZzk=
X-Received: by 2002:ac2:4563:: with SMTP id k3mr34932135lfm.101.1554205839761;
 Tue, 02 Apr 2019 04:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190401102456.11162-1-mcroce@redhat.com> <20190401110329.GA12232@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1904021045310.1676@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904021045310.1676@nanos.tec.linutronix.de>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 2 Apr 2019 13:50:03 +0200
Message-ID: <CAGnkfhzkS-QDq0uTSF=XEutaZ3ig6NYg5rgcWwQNmH9QM0TMSg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Introduce the aural error reporting framework
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-sound@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000fcd65c05858abee0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000fcd65c05858abee0
Content-Type: text/plain; charset="UTF-8"

On Tue, Apr 2, 2019 at 11:33 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Mon, 1 Apr 2019, Peter Zijlstra wrote:
> > On Mon, Apr 01, 2019 at 12:24:51PM +0200, Matteo Croce wrote:
> > > The buzzer driver is simple, requires just a few register writes to work,
> > > the hardware is extremely cheap and is already present on most machines.
> >
> > What, no morse-code register dumps?
>
> Aside of that, where is the android-app to customize and decode the
> melodies?
>
> I surely want to have the music theme of 'Once Upon a Time in the West' on
> kernel crashes.
>
> Thanks,
>
>         tglx
>

Hi Thomas,

I'm a little rusty with Android programming, so I'll share the script
I use to convert notes to frequences.
With some awk magic it can turn notes into a C array, I hope that you
find it useful.

Bye,
-- 
Matteo Croce
per aspera ad upstream

--000000000000fcd65c05858abee0
Content-Type: application/x-shellscript; name="notes2freq.sh"
Content-Disposition: attachment; filename="notes2freq.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_jtzpskb60>
X-Attachment-Id: f_jtzpskb60

IyEvYmluL2Jhc2gKCndoaWxlIHJlYWQgbm90ZSB0aW1lOyBkbwoKb2N0YXZlPTMKCmNhc2UgJG5v
dGUgaW4KKjB8KjF8KjJ8KjN8KjR8KjV8KjZ8Kjd8Kjh8KjkpCW9jdGF2ZT0ke25vdGU6KC0xKX0K
CQkJCW5vdGU9JHtub3RlOjA6JCgoJHsjbm90ZX0tMSkpfQoJCQkJOzsKZXNhYwoKbm90ZT0ke25v
dGUvXCMvc30KCm9jdGF2ZT0kKChvY3RhdmUtMykpCgpjYXNlICRub3RlIGluCkxhCXxBCQkpIGZy
ZXE9NDQwOzsKTGFzCXxBcwl8QmIJKSBmcmVxPTQ2Njs7ClNpCXxCCQkpIGZyZXE9NDk0OzsKRG8J
fEMJCSkgZnJlcT01MjM7OwpEb3MJfENzCXxEYgkpIGZyZXE9NTU0OzsKUmUJfEQJCSkgZnJlcT01
ODc7OwpSZXMJfERzCXxFYgkpIGZyZXE9NjIyOzsKTWkJfEUJCSkgZnJlcT02NTk7OwpGYQl8RgkJ
KSBmcmVxPTY5ODs7CkZhcwl8RnMJfEdiCSkgZnJlcT03NDA7OwpTb2wJfEcJCSkgZnJlcT03ODQ7
OwpTb2xzCXxHcwl8QWIJKSBmcmVxPTgzMTs7ClAJCQkpIGZyZXE9MDs7CmVzYWMKCmk9JG9jdGF2
ZQppZiBbICRvY3RhdmUgLWd0IDAgXTsgdGhlbgoJd2hpbGUgWyAkaSAtZ3QgMCAgXTsgZG8KCQlm
cmVxPSQoKGZyZXEgKiAyKSkKCQlpPSQoKGktMSkpCglkb25lCmVsc2UKCXdoaWxlIFsgJGkgLWx0
IDAgIF07IGRvCgkJZnJlcT0kKChmcmVxIC8gMikpCgkJaT0kKChpKzEpKQoJZG9uZQpmaQoKZWNo
byAiJCgodGltZSAqIDEwMCkpICRmcmVxIgoKZG9uZQo=
--000000000000fcd65c05858abee0--
