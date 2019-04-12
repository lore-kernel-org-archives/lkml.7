Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E179AC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5E352171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 07:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfDLHSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 03:18:18 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:39019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbfDLHSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 03:18:18 -0400
Received: from [192.168.1.110] ([77.9.22.14]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N5mWp-1gnDLm3t51-017GnO; Fri, 12 Apr 2019 09:17:30 +0200
Subject: Re: [PATCH] tty: Add NULL TTY driver
To:     "Adamski, Krzysztof (Nokia - PL/Wroclaw)" 
        <krzysztof.adamski@nokia.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190403113327.3628-1-vincent.whitchurch@axis.com>
 <20190403131213.GA4246@kroah.com> <20190403141109.3mdmqbt3mjxrie6k@axis.com>
 <e8b1618a-545b-ee35-ec51-f831cbdff7fa@metux.net>
 <20190405090043.vnsftwpdm56cx2hr@axis.com>
 <de23cde3-c77f-cdbf-0968-d7f44c723120@metux.net>
 <20190411130458.GA11390@localhost.localdomain>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <c77474fd-96d6-392b-9a54-fd7e6a29b72d@metux.net>
Date:   Fri, 12 Apr 2019 09:17:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190411130458.GA11390@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qyehZw4BxFk0EO6zWqfZLo+RVqSCdP13a+fDHUYtMLpXvZmb1V7
 Uf8rxcfwsa+Is2nUXaMYrKL59zcMQLpmPKwnA09g/mwFr/2pNhUokBoMajczvn3uk2xbZjC
 i75NxWRvdPHOfJQITlt/zyt0yUO2uUFnXcw9uGci3D+VmGJotav4EHOdUa19zYmiwy85m4V
 6psMZrBfZ2IfkqyWrty+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:907ZcZ8n834=:C4LhqoM3TQG9w8qqzWPGMf
 MPrkSdammynho9pr4IpsNLSZpLa+4CLq0OE+DeTsLgxw8Alyhqv5V/fTsixhfYm8h4wy93yAr
 Nv03iNFPUyxIx0W+7/hO9mctH80ar9A93E6jbaY+xBG0AT1OFQOu0qFUxBjRz8QNYJnekAK3Q
 isU+Mboe7VZOa81azFn4v0CMjpVIlz/Cb7xuqRoTczi9k8PiaIiyKerYnEK4ehZgZ8D3z9ujl
 UKP3WbPy+Bsc4rJlGiaioS3O3T672y3VemDvXJLptsUJQP1f9zBgRFZI1NCkSJuP38wVJLuIG
 uBw/KEVc27dRuu6+7ywY86GqM3Hhtr1n2GgY2rPTah/dOiG+Uzj0lPU9Ikexl4hgEpwxLOdpU
 GxkbVl836D0ExTCHRf9kO+zpw8P0HbSdeyfv0W03zVfphJCD0rI8N1YufQKeYcadKJEwynxxz
 gd4aUzOOBOfTeZBU/e/C321erOxk8kc/nT2c+KgaNWLkIg5ui7Dh9cZTYCPFTwCyCh2ezzwLx
 JhRkltL7194IXYne0qcxYKPRkcWokPrbqTP60EDZlHgbj3bDdCZHcUuYTT2Ze9ndsNApM/Uux
 K151IScG4jjeNNhVXHehHkouzA8Fug1DwXXY7cvYbQIz6waZk0NakisYDxhWV2wsy1oXSN3GB
 ZeXJned62K+pDSK8GkCJXid8RjdQn6sQ7OrvgoG+gH6FRFMVPlQyUqpdbeEusHLvorjq6CepK
 rjvEGiGa0W/849Fb5nSgSmFlGZIDqLEusV9AqNypxHysBR2/GSsS8EYN0e4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.19 15:05, Adamski, Krzysztof (Nokia - PL/Wroclaw) wrote:

> There are (embedded) cases where the kernel ring buffer is stored for> log inspection and all the logs that are *not* wanted there (like>
interactive debug logs, some progress bar, etc) are send specifically
to> /dev/console to avoid sending them to normal log store (as they are
only> useful when debugging over console). In non-debug mode
/dev/console> becomes /dev/null to speed things up.
So, in your case, it doesn't need to be an actual tty, any file/chardev
already do it, correct ? But then, why is that new driver needed ?
--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
