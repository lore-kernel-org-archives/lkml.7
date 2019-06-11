Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC932C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B2C20896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 18:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406975AbfFKSNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 14:13:05 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56987 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406831AbfFKSNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 14:13:04 -0400
Received: from [192.168.1.110] ([95.118.191.213]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MwQCb-1giNZA3N25-00sOvD; Tue, 11 Jun 2019 20:11:17 +0200
Subject: Re: [PATCH resend] serial: 8250: Add support for using
 platform_device resources
To:     Esben Haabendal <esben@haabendal.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        linux-kernel@vger.kernel.org
References: <20190430140416.4707-1-esben@geanix.com>
 <20190521113426.16790-1-esben@geanix.com> <20190521131131.GA19685@kroah.com>
 <878suzn9wx.fsf@haabendal.dk>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ef125e69-3128-255d-483e-14b50036905f@metux.net>
Date:   Tue, 11 Jun 2019 20:11:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <878suzn9wx.fsf@haabendal.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:x93nJV3Bbkp8Z/g8aMYok3VV7GLXLxitWGsdzTWg68qpXr7r4Fx
 CnQUJRVBah+Qe5WXAw0Uf3WyAiaLDgHZ5fgXiCikahMozhuantK5PAbqE9iGnDZdlVF9dNR
 d2lo4627itDIdvvpfuzQPYBVTPJJFKaGRZbeO711zzd46UxLit8ZZaUUqHVMasW0ColbCJ/
 qLVj844T5AL99/c/aphjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TkpVOKfh1aw=:DF8vRhPwBU7XHqD5rSAaza
 MRtAkq1iIi/YC6+Yy7yf8v17rcoi0Bx7RUZcgpUHcbJ0XxQtOFg2wwbD1v9Dzf0JKQUqjPR+S
 E+uwcwznlRuUUFX8d3RoIkNokLhdOWCGPWGtFAcGW8XlLWuMOo0dfOWpBdUImOPbrNgRJfqeq
 Io9JrP9pourQ8hmRJj5k56JCmxTP/RkXfM9473BsVW+B9hiuUznjr4I5usZUE6T9NLvvh68FA
 G31ojb/S8252vCh5fPDhEanwnvqYUFoCjWq/m/LiYcHIxtAOlimuKhNSurxEfysZQotLZI9xi
 1yA5UPcQkOGNg7hI3G6MGBHW1XwsNlm5/r94lxZY7o3GbN5eGNvwZDg0dmIsbTLo641UMsxXR
 ++Vlj6HkICH1tFnil2GF382YNkfGEdy/Rn7qk/Ao+cA9TqUgfEZ26X4K3C8hZXVcd5k5ymhIA
 9eBpLD7G38GwDPp1/RZkUtcweb2vl2FA4/lLaHFlO1zNXklWy3Qyl1YEvL+L7TlMKkS2NGRp/
 63jmgKpTX8+wJ1H5GN3Iw0ohwCZve4+zmkxZEeBjPAs4tSU5nnKCNeBUrxt8EDr1U3U8JiZf+
 38yl2snfj1JllqQZgwB85dQwhosj4HvLQNISweeY4llBrH4SqTgXfLmFG39ln9dzE58NsMZYE
 bZ+judknO2OYW2bHalP5STZAdLTi2Aagbqd4NN2ra/h9e/ayqD1tF4Lk5JGfr4N4twb8v/nRL
 l9TchayIw3q3YK3izxM7Vprz8SJLgdTqmV0SomaPewYuprExAKc9UHrUIgbB9v5wNC4kJBXpD
 YgJr1Bw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.05.19 16:45, Esben Haabendal wrote:
> It sits here.  It is a rather big and clunky mfd driver, not ready for
> upstreaming in its current form.  I hope to get around to clean it up.
> But it is for a very specific hardware that is really available or
> usable for anybody else.  Does it make sense to spend effort on
> submitting such a driver?

Maybe you could post your queue w/ "RFC: " prefix and add a proper
introduction, so everybody knows that isn't meant to be upstreamed,
but instead a basis for discussions ?

Personally, I'd like to have a look at it and understand, what's the
actual problem you'd like to solve.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
