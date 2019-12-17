Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A970AC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7214824672
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="jOY+v5TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbfLQAb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:31:59 -0500
Received: from mout.web.de ([212.227.17.12]:52557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfLQAb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:31:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576542706;
        bh=VAIarekXGaF7LbwrHuNiLBdwDHGgah+wk5zWVi3fUw0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jOY+v5TSrp1jXA2PfIum+7Y7i4dl4sYqiS9SAu7ia9a0oIexHZzxTr2WHOED/mSsC
         rlvTH7gh6ukNBh6NxYuR2QYG+G+BdyZ7hR8p66ZqXBCMByZN0x3EWd7YtymwbHnOKs
         sUUC8Cxp3RXlW2Ovp0TCg4O1U+jIdX93E8plQp7A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.43.108] ([89.204.137.13]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5wrF-1hk7Wl1RUn-00xuY3; Tue, 17
 Dec 2019 01:31:46 +0100
Subject: Re: [PATCH 0/4] mfd: RK8xx tidyup
To:     Robin Murphy <robin.murphy@arm.com>, lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux.amoon@gmail.com, linux-rockchip@lists.infradead.org
References: <cover.1575932654.git.robin.murphy@arm.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <a7f8f6da-4913-910b-bcf0-e7c39a251c61@web.de>
Date:   Tue, 17 Dec 2019 01:31:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <cover.1575932654.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-Provags-ID: V03:K1:8QdblLwHK9OyDD7ibW1J/hpvHe3mNoLqarHlddxZXSju1eo3iK3
 2/EgJ/aB+kMYT1B/Hq6IqocaGNya1ZJeQM1ZissE/BKMsDqIEAH69xKItTg2K+TCAyg5+Df
 fHIhfL130zLNgoPEjIEUKZpJthbUt99Zp0tZ9d1rfYKAJrSZk7l/RS/lw/LhXOyD7Lat5pb
 omukZRrssExn+vhKBo/YA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pu7hEOyfe0k=:vfoheoKlKDogR3GLB+PI0D
 twUpyEUcpYIkSexlVxfVWroW7+VSoGx93k2lzLmgNdM4wENevzeE+nTdnw2PDvgLaER0S8Zs9
 MpiAg89YLdN4fVNCJVDNzOP5oSeXrXD16U6cnzmXtat1ssOt8u+jHtMPe/F3txkhiv64L8kdh
 41NvgV1XOM77xpDC8wgL4dgTC2EoDJk6oFxHScdoVa5wk4HCpvgT7IgGOFYvRVKe6ZrgYWo0C
 j0hXJBQm9Ohyio/JTD+XqdKHo7089212UX+YRoizB4JP2I+hAhuMd25iq9krcb1H6Xbp2mOWC
 xEBoEWEY0k1oXuVDbJ6EaEtS81d4KPIBW8D2+UE7nm75WQTZEqnI1xKIvl/e/KDZAOtkUu44K
 PTL8umstUqKfaUAt3sspKeEwdw2V5MI5cAxAA0/DD9rnrOpgU1hDNl75eHH23pDGJFchtW/mm
 u9ezfMNO0+fQh7ac7SkcVUlHrzOpBfiibbdlImlvauz0xHHPywmH01VelAlCNah53EqtePEg5
 YYaVjdnplwhpTgjkxtJ2w9cKfeARC2A3stqDR+YYjvHiRv7aairIqzsZswHOKIYSA7uQPb7Sp
 z83Pc++aE8aLmRt0iirV/F4uJQflTJzhK/+l/2poTtWi/GI69TOa+VztvWVNuyIRp8Lt1KVgG
 Y2vBuSY4zOkftpjKT6guWlm5ZW4MxEVKQGNB0CbF7AXpwcMWMs3Ic4IUlW3OsZpuSjzjCt/Yl
 B5R3fS4ugZd47iKwH1O3mIZnB8R4ZrFa0s//d9jlgvGoPfge5sPze21IX8t0iDq0WZ0IV0hYi
 p23MlOTwFBN0mQIqsDkPdzr7zfcDPszFC1zj1LdrGmnGIeZ37MXyihTbETdpGdbC2/PdmddV6
 nk/X7pbdNcps9ne+S0zih3AnO7brHblBLVCUd0YpFpd7JCA1s0mYYxes0C7403JQvBRkDdNoB
 iH4db01Qox3jMiY9nJR/6AgzqUd5c6nfS4JG2kEkl96zcHFKt2wihEAN3k+9mn1QpFUvPSG40
 S4ozi7JQ1kQ2JmZjAg2ZTT9AZMc0CJCCA0PWqFDUptEgDEi2icD3SXuZ3OpRkNVLPf2lj2i/e
 2usYX7zTYljrCHtoTNW/xDbfcKpk+23QPiRd01ig8P7YSSPYWoTCJXmL2LwPZZZNYXFF9dtYB
 dMwHBbV2ehiU1mZ5khuAGxS7v7aAnxNjkdMU4OgWijqu4EMxep7xDYpkQJNMORu8ueLbvLjCB
 ywDN7A1QGsUZFADhTOzfr5bd4F4pX27qci1HhPw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.12.19 14:24, Robin Murphy wrote:
> Hi all,
>
> In trying to debug suspend issues on my RK3328 box, I was looking at
> how the RK8xx driver handles the RK805 sleep pin, and frankly the whole
> driver seemed untidy enough to warrant some cleanup and minor fixes
> before going any further. I've based the series on top of Soeren's
> "mfd: rk808: Always use poweroff when requested" patch[1].
>
> Note that I've only had time to build-test these patches so far, but I
> wanted to share them early for the sake of discussion in response to
> the other thread[2].
>
> Robin.
>
> [1] https://patchwork.kernel.org/patch/11279249/
> [2] https://patchwork.kernel.org/cover/11276945/
>
> Robin Murphy (4):
>   mfd: rk808: Set global instance unconditionally
>   mfd: rk808: Always register syscore ops
>   mfd: rk808: Reduce shutdown duplication
>   mfd: rk808: Convert RK805 to syscore/PM ops
>
>  drivers/mfd/rk808.c       | 122 ++++++++++++++++----------------------
>  include/linux/mfd/rk808.h |   2 -
>  2 files changed, 50 insertions(+), 74 deletions(-)
>
The whole series, on top of [1]:
Tested on RockPro64 board with RK808 PMIC.

Tested-by: Soeren Moch <smoch@web.de>

Regards,
Soeren
