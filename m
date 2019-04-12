Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316F7C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E352186A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727224AbfDLLbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:31:11 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55241 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfDLLbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:31:11 -0400
Received: from [192.168.1.110] ([77.9.22.14]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyJx6-1gwGTr2EmK-00ygCY; Fri, 12 Apr 2019 13:31:03 +0200
Subject: Re: [PATCH] tty: Add NULL TTY driver
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-kernel@vger.kernel.org
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
 <20190411152845.xomzmhtyejzr4r35@axis.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <44d0b915-f084-e7b1-6e73-51ffed2e1d18@metux.net>
Date:   Fri, 12 Apr 2019 13:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190411152845.xomzmhtyejzr4r35@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:8rIgG6aHjfmzI5v5ZkRK+1yEYl3q24ScMEXuGkkxeFqHYTL96nJ
 6V/sJyAoFCO6EgUhtr7OWo3cPZW+oisxNYjpWJhCMDv7WW7kkaJvtcafkW9+KGOUwJF/SIF
 PB3miQCMis70EA1u1qg+dtOaVDT49dXvytq7LkHGsaqa0CQwbukX2X4gyDfVVIkE7r2qABC
 1lIa8pKhJvzEYUjcHNs0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nUFdakN8IuE=:AIHhO1gbvHG3m8QdSVdFEP
 ldhs4eYhCag/CKOyoROGJGEBy8TmA8530X+SnPInkZuy+P43aSDUzL5MZiuUFz5+9ulMQjbd6
 urXH4kp+d3ZEp0Z0Hu+KYoi1YmgX7fuJJjcBaT2/w4bIVv+AuKQHHajb75DudD1RNl91SSL55
 34Eyi7tWg1sJlK3uLCx7+jaIRchL8eX0+vCF5nuaOkJo0D31VVsOtaTHxammCmiQiS/F7M3mb
 3AtpzECaC0+sBYYlbGFN3zjKi236nNh1/ULTCQTjgiyqN8YRjmWpyw58xgXMnRCzwbp2R21rY
 XNkBaI6worWenZmLk9FJ91KbCJ79tvPTTZW7vwmU1SxrsDtlaNZr2f1hwJbEyaw+vB05qfgKp
 IcS/Ko28dlQ5HtVmiHEtKasMMikRzNGdjIXGg7A2RiO4cEpA02TuMUuFAAA2ZBwb2zHivTL7d
 bW0JyxcaUYf5OIOqP6aDfD6zzLS2nDkUp5TDUgPfJR7frdf8t7D1+b09Aux1xSx4j31s5zLLL
 ka9dz/UdJ/pu/gdQVjaCRSwVD+uEnfy01WnyHz9ZZz7S4IhOaI5qIQ8onfyDNknDLTZra2ibH
 XF3fMIAZyUjbZgWJWP8Dkd0ZIBS59UJjMznPgZ9Jiou61X0j68DzP/21ZuVNgUlMttPjLXFw/
 wicMP+5QRn7sawlPdwWLRrBauhunWTRjcr1viGtaxBOWtOnJjk0Qj2WrX6G/3+y1A2JPq2rJj
 gfxb0S/lQy99+SPMalT82djI5P33kE2yz/ZVI32OYEB8m9qBMmXie4wYcT0=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.19 17:28, Vincent Whitchurch wrote:

<snip>

>> hmm, wo (which programs) do you need, that really need them ?> > I think it was systemd's debug-shell which complained about the ioctls.
Okay, why not fixing this broken userland ?

systemd is written by somebody who doesn't even know the semantics of
rm  -R (as specified by unix standard since many decades) and so causing
funny things like complete disk wipe:

   https://github.com/systemd/systemd/issues/5644


In the last 25 years, I've always been fine w/ just redirecting to
/dev/null.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
