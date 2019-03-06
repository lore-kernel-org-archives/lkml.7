Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F7AC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7104F20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfCFUQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:16:24 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:43053 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbfCFUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:16:24 -0500
Received: from [192.168.1.110] ([95.118.27.116]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MpD39-1gjrsw1bXr-00qfBw; Wed, 06 Mar 2019 21:16:05 +0100
Subject: Re: Smarter Kconfig help
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Peng Hao <peng.hao2@zte.com.cn>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Lucas Stach <l.stach@pengutronix.de>
References: <20190305173111.t3n6ycktht7kxuhq@shell.armlinux.org.uk>
 <1551865552.9298.24.camel@pengutronix.de>
 <20190306095147.xyf3d62bywx4v6ji@shell.armlinux.org.uk>
 <CAHp75Vc_Nfm7tAwGtLuYgrPGPFQzx3a4ppx0+mXhF=q_X8jT7w@mail.gmail.com>
 <20190306113436.5ucdjppibwl6pahz@shell.armlinux.org.uk>
 <20190306124221.bf6qj6zx6jbdcsey@shell.armlinux.org.uk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <80d7c75a-f537-ee10-a139-d342c6b0f2b4@metux.net>
Date:   Wed, 6 Mar 2019 21:16:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190306124221.bf6qj6zx6jbdcsey@shell.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eUyNFs9FANQa0pvp44i2ac92YImyBKauim5EPAoFsLZ3Ck8qTvK
 SkEOGqrn9/vFEtY0Ut3OKKPSXxwuJKNFtmgLyYeouFMpE0WRmNXeJrWfXFscXHSx+gelOWq
 VjjY1fjt8Bk137JLRdy1Jj60dcPF0U8Sdi811aLEqYQr80/cC9Ff/fcqMGPcj9z4lrRIfNK
 +SriHZbQHykRcJ1NjQGVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZENrRlGmpQM=:sfanUOSDcGLN8nzE39HzTN
 Ycn+ZygpECrevHGBo1acqczzJrK5Tcz32P6L8bqJntTPC4tnsFd+EunifZKMsQUEE0BiZsi8I
 hzHFjQ2Y1f0ShhQPEOZeu2GAuRG/Zv3KGfUGIiY02APg+Nxu+Ja3Q2JZarmrUjE6dRjxElOWx
 iiBlQkfJxLnukazaCqwXzQ6QXyHdJqAqb1fsOw3GL35J5+I4Y+WVsn0zdBDBCQapSW5+yWpbd
 saj4bwOsE5vq9DxkhA2izVsHaaKTEtSqk00Tq0qQdmTAh1VXfHc6BTYDRCF6hKoZq4E0EtXGz
 A8KD5BE8hUELZK74ccnTOKEbHUhn60gO1cZ+kU3WOSs1yRPyJQTiOt1SJ5swl58kZk2iizIGD
 /9LG0zbeRcP9f8jSffV1r2A+XGbQMIPxC7HmTlts94KyWN+n2i248Waeqbyjce1jUpbOZtBLq
 Gf7Vk/+KzBt54Aw0GMfXcTJWPMgw5F09RA2lcRoSTxF7n/9F4YHqCMu0ia195dF5pTcaCvhDx
 flypkJJ9iRn4HCu/f3dwrN2TOvSULSd8lCBefPEWnGlKB/8r2DTWxb3Iv8gGZUDYj3lr/fJ/J
 0sO5isq0mF/mN3iVmF1Ia4R9yvzqbEjpyq4KcDXBvHO9QpXYKF85/HOaM3PaMyRdVIstUvVpT
 z9pgQHT5eIP5Z2CZ5a7/zKEdXhKqX0fx2C9SAlXz24B/AtvxrYm2tXnnkJrmJGQ6SR7syn3t4
 6suy9cZKX9Xt2i1ghEdRHyIRyaVA8cU6VbViKeFF23DkEeT+VR8oD2GO8LU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.19 13:42, Russell King - ARM Linux admin wrote:

> In case it isn't clear, this is the *exact* point here - I don't know> whether this option should be enabled for iMX6 or not, and the only>
way I found out was to grep the dts files in arch/arm/boot/dts for> the
driver's compatible string.  What that reveals is that *no* 32-bit> dts
files contain the compatible string, and so I summise that *no*> 32-bit
iMX SoC should have this driver enabled.
The problem is a bit more generic. I often have to spend lots of time
to find out which configs to enable on a specific board, to get certain
features (eg. network, sata, display, gpu, ...). Even worse: many
options require other stuff enabled before even showing up. And when
disabling unneeded stuff, it leaves lots of other things enabled.
(we don't have some `apt autoremove` kconfig counterpart :().

I've decided to cope w/ that on a higher level and written a little
config generator tool for that - here you can enable high level
features (eg. 'network' or 'display', etc) and it will generate the
actual .config:

	https://github.com/metux/kmct

> The excuse that "we can't list the explicit SoCs" to me seems to be> a very lame excuse

Maybe this actually means "nobody here volounteered to actually maintain
these help texts" ?

> The best that I can come up with right now, given what little I know> from grepping the 32-bit DTS files, is that the help text should at>
least indicate that it *isn't* applicable to 32-bit SoCs, or if you>
prefer, *is* applicable to 64-bit SoCs.  Beyond that, I have no>
information to formulate a better suggestion.
Perhaps just fix the text based on your knowledge and send a patch to
the maintainers. They'll propably tell you if it's incorrect.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
