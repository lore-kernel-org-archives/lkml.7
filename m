Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5798218FC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 13:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbfDXNx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 09:53:58 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41910 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730131AbfDXNx6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 09:53:58 -0400
Received: from [80.143.192.209] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1hJILS-00005O-Qz; Wed, 24 Apr 2019 15:53:54 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Doug Anderson <dianders@chromium.org>, stable@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Mark Brown <broonie@kernel.org>,
        Urja Rannikko <urjaman@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM attribute
Date:   Wed, 24 Apr 2019 15:53:54 +0200
Message-ID: <2153141.WrWJEDd2yy@phil>
In-Reply-To: <20190424134536.GA20271@kroah.com>
References: <20180910163932.13722-1-katsuhiro@katsuster.net> <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com> <20190424134536.GA20271@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 24. April 2019, 15:45:36 CEST schrieb Greg KH:
> On Tue, Apr 23, 2019 at 03:26:42PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
> > >
> > > This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
> > >
> > > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > > ---
> > >  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > I just tracked down that audio was broken on 4.19 and needs this
> > change to work.  Stable: can you please pick it?  Specifically I
> > believe you'd want to treat it as if it had:
> > 
> > Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
> > dmaengine pcm register")
> 
> What is the git commit id of this patch in Linus's tree?

Commit id is 24d6638302b48328a58c13439276d4531af4ca7d [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24d6638302b48328a58c13439276d4531af4ca7d


