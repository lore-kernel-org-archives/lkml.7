Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736C7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469D621479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 12:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388474AbfDRMe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 08:34:58 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:60833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfDRMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 08:34:57 -0400
Received: from [192.168.178.167] ([109.104.40.126]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MA7Om-1h6bbC1VFK-00BeRR; Thu, 18 Apr 2019 14:34:36 +0200
Subject: Re: [PATCH RFC] staging: vc04_services: handle kzalloc failure
To:     Nicholas Mc Guire <hofrat@osadl.org>, Eric Anholt <eric@anholt.net>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phil Elwell <phil@raspberrypi.org>,
        linux-kernel@vger.kernel.org,
        Tobias Buettner <tobias.buettner@fau.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-arm-kernel@lists.infradead.org
References: <1555583384-15670-1-git-send-email-hofrat@osadl.org>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <bf13c010-745d-8c0b-c73f-2dacb26e3346@i2se.com>
Date:   Thu, 18 Apr 2019 14:34:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555583384-15670-1-git-send-email-hofrat@osadl.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:oc6nPt0+Qfm0BfV3a08wzgG81uesy7XkH4HUnlynMwdkBI3Iyff
 7uI8w0Wb9xCdSyKMuwR4FtQGw8F2IhWwwCcDr67QIjkdlpUTFF1gc31RWpDod0P7PfFg2RH
 AIPp2v5Ali3GYprIj2DT7jC39nJnA6sK86EoGa3TiNrzqhfTo5XpzrT8h7iihij34u8GsWi
 K8gF4S1XWFe0vy/SwsKnQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4FIxG/zODfY=:KyeK9fUAQGjkmqK08m0eRs
 mgsskC+KrxfvEavqVyOrlEKL+vlvm4RcnksO+n9Miy6GjzfEqxBsgf9WEOWXopjzsUTTd/MFF
 JzYELDT8ot2QSBOGjeSbDXCpTDIHxVYqfdQzcQOC5V21xUdDK6DFdmonvH4FuN0IoltZU1PmB
 c/IVhxbkL479LPIFpfnzRFgkht+7ncDfXWv2xyEuzKFpi4gk0gr7ocIqQdwRF4vD1NioWbXjm
 LhYpAL6HWUWdNS9shZyX5hAJ4X29flDpaNqu712z3qDfOACmbzWUkRaHyAJWJQCjXTVvtnq4G
 Ft1OuGIJ3PXvillL7RwdXBFf3+uZyoDC62+y7HWXNa4egnXOXN8Fl2l09ryYA1pIPMGesrAKb
 CNF3udVonVhhFi/G7E3G+u2aOW7O7NLPF5mSH9vLlTH83npJinwn1zJgr5noBxKjtllyd5f2c
 SjJlgVsXIl3ED5CMpRFQ+DtzRh3UeAsMWzQbyEACnuZZNG6DC0PHfq6j1ngyKkHBs0JcAb8fS
 kI8Dd0hkpL7XavsAa86VI9z4LEy42KpUVEXmIzD19N5YVrkLK92ydCkyssbb60rjGm02GeuAZ
 PJqkVInz4Ej5O4B5IlI1zsDQBEP0avky7TfL1auZMKKPuaAzRjX66UI6b9NSvHMwRKpt1HpuS
 CDP0dDPZW95GSFPq6TfAUniedObqFh1I1qrzanfqoar+/xbRY21GkkdPDnTMxwaMUa1S1JS8x
 Vqa3KZwVi2rpb7yoIkcHugmsvRe19YPgk4uVQ2oIS2cNvKYL80bdo+9CqQ8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.04.19 12:29, Nicholas Mc Guire wrote:
> The kzalloc here was being used without checking the return - if the
> kzalloc fails return VCHIQ_ERROR. The call-site of
> vchiq_platform_init_state() vchiq_init_state() was not responding
> to an allocation failure so checks for != VCHIQ_SUCCESS
> and pass VCHIQ_ERROR up to vchiq_platform_init() which then
> will fail with -EINVAL.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

