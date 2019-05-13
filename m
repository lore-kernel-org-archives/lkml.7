Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54870C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D8D21019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfEMWhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:37:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40496 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfEMWhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:37:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id r136so10643581oie.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2PIg7PA7NbXYzQ6ceMERMEffFgZCmj4m+9Gzp4ac1s=;
        b=KixOo7ye0D+zF3UgMeTTwZRnsbvZAJAi1IA7H39U8r62aBPe1ec4D3tY/8XzxRrJM0
         xnoVhR5ioZtunbHzmKlSkjFtyTNJwX/NBtussOqHfdOL8ki8BJkaYIcJZKL9W3fQo6Bu
         UGITGVFy6BuBjJFfyzcew3FOgjr2pWTCO0PUg1+IYS26B3tqsC7j4ZSer2Jzul5sv8d2
         nqtZysb8mt1NY2P91do2KM7mLajS4J7zn6DJVnb8JJLorZ4tVbr3cTWvitSzX+AEr4aS
         /CUN2v9GGOz1MKvL8WHRA7aw1q8UxVYGYQ9yhMlxxLDteLoBiG/llqqTXZYZCBaBWWeD
         21sQ==
X-Gm-Message-State: APjAAAWdwQ9N7wW2iggKHtGOUoo7tH+QRsdo6E/REQFhhWj7PnPQdBig
        CwMOvrX+mV4BtUixojJ8R4EdZy6wHe3w4kZw/DTSkg==
X-Google-Smtp-Source: APXvYqz5evQSu+Tg9JhDLJiwRCjCfq8rG1B3Pw6oRQUdSIZIqFNj8pim4lR3yk5sRjpmwRfnHXufEAPsWralDpgUneE=
X-Received: by 2002:aca:f086:: with SMTP id o128mr926818oih.101.1557787037890;
 Mon, 13 May 2019 15:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190513195904.15726-1-agruenba@redhat.com> <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
In-Reply-To: <CAHk-=wg=yz_=6oM1r5C4pWJPac8cD1kHiki73wDciuLLoRNY=w@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Tue, 14 May 2019 00:37:06 +0200
Message-ID: <CAHc6FU43Fv_b9hMiRscs+cPbwLmcCBM-9R32fSsK9gUtMVMGUQ@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Fix error path kobject memory leak
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 May 2019 at 00:27, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Andreas,
>  did you intend for me to take this as a patch from the email, or will
> I get a pull request with this later?

Sorry, I should have been more explicit. Would you mind taking this
patch, please? If it's more convenient or more appropriate, I'll send
a pull request instead.

Thanks,
Andreas
