Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D75C19759
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB47920679
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbfHANbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:31:49 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33509 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729985AbfHANbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:31:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so73724494wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2019 06:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIuWAYX3PneeYTTjAbiFSBHYZS04N2KVJUpzKrkXrq0=;
        b=ScitrLRdPLCE1MBMdpxfR2EId/YzFml9uySRkaAeSJy9HxhqWf5AGhHpGKhD0ohZJB
         oiWqB/vKqI9U+ouCjF003FLY1s12lbgamGISEu1MrBbTuZarolFzSEFu+46GEU1Zv67l
         cLzMqs7xvduYIbwnO39yey0l1JmM+TcFnr/NoUSTRz/ASr/BsZ9Scc5xaPVVWPr0ijRZ
         Pvyiwx8ltA1d5bCgW/JZYIWtZgnU8Zs/P+8vj1VLhTvOwVdTjrUqZInMpQct4lIIiigw
         SwnGxpkvKbHG9tv7JHNl8oyvtsYTZwvdS2MS1nK5KzqDhy6j/RC6STJTVzVurNJX9DKl
         Jtng==
X-Gm-Message-State: APjAAAXiIAqOC4ucQjYa6dsNuKwGJ0AHM/Bycy9qa+T1gVj0H19QbbHy
        xdE7nM5bQxqwW5P3dFQvp+if58X3DBDvNy4Ghlk=
X-Google-Smtp-Source: APXvYqznc50yn60/ExWwPM56mPnNwRQgsfmZ5HaVoIrpJVWLVeHAqVaVK49vMbZKhih4uq1MeedVmcYOGkFdngsUe4w=
X-Received: by 2002:adf:f08f:: with SMTP id n15mr55165670wro.213.1564666306748;
 Thu, 01 Aug 2019 06:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190617143547.4721-1-geert+renesas@glider.be> <20190801131527.GA23424@e107155-lin>
In-Reply-To: <20190801131527.GA23424@e107155-lin>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Aug 2019 15:31:34 +0200
Message-ID: <CAMuHMdX+Nd1XH0KDHXmdOa_=UYcBso_EKfugYbZ_Zyd=4e2nGw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vexpress: Add missing newline at end of file
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Thu, Aug 1, 2019 at 3:15 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Mon, Jun 17, 2019 at 04:35:47PM +0200, Geert Uytterhoeven wrote:
> > "git diff" says:
> >
> >     \ No newline at end of file
> >
> > after modifying the file.
>
> Sorry for missing this earlier. Just found this unread and thought of
> applying it to v5.4
>
> However doing a quick check on the tree revealed more file and wonder
> why you are addressing only handful of them. Why not all in one go ?

I did address all of them, but sent separate patches per subsystem.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
