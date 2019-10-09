Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B153BC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E83920679
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 19:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731777AbfJITbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 15:31:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44685 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729535AbfJITbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:31:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so3276663qkk.11;
        Wed, 09 Oct 2019 12:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUusHZnfWO6yMQOFQ+VtWA65o/Iz6fBliSGz9QEZwDg=;
        b=Gm5HwDXVyVrEOxieRL46FWN78itw3QMAGcQZjwh2MjVLn+9TRxpzkVuLn08u47LxPW
         qGoa5dNUUkTClS9z41PdxtIJLkAdwSGlJaieomYEwOnRvutnLaB7ZZ0Of24U3Qzx+zty
         6sUHr8/H8ozxSl2UDe/q9OhWX5tQh5lfSQ0C3KyammWVYPHNZiqx3cOuVQ0LdW5gMUjY
         qjJKcLl6CAIbcxPDxTi1CLNO9jbaW/twUb42nipqa2xf10yYD77Q/4xdqsJfcyUDdYSj
         hju89HMEQge/OXdjfkmDXcuVef48U/jf6lxfcmvwoyIHZm33OIDpDh9zAUPj19eGYRRT
         eF5A==
X-Gm-Message-State: APjAAAVQ7YZ3IishH+kOO0n1RhbF0w1QunPNLD4WbMS0pmrSSyhPDqzF
        xuvd4JDGYU6ehFVJ0hjiaB7PPA5f7GTkWgn9QNW0APTB
X-Google-Smtp-Source: APXvYqxDcZcqVm8Nm1eqPFmKZDJyPAWkGBqwBEf2+Yye78l/7+Ho8Fxl+0VisC2hYNFeNCXUJ1GsSgs0/Q3IYnRco7U=
X-Received: by 2002:a05:620a:1592:: with SMTP id d18mr5478352qkk.286.1570649509847;
 Wed, 09 Oct 2019 12:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191009190853.245077-1-arnd@arndb.de> <20191009191044.308087-10-arnd@arndb.de>
 <20191009192524.GK4254@piout.net>
In-Reply-To: <20191009192524.GK4254@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 9 Oct 2019 21:31:32 +0200
Message-ID: <CAK8P3a1zf5kwsRcE1a-GranGz2BEjwdQ_fBcfRLVs-vmC=CjGw@mail.gmail.com>
Subject: Re: [PATCH v6 10/43] compat_ioctl: move rtc handling into rtc-dev.c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 9:25 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> If you ever have to resend, the file is now named rtc/dev.c so you could
> adjust the subject.

Ok, I fixed up my local copy.

      Arnd
