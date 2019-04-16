Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A82BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D2020872
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 17:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbfDPRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 13:08:09 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:54867 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729956AbfDPRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 13:08:09 -0400
Received: from [192.168.1.110] ([95.117.99.70]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDPqi-1h61wS3rYk-00AYH2; Tue, 16 Apr 2019 19:06:51 +0200
Subject: Re: [PATCH v11 2/7] anybus-s: support HMS Anybus-S bus
To:     Sven Van Asbroeck <thesven73@gmail.com>, robh+dt@kernel.org,
        linus.walleij@linaro.org
Cc:     lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, jan.kiszka@siemens.com,
        maxime.ripard@bootlin.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20190416155618.1369-1-TheSven73@gmail.com>
 <20190416155618.1369-3-TheSven73@gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <4aecef30-0d64-c5f7-c4de-43b0754e2fdd@metux.net>
Date:   Tue, 16 Apr 2019 19:06:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190416155618.1369-3-TheSven73@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/StFjb92ehPTCM32sGbzFPQa6/ePviqGY5nt7Q92ObUEiaS2OgE
 0YLcMfxwigBBNgu81s+7v+owJOccRtz9hhfvF8vDvWLVj2Z22Yzl8i1tl+UFMFp7zVkeeMw
 vleqFS8h3eXf+PPL7PZCHY7QPoPy8Qs+RXfPczlTd4/8k7ZV+eK5SBadWMDeQW4UfM7fMCP
 FkB5/JbgHz8nxZEOObzIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GQ6ooqywZYE=:McGdIFYEXZOfxu4nu719BQ
 Y2YivaGknx/WWclbVup9Jh906wfDhRspc2cmmgjYO9oYxoA40qItSQH4CD5c9GR6htjyYLaPc
 jqfFObdoVf81ZOxsKn/I0Js30r99UPzLRomILa3L7FbiHlVEXol24bTPqhBxDGuONAUZ0y4s+
 7nHASGXbBxRlAhmzvZlAkN3573NqekMPiv9JmTXbnqvwZzdJ6Xaoj0DT6UExpetaFOOWe7/tR
 hbODcHBnnlXBDauYZY4wvb4wi3OIAVA//cw2klQf2bpF7Yaj63TTiZA/fMHHrF/o+KRXDszhg
 zFArbwa7IvZYFYFhpY2/Sb1jTQIY7fbU+9zbDD0tipHPCNfcrK7AE7jHZ5swGQYg6fakS79P2
 sXvRBlaildJIq1a54YrRiteCNgMPSySkzLJ7vxtDxodQUbwMchKhU2MwXZieUFpr2sdevDq0+
 1UiUJfTPhht4F68lzoG5jx9tqZK+CWK5ZB5P01xOcv9riewwmpatr1Pwkt9Gl5A7LsePFvDMv
 /fyPFUsyNEN8EFTen6kj1ntfn9fUkx/ttdzSCIhFUIcVTszSTHvkKso+OxXt1puMpLMSewzK6
 dJRqFZW34BybtZdvuHrGSG/vC+MYrkIV9yGL45uM4zaZmBa1Slqmsx46nTd0609NQPV9jK9Du
 DnWyoK9lbHeE0p+63vhwlgRpOK9rfsi3c4iObLAHNIv1mdMViJHkXQ2ahSjhaXx6iHNbwT0wo
 IovzMMK3HNdFL5vvs98j0WvZGjh00EppMiDYZHNKHlfAyGClqz2iqNsm233E2EuSVh8HNFqIo
 j+6s+U8Gul/+KdJni1xiQMnz/Ch9cvurL+csLqrAaB0AiSAPcfOYafqFPLMg+std/Cfbl9/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.04.19 17:56, Sven Van Asbroeck wrote:

Hi,

> The Anybus-S/Anybus-M is a series of interchangeable fieldbus communication
> modules featuring on board memory and processing power. All software and
> hardware functionality required to communicate on the fieldbus is
> incorporated in the module itself, allowing the application to focus on
> other tasks.

I'm a bit confused, what this anybus stuff actually does.

Is it some proprietary backplane bus, where things like eg. fieldbus
adapters are attached to ?

I see some struct bus_type field declaration - is that going to be some
subsystem, similar to those for other bus'es (eg. pci, usb, ...) ?

Maybe that deserves a bit more documentation :p



--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
