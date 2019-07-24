Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1672C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8194227BF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 04:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfGXEs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 00:48:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45908 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfGXEs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 00:48:28 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1hq9CU-0007m6-Ni
        for linux-kernel@vger.kernel.org; Wed, 24 Jul 2019 04:48:26 +0000
Received: by mail-pg1-f199.google.com with SMTP id w5so27473949pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 21:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yfzK+CD5lC0fbY3LJShFWmbhqPkImhOP3cc2stxkE2c=;
        b=KGguBRisVaLa+qyUYsiug6Eq/5pu93CPrXdm641bcIAApmDIYoQRj47x8wiorwY6am
         Hx70FeUG3MFtqFKUfA3dkW7ENop5q16miWL0MtUHBjTGIUhYd3ikuZ0+fOPM20T7gqmQ
         iTDVjo7YLhZDlPhtZMn+V3YJQ01ap486GPXznVqyATGR8SQeMilCnU7d0f9W7LF8IrxI
         LdmyP7KfSrCCaZjGdthraAYQL7UqXp1hXbs4jW//M5eDy/T0zYpN0RAswX7XKBAMMsve
         3FlpAkzBpOvHunKZqWkpTH+L9mshliyb1GDaGyI0tiwJHFBytdrnWqZ8sLL4z2B189jN
         iBhA==
X-Gm-Message-State: APjAAAXEyXR0SRg7b3UBE06DMyY+RHDQo7zJMnXQVFtcIVLXrQUnGg/l
        BH57O48gfcSFzgY+zGSYMdfDmInswZXpu3AXogylFo1At2rmumiBxwj7/zFQ7cxI7wRyWJ4SUXo
        m61uPwhQH22VOafmcWWiTr5AzwY7oQtF15euoapnj5g==
X-Received: by 2002:a17:90a:ff17:: with SMTP id ce23mr85387746pjb.47.1563943705186;
        Tue, 23 Jul 2019 21:48:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwpPQg9WiyNO1ZuciWHV6XFxN1rkRMp+EjLZh1z8SW7D3P7l0k07rIIMzDqyBTW9T7TfafXjA==
X-Received: by 2002:a17:90a:ff17:: with SMTP id ce23mr85387728pjb.47.1563943704873;
        Tue, 23 Jul 2019 21:48:24 -0700 (PDT)
Received: from 2001-b011-380f-3c20-9d3c-ccd5-c106-ac9d.dynamic-ip6.hinet.net (2001-b011-380f-3c20-9d3c-ccd5-c106-ac9d.dynamic-ip6.hinet.net. [2001:b011:380f:3c20:9d3c:ccd5:c106:ac9d])
        by smtp.gmail.com with ESMTPSA id k8sm43825030pgm.14.2019.07.23.21.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 21:48:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: linux-next: build warning after merge of the input-current tree
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190724095416.65450cbf@canb.auug.org.au>
Date:   Wed, 24 Jul 2019 12:48:21 +0800
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Transfer-Encoding: 7bit
Message-Id: <5463D761-FAFB-4BBE-8EE1-95EF1A52F927@canonical.com>
References: <20190724095416.65450cbf@canb.auug.org.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

at 07:54, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
>
> After merging the input-current tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
>
> drivers/input/mouse/elantech.c: In function 'elantech_use_host_notify':
> drivers/input/mouse/elantech.c:1843:6: warning: this statement may fall  
> through [-Wimplicit-fallthrough=]
>    if (dmi_get_bios_year() >= 2018)
>       ^
> drivers/input/mouse/elantech.c:1845:2: note: here
>   default:
>   ^~~~~~~
>
> Introduced by commit
>
>   883a2a80f79c ("Input: elantech - enable SMBus on new (2018+) systems")
>
> I get these warnings because I am building with -Wimplicit-fallthrough
> in attempt to catch new additions early.  The gcc warning can be turned
> off by adding a /* fall through */ comment at the point the fall through
> happens (assuming that the fall through is intentional).

Yes the fall through is intentional.

Kai-Heng

>
> -- 
> Cheers,
> Stephen Rothwell


