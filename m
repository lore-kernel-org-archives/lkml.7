Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB94C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1BA21744
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WbaYEV5e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgAGSGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 13:06:19 -0500
Received: from mout.gmx.net ([212.227.15.15]:41051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgAGSGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 13:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578420363;
        bh=iZfwkxOhTlh7umLDzawPWQ0XrV9W/IiTb8gMCTxXpOw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WbaYEV5eRiFann9/oiOyPcDy34Y+BY6gun+3pW4kFlPWNeIT9nmOhnD30ASf6/coa
         XBEr/izzX9N/zhmywoyIcPBmeWrOF46l/PeMloeBSL0U5mPFkTNjPIL+D+xd4FCkk5
         OiUTVbZSsjBFCGfSShuE1JaFnYDWqnOcmH/p7vSU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.1.176] ([37.4.249.154]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1jHB6S38gx-00UXoK; Tue, 07
 Jan 2020 19:06:03 +0100
Subject: Re: [RFC] ARM: add bcm2711_defconfig
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        f.fainelli@gmail.com
Cc:     mbrugger@suse.com, Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, hch@lst.de,
        linux-arm-kernel@lists.infradead.org
References: <20200107172459.28444-1-nsaenzjulienne@suse.de>
From:   Stefan Wahren <wahrenst@gmx.net>
Message-ID: <3688a55b-e929-6cef-66c6-affed97d938b@gmx.net>
Date:   Tue, 7 Jan 2020 19:06:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200107172459.28444-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:3pRWyf+PH7jY01QAkX+MY0kKfyybc4wTL/skRdtoftPiphJvlUp
 gjsmsMMFX92e93QGKqmkE9z0FF8emuDRv31KLkrcbr3pqxuvUU8Td/xYSJ2+R/7B4UuhZWn
 HsxOGReKbIvxTIF8r4mHwkSD30d6zXwn5wD8fgzzv9rIhqY4ee5zuO5XjknKSxlUS8l5ek5
 FpVfauNbe3DEu8YpIvVrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EayFQX0crR4=:gh9FrsHEF2ODI54F2IWaaz
 8OjqnWjDGOwAejFffSMakdx0WmpVfPbquFmQVDLmB1Po9GH46DPWxLC89S6WR1dcRetDkE/wu
 Tf9srWS3CSJSgU8++pAQY4YiLQhj1Xua4H3z3a6HfeFqWX11J88Mx3LxHhX4XFTonGPvY3siN
 ct8jaY7bMXMsebXMzSChEfRmWgUwq8sZ+zUVhyZktDLEO2JQoM82cjJombQuelCKnDrxtoBQv
 Zu7Gse+eAvoKD3TE5xb/g68eNfjqH/bqxK3uamkcfifW8+ues5K9TJsl3DOie3+DwtYAhAYbl
 EKoj2pgbNsWxQam0PNsyrgkeBef1x/+bj5kfEspdZUZ5j+KEt8tBouDFdY8WTeK8BqZmW+Uu3
 L0DjTLB9GJj9ijlxnV5qgNRl7e84A01lZeksQ5xph2zPGANK0P47rVVTEDy/dCwe2xCJ2Dm9V
 +NfOltOwc5Cg8kaklXmvuWNcMi8nV9BPFL15xUb63ax+nLQcSaRTJQpQN2mGV6nvbkl1F4irb
 csyAqlp7aO8acNzuL8vuGqy95G8wloprXxJ/cEPaU6eBrDbgFJwXh0RwXAI3l0/lyK6UbfBGu
 415RVBTD4iHuFgA8BIMYe9UWmx7tM2JJYs32vlIXu8F6gkto/gSkXD6Q6Fa21DcsA8yLIHtHe
 VENtVFSF1H2Jj+aK0IIbq1ZLavsu9HRUco9YzBuB2FVdYk2j6eId7swupS7B3Ujh3mSwIPBh6
 /thrRVqGIuLJFuM+DXh4E9XJyKC96ewta0PgtD/pSoD+vwK/GZ/B7qdn0SwUUAeYh3RwnvMMq
 EcpGVa7ooLvderbCXWpKqYm61CLxt0Zfo0ELN+4l05q5eP/LDlQjbswNXdiFmTvR7dkJ37+8N
 oZHCMADclAWy0nPZKa7z0p5hS1++n9TnLwPf0KVnGY0efKcOj2Ujz+Qt/jD9J3SDmeq2KlBU8
 vzwCR9jSxgpGuHQAMimgmuzr+MzPV2t34szfieIf/99F2M7k42nkRFiBR9WHAKG86lqJ6hNHE
 m02TFlVtBQw2Bj8Q+F+1qzfYCOuWRRFbehsDwTtvQ6+z50AIsbJL4spQZXSFIYCTVK/VdC1F1
 a95g5GCN66UsHCW4d28K3d7VyZ4XoHlR2OUzjAR10J41y8wOIoKHeNQA7KEz/HMz03trSKQwG
 amq100coXgSWcBHbZOAZc+XUmc7/plUwcRqGjBr5VvNaftkWMmpq3d7LsZXnOu22zlZUvJbUt
 VfpHtq3vyTYvIJcoOF4wHVPy/oGgfcUyWPSqZQMwzsiPMmbMqan2xk9HJsuk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

Am 07.01.20 um 18:24 schrieb Nicolas Saenz Julienne:
> The Raspberry Pi 4 depends on LPAE in order to use its PCIe port, which
> is essential, as it ultimately provides USB2/3 connectivity. As this
> setup doesn't fit any generic purpose configuration this adds
> bcm2711_defconfig which is based on the current Raspberry Pi foundation
> config file[1] with as little changes as possible

i really dislike the Foundation config file, because it contains so many
unnecessary features. Bisecting with such a kernel config is horrible.

How about finding a compromise between bcm2835_defconfig and
multi_v7_defconfig + LPAE?

