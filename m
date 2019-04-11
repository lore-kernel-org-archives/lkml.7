Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FA5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB4312084D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 17:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo5odYFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfDKRiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 13:38:06 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35474 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfDKRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 13:38:06 -0400
Received: by mail-wm1-f48.google.com with SMTP id y197so7715638wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 10:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Xfd9D96rIFnRm2emdnHGOBFU/e7LkPN7Z8N95Gj9aoA=;
        b=Mo5odYFIlufBfkSf4Bf7nYyhAbpbwB0VcRUmfYPBoLt017S9HS4idp2Kh88Uk0iDIr
         OBgojHzKGe0CNRAyCjlsWHl8O2eYW4ImheNJ1GAONtww2QLqBfABj5pO+VE/wvmJfbhU
         8H7T6WgbJ3A5ovptI2PLs2e/wNtDEh+q5bNLCjAyH7Vm+plXBb0DRqey5rm54baBGTc4
         YXMVfvghUp8TUGOojequDLmhSuYtc5451xVUn7TQ6kI+j767kLGS9FTDc3jeogRSHM9i
         TewXGkAXdZQ5YGQVECCGQRJQ5OFbolpk0RjrMmrlbQ7U8gQhsKiyZlDTic1NoHGF7iUh
         QBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Xfd9D96rIFnRm2emdnHGOBFU/e7LkPN7Z8N95Gj9aoA=;
        b=O4dUtgC3V3nEAwUP5om+xCnuZyB3EZc+Xk1299dwsZ3Y9NvIBE5/emqgpx1HqaMmwl
         gvLNqll0bOC+N9tJi8VNDSMsSLPj7ioz/2/tbs9iCxgoFXvwf693IOVRpmaxohEM5jn2
         tpnm+dPKgxa2WLSdplUC6qUpCZQsZuoXuNbx3Wb5DwhdCb2r9A5fEaBMYZLiIH+xhqoJ
         mn0kr4Y3r+5hBZAPFuiN1rOSIHWRqYN/A7WZ7o3jX23vPJfA3V/bxlE3MqiaLyGL2wMQ
         lYCBbwtDjBAjJwuOmWU9MzBZIRwBtA5dvarfUqt5NHqwFdJGTsvdRAbneLmrRZJfhy4Y
         7R3g==
X-Gm-Message-State: APjAAAW4uB2G84LiJZXupsjJ1gMU/bYLW5Bt75SfWjCwuv9gUq15RmUr
        9xjMjDIzx1L912kEiPju+RuDomsZIC/aJ1U62Lo=
X-Google-Smtp-Source: APXvYqwaZupbQz6vITw2mimQCXXzcRmPwEOP25Axu7PuDR9xx6/hSgt+2S8QT3wJyEThHcfmznBg1CGZm4rOMNX6X00=
X-Received: by 2002:a1c:e0d6:: with SMTP id x205mr7860856wmg.28.1555004284212;
 Thu, 11 Apr 2019 10:38:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Thu, 11 Apr 2019 10:37:51 -0700
Message-ID: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
Subject: Linux Testing Microconference at LPC
To:     Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>, willy@infradead.org,
        gustavo.padovan@collabora.co.uk,
        Dmitry Vyukov <dvyukov@google.com>, knut.omang@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks,

This is a call for participation for the Linux Testing microconference
at LPC this year.

For those who were at LPC last year, as the closing panel mentioned,
testing is probably the next big push needed to improve quality. From
getting more selftests in, to regression testing to ensure we don't
break realtime as more of PREEMPT_RT comes in, to more stable distros,
we need more testing around the kernel.

We have talked about different efforts around testing, such as fuzzing
(using syzkaller and trinity), automating fuzzing with syzbot, 0day
testing, test frameworks such as ktests, smatch to find bugs in the
past. We want to push this discussion further this year and are
interested in hearing from you what you want to talk about, and where
kernel testing needs to go next.

Please let us know what topics you believe should be a part of the
micro conference this year.

Thanks!
Sasha and Dhaval
