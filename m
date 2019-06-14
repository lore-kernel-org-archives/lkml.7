Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D6C31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB122073F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 03:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbfFNDS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 23:18:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42864 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfFNDS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 23:18:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so1285918edq.9;
        Thu, 13 Jun 2019 20:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rY0FBLu0h9/AWoT8gIxRHyZHL+wYrWVVxtiQxFiOFAg=;
        b=eBSjsPrE4/uImZTSsfDVJi7NW7rwgQ5n1kWcxvZrcbzojDu+1oAyioQDMAEW/vyrw2
         S+DG19zfPwZywSFdeTRwArB68pYWwUnsYVz+C6EdkbkI7bfDEkJpLDGedkHNxdEAPX4Q
         qvrfbhBFWShNPpb/zy6B05cED8lC4l8mTLos+GhpQVfqksxSO9sbbKFAZaRlNGXQaRY1
         0O7ZQIqKDRUX77IDDORL2eTgMbrXHxgN+o7YUlEJezfLUCVu7Oqwb4KL5mDo/fRklaXQ
         xX9uyT7mT7QyGwKslINwf0iLKKCw88QvGvx7ciLRMjVIdEU4rEgn4YWZhWxk6lzlpnCs
         YSNw==
X-Gm-Message-State: APjAAAWUfVtj3ZjeMiTQJEpZ5OBYI8DcH3DXrGyLIBB0YD+YGriizwPV
        GekieHnh077Ck+m8Tj5pAEhKXypLhFw=
X-Google-Smtp-Source: APXvYqwBljU69CEhZ4u1sK/roevkFO+Q3ztGcCmnJiPKqVwE0wgM0gbfd5f4cipz9VtshWrr5xhKXA==
X-Received: by 2002:a17:906:5c4a:: with SMTP id c10mr8689565ejr.15.1560482335973;
        Thu, 13 Jun 2019 20:18:55 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id h10sm138276ede.93.2019.06.13.20.18.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 20:18:54 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id c2so862543wrm.8;
        Thu, 13 Jun 2019 20:18:54 -0700 (PDT)
X-Received: by 2002:a5d:4311:: with SMTP id h17mr64136370wrq.9.1560482334085;
 Thu, 13 Jun 2019 20:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190613185241.22800-1-jagan@amarulasolutions.com> <20190613185241.22800-2-jagan@amarulasolutions.com>
In-Reply-To: <20190613185241.22800-2-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 14 Jun 2019 11:18:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v64NVoakoRzg6XeE0jzgACU3G7=_E6MOGfPYGkw3f8E8nQ@mail.gmail.com>
Message-ID: <CAGb2v64NVoakoRzg6XeE0jzgACU3G7=_E6MOGfPYGkw3f8E8nQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/9] dt-bindings: display: Add TCON LCD
 compatible for R40
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-amarula@amarulasolutions.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2019 at 2:53 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Like TCON TV0, TV1 allwinner R40 has TCON LCD0, LCD1 which
> are managed via TCON TOP.
>
> Add tcon lcd compatible R40, the same compatible can handle
> TCON LCD0, LCD1.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
