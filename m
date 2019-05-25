Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4839FC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2764920862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 14:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfEYO4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 10:56:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39482 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfEYO4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 10:56:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id a10so327793ljf.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2019 07:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/X+8YB2j/JqfHhLDF3OiGnGgSAUQclrWd6VzxGsSk7I=;
        b=q4YKfq0TDwPGDYMHayr42u12ZPj8r+7PE+tn0qyqty+hMU+YZAie6MGLipjyRh4Edt
         g59RYAfINSjt+Fvo0HEDjPGruQmngO+xPhQJKjSRFiYdnVn0QgqTkXAUSxrSyzHCiLD5
         2cmq2L/WLvXdGdz5pLjWml0HWTlpTgj2v1TTJip9hxqjJ6dSV8n+/Ef3IOWCOL7Vm460
         8wLYmN4munbJg3zEEhhvMpUeacd5ODrwMpNaVVUCr+qMv+ZSbp4PNmPwPBTs3Yv8C2Bw
         iQFB9sZ9tekn3mgXu7SIqy3FU8usKtylj29Mzc7zgk/sCt8dwp8U2Ni1untIXRSdwtbV
         OBkQ==
X-Gm-Message-State: APjAAAXWeSnS41i3Ay7BA/pp5QZX0HGNeMg8oZ8eW/ceuvLKzhXEFkcP
        ReqCv5jF1/C2yyrAHA0Ahe6KKCKJ7qU+hn+KhLrytQ==
X-Google-Smtp-Source: APXvYqy/C4aHpdudpJGrMgEHpV92vAqgewvnVpa6r5ORKNXVBwmpANtU+dFdH1pIoknedidtAj9htXb5M+c3Lt/tv20=
X-Received: by 2002:a05:651c:1056:: with SMTP id x22mr34854028ljm.45.1558796210112;
 Sat, 25 May 2019 07:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190525073026.GA7114@hari-Inspiron-1545>
In-Reply-To: <20190525073026.GA7114@hari-Inspiron-1545>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 25 May 2019 16:56:14 +0200
Message-ID: <CAGnkfhzauQGgGdvPtkNcdGkjvo1BsORxZ6f3SzGzQYuYCDetUg@mail.gmail.com>
Subject: Re: [PATCH] drm/omapdrm: fix warning PTR_ERR_OR_ZERO can be used
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2019 at 9:30 AM Hariprasad Kelam
<hariprasad.kelam@gmail.com> wrote:
>
> fix below warnings reported by coccicheck
>

Hi,

a similar patch was nacked because it makes backports more difficult:

https://lore.kernel.org/lkml/3dec4093-824e-b13d-d712-2dedd445a7b7@ti.com/

Tomi, what's your thought?

-- 
Matteo Croce
per aspera ad upstream
