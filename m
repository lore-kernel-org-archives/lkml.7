Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B27C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0A220851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 22:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfCGWQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 17:16:44 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfCGWQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 17:16:44 -0500
Received: from [192.168.1.110] ([77.9.35.131]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MWhxY-1hZ5ym2WKm-00X0Zr; Thu, 07 Mar 2019 23:16:28 +0100
Subject: Re: [PATCH] arch: um: drivers: Kconfig: formatting cleanup
To:     Richard Weinberger <richard@nod.at>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, jdike@addtoit.com,
        anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
References: <1551897164-5689-1-git-send-email-info@metux.net>
 <22846131.xdEJ5N2VYq@blindfold>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <480ebcef-c438-7272-8a78-35eee0680d2a@metux.net>
Date:   Thu, 7 Mar 2019 23:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <22846131.xdEJ5N2VYq@blindfold>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Dtukm2Chb/9Mxk4DM3p0g6Oq7DdFoVlb8fxtHtibLdmK2xD9XQu
 M4nc0lNBGEIORFKcb09vPxgJ0oEhRaw2C4DIdsRk5KHYcqm6gBny6bIr8c4mSdcC2xEXyao
 iz7qcbNNSarJePgX2dZny8ugutcohiHjzIPd1yPCA9Is2gdB3wkML/bWHtS21j+ZwdyXFXL
 h/rH/nbWrmenPzDFIPShA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qdiiTqJPLDU=:x7JqFfT7l5n+zQxvDAZAD0
 rDmTGd1be+BaQit6K8/m+OHQNXo0elj9EPWWe21jj5YH+Oa+jCcDjCj0cwpW6BsD9EXZm3dN2
 t5T8wvhnDkjszbl+perpXHhppe4/uZbPXaYRGbc/jjde+AdPRd7gILgrXwXK0TvLIp1ph74OX
 6nI8Py1xe39uRwBecjfTpmj2Tkgk4PdXyodWNfQG7LprwZawloF0lMnC0aiGVmlW0YS41HKLg
 kbTqZyg3xOBiSmTAiVMaBn7d32xOWBwRTfT1g/WY06GUw1JV4d9OfSQnrpM30PEjMWrgqPoBF
 dFGyXeNoPEdgCX47OoBNmlEzBF2jlIGhzIu2aOApjXXt8lv4TM095pyZGjnsD3G1EcmdaZwzX
 x04CE6th1J1twD3SZXxAgmEKzzONwSnGEmuy++7BYjqQLHAWcrne3Hggs5z9rlo49u00HO67a
 tLZnlulGoaYu+2OOgf6dzI1S7KLFVxR67JhIyWwDKC8I5pDZj5qCNo7Y3tmwItXOYQaQSf5m1
 +ZppXfLRr12z6JrOgu+Dx/IeFrLdg8yDkkJsSLWJ24DdZDA9xdUCuv+silEaL68D5ZmVeIw6E
 oyjCiKFzKQqCMb0g10ug8870gMASmVdBeKTExh5tmcQvcstMxrd01jdB+WD6C9nLYjy4IHe0G
 XQS39m/Q+09SeAC8tNy+xyyVQ5lK0Kq3gf3zmebCM7hf8ZEylNawWehkV2oW998ERTZsS2Xc8
 r6MIvCddwsEofHRU7slZCmlWYXR667/JKU8hgFJKjn5YPpZvIktD5kbiI5E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.03.19 22:43, Richard Weinberger wrote:
> Am Mittwoch, 6. März 2019, 19:32:44 CET schrieb Enrico Weigelt, metux IT consult:
> 
> Here please also a changelog. :-)

Sorry, forgotten that :o

Those things happen if you're doing the same thing a hundred times
(yes, I took the time to go through all Kconfig files, ending up w/ a
huge queue of small patches - separated by subsystems / drivers) ...


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
