Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC037C28CC0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE8E24358
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 00:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEaAwh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 20:52:37 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41534 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEaAwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 20:52:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id c2so5329480wrm.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 17:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=I8M9lvtm1d9zCggAPZv8v5211uKjHgAxomcu7+qVxH4=;
        b=sDO3uuoENA4k2kLagWojoy4xYoKNp78JuPVYgWV7H8Ne+nIevOitEK5TZwsXECqBxF
         1d8mn/00AGkCOBDOYWAsgVohjr1+eUgAbomnUe220YFD07og6hPT2i2UUifihNG+Woqj
         ycwrQ9dhn37yKQ1/Yy96JwUw40vCTTYNAeFGiALfIM0gRZKv4xOcmSSow2H4p36xgKj9
         bCjKQvM1JHjYVMiZRzzDG4M6dif6+POvm9oDyPOWgBwELuMR0zYkxGrsNjYVBKPK+kAt
         Q91EDiyBKleENBpDaHZxDwkPT8UderjUqCvq1azyiLCWSC41P8KHFwGjHBUGY/fhmCf3
         HjrA==
X-Gm-Message-State: APjAAAWriH1ha3BPsK/ZHxgOMU9pyQ/EoQd66XSSB4WfvKTAuzicVGTO
        w2FeVjr650zMhMC64F/BEW5qRQ==
X-Google-Smtp-Source: APXvYqwgzZnBOvYClN6m+tUmJT6X/IFmZujM/95ucohLVOSrujuZHxV1tShS+mXJaqldvgg6SXNAUQ==
X-Received: by 2002:adf:e344:: with SMTP id n4mr4332512wrj.192.1559263956073;
        Thu, 30 May 2019 17:52:36 -0700 (PDT)
Received: from mi5s.teknoraver.net (net-93-144-152-91.cust.vodafonedsl.it. [93.144.152.91])
        by smtp.gmail.com with ESMTPSA id z25sm2966242wmi.5.2019.05.30.17.52.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:52:35 -0700 (PDT)
Date:   Fri, 31 May 2019 02:52:32 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <20190531100646.212b065f@canb.auug.org.au>
References: <20190530162132.6081d246@canb.auug.org.au> <28716a14-772d-bc82-5111-34cd38cfda54@infradead.org> <20190531100646.212b065f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: linux-next: Tree for May 30 (firmware_loader)
To:     Stephen Rothwell <sfr@canb.auug.org.au>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Matteo Croce <mcroce@redhat.com>
Message-ID: <1D63F878-8B7D-4BE4-9FB7-F523C7F473BE@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2019 2:06:46 AM GMT+02:00, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
> 
> On Thu, 30 May 2019 09:10:13 -0700 Randy Dunlap
> <rdunlap@infradead.org> wrote:
> >
> > on i386 or x86_64:
> > when CONFIG_PROC_SYSCTL is not set/enabled:
> > 
> > ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x1c):
> undefined reference to `sysctl_vals'
> > ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x20):
> undefined reference to `sysctl_vals'
> > ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x40):
> undefined reference to `sysctl_vals'
> > ld: drivers/base/firmware_loader/fallback_table.o:(.data+0x44):
> undefined reference to `sysctl_vals'
> 
> Caused by commit
> 
>   6a33853c5773 ("proc/sysctl: add shared variables for range check")
> 
> Added some more cc's

Hi,

Probably the whole firmware_config_table declaration should be under #ifdef CONFIG_PROC_SYSCTL?

I'll look into it, thanks.
-- 
Matteo Croce
per aspera ad upstream
